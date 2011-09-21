# SmartEnv

    gem install smart_env
  
    require 'smart_env'

## Purpose
Attach hooks to your ENV vars and wrap them in Proxy Objects.

## Example with built-in URI Proxy
    ENV['SERVICE'] = 'http://username:password@example.com:3000/"

    ENV['SERVICE']             #=> 'http://username:password@example.com:3000/"
    ENV['SERVICE'].base_uri    #=> 'http://example.com/"
    ENV['SERVICE'].url         #=> 'http://example.com/"
    ENV['SERVICE'].user        #=> 'username'
    ENV['SERVICE'].password    #=> 'password'
    ENV['SERVICE'].host        #=> 'example.com'
    ENV['SERVICE'].scheme      #=> 'http'
    ENV['SERVICE'].port        #=> 3000

## Add your own Proxies
    class TestProxy
      def initialize(value)
      end
    end

    ENV.use(TestProxy).when { |key, value| key == 'FOO' }

    ENV['FOO'] = 'bar'
    ENV['FOO'].class           #=> TestProxy

## License

SmartENV distributed under the terms of the MIT License. See [LICENSE][] for details.

[LICENSE]: /csquared/smart_env/blob/master/LICENSE

