module API
  module V1
    class ProductsController < APIController
      before_action :set_product, only: [:show, :edit, :update, :destroy]

      # GET /products
      # GET /products.json
      def index
        @products = Product.all
      end

      # GET /products/1
      # GET /products/1.json
      def show
      end

      # GET /products/new
      def new
        @product = Product.new
      end

      # GET /products/1/edit
      def edit
      end

      # POST /products
      # POST /products.json
      def create
        @product = Product.new(product_params)

        if @product.save
          render :show, status: :created, location: api_v1_product_path(@product)
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /products/1
      # PATCH/PUT /products/1.json
      def update
        if @product.update(product_params)
          render :show, status: :ok, location: api_v1_product_path(@product)
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      # DELETE /products/1
      # DELETE /products/1.json
      def destroy
        @product.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def product_params
        params.require(:product).permit(:gtin, :information_provider_gln, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short, :description_full, :active)
      end
    end
  end
end
