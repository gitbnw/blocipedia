require 'rails_helper'

RSpec.describe Wiki, type: :model do
    
     it { should have_many(:collaborators) }
     
end
