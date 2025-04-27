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
      value                 # return/pop the last node's value
    end
  end

  def contains(value)
    tmp = @head
    until tmp.nil?
      return true if value == tmp.value

      tmp = tmp.next_node
    end
    false
  end

  def find(value)
    count = 0
    tmp = @head

    until tmp.nil?
      return count if value == tmp.value

      tmp = tmp.next_node
      count += 1
    end
    nil
  end

  def to_s
    tmp = @head
    result = []
    until tmp.nil?
      result << "( #{tmp.value} )"
      tmp = tmp.next_node
    end
    result << "( nil )" # append the nil representing the last node value
    puts result.join(" -> ")
  end

  def insert_at(value, index)
    return nil if @size.zero? || index >= @size

    if index.zero?
      prepend(value)
    else
      tmp = @head
      (index - 1).times do # move to the node before the index
        tmp = tmp.next_node
      end
    end

    new_node = Node.new(value, tmp.next_node)
    tmp.next_node = new_node
    @size += 1
  end

  def remove_at(index)
    return nil if @size.zero? || index >= @size

    if index.zero?
      @head = @head.next_node
    else
      tmp = @head
      (index - 1).times do
        tmp = tmp.next_node
      end

      # Removing the node at the specified index
      tmp.next_node = tmp.next_node.next_node

      # if we removed the last node, update the tail
      @tail = tmp if tmp.next_node.nil?
    end

    @size -= 1
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
p list.find("two")
p list.find("one")
list.to_s
list.insert_at("five", 1)
list.to_s
list.remove_at(2)
list.to_s
