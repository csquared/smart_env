# SmartEnv

## Purpose
Attach hooks to your ENV vars and wrap them in Proxy Objects.

## Example
    ENV['SERVICE'] = 'http://username:password@example.com:3000/"

    ENV['SERVICE']             #=> 'http://username:password@example.com:3000/"
    ENV['SERVICE'].base_uri    #=> 'http://example.com/"
    ENV['SERVICE'].url         #=> 'http://example.com/"
    ENV['SERVICE'].user        #=> 'username'
    ENV['SERVICE'].password    #=> 'password'
    ENV['SERVICE'].host        #=> 'example.com'
    ENV['SERVICE'].scheme      #=> 'http'
    ENV['SERVICE'].port        #=> 3000
