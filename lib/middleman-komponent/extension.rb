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
    require 'komponent-core/component_helper'

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

      # Append component module into context
      require_relative(app.root + "/frontend/components/#{component_name}/#{component_name}_component")
      component_module = "#{component_name}_component".classify.constantize

      context = @app.generic_template_context.dup
      context.class_eval do
        include component_module
      end

      # Append locals into context
      context.instance_eval do
        if component_module.respond_to?(:properties)
          locals = locals.dup
          component_module.properties.each do |name, options|
            unless locals.has_key?(name)
              if options.has_key?(:default)
                locals[name] = options[:default]
              elsif options[:required]
                raise "Missing required component parameter: #{name}"
              end
            end
          end
        end

        locals.each do |name, value|
          instance_variable_set(:"@#{name}", locals[name])
        end

        instance_variable_set(:"@block_given_to_component", capture_block)
      end

      ### Rendering component
      path = app.root + "/frontend/components/#{component_name}/_#{component_name}.slim"

      content_renderer = ::Middleman::FileRenderer.new(@app, path)
      content = content_renderer.render(locals, {}, context, &capture_block)

      content
    end
    alias c component
  end
end
