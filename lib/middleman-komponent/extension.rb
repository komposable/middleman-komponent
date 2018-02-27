require 'middleman-core'
require 'middleman-komponent/helpers'

module Middleman
  class MiddlemanKomponent < Extension
    option :my_option, 'default', 'An example option'

    self.defined_helpers = [Middleman::Komponent::Helpers]

    def initialize(app, options_hash={}, &block)
      super

      require 'komponent-core/component_helper'
    end
  end
end
