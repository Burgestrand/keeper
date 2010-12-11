module Keeper
  # Current release version of Keeper
  #
  # @see http://semver.org/
  module Version
    # Incremented *only* on backwards **incompatible** changes.
    MAJOR  = 1
    
    # Incremented *only* after adding new, backwards compatible functionality.
    MINOR  = 0
    
    # Incremented *only* on backwards compatible bug fixes.
    PATCH  = 0
    
    # String representation of the current version in the form X.Y.Z
    STRING = "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
end