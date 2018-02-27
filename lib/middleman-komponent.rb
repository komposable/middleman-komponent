require "middleman-core"
require "middleman-komponent/version"

::Middleman::Extensions.register(:komponent) do
  require "middleman-komponent/extension"
  require "middleman-komponent/commands/component"

  ::Middleman::MiddlemanKomponent
end
