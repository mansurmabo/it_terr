require 'rails_helper'

describe PostsController, type: :controller do
  let(:params) { {login: 'username', title: 'title', description: 'text'} }

  describe "POST #create" do

    context 'success' do
      before {post :create, params: params}

      it 'response' do
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response[:title]).to eq('title')
        expect(parsed_response[:description]).to eq('text')
        expect(parsed_response[:ip_address]).to eq('0.0.0.0')
      end
    end

    context 'errors' do
      before {post :create, params: {}}

      it 'repsonse' do
        expect(response.status).to eq(422)
      end
    end

  end

  describe "GET #index" do
    let(:user) {create :user}
    let!(:posts) { create_list :post, 10, user_id: user.id}
    let!(:ratings) { create_list :rating, 100, post_id: Random.new.rand(1..10) }

    before { get :index }

    it 'response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.count).to eq(posts.count)
    end
  end

end
