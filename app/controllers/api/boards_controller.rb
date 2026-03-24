class Api::BoardsController < ApplicationController
    before_action :authenticate_user!

    def index
        boards = current_user.boards
        render json: boards
    end

    def show
        board = current_user.boards.includes(lists: :cards).find(params[:id])
        render json: board.to_json(
  include: {
    lists: {
      include: {
        cards: {
          include: :labels   # 🔥 REQUIRED
        }
      }
    },
    labels: {}
  }
)
    end

    def create
        board = current_user.boards.new(board_params)

        if board.save
            render json: board, status: :created
        else
            render json: { errors: board.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        board = current_user.boards.find(params[:id])

        if board.update(board_params)
            render json: board
        else
            render json: { errors: board.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        board = current_user.boards.find(params[:id])
        board.destroy
        head :no_content
    end

    private

    def board_params
        params.require(:board).permit(:name)
    end
end