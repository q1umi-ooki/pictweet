class UsersController < ApplicationController
  def show
    user = User.find(params[:id]) #？？show.html.erbよりcommentsテーブルのuser_idがパスの中にあり送られてくる
#このparams[:id]の中身はクリックされたcommentsテーブルのuser_idのカラムでOK？？
#⁇アソシエーションでusersテーブルにcommentsテーブルは属しているのでcommentsテーブルのuser_idにはusersテーブルのidが入る？？カラム名＝モデルクラスでないといけないから！！
    @nickname = user.nickname #今回はuserというインスタンスは定義してませんよね。current_userはUserのインスタンスです。
    @tweets = user.tweets.page(params[:page]).per(5).order("updated_at DESC")
  end #上記はUserクラスとTweetクラスの間にアソシエーションが定義されたからできる記述。
      #そもそもは= Tweet.where(user_id:current_user.id).page(prams[:page])per.(5).order("updated_at DESC")
end



# @nickname = current_user.nickname
# @tweets = current_user.tweets.page(params[:page]).per(5).order("updated_at DESC")
#今回はuserというインスタンスは定義してませんよね。current_userはUserのインスタンスです。
#     #上記はUserクラスとTweetクラスの間にアソシエーションが定義されたからできる記述。
#       #そもそもは= Tweet.where(user_id:current_user.id).page(prams[:page])per.(5).order("updated_at DESC")
