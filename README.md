OmniAuth FiveColleges
=====================

This gem contains the FiveColleges strategy for OmniAuth.

How To Use It
-------------

If you are using rails, you need to add the gem to your `Gemfile`:

    gem 'omniauth-fivecolleges'

You can pull them in directly from github e.g.:

    gem "omniauth-fivecolleges", :git => "git://github.com/acoburn/oauth-5c.git"

Once these are in, you need to add the following to your `config/initializers/omniauth.rb`:

    Rails.application.config.middleware.use OmniAuth::Builder do
    	provider :fivecolleges, 'consumer_key', 'consumer_secret'
    end

Use the name of the class as provider(fivecolleges).


You will then need to your own key and secret.


After you have the gem running and the configuration is done, you can get to the follow url to log the user in:

	http://localhost:3000/auth/fivecolleges

Now just follow the README at: https://github.com/intridea/omniauth

Questions
---------

For any question, fell free to send me a tweet [@aarondcoburn](http://twitter.com/aarondcoburn)

