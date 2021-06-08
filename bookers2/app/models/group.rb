class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    
    validates :name, presence: true
    validates :introduction, length: {maximum: 50}
  
    attachment :image, destroy: false
end
