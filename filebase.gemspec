Gem::Specification.new do |s|
  s.name = %q{filebase}
  s.version = "0.2.0"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Yoder"]
  s.date = %q{2008-04-30}
  s.email = %q{dan@zeraweb.com}
  s.files = ["lib/attributes.rb", "lib/filebase.rb", "lib/model.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://dev.zeraweb.com/waves}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.0.1}
  s.summary = %q{Simple file-based database with model support.}

  s.add_dependency(%q<extensions>, [">= 0"])
end
