require 'helper'

describe Faraday::Response::ArrForce do

  context 'when used' do
    let(:arr_force) { Faraday::Response::ArrForce.new(nil, :tokens) }

    it 'should create an Array for arguments' do
      env = { :body => { "tokens" => { "token" => '123', 'secret' => 'abc' } } }
      res = arr_force.on_complete(env)
      res.class.should == Hash
      res['tokens'].class.should == Array
    end

    it 'should pass through strings' do
      env = { :body => 'this is a string' }
      res = arr_force.on_complete(env)
      res.class.should == String
      res.should == 'this is a string'
    end

    it 'should properly handle arrays' do
      env = { :body => ['abc', { 'somekey' => 'somevalue'}, 123] }
      res = arr_force.on_complete(env)
      res.class.should == Array
    end

    it 'should properly handle keys nested in arrays' do
      env = { :body => ['abc', { 'tokens' => 'boo'}, 123] }
      res = arr_force.on_complete(env)
      res.class.should == Array
      res[1]['tokens'].class.should == Array
    end
  end

  context 'when not configured' do
    let(:arr_force) { Faraday::Response::ArrForce.new }

    it 'should have no impact' do
      env = { :body => { "tokens" => { "token" => '123', 'secret' => 'abc' } } }
      res = arr_force.on_complete(env)
      res.class.should == Hash
      res['tokens'].class.should == Hash
    end
  end

  context 'when passed multiple arguments' do
    let(:arr_force) { Faraday::Response::ArrForce.new(nil, [:tokens, :access_tokens]) }

    it 'should create an Array for arguments' do
      env = { :body => { "tokens" => { "token" => '123', 'secret' => 'abc' }, 'access_tokens' => 'abcdefg' } }
      res = arr_force.on_complete(env)
      res.class.should == Hash
      res['tokens'].class.should == Array
      res['access_tokens'].class.should == Array
    end
  end

  context 'integration test' do
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }
    let(:connection) do
      Faraday::Connection.new do |builder|
        builder.adapter :test, stubs
        builder.use Faraday::Response::ArrForce, :tokens, :voodoo
      end
    end

    # although it is not good practice to pass a hash as the body, if we add ParseJson
    # to the middleware stack we end up testing two middlewares instead of one
    it 'should create a Hash from the body' do
      stubs.get('/hash') {[200, {'content-type' => 'application/json; charset=utf-8'}, { "tokens" => { "token" => '123', 'secret' => 'abc' }, "otherkey" => 'xyz' }]}
      res = connection.get('/hash').body
      res['tokens'].class.should == Array
      res['tokens'].first['token'].should == '123'
      res['otherkey'].should == 'xyz'
    end
  end
end
