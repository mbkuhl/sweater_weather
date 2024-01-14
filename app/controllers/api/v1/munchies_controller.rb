class Api::V1::MunchiesController < ApplicationController

  def show
    munchies = MunchiesFacade.get_munchies(params[:destination], params[:food])
    require 'pry'; binding.pry
    render json: MunchiesSerializer.new(munchies)
  end

end