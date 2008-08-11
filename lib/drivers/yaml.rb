require 'yaml'
require 'extensions/io'
class Filebase
  
  class YAML
    
    def initialize( root )
      @root = root
    end
    
  	def path( key )
  		@root / key + '.yml'
  	end
  	
  	def all
  	  Dir[ path('*') ].map { |file| ::YAML.load( File.read( file ) ) }
  	end
    
    def find( key )
  		( ::YAML.load( File.read( path( key ) ) ) if File.exists?( path( key ) ) ) || nil
  	end
  	
  	def save( key, object )
  		File.write( path( key ), object.to_yaml )
  	end
  	
  	def delete( key )
  		FileUtils.remove( path( key ) )
	  end
	  
	end

end