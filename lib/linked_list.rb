require 'pry'
require_relative './node'

class LinkedList
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def add_node(data)
    new_node = Node.new(data)

    if @head.nil?
      @head = new_node
      return @head
    end

    current_node = traverse(@head)
    current_node.next_node = new_node
    @head
  end

  def combine(linked_list)
    first = self
    second = linked_list
    current_node = traverse(@head)
    current_node.next_node = second.head
    first
  end

  def length
    if @head.nil?
      return length = 0
    end

    length = 1
    traverse(@head) { length = length + 1 }

    length
  end

  def traverse(current_node)
    while current_node.next_node
      yield if block_given?
      current_node = current_node.next_node
    end
    current_node
  end

  def reorder_linked_list
    return if @head.nil?

    new_head = Node.new(@head.data)
    odd = LinkedList.new(new_head)
    even = LinkedList.new
    current_node = @head
    
    while current_node.next_node
      if odd.length > even.length
        even.add_node(current_node.next_node.data)
      else
        odd.add_node(current_node.next_node.data)
      end
      current_node = current_node.next_node
    end

    odd.combine(even)
    self.head = odd.head
  end
end
