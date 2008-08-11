Gem::Specification.new do |s|
  s.name = %q{filebase}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Yoder"]
  s.date = %q{2008-04-30}
  s.email = %q{dan@zeraweb.com}
  s.files = ["lib/drivers/yaml.rb", "lib/filebase/attributes.rb", "lib/filebase/model.rb", "lib/filebase.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://dev.zeraweb.com/waves}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Simple file-based database with model support.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<extensions>, [">= 0"])
    else
      s.add_dependency(%q<extensions>, [">= 0"])
    end
  else
    s.add_dependency(%q<extensions>, [">= 0"])
  end
end
