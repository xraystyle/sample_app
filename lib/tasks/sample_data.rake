namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end

end


def make_users

	User.create!(name: "Example User", 
				 email: "example@railstutorial.org",
				 username: "example-user", 
				 password: "foobar", 
				 password_confirmation: "foobar",
				 admin: true)

	99.times do |n|
		name = Faker::Name.name
		username = "#{Faker::Internet.user_name(specifiers = (1..18), separators = %w(- _))}#{n}"
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(name: name,
					 username: username, 
					 email: email,
					 password: password,
					 password_confirmation: password)
	end
	
end

def make_microposts
	users = User.all(limit: 6)

	# Make posts without mentions.
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end

	# make posts with mentions
	50.times do
		content = Faker::Lorem.sentence(3) + " @#{User.limit(1).order("RANDOM()").first.username} " + Faker::Lorem.sentence(2)
		users.each { |user| user.microposts.create!(content: content) }
	end

end


def make_relationships

	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user)  }
	
end


	



















