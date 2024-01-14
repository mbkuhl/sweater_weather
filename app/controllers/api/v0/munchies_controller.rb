class Api::V0::MunchiesController < ApplicationController

  def show
    munchies = MunchiesFacade.get_munchies(params[:location], params[:food])
    render json: MunchiesSerializer.new(forecast)
  end

end