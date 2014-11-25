require 'spec_helper'

describe Mention do
  
	let(:first_user) { FactoryGirl.create(:user) }
	let(:second_user) { FactoryGirl.create(:user) }
	let(:third_user) { FactoryGirl.create(:user) }
	let(:content) { "I'm mentioning @#{first_user.username}" }
	let(:post) { second_user.microposts.create!(content: content) }
	
	before do
		@mention = Mention.where(user_id: first_user.id).where(micropost_id: post.id)
	end

	subject { @mention }

	its(:user) { should eq first_user }
	its(:micropost) { should eq post }

	describe "should respond to these methods" do
		it { should respond_to(:user) }
		it { should respond_to(:micropost) }
		it { should respond_to(:user_id) }
		it { should respond_to(:micropost_id) }
	end


	describe "when user_id is missing" do
		before { @mention.user_id = nil }
		it { should_not be_valid }
	end

	describe "when micropost_id is missing" do
		before { @mention.micropost_id = nil }
		it { should_not be_valid }
	end

	describe "creating a duplicate mention entry" do
	  
		before do
			@mention.user_id = first_user.id
			@mention.micropost_id = post.id
			@micropost.save
		end

		it "should not save to the DB" do

			expect do
			  Mention.create(user_id: first_user.id, micropost_id: post.id)
			end.not_to change(Mention, :count)

		end

	end


	describe "writing a post with a mention" do

		it "should create a new mention entry" do

			expect do
			  first_user.microposts.create!(content: "I'm mentioning @#{second_user.username}")
			end.to change(Mention, :count).by(1)

		end
	  
	end


	describe "writing a post with multiple mentions" do
		
		it "should create as many mention entries as there are mentions" do
			
			expect do
			  first_user.microposts.create!(content: "I'm mentioning @#{second_user.username} and @#{third_user.username}")
			end.to change(Mention, :count).by(2)			
		end

	end


	describe "writing a post without a mention" do

		it "should not create a new mention entry" do

			expect do
			  first_user.microposts.create!(content: "I'm not mentioning anyone.")
			end.not_to change(Mention, :count)

			# mention_count = Mention.count
			# first_user.microposts.create!(content: "I'm not mentioning anyone.")
			# expect(Mention.count).to eq(mention_count)

		end
	  
	end

	
end
