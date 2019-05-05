require 'rails_helper'
describe TweetsController do
    describe "GET #new"do
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
            #responseは遷移先のビューの情報を持つインスタンス
            #render_template引数で指定したアクションがリクエストされた時に
            #自動的に遷移するビューを返す。
        end
    end
    describe "GET #edit" do
        it "assigns the requested tweet to @tweet" do
            tweet = create(:tweet) #spec/factories/tweets.rbでダミー設定
            get :edit, params: {id: tweet} #ここでのインスタンス
            expect(assigns(:tweet)).to eq tweet 
            #assignsメソッドはアクションで定義しているインスタンス変数を確認する
            #ためのもの引数には直前でリクエストしたアクション（get :edit）内で定義
            #されているインスタンス変数をシンボル型でとる
        end
        it "renders the :edit template" do
            tweet = create(:tweet)
            get :edit, params: {id: tweet}
            expect(response).to render_template :edit
        end
    end
    describe "GET #index" do
        it "populates an array of tweets ordered by created_at DESC" do
            tweets = create_list(:tweet, 3) #3つのtweetsレコードを作りました。
            #3つ作ったのに伴ってuserも３名分作成されます。その時みんな同じemailだと
            #バリデーションに引っかかってしまうのでFakerを使います
            get  :index
            expect(assigns(:tweets)).to match(tweets.sort{|a, b| b.created_at <=> a.created_at })
            #matchで終わると降順のソートができない。ここでまたFakerを使う。
        end

        it "renders the :index template" do
            get  :index
            expect(response).to render_template :index
        end
    end
 end