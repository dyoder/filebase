require 'rubygems'
require 'lib/yaml'
require 'lib/symbol'
require 'lib/string'
class Filebase
  class << self ; attr_accessor :storage ; end
  self.storage = YAML
	def initialize( root = '.', storage = nil )
		@storage = ( storage || Filebase.storage ).new( root )
	end
	# delegate everything to the storage object ...
	def method_missing( name,*args ) ; @storage.send( name, *args ) ; end
end