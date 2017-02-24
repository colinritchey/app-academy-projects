class Post < ActiveRecord::Base
  validates :title, :user_id, :content, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id

  has_many :subs,
    through: :postsubs,
    source: :sub

  has_many :postsubs, inverse_of: :sub
end
