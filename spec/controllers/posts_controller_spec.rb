require 'rails_helper'

describe PostsController do
  let(:params) { {} }
  subject { get action, params: params }

  describe "POST #create" do
    let(:action) { :create }

    it { is_expected.to be_success }

  end

end
