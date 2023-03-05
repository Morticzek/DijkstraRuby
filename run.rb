# frozen_string_literal: true
require './dijkstra.rb'

require 'gtk3'

class MyWindow < Gtk::Window
  def initialize
    super("My Application")
    self.border_width = 10
    self.set_default_size(400, 300)
    self.signal_connect("destroy") { Gtk.main_quit }

    # Create a box to hold the text field, button, and text view
    box = Gtk::Box.new(:vertical, 5)
    self.add(box)

    # Create a text field
    entry = Gtk::Entry.new
    entry.placeholder_text = "Enter some text"
    box.pack_start(entry, :expand => false, :fill => false, :padding => 0)

    # Create a text view
    text_view = Gtk::TextView.new
    text_view.editable = false
    scrolled_window = Gtk::ScrolledWindow.new
    scrolled_window.set_policy(:automatic, :automatic)
    scrolled_window.add(text_view)
    box.pack_start(scrolled_window, :expand => true, :fill => true, :padding => 0)

    # Create a button
    button = Gtk::Button.new(:label => "Run Dijkstra")
    button.signal_connect("clicked") do
      buffer = text_view.buffer
      buffer.text = entry.text
      dijkstra = Dijkstra.new
      dijkstra.load_from_text_file
      dijkstra.get_unique_vertex_names
      dijkstra.main_stage(entry.text)
      buffer.text = dijkstra.print_result(entry.text)
    end
    box.pack_start(button, :expand => false, :fill => false, :padding => 0)

    show_all
  end
end

win = MyWindow.new
Gtk.main

# dijkstra = Dijkstra.new
# dijkstra.load_from_text_file
# dijkstra.get_unique_vertex_names
# dijkstra.main_stage('Częstochowa')
