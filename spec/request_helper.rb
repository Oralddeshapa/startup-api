require "rails_helper"

def login(user)
    allow_any_instance_of(Api::V1::ApiController).to receive(:authorized?) { true }
    allow_any_instance_of(Api::V1::ApiController).to receive(:current_user) { user }
end
