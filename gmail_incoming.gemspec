# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gmail_incoming/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stéphane Busso"]
  gem.email         = ["stephane.busso@gmail.com"]
  gem.description   = %q{check bounced and complaint from gmail account}
  gem.summary       = %q{check bounced and complaint from gmail account}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gmail_incoming"
  gem.require_paths = ["lib"]
  gem.version       = GmailIncoming::VERSION
  gem.add_dependency 'mail'
  gem.add_dependency 'gmail'
end
