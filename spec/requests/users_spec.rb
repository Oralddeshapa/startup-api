require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:all) {
    @user = User.new(
      username: Faker::Name.first_name,
      password: Faker::Internet.email,
      email: Faker::Code.nric,
      role: 'temporary_role',
    )
    @user.save
    secret = Rails.application.credentials.jwt_token
    payload = {
      :email => @user.email,
      :password => @user.password,
      :role => @user.role
    }
    @token = JWT.encode payload, secret, 'HS256'
  }
  context 'with authorized user' do
    describe "GET /index" do
      it 'returns a success response' do
        get :index, :params => { :token => @token }
        expect(response.status).to eq(200)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => @user.id, :token => @token }
        expect(response.status).to eq(200)
      end
    end

    describe "POST /authorize" do
      it 'returns a success response' do
        post :authorize, :params => {
          :email => @user.email,
          :password => @user.password
        }
        expect(response.status).to eq(200)
      end
    end

    describe "GET /update" do
      it 'returns a success response' do
        post :update, :params => {
          :token => @token,
          :user => {
            :username => Faker::Name.first_name,
            :password => Faker::Internet.email,
            :email => Faker::Code.nric,
            :role => 'temporary_role',
          },
          :id => @user.id
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
        get :show, :params => { :id => @user.id, :token => nil }
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
          :id => @user.id
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
