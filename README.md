OmniAuth FiveColleges
=====================

This gem contains the (OAuth-based) FiveColleges strategy for OmniAuth.


How To Use It
-------------

If you are using rails, you need to add the gem to your `Gemfile`:

    gem 'omniauth-fivecolleges'

You can pull them in directly from github e.g.:

    gem "omniauth-fivecolleges", :git => "git://github.com/acoburn/oauth-5c.git"

Once this has been added, you need to inform your application about omniauth.

If you are using `devise`, you will need to add the appropriate configuration to
`config/initializers/devise.rb`. For example:

    config.omniauth :fivecolleges, 'consumer_key', 'consumer_secret', :strategy_class => OmniAuth::Strategies::FiveColleges

After you have the gem running and the configuration is done, you can get to the follow url to login:

	http://localhost:3000/auth/fivecolleges

You may also wish to adjust the `config/locales/devise.en.yml` like so:

    en:
      devise:
        omniauth_callbacks:
          failure: "Could not authenticate you from %{kind} because \"%{reason}\"."
          success: "Successfully authenticated from %{kind} account."


User Model
----------

In order to integrate this into your user model, you may need to adjust your `app/models/user.rb` file,
including these lines:

    devise :omniauthable, :omniauth_providers => [:fivecolleges]

    def self.find_for_fivecolleges_oauth(auth)
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.provider = auth.provider
            user.id = auth.uid
            user.email = auth.info.email
            user.display_name = auth.info.name
        end
    end


User Controller
---------------

The user controller (`app/controllers/users/omniauth_callbacks_controller.rb`) also needs to be informed
of the omniauth configuration. For example:

    class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
        def fivecolleges
            @user = User.find_for_fivecolleges_oauth(request.env["omniauth.auth"])

            if @user.persisted?
                sign_in_and_redirect @user, :event => :authentication
                set_flash_message(:notice, :success, :kind => "Five Colleges") if is_navigational_format?
            else
                session["devise.fivecollege_data"] = request.env["omniauth.auth"]
                redirect_to new_user_registration_url
            end 
        end 
    end

Now just follow the README at: https://github.com/intridea/omniauth

Questions
---------

For any question, fell free to send me a tweet [@aarondcoburn](http://twitter.com/aarondcoburn)

