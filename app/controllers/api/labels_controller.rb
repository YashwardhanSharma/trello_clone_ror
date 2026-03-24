class Api::LabelsController < ApplicationController
  before_action :authenticate_user!

  def create
    board = current_user.boards.find(params[:board_id])

    label = board.labels.create(label_params)

    render json: label
  end

  private

  def label_params
    params.require(:label).permit(:name, :color)
  end
end