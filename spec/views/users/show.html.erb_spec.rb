require 'spec_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @pins = @user.pins
  
    allow(view).to receive(:logged_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(@user)
  end

  it "renders attributes in <p>" do
    render
    #expect(rendered).to match(@user.first_name)
    #expect(rendered).to match(@user.last_name)
    #expect(rendered).to match(@user.email)
  end
end
