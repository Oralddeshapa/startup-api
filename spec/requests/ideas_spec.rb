require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do

  context 'with creator user' do

    let (:user) { create(:user, role: 'creator') }
    let (:idea) { create(:idea, user_id: user.id) }

    def generate_token
      secret = Rails.application.credentials.jwt_token
      payload = {
        :email => user.email,
        :password => user.password,
        :role => user.role
      }
      token = JWT.encode payload, secret, 'HS256'
    end

    let (:token) { generate_token }

    describe "GET /index" do
      it 'returns a success response' do
        get :index, :params => { :token => token, :id => user.id }
        resp = response.body
        data = ActiveModelSerializers::SerializableResource.new(user.ideas)
        data = data.to_json
        expect(resp).to eq(data)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => idea.id, :token => token }
        data = ActiveModelSerializers::SerializableResource.new(idea).to_json
        expect(response.body).to eq(data)
      end
    end

    describe "POST /get_fields" do
      it 'returns a success response' do
        post :get_fields, :params => { :token => token }
        data = { regions: Idea.regions.keys, fields: Idea.fields.keys }
        data = data.to_json
        expect(response.body).to eq(data)
      end
    end

    describe "GET /create" do
      it 'returns a success response' do
        post :create, :params => {
          :token => token,
          :idea => {
            :title => Faker::Tea.variety,
            :problem => Faker::Lorem.paragraph,
            :rating => rand(6),
            :region => Idea.regions.keys[rand(8)],
            :field => Idea.fields.keys[rand(6)],
          }
        }
        expect(response.status).to eq(200)
      end
    end
  end

  context 'with investor user' do
    let (:user) { create(:user, role: 'investor') }
    let (:idea) { create(:idea, user_id: user.id) }

    def generate_token
      secret = Rails.application.credentials.jwt_token
      payload = {
        :email => user.email,
        :password => user.password,
        :role => user.role
      }
      token = JWT.encode payload, secret, 'HS256'
    end

    let (:token) { generate_token }

    describe "GET /index" do
      it 'returns a success response' do
        get :index, :params => { :token => token }
        resp = response.body
        data = ActiveModelSerializers::SerializableResource.new(Idea.all)
        data = data.to_json
        expect(resp).to eq(data)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => idea.id, :token => token }
        data = ActiveModelSerializers::SerializableResource.new(idea).to_json
        expect(response.body).to eq(data)
      end
    end

    describe "POST /get_fields" do
      it 'returns a success response' do
        post :get_fields, :params => { :token => token }
        data = { regions: Idea.regions.keys, fields: Idea.fields.keys }
        data = data.to_json
        expect(response.body).to eq(data)
      end
    end
  end
end
