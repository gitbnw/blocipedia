require 'rails_helper'
require 'pundit/rspec'

describe WikiPolicy, type: :policy do
  subject { WikiPolicy }
  
let(:current_user) { FactoryGirl.build_stubbed :user }

  permissions :update?, :edit? do

    it "grants access if wiki is not private" do
      expect(subject).to permit(current_user, Wiki.new(:private => false))
    end
    
    it "does not allow access to private wiki" do
      expect(subject).not_to permit(current_user, Wiki.new(:private => true))
    end

  end
end