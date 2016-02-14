require 'spec_helper'
RSpec.describe PinsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  after(:each) do
    if !@user.destroyed?
      @user.destroy
    end
  end

  describe "GET index" do
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'populates @pins with all pins associated with user' do
      get :index
      expect(assigns[:pins]).to eq(Pin.where(user_id: @user.id))
    end

    it 'logouts the user' do
      logout(@user)
      get :index
      expect(response).to redirect_to(:login)
    end
  end

  describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end

    it 'logs out the user' do
      logout(@user)
      get :new
      expect(response).to redirect_to(:login)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2
      }
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
    it 'logouts the user' do
      logout(@user)
      get :create
      expect(response).to redirect_to(:login)
    end
  end

  describe "GET edit" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard-edit", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}  
        @edit_pin = Pin.create(@pin_hash)
    end


    after(:each) do
      @edit_pin.destroy
    end

    it 'responds with successfully' do
      get :edit, id: @edit_pin.id
      expect(response).to render_template("edit")
    end

    it 'renders the edit view' do
      get :edit, id: @edit_pin.id   
      expect(response).to render_template(:edit)
    end

    it 'assigns an instance variable called @pin to the pin with the appropriate id' do
      get :edit, id: @edit_pin.id
      expect(assigns(:pin)).to eq(@edit_pin)
    end

    it 'logouts the user' do
      logout(@user)
      get :edit, id: @edit_pin.id
      expect(response).to redirect_to(:login)
    end
  end

  describe "POST update" do
    before(:each) do
        @update_pin = FactoryGirl.create(:pin)#Pin.create(@update_pin_hash)
    end


    after(:each) do
      @update_pin.destroy
    end

    #it 'renders the update template' do
      #post :update, pin: @update_pin
      #expect(response).to render_template("update")
    #end

    #it 'populates @pins with all pins' do
     #get :update
     #expect(assigns[:pins]).to eq(Pin.all)
    #end
    it 'logouts the user' do
      logout(@user)
      post :update, id: @update_pin
      expect(response).to redirect_to(:login)
    end
  end

end