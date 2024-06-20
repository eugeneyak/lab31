module Refinements
  refine String do
    def presence = self == "" ? nil : self
  end
end