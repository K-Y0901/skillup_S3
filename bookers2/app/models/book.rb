class Book < ApplicationRecord 
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # いいね数順
  has_many :favorited_users, through: :favorites, source: :user
  
  
  validates :title, presence: true
  validates :body ,presence: true, length: {maximum: 200}
  validates :rate, presence: true
  validates :category, presence: true
	
  # PV数カウント
  is_impressionable
  
  # 一覧画面　並び替え
  scope :latest, -> {order(created_at: :desc)}
  scope :rate, -> {order(rate: :desc)}
  
  # 検索機能
  def self.search(search)
    return Book.all unless search
    Book.where(['category LIKE ?', "%#{search}%"])
  end
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

