require 'foreman'
require 'foreman/env'

module EnvLoader
  extend self

  def load(env_file)
    if File.exists?(env_file)
      Foreman::Env.new(env_file).entries do |name, value|
        ENV[name] ||= value
      end
    end
  end
end