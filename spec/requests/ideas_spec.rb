require 'request_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do

  context 'with creator user' do

    let(:user) { create(:user, role: 'creator') }
    let(:idea) { create(:idea, user_id: user.id) }

    before { login(user) }

    describe "GET /index" do
      it 'returns a success response' do
        get :index, :params => { :id => user.id }
        resp = response.body
        data = ActiveModelSerializers::SerializableResource.new(user.ideas)
        data = data.to_json
        expect(resp).to eq(data)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => idea.id }
        data = ActiveModelSerializers::SerializableResource.new(idea).to_json
        expect(response.body).to eq(data)
      end
    end

    describe "POST /get_fields" do
      it 'returns a success response' do
        post :get_fields
        data = { regions: Idea.regions.keys, fields: Idea.fields.keys }
        data = data.to_json
        expect(response.body).to eq(data)
      end
    end

    describe "GET /create" do
      it 'returns a success response' do
        post :create, :params => {
          :idea => {
            :title => Faker::Tea.variety,
            :problem => Faker::Lorem.paragraph,
            :region => Idea.regions.keys[rand(8)],
            :field => Idea.fields.keys[rand(6)],
          }
        }
        expect(response.status).to eq(200)
      end

      it 'changes amount of ideas' do
        expect { post :create, :params => {
          :idea => {
            :title => Faker::Tea.variety,
            :problem => Faker::Lorem.paragraph,
            :region => Idea.regions.keys[rand(8)],
            :field => Idea.fields.keys[rand(6)],
          }
        }}.to change { Idea.count }.by 1
      end
    end
  end

  context 'with investor user' do
    let(:user) { create(:user, role: 'investor') }
    let(:idea) { create(:idea, user_id: user.id) }

    before { login(user) }

    describe "GET /index" do
      it 'returns a success response' do
        get :index
        resp = response.body
        data = ActiveModelSerializers::SerializableResource.new(Idea.all)
        data = data.to_json
        expect(resp).to eq(data)
      end
    end

    describe "GET /show" do
      it 'returns a success response' do
        get :show, :params => { :id => idea.id }
        data = ActiveModelSerializers::SerializableResource.new(idea).to_json
        expect(response.body).to eq(data)
      end
    end

    describe "POST /get_fields" do
      it 'returns a success response' do
        post :get_fields
        data = { regions: Idea.regions.keys, fields: Idea.fields.keys }
        data = data.to_json
        expect(response.body).to eq(data)
      end
    end
  end
end
