require 'turbolinks/version'
require 'turbolinks/redirection'

module Turbolinks
  module Controller
    extend ActiveSupport::Concern

    included do
      include Redirection
    end
  end

  class Engine < ::Rails::Engine
    config.turbolinks = ActiveSupport::OrderedOptions.new
    config.turbolinks.auto_include = true
    config.assets.paths += [File.expand_path("../assets/javascripts", __FILE__)] if config.respond_to?(:assets)

    initializer :turbolinks do |app|
      ActiveSupport.on_load(:action_controller) do
        if app.config.turbolinks.auto_include
          include Controller
        end
      end
    end
  end
end
