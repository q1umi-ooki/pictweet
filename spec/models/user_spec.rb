require 'rails_helper'
describe User do
  describe '#create' do #"#"はメソッド名を書く時の慣習
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      # まずはテストしたいプロパティを持つuserクラスのインスタンスを新規作成する。
      #スペックファイル内でモデルクラスが使えるという事実
      user.valid? #valid?←重要
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "is invalid without a email" do
      user = build(:user, email:"")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a password" do
      user = build(:user, password:"")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation:"")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "is valid with nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "is invalid if nickname's characters are over 7 " do
      user = build(:user, nickname: "kinggnu")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end
    it "is valud if nickname's characters are within 6" do
      user = build(:user, nickname: "nuuama")
      expect(user).to be_valid
    end
    it "is invalid with duplicate email address" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
    it "is invalid if password's characters are within 5 characters" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
    it "is valid if password's characters are over 6 characters" do
    user = build(:user, password: "000000", password_confirmation:"000000")
    expect(user).to be_valid
    end
  end
end
#nickname無しにはバリデーションされない。
