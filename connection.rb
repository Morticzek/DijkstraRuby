# frozen_string_literal: true

class Connection
  attr_reader :from, :to, :weight

  def initialize(from, to, weight)
    @from = from
    @to = to
    @weight = weight
  end

  def to_s
    "Connection: from: #{from.name} to: #{to.name} weight: #{weight}"
  end
end
