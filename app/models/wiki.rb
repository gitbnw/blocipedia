class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  
  belongs_to :user
  
  scope :public_wikis, -> { where(private: false) } 
  scope :collaborators_for, -> { where(:user_id => user.collaborators.select(:wiki_id)) }
  scope :written_by, -> { where(:user_id => user) }
  
end
