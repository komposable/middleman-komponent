require 'middleman-cli'

module Middleman
  module Cli
    class Component < ::Thor::Group
      include Thor::Actions

      protected

      Base.register(self, 'component', 'component NAME', 'Create a new component' )
    end
  end
end
