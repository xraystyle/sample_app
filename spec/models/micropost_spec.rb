require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }
	before do
		# This code is not idiomatically correct.
		@micropost = user.microposts.build(content: "Lorem Ipsum")
	end

	subject { @micropost }

	its(:user) { should eq user }

	describe 'should respond to the following methods' do
		it { should respond_to(:content) }
		it { should respond_to(:user_id) }
		it { should respond_to(:user) }
	end

	it { should be_valid }

	describe 'when user id is not present' do

		before { @micropost.user_id = nil }
		
		it { should_not be_valid }

	end




end
