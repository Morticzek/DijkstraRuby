# frozen_string_literal: true

class Vertex
  attr_reader :name, :previous, :total_distance, :is_visited

  def initialize(name)
    @name = name
    @previous = nil
    @total_distance = Float::INFINITY
    @is_visited = false
  end

  def set_previous(previous)
    @previous = previous
  end

  def set_total_distance(total_distance)
    @total_distance = total_distance
  end

  def set_is_visited(is_visited)
    @is_visited = is_visited
  end

  def to_s
    "Vertex: name: #{name} previous: #{previous} total_distance: #{total_distance} is_visited: #{is_visited}"
  end
end
