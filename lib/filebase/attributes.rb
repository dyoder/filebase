module Attributes
  
	def initialize( hash = {} ) ; self.attributes = hash ; end
	
	def attributes=( hash )
	  # copy the hash, converting all keys to strings
		@attrs = hash.inject({}) { |h,p| k,v = p; h[k.to_s] = v; h  }
	end
	
	def attributes ; @attrs ||= {} ; end
	
	def has_key?( key ) ; attributes.has_key?( key.to_s ) ; end
	
	def delete( key ) ; attributes.delete( key.to_s ) ; end
	
	def method_missing(name,*args)
	  name = name.to_s
	  case args.length
    when 0 then get( name )
    when 1
      if name[-1,1] == '=' 
        set( name[0..-2], args[0] )
      else
        super
      end
    else super
		end
	end
	
	def [](name) ; get(name) ; end
	
	def []=(name,val) ; set(name,val) ; end
	
	def set(name, val) ; attributes[name.to_s] = val ; end
	
	def get(name)
		( ( rval = attributes[name.to_s] ).is_a?( Hash ) and attributes[name.to_s] = self.class.new( rval ) ) or rval
	end
	
	def to_h ; @attrs ; end
	
  alias_method :to_hash, :to_h
  
end
