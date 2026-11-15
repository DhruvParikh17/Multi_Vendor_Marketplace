# Multi Vendor Marketplace

A RESTful backend API built with Ruby on Rails and PostgreSQL that powers multi 
vendor e-commerce operations,nested product variants, and ACID (Atomicity, 
Consistency, Isolation, and Durability) complaint transactional checkouts.

# Multi-Vendor Architecture: Relational data model supporting independent merchants (User to Store), product catalogs (Product), and SKU-level options (Variant).
# Nested Resource Creation: Leverages `accepts_nested_attributes_for` and Rails Strong Parameters to create parent products and multiple child variants in a single JSON payload.
# Query Optimization: Uses Active Record eager loading (includes(:variants)) on catalog index endpoints to eliminate N+1 database query bottlenecks.
# Atomic Checkout & Inventory Locking: Wraps order creation and stock deduction inside `ActiveRecord::Base.transaction` blocks, automatically rolling back database changes if stock is insufficient or validation fails.

---

# Tech Stack

# Framework: Ruby on Rails 8 (API mode)
# Database: PostgreSQL
# Architecture: Versioned RESTful JSON API (`/api/v1`)
