$:.unshift File.join(File.dirname(__FILE__))

require 'rubygems'
require 'logger'
# Set up gems listed in the Gemfile.
require 'bundler/setup'

# The "Bundler.require" line will require all your dependencies.
Bundler.require


require "server"
