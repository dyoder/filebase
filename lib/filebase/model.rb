require 'filebase/attributes'

class Filebase
  
  Error = RuntimeError
	
	module Model
		
		def self.[]( path )
		  Module.new do |mixin|
		    ( class << mixin ; self ; end ).module_eval do
		      define_method( :included ) do | model |
  		      model.module_eval do
              @db = Filebase.new( path )
  		        extend Mixins::ClassMethods ; include Attributes ;  include Mixins::InstanceMethods
  		      end
  		    end
		    end
		  end
		end
		
		module Mixins
		  
		  module ClassMethods
		    attr_accessor :db
		    def create( assigns ) ; save( new( assigns ) ) ; end
		    def all ; db.all.map { |attrs| new( attrs ) } ; end
		    def find( key ) ; attrs = db.find( key ); new( attrs.merge( :key => key ) ) if attrs ; end
		    def []( key ) ; find( key ) ; end
		    def save( object )
		      raise( Filebase::Error.new, 'attempted to save an object with nil key' ) if object.key.nil? or object.key.empty?
          db.save( object.key, object.to_h )
		    end
		    def delete( object )
		      raise( Filebase::Error.new, 'attempted to delete an object with nil key' ) if object.key.nil? or object.key.empty?
		      db.delete( object.key )
		    end
		    def has_one( name, options = {} )
		      module_eval do
		        define_method name do
  		        @has_one ||= {}
    		      options[:class] ||= Object.module_eval( name.to_s.camel_case )
		          @has_one[name] ||= options[:class].find( get( name ) ) 
		        end
		        define_method( name.to_s + '=' ) do | val |
  		        @has_one ||= {}; @has_one[name] = nil
		          set( name, String === val ? val : val.key )
		        end
		      end
		    end
		    def has_many( name, options = {} )
		      module_eval do
		        define_method( name ) do
		          @has_many ||= {}
    		      options[:class] ||= Object.module_eval( name.to_s.camel_case )
		          @has_many[name] ||= ( get( name ) || [] ).uniq.map { |key| options[:class].find( key ) } 
		        end
            # when we save, make sure to pick up any changes to the array
            (class<<self;self;end).module_eval do
              old_save = instance_method(:save)
              define_method :save do |object|
  		          object.set( name, object.send( name ).map{ |x| x.key }.uniq )
                old_save.bind(self).call(object)
              end
            end
          end
		    end
		  end
		  
      module InstanceMethods
        def initialize( assigns ) ; super ; assign( assigns ) ; end
        def assign( assigns ) ; assigns.each { |k,v| self.send( "#{k}=", v ) }; self ; end
        def save ; self.class.save( self ) ; self; end
        def delete ; self.class.delete( self ) ; self ; end
        def ==(object) ; key == object.key ; end
      end

		end
	
	end

end