require "middleman-core"

Middleman::Extensions.register :komponent do
  require "middleman-komponent/extension"
  MiddlemanKomponent
end
