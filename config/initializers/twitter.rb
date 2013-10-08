# coding: utf-8
Twitter.configure do |config|
   config.consumer_key       = Setting.twitter_key
   config.consumer_secret    = Setting.twitter_secret
   config.oauth_token        = Setting.oauth_token
   config.oauth_token_secret = Setting.oauth_token_secret
end

