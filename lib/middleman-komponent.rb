require "middleman-core"

Middleman::Extensions.register :middleman-komponent do
  require "my-extension/extension"
  MyExtension
end
