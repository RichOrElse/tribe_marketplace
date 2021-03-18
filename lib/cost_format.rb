module CostFormat
  refine Numeric do
    def format
      return "$#{to_i}" if to_i == self

      sprintf("$%.2f", self)
    end
  end
end
