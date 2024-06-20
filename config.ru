require "roda"
require "mysql2"

require_relative "utils/refinements"
require_relative "database"
require_relative "app"

run App.freeze.app