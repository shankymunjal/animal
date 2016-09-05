class BirdsController < ApplicationController
  before_action :set_bird, only: [:show, :destroy]

  # GET /birds
  # GET /birds.json
  def index
    @birds = Bird.all_visible
    render json: {birds: @birds.as_json}, status: :ok
  end

  # GET /birds/1
  # GET /birds/1.json
  def show
    if @bird
      render json: {bird: @bird.as_json}, status: :ok
    else
      render json: {bird: {}}, status: :not_found
    end
  end

  # POST /birds
  # POST /birds.json
  def create
    @bird = Bird.new(bird_params)
    if @bird.save
        render json: { bird: @bird }, status: :created
    else
        render json: @bird.errors, status: :bad_request
    end
  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    if @bird
      @bird.destroy
      render json: { bird: @bird }, status: :ok
    else
      render json: { bird: @bird }, status: :not_found
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bird
      @bird = Bird.where(_id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bird_params
      params.require(:bird).permit(:name, :family, :added, :visible, continents: [])
    end
end
