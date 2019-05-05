class CommentsController < ApplicationController

  def create
    @comment  = Comment.create(comment: comment_params[:comment], tweet_id: comment_params[:tweet_id], user_id: current_user.id)
      respond_to do |format|
          format.html { redirect_to "/tweets/#{@comment.tweet.id}"}
          format.json 
        end
      #todo_appの時は引数にはインスタンスだったけれども
  end
private
  def comment_params
    params.permit(:comment, :tweet_id)
  end
end
