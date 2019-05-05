class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments

  before_create :add_exclamation
 
  private
  def add_exclamation
      self.text = self.text + "!!"
  end
end
