module Attributes
  
	def initialize( hash = {} ) ; self.attributes = hash ; end
	
	def attributes=( hash )
	  # copy the hash, converting all keys to strings
		@attrs = hash.inject({}) { |h,p| k,v = p; h[k.to_s] = v; h  }
	end
	
	def attributes ; @attrs ||= {} ; end
	
	def method_missing(name,*args)
	  case args.length
    when 0 then get( name.to_s )
    when 1 then	set( name.to_s[0..-2], args[0] )
    else raise ArgumentError.new("#{args.length} for 0 or 1")
		end
	end
	
	def [](name) ; get(name) ; end
	
	def []=(name,val) ; set(name,val) ; end
	
	def set(name, val) ; attributes[name.to_s] = val ; end
	
	def get(name)
		( ( rval = attributes[name.to_s] ).is_a?( Hash ) and self.new( rval ) ) or rval
	end
	
	def to_h ; @attrs ; end
	
  alias_method :to_hash, :to_h
  
end
