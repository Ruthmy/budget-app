require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'User Registration (Sign Up)' do
    it 'registers a new user with valid information' do
      valid_user_attributes = {
        name: 'Ruth Abreu',
        email: 'testing@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }

      post '/users', params: { user: valid_user_attributes }

      expect(response).to have_http_status(303)
      expect(response).to redirect_to(root_path)
    end

    it 'prevents registration with missing information' do
      invalid_user_attributes = {
        email: 'testing@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }

      post '/users', params: { user: invalid_user_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end
  end
end
