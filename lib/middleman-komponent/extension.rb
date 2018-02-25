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

      require_relative(app.root + "/frontend/components/#{component_name}/#{component_name}_component")
      component_module = "#{component_name}_component".classify.constantize
      @app.template_context_class.class_eval do
        include component_module
      end

      path = app.root + "/frontend/components/#{component_name}/_#{component_name}.slim"

      content_renderer = ::Middleman::FileRenderer.new(@app, path)
      content = content_renderer.render(locals, {}, @app.generic_template_context, &capture_block)
      content
    end

    alias c component
  end
end
