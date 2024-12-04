# typed: strict
# frozen_string_literal: true

require "os/linux"

module OS
  module Linux
    module Cask
      module Config
        extend T::Helpers

        requires_ancestor { ::Cask::Config }

        module ClassMethods
          DEFAULT_DIRS = T.let({
            vst_plugindir:  "~/.vst",
            vst3_plugindir: "~/.vst3",
            fontdir:        "#{ENV.fetch("XDG_DATA_HOME", "~/.local/share")}/fonts",
          }.freeze, T::Hash[Symbol, T.nilable(String)])

          sig { returns(T::Hash[Symbol, T.untyped]) }
          def self.defaults
            {
              languages: LazyObject.new { Linux.languages },
            }.merge(DEFAULT_DIRS).freeze
          end
        end
      end
    end
  end
end

Cask::Config.singleton_class.prepend(OS::Linux::Cask::Config::ClassMethods)
Cask::Config.prepend(OS::Linux::Cask::Config)
