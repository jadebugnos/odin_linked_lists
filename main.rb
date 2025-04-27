class LinkedList # rubocop:disable Style/Documentation
  attr_reader :head, :size, :tail

  def initialize
    @head = nil
    @size = 0
    @tail = nil
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @size += 1
  end

  def append(value)
    if @head.nil?
      prepend(value)
      @tail = @head
    else
      @tail.next_node = Node.new(value, nil)
      @tail = @tail.next_node
      @size += 1
    end
  end

  def at(index)
    return nil if index >= @size

    count = 0
    tmp = @head
    until count == index
      tmp = tmp.next_node
      count += 1
    end
    tmp.value
  end

  def pop
    if @size.zero?
      nil
    elsif @size == 1
      tmp = @head
      @head = nil
      @tail = nil
      tmp.value
    else
      tmp = @head

      tmp = tmp.next_node until tmp.next_node == @tail # traverse the list until we reach the second to last node

      value = @tail.value   # save the value of the last node
      @tail = tmp           # make the second to the last node the new tail
      @tail.next_node = nil # remove the last node of the list that's about to be popped
      @size -= 1            # reduce the size of the list
      value                 # return/pop the last node
    end
  end

  def contains(value)
    
  end

  class Node # rubocop:disable Style/Documentation
    attr_accessor :value, :next_node

    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end

  private_constant :Node
end

list = LinkedList.new
list.append("one")
list.append("two")
list.append("three")
# puts list.size
# puts list.at(0)
# puts list.at(2)
puts list.size
puts list.pop
puts list.size
