class Api::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def create
    list = @board.lists.new(list_params)

    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    list = @board.lists.find_by(id: params[:id])

    if list
      list.destroy
      render json: { message: "List deleted successfully" }
    else
      render json: { error: "List not found" }, status: :not_found
    end
  end

  private

  def set_board
    @board = current_user.boards.find_by(id: params[:board_id])

    unless @board
      render json: { error: "Board not found or not authorized" }, status: :not_found
    end
  end

  def list_params
    params.require(:list).permit(:title)
  end
end