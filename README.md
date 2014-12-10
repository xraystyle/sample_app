# Ruby on Rails Tutorial: sample application

This is the sample application for
the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/).

This is my implementation of the RoR tutorial written by Michael Hartl.

During the process of completing this tutorial I've made a number of tweaks and additions to the example code given on the website. I've completed most if not all of the chapter exercises, as well as added a decent amout of further test coverage that wasn't in the original examples.

Also, I've implemented unique usernames and Twitter "@" style username mentions. All of this functionality was implemented via TDD, with the Rspec tests being written prior to the implementation. Test coverage for this new functionality is fairly good as well.

Specifically, if a user creates a post with an "@username" mention, the user who was mentioned will see this post in their feed, even if they don't follow the post author. Also, anyone following the mentioned user will also see the post in their feed, regardless of whether or not they follow the post author. Following the mentioned user is enough to cause the post to appear in the feed. 

Multiple mentions per post are supported and mentions appear as links to the mentioned user profile pages. The link tags in the posts don't count toward the 140 character limit and are generated dynamically when the posts are retrieved from the database.

Also, I've implemented a Twitter-style character counter in the micropost composition window via Javascript. The character count turns red when it hits zero or below.

A live verson of this code can be seen here: https://rocky-bastion-6661.herokuapp.com/
The code is running on Heroku's free tier, and as such, with only a single dyno, will be a bit slow. The site is populated with sample data from the lib/tasks/sample_data.rake task.

Feel free to dig through and use any of this code if you're working through the tutorial yourself and would like to see how someone else implemented it.