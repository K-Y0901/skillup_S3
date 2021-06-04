class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attachment :profile_image, destroy: false
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :name, presence: true, length: {maximum: 10, minimum: 2}
  validates :introduction, length: {maximum: 50}
  
  # フォロワー
  has_many :followee, class_name: 'Relationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :follower_user, through: :followee, source: :follower
  
  # フォローしている人
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followee
  
  
  
  # has_many :followee_relationships,foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  # has_many :followee, through: :followee_relationships
  # has_many :follower_relationships,foreign_key: "followee_id",class_name: "Relationship", dependent: :destroy
  # has_many :follower, through: :follower_relationships
  
  
  # def following?(other_user)
  #   self.followings.include?(other_user)
  # end
  
  def following?(user)
      following_user.include?(user)
  end

  # def follow(other_user)
  #   unless self == other_user
  #     self.relationships.find_or_create_by(followee_id: other_user.id)
  #   end
  # end
  
  def follow(user_id)
      follower.create(followee_id: user_id)
  end
  
  # def unfollow(other_user)
  #   unless self == other_user
  #     relationship = self.relationships.find(followee_id: other_user.id)
  #     relationship.destroy if relationship
  #   end
  # end
  
  
  def unfollow(user_id)
      follower.find_by(followee_id: user_id).destroy
  end

end 

