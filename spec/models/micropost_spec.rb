require 'spec_helper'

describe Micropost do

	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }
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

	describe 'with blank content' do

		before { @micropost.content = "" }
		it { should_not be_valid }

	end

	describe 'with more than 140 characters' do

		before { @micropost.content = "a" * 141 }
		it { should_not be_valid }		
		
	end

	describe "containing mentions" do
		before do 
			@micropost.content = "lorem ipsum @#{other_user.username}" 
			@micropost.save
			@micropost.reload
		end

		it "should convert the @ mentions to links to user profiles" do
			
			expect(@micropost.content).to eq("lorem ipsum <a href = \"/users/#{other_user.id}\">@#{other_user.username}</a>")

		end
	  
	end



end








