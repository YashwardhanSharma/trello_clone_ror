class Api::CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:show, :update, :destroy]

  def create
    board = current_user.boards.find(params[:board_id])
    list = board.lists.find(params[:list_id])

    @card = list.cards.create(card_params)

    render json: @card
  end

  def show
    render json: @card
  end

  def update
    if @card.update(card_params)
      if params[:label_ids]
        @card.label_ids = params[:label_ids] # 🔥 assign labels
      end

      render json: @card.to_json(include: :labels)
    else
      render json: { errors: @card.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy
    render json: { message: "Card deleted successfully" }
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :list_id)
  end

  def set_card
    @card = Card.joins(list: :board)
                .where(boards: { user_id: current_user.id })
                .find(params[:id])
  end
end