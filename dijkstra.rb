# frozen_string_literal: true
require './vertex.rb'
require './connection.rb'

class Dijkstra
  def initialize
    @vertices = []
    @connections = []
    @buffer = ''
  end

  def add_vertex(name)
    @vertices << Vertex.new(name)
  end

  def add_connection(from, to, weight)
    @connections << Connection.new(from, to, weight)
  end

  def load_from_text_file
    file = File.open('routes.txt', 'r')
    File.readlines(file).each do |line|
      from, to, weight = line.split(' ')
      add_connection(from, to, weight.to_i)
    end
  end

  def get_unique_vertex_names
    @names = []
    @connections.each do |connection|
      @names << connection.from
      @names << connection.to
    end
    @names.uniq!
    @names.each do |name|
      add_vertex(name)
    end
  end

  def main_stage(word)
    @vertices.each do |vertex|
      if vertex.name == word
        vertex.set_total_distance(0)
      end
    end
    @vertices.each do |_|
      @min_vertex = ''
      @min_distance = Float::INFINITY
      @inspected_vertex = ''
      @vertices.each do |vertex2|
        if vertex2.is_visited == false && vertex2.total_distance < @min_distance
          @min_distance = vertex2.total_distance
          @min_vertex = vertex2.name
        end
      end
      if @min_vertex != ''
        @vertices.each do |vertex3|
          if vertex3.name == @min_vertex
            vertex3.set_is_visited(true)
          end
        end
      end
      @connections.each do |connection|
        if connection.from == @min_vertex || connection.to == @min_vertex
          if connection.from == @min_vertex
            @inspected_vertex = connection.to
          else
            @inspected_vertex = connection.from
          end
          @vertices.each do |vertex4|
            if vertex4.name == @inspected_vertex
              if vertex4.total_distance > @min_distance + connection.weight
                vertex4.set_total_distance(@min_distance + connection.weight)
                vertex4.set_previous(@min_vertex)
              end
            end
          end
        end
      end
    end
    print_result(word)
  end

  def print_result(word)
    @buffer = "Vertices for #{word}:\n"
    puts "Vertices for #{word}"
    @vertices.each do |vertex|
      if vertex.name != word
        @buffer += "Vertex: #{vertex.name} Distance: #{vertex.total_distance} Previous: #{vertex.previous}\n"
        puts vertex
      end
    end
    @buffer
  end
end
