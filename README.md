ArrForce
========

Parsing XML is teh suck, but sometimes you don't have a choice, who hasn't experienced this joy?

```xml
<access_tokens>
  <access_token>
    <token></token>
    <secret></secret>
  </access_token>
</access_tokens>
```
Parsing that returns this:

```
{ 'access_tokens' => { 'access_token' => { 'token' = 'abc', 'secret = '123' } }
```

What you really wanted was this:

```
{ 'access_tokens' => [ 'access_token' => { 'token' = 'abc', 'secret = '123' } ] }
```

ArrForce is a Faraday Middleware that will do that for you.  Just tell ArrForce what keys should be arrays and ArrForce will make sure they are. Simply add it to your middleware stack:

```ruby
Faraday::Connection.new do |builder|
  builder.use Faraday::Response::ArrForce, :access_tokens
  builder.use Faraday::Response::ParseXml
end
```