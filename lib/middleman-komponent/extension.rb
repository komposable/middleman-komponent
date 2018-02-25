# Require core library
require 'middleman-core'

# Extension namespace
class MiddlemanKomponent < ::Middleman::Extension
  option :my_option, 'default', 'An example option'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'

    # set up your extension
    # puts options.my_option
  end

  def after_configuration
    # Do something
  end

  # A Sitemap Manipulator
  # def manipulate_resource_list(resources)
  # end

  helpers do
    def component(component_name, locals = {}, &block)
      capture_block = Proc.new { capture(&block) } if block

      partial("components/#{component_name}/#{component_name}", locals: locals, &capture_block)
    end

    alias c component
  end
end
