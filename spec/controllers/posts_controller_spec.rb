require 'rails_helper'

describe PostsController, type: :controller do
  let(:params) { {login: 'username', title: 'title', description: 'text'} }

  describe "POST #create" do

    context 'success' do
      before {post :create, params: params}

      it 'with valid params' do
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response[:title]).to eq('title')
        expect(parsed_response[:description]).to eq('text')
        expect(parsed_response[:ip_address]).to eq('0.0.0.0')
      end
    end

    context 'fail' do
      before {post :create, params: {}}

      it 'with invalid params' do
        parsed_response = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to include('null value in column "login" violates not-null constraint')
      end
    end

  end

  describe "GET #index" do
    context 'without number' do
      let(:user) {create :user}

      before do
        10.times do
          user.posts.create(
            title: FFaker::BaconIpsum.word,
            description: FFaker::BaconIpsum.sentence,
            ip_address: FFaker::Internet.ip_v4_address
          )
        end
      end

      before { user.posts.each { |p| 10.times { p.ratings.create(mark: Random.new.rand(1..5))} } }
      before { get :index }

      it 'response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eq(user.posts.count)
      end
    end

    context 'with number' do
      let(:user) {create :user}
      let!(:posts) { create_list :post, 10, user_id: user.id }
      before { posts.each { |p| 10.times { p.ratings.create(mark: Random.new.rand(1..5))} } }

      before { get :index, params: { number: 5 } }

      it 'response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eq(5)
      end
    end

  end

  describe "POST #estimate" do
    context 'with valid params' do
      let(:user) {create :user}
      let!(:valid_post) { create :post, user_id: user.id}
      before { 100.times { valid_post.ratings.create(mark: Random.new.rand(1..5))} }
      before { post :estimate, params: {id: valid_post.id, mark: 5} }

      it 'successfully response' do
        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(parsed_response.to_d).to eq(valid_post.average)
        expect(valid_post.ratings.count).to eq(101)
      end
    end

    context 'with invalid params' do
      before { post :estimate, params: {id: 1} }

      it 'response with errors' do
        parsed_response = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq('Estimate not found')
      end
    end

  end
end
