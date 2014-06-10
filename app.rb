# -*- coding: utf-8 -*-
# require 'milkode/cdweb/app'

require "bundler/setup"
require "sinatra/base"

class Sample < Sinatra::Base
  get "/" do
    "Hello Heroku"
  end
end
