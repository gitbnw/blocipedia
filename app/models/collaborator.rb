class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  
   def self.update_collaborators(collaborator_string, wiki_id)

     return Collaborator.none if collaborator_string.blank?

     collaborator_string.split(",").map do |collaborator|
       Collaborator.find_or_create_by(user_id: User.find_by(email: collaborator.strip), wiki_id: wiki_id)
       
     end
   end  
  
end
