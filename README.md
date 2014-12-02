# Ruby on Rails Tutorial: sample application

This is the sample application for
the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/).

This is my implementation of the RoR tutorial written by Michael Hartl.

During the process of completing this tutorial I've made a number of tweaks and additions to the example code given on the website. I've completed most if not all of the chapter exercises, as well as added a decent amout of further test coverage that wasn't in the original examples.

Also, I've implemented unique usernames and Twitter "@" style username mentions. All of this functionality was implemented via TDD, with the Rspec tests being written prior to the implementation. Test coverage for this new functionality is fairly good as well.

A live verson of this code can be seen here: https://rocky-bastion-6661.herokuapp.com/
The code is running on Heroku's free tier, and as such, with only a single dyno, will be a bit slow. The site is populated with sample data from the lib/tasks/sample_data.rake task.

Feel free to dig through and use any of this code if you're working through the tutorial yourself and would like to see how someone else implemented it.