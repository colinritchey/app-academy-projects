class Sub < ActiveRecord::Base
  validates :user_id, :title, :description, presence: true

  belongs_to :moderator,
    class_name: :User,
    foreign_key: :user_id

  has_many :posts,
    through: :postsubs,
    source: :post

  has_many :postsubs, inverse_of: :post

end
