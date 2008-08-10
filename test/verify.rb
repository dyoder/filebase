require 'rubygems'
require 'bacon'
Bacon.extend Bacon::TestUnitOutput
Bacon.summary_on_exit

require 'lib/filebase'
require 'lib/filebase/model'

class Person ; include Filebase::Model[ 'test/db/person' ] ; has_one :organization ; end
class Organization ; include Filebase::Model[ 'test/db/organization' ] ; has_many :members, :class => Person ; end

describe 'A filebase' do

  it 'should allow you to access an existing record' do
    Person.find( 'joe@acme.com' ).name.should == 'Joe Smith'
  end
  
  it 'should return nil if the record does not exist' do
    Person.find('jane@acme.com').should == nil
  end
  
  it 'should allow you to create a new record' do
    Person.create( :key => 'jane@acme.com', :name => 'Jane Smith' )
    Person.find( 'jane@acme.com' ).name.should == 'Jane Smith'
  end
  
  it 'should allow you to modify a record and save the change' do
    jane = Person.find( 'jane@acme.com' )
    jane.name = 'Jane Doe' ; jane.save
    Person.find( 'jane@acme.com' ).name.should == 'Jane Doe'
  end

  it "should allow you to create new attributes out of thin air" do
    jane = Person.find( 'jane@acme.com' )
    jane.gender = 'Female' ; jane.save
    Person.find( 'jane@acme.com' ).gender.should == 'Female'
  end
  
  it 'should allow you to delete a record' do
    Person.find('jane@acme.com').delete
    Person.find('jane@acme.com').should == nil
  end
  
  it 'should raise an exception if you save an object without a key' do
    lambda { Person.create( :name => 'Jane Smith' ) }.should.raise( Filebase::Error )
  end
  
  it "should allow a 'has-one' association" do
    joe = Person.find('joe@acme.com'); joe.organization = Organization.find('acme.com'); joe.save
    Person.find('joe@acme.com').organization.key.should == 'acme.com'
  end
  
  it "should allow a 'has-many' association'" do
    acme = Organization.find('acme.com'); acme.members << Person.find('joe@acme.com'); acme.save
    acme.members.include?( Person.find( 'joe@acme.com' )).should == true
  end    
  
end