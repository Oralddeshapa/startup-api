require 'request_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

  context 'with authorized creator' do
    let (:user) { create(:user, role: "investor") }
    let(:idea) { create(:idea, user_id: user.id) }
    before { login(user) }

    describe "under the post" do
      it 'saves comment' do
        get :create, :params => {
          :comment => {
            :text => 'Some text',
            :idea_id => idea.id,
          },
          :idea_id => idea.id
        }
        expect(response.status).to eq(200)
      end
    end
  end
end
