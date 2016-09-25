class CommentsController < ApplicationController

  def create
    if params[:reply_id]
      @comment = Comment.new(
        game_id: params[:game_id],
        text: params[:text],
        user_id: params[:user_id],
        reply_id: params[:reply_id]
      )
    else
      @comment = Comment.new(
        game_id: params[:game_id],
        text: params[:text],
        user_id: params[:user_id]
      )
    end
    if @comment.save
      redirect_to "/games/#{@comment.game_id}"
    end
  end

end
