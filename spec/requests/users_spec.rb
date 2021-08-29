require File.expand_path('./spec/request_helper.rb')

RSpec.describe Api::V1::UsersController, type: :controller do

  let (:user) { create(:user) }

  context 'with authorized user' do
    before {
      login(user)
    }

    describe "GET /index" do
      it 'returns a success response' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => user.id }
        expect(response.status).to eq(200)
      end
    end

    describe "POST /authorize" do
      it 'returns a success response' do
        post :authorize, :params => {
          :email => user.email,
          :password => user.password
        }
        expect(response.status).to eq(200)
      end
    end

    describe "GET /update" do
      it 'returns a success response' do
        post :update, :params => {
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'temporary_role',
          },
          :id => user.id
        }
        expect(response.status).to eq(200)
      end
    end
  end

  context 'with unauthorized user' do

    describe "POST /create" do
      it 'returns a success response' do
        post :create, :params => {
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'temporary_role',
          }
        }
        expect(response.status).to eq(200)
      end
    end

    describe "GET /index" do
      it 'returns a success response' do
        get :index, :params => { :token => nil }
        expect(response.status).to eq(401)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => user.id, :token => nil }
        expect(response.status).to eq(401)
      end
    end

    describe "GET /update" do
      it 'returns a success response' do
        post :update, :params => {
          :token => nil,
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'temporary_role',
          },
          :id => user.id
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
