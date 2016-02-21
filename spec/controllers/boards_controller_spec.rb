require 'spec_helper'
RSpec.describe BoardsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @board = @user.boards.first
    login(@user)
  end

  after(:each) do
    if !@user.destroyed?
      @user.pinnings.destroy_all
      @user.boards.destroy_all
      @user.destroy
    end
  end

let(:valid_attributes) {
    {
      name: @board.name,
      user_id: @user.id
    }
  }

  let(:invalid_attributes) {
    {
      name: @board.name
    }
  }

  let(:valid_session) { {} }

  describe "GET new" do
    it 'responds with succesfully' do
      get :new
      expect(response.success?).to be(true)
    end

    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end

    it 'assigns an instance variable to a new board' do
      get :new
      expect(assigns(:board)).to be_a_new(Board)
    end

    #test below is not needed. show page doesn't require login
    #it 'redirects to the login page if user is not logged in' do
      #user = User.create! valid_attributes
      #get :show, {:id => @board.to_param}, valid_session
      #expect(response).to redirect_to(:login)
    #end
  end

  describe "POST create" do
    before(:each) do
      @board_hash = {
        name: "My Pins!",
        user_id: @user.id
      }
    end

    after(:each) do
      board = Board.find_by_name("My Pins!")
      if !board.nil?
        board.destroy
      end
    end

    it 'responds with a redirect' do
      post :create, board: @board_hash
      expect(response.redirect?).to be(true)
    end

    it 'creates a board' do
      post :create, board: @board_hash  
      expect(Board.find_by_name("My Pins!").present?).to be(true)
    end

    it 'redirects to the show view' do
      post :create, board: @board_hash
      new_board = Board.where(name: "My Pins!").last
      expect(response).to redirect_to(board_path(new_board.id))
    end

    it 'redisplays new form on error' do
      @board_hash[:name] = nil
    end

    it 'redirects to the login page if user is not logged in' do
      logout(@user)
      post :create, board: @board_hash
      expect(response).to redirect_to(:login)
    end
  end

  describe "GET #show" do
    it 'assigns the requested board' do
      get :show, {:id => @board.to_param}
      expect(assigns(:board)).to eq(@board)
    end

    it 'assigns the @pins variable with the board\'s pins' do
      get :index
      expect(assigns[:boards]).to eq(@user.boards)
    end
  end
end