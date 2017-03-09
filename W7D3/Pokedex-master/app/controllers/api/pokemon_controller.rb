class Api::PokemonController < ApplicationController

  def index
    @pokemon = Pokemon.all
    render :index
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render :show
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :attack, :defense, :moves, :image_url, :poke_type)
  end

end
