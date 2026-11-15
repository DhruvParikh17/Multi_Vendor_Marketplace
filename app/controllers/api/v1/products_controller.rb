# Handles RESTful API requests for listing a store's products and creating new ones with nested variants
module Api
  module V1
    class ProductsController < ApplicationController
      
      # GET /api/v1/stores/:store_id/products
      def index
        @store = Store.find(params[:store_id])
        @products = @store.products.includes(:variants)
        render json: @products.as_json(include: :variants), status: :ok
      end

      # POST /api/v1/stores/:store_id/products
      def create
        @store = Store.find(params[:store_id])
        @product = @store.products.new(product_params)

        if @product.save
          render json: @product.as_json(include: :variants), status: :created
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:product).permit(
          :title, 
          :description, 
          variants_attributes: [:sku, :price, :inventory_count]
        )
      end
    end
  end
end