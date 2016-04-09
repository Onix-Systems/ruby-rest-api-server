module API
  module V1
    class ClientsController < APIController
      before_action :set_product, only: [:index, :show, :create, :update, :destroy]
      before_action :set_client, only: [:show, :update, :destroy]

      # GET /api/v1/clients(.:format)
      # GET /api/v1/products/:product_id/clients(.:format)
      def index
        @clients = @product.present? ? @product.clients : Client.all
      end

      # GET /api/v1/clients/:id(.:format)
      # GET /api/v1/products/:product_id/clients/:id(.:format)
      def show
      end

      # POST /api/v1/clients(.:format)
      # POST /api/v1/products/:product_id/clients(.:format)
      def create
        @client = @product.present? ? @product.clients.new(client_params) : Client.new(client_params)

        if @client.save
          render :show, status: :created, location: api_v1_client_path(@client)
        else
          render json: @client.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/clients/:id(.:format)
      # PATCH/PUT /api/v1/products/:product_id/clients/:id(.:format)
      def update
        if @client.update(client_params)
          render :show, status: :ok, location: api_v1_client_path(@client)
        else
          render json: @client.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/clients/:id(.:format)
      # DELETE /api/v1/products/:product_id/clients/:id(.:format)
      def destroy
        @client.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:product_id]) if params[:product_id].present?
      end

      def set_client
        @client = @product.present? ? @product.clients.find(params[:id]) : Client.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def client_params
        params.require(:client).permit(
          :client_type, :gln, :full_name, :short_name, :description,
          client_products_attributes: [:id, product_attributes: [:gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short, :description_full, :active]]
        )
      end
    end
  end
end
