module API
  module V1
    class ProductsController < APIController
      before_action :set_client, only: [:index, :show, :create, :update, :destroy]
      before_action :set_product, only: [:show, :update, :destroy]
      before_action :set_new_product, only: [:create]
      before_action :set_products, only: [:index]

      # GET /api/v1/products(/page/:page)(/per_page/:per_page)(.:format)
      # GET /api/v1/clients/:client_id/products(/page/:page)(/per_page/:per_page)(.:format)
      def index
        products = @_products.order('products.id ASC')
        products = products.page(params[:page]).per(params[:per_page]) if params[:page].present?
        @products = products
      end

      # GET /api/v1/products/:id(.:format)
      # GET /api/v1/clients/:client_id/products/:id(.:format)
      def show
      end

      # POST /api/v1/products(.:format)
      # POST /api/v1/clients/:client_id/products(.:format)
      def create
        if @product.save
          render :show, status: :created, location: api_v1_product_path(@product)
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/products/:id(.:format)
      # PATCH/PUT /api/v1/clients/:client_id/products/:id(.:format)
      def update
        if @product.update(product_params)
          render :show, status: :ok, location: api_v1_product_path(@product)
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # DELETE /products/:id(.:format)
      # DELETE /api/v1/clients/:client_id/products/:id(.:format)
      def destroy
        @product.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_client
        @client = Client.find(params[:client_id]) if params[:client_id].present?
      end

      def set_product
        @product =
          if @client.present?
            @client.products.find(params[:id])
          else
            Product.find(params[:id])
          end
      end

      def set_new_product
        @product =
          if @client.present?
            @client.products.new(product_params)
          else
            Product.new(product_params)
          end
      end

      def set_products
        @_products =
          if @client.present?
            @client.products
          else
            Product
          end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def product_params
        params.require(:product).permit(
          :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short, :description_full, :active,
          client_products_attributes: [:id, client_attributes: [:client_type, :gln, :full_name, :short_name, :description]]
        )
      end
    end
  end
end
