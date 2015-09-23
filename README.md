# What's This?

Git Highlighter shows you repos you might find interesting, based on your social graph on GitHub. This is great if you're looking for a new project, want to keep up with the latest tools, or just want to see what weird stuff people are building.

# Is It Live Yet?

[Not exactly!](http://git-highlighter.herokuapp.com) It takes a few minutes for the app to generate recommendations, since it has to make a lot of client calls to GitHub and recommendations are custom-tailored to each user. I'm looking at ways to speed this up.

I've also suspended the worker, so it won't generate new recommendations for anyone right now. Feel free to take the code and push it to heroku if you want to take it for a spin, or email me and ask me to switch the worker on if you're really curious.

# Anything Else I Should Know? 

All code is released under the MIT License. 

If you want to add a feature, just write some code, write some tests, and submit a pull request.
