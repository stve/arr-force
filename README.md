ArrForce
========

Parsing XML is teh suck, but sometimes you don't have a choice, who hasn't experienced this joy?

```xml
<access_tokens>
  <access_token>
    <token>abc</token>
    <secret>123</secret>
  </access_token>
</access_tokens>
```

Parsing that returns a hash:

```
{ 'access_tokens' => { 'access_token' => { 'token' = 'abc', 'secret = '123' } }
```

What you probably wanted was this:

```
{ 'access_tokens' => [ 'access_token' => { 'token' = 'abc', 'secret = '123' } ] }
```

ArrForce is a Faraday middleware that will do that for you.  Just tell ArrForce what keys should be transformed into arrays and ArrForce will make sure they are.

Installation
------------
    gem install arr-force

Usage
-----

Simply add it to your middleware stack:

```ruby
conn = Faraday.new(:url => 'http://sushi.com') do |builder|
  builder.use Faraday::Response::ArrForce, :access_tokens
  builder.use Faraday::Response::ParseXml
end
```

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Steve Agalloco. See LICENSE for details.