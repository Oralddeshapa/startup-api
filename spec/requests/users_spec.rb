require 'request_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let (:user) { create(:user) }
  before {  }

  context 'with authorized user' do
    before { login(user) }

    describe "GET /index" do
      it 'returns a success response' do
        skip_cancan
        get :index
        expect(response.status).to eq(200)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        skip_cancan
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

      it 'returns a correct value' do
        post :authorize, :params => {
          :email => user.email,
          :password => user.password
        }
        data = JSON.parse(response.body)
        decoded_token = JWT.decode data["token"], Rails.application.credentials.jwt_token, true, { algorithm: 'HS256' }
        decoded_token = decoded_token[0]
        expect(decoded_token["email"]).to eq(user.email)
      end
    end

    describe "GET /update" do
      it 'returns a success response' do
        post :update, :params => {
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'creator',
          },
          :id => user.id
        }
        expect(response.status).to eq(200)
      end

      it 'changes fields' do
        post :update, :params => {
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'creator',
          },
          :id => user.id
        }
        updated_user = JSON.parse(response.body)
        expect(updated_user["username"]).not_to eq(user.username)
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
            :role => 'creator',
          }
        }
        expect(response.status).to eq(200)
      end

      it 'changes amount of ideas' do
        expect { post :create, :params => {
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'creator',
          }
        }}.to change { User.count }.by 1
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
            :role => 'creator',
          },
          :id => user.id
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
