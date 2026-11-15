# Manages the customer checkout process using atomic database transactions to safely create orders and decrement stock
module Api
  module V1
    class OrdersController < ApplicationController
      # POST /api/v1/stores/:store_id/orders
      def create
        @store = Store.find(params[:store_id])

        ActiveRecord::Base.transaction do
          @order = @store.orders.new(order_params)
          @order.status = "pending" if @order.status.blank?

          if @order.save
            # Optional: Deduct inventory for each order item
            @order.order_items.each do |item|
              variant = item.variant
              if variant.inventory_count >= item.quantity
                variant.update!(inventory_count: variant.inventory_count - item.quantity)
              else
                @order.errors.add(:base, "Insufficient inventory for SKU: #{variant.sku}")
                raise ActiveRecord::Rollback
              end
            end

            if @order.errors.empty?
              render json: @order.as_json(include: { order_items: { include: :variant } }), status: :created
            else
              render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def order_params
        params.require(:order).permit(
          :total_price,
          :status,
          order_items_attributes: [ :variant_id, :quantity, :price ]
        )
      end
    end
  end
end
