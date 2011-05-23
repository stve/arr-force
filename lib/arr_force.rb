require 'faraday'

class Faraday::Response
  autoload :ArrForce,   'faraday/response/arr_force'
end