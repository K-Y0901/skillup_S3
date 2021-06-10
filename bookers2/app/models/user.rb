class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :mails, dependent: :destroy
  
  # いいね数順
  has_many :favorited_books, through: :favorites, source: :book
  
  validates :name, presence: true, length: {maximum: 10, minimum: 2}
  validates :introduction, length: {maximum: 50}
  
  attachment :profile_image, destroy: false
  
  
  # フォロワー
  has_many :followee, class_name: 'Relationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :follower_user, through: :followee, source: :follower
  
  # フォローしている人
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followee
  
  
 
  
  def following?(user)
      following_user.include?(user)
  end
  
  def follow(user_id)
      follower.create(followee_id: user_id)
  end
 
  def unfollow(user_id)
      follower.find_by(followee_id: user_id).destroy
  end

end 

