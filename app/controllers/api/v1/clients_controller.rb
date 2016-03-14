module API
  module V1
    class ClientsController < APIController
      before_action :set_client, only: [:show, :edit, :update, :destroy]

      # GET /clients
      # GET /clients.json
      def index
        @clients = Client.all
      end

      # GET /clients/1
      # GET /clients/1.json
      def show
      end

      # GET /clients/new
      def new
        @client = Client.new
      end

      # GET /clients/1/edit
      def edit
      end

      # POST /clients
      # POST /clients.json
      def create
        @client = Client.new(client_params)

        if @client.save
          render :show, status: :created, location: api_v1_client_path(@client)
        else
          render json: @client.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /clients/1
      # PATCH/PUT /clients/1.json
      def update
        if @client.update(client_params)
          render :show, status: :ok, location: api_v1_client_path(@client)
        else
          render json: @client.errors, status: :unprocessable_entity
        end
      end

      # DELETE /clients/1
      # DELETE /clients/1.json
      def destroy
        @client.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_client
        @client = Client.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def client_params
        params.require(:client).permit(:client_type, :gln, :full_name, :short_name, :description)
      end
    end
  end
end
