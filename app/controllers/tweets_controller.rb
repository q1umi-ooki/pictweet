class TweetsController < ApplicationController

   before_action :move_to_index, except: [:index, :show]

   def index
    @tweets = Tweet.order("updated_at DESC").page(params[:page]).per(5)
   end

   def new
   end

   def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
   end

   def show #private以降に打ってしまうとビューファイルに呼び出せません。
     @tweet = Tweet.find(params[:id])
     @comments = @tweet.comments.includes(:user)
     #誰のコメントか明らかにするために、アソシエーションを使ってユーザーのレコードを取得する処理をする。
     #わかりそうなことがある。アソシエーション表記の最初のインスタンスあとはメソッド的な感じだ
    
   end

   def edit
    @tweet = Tweet.find(params[:id])
   end

   def update
    tweet= Tweet.find(params[:id])
    tweet.update(tweet_params) if tweet.user_id ==current_user.id
   end

   def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
   end
  private
   def tweet_params #ストロングパラメーターを直下に作成しています。
    params.permit(:image, :text)
   end

   def move_to_index
    redirect_to action: :index unless user_signed_in?
   end
end
