class LinkedList
  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @size += 1
  end

  def append(value)
    if @head.nil?
      prepend(value)
    else
      tmp = @head
      tmp = tmp.next_node until tmp.next_node.nil?

      tmp.next_node = Node.new(value, nil)
      @size = 1
    end
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end
end
