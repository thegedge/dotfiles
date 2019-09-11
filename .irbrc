def silent_require(name)
  require name
rescue LoadError
end

def silent_require_relative(name)
  require_relative name
rescue LoadError
end

def im(thing)
  thing.public_instance_methods(false) + thing.private_instance_methods(false) + thing.protected_instance_methods(false)
end

def m(thing)
  thing.public_methods(false) + thing.private_methods(false) + thing.protected_methods(false)
end

silent_require 'bigdecimal'
silent_require 'bigdecimal/util'
silent_require 'forwardable'
silent_require 'irb/completion'
silent_require 'json'
silent_require 'pathname'
silent_require 'pp'
silent_require 'yaml'

silent_require 'active_support'
silent_require 'active_support/timezone'
silent_require 'benchmark/ips'

silent_require_relative File.join(ENV['HOME'], '.irb_private')

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
