require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    context 'when the user is signed in' do
      before do
        @user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123',
                            confirmed_at: Time.now)
      end

      it 'displays user-specific content' do
        sign_in @user
        get root_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not signed in' do
      it 'redirects to the splash page' do
        get root_path

        expect(response).to redirect_to(splash_index_path)
        follow_redirect!
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
