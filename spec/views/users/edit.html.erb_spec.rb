require 'spec_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "renders the edit user form" do
    render
    expect(rendered).to match(@user.first_name)
    expect(rendered).to match(@user.last_name)
    expect(rendered).to match(@user.email)
  end
end
