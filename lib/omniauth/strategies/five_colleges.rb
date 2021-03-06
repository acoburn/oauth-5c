require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class FiveColleges < OmniAuth::Strategies::OAuth
      
      option :name, 'fivecolleges'
      
      option :client_options, {
        :access_token_path => "/oauth/access_token",
        :authorize_path => "/oauth/authorize",
        :request_token_path => "/oauth/request_token",
        :site => "https://www.ats.amherst.edu"
      }
      
      uid { 
        user_info['id']
      }
      
      info do 
        {
          :email => user_info['email'],
          :name => user_info['displayName'],
          :id => user_info['id']
        }
      end
      
      extra do
        {
          :raw_info => raw_info
        }
      end

      # Return info gathered from the flickr.people.getInfo API call 
     
      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/oauth/user_profile').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      # Provide the "Person" portion of the raw_info
      
      def user_info
        @user_info ||= raw_info.nil? ? {} : raw_info
      end
      
      def request_phase
        options[:authorize_params] = {:perms => options[:scope]} if options[:scope]
        super
      end
    end
  end
end
