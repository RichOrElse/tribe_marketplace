module NewFromRow
  def to_proc
    -> row { new(*row) }
  end
end
