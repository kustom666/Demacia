# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'demacia'
  s.version     = '0.0.4'
  s.date        = '2013-12-11'
  s.summary     = "Demacia helps ruby devs get data from the League of Legends API"
  s.description = "For Demacia!"
  s.authors     = ["Paul Forti"]
  s.email       = 'paul.forti@gmail.com'
  s.files       = ["lib/Demacia.rb", "lib/demacia/Page.rb", "lib/demacia/Rune.rb", "lib/demacia/Summoner.rb", "lib/demacia/Talent.rb"]
  s.homepage    = 'http://rubygems.org/gems/demacia'
  s.license     = 'MIT'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'openuri'
  s.add_runtime_dependency 'htmlentities'

  s.add_development_dependency 'json'
  s.add_development_dependency 'openuri'
  s.add_development_dependency 'htmlentities'
end