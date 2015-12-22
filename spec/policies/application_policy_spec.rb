require 'rails_helper'
require 'pundit/rspec'

describe ApplicationPolicy, type: :policy do
  subject { ApplicationPolicy }
  
let(:current_user) { FactoryGirl.build_stubbed :user }

  permissions :update?, :edit? do

    it "grants access if wiki is not private" do
      expect(subject).to permit(current_user, Wiki.new(:private => false))
    end

  end
end