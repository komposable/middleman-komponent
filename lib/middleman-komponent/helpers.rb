module Middleman
  module Komponent
    module Helpers
      def component(component_name, locals = {}, &block)
        capture_block = Proc.new { capture(&block) } if block

        require_relative(app.root + "/frontend/components/#{component_name}/#{component_name}_component")
        component_module = "#{component_name}_component".classify.constantize

        context = @app.generic_template_context.dup
        context.class_eval do
          include component_module
        end

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

        path = app.root + "/frontend/components/#{component_name}/_#{component_name}.slim"

        content_renderer = ::Middleman::FileRenderer.new(@app, path)
        content = content_renderer.render(locals, {}, context, &capture_block)

        content
      end
      alias c component

    end
  end
end
