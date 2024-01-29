require_relative 'node'

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  # only need one of append and prepend
  # def append(key, value)
  #   # Creates a new instance of the Node class at the end of the list
  #   if @head.nil?
  #     prepend(key, value)
  #   else
  #     temp_node = @head
  #     temp_node = temp_node.next_node until temp_node.next_node.nil?
      
  #     new_node = Node.new(key, value)
  #     temp_node.next_node = new_node
  #     [key, value]
  #   end
  # end

  def add(key, value)
    return prepend(key, value) if @head.nil?

    if @head.key == key
      @head.value = value
      return value
    else
      temp_node = @head
      until temp_node.next_node.nil?
        if temp_node.key == key
          temp_node.value = value
          return [key, value]
        end
        temp_node = temp_node.next_node
      end
      new_node = Node.new(key, value)
      temp_node.next_node = new_node
      [key, value]
    end
  end

  def prepend(key, value)
    # Creates a new instance of the Node class at the beginning of the list
    new_node = Node.new(key, value)
    new_node.next_node = @head
    @head = new_node
    [key, value]
  end

  # def size
  #   # Returns the number of node instances in 'this' instance of LinkedList
  #   return 0 unless @head
    
  #   count = 1
  #   temp_node = @head
  #   until temp_node.next_node.nil?
  #     temp_node = temp_node.next_node
  #     count += 1
  #   end
  #   count
  # end

  def head
    # Returns the value of the first node
    @head ? [@head.key, @head.value] : nil
  end

  # def tail
  #   # Returns the value of the last node
  #   if @head
  #     temp_node = @head
  #     temp_node = temp_node.next_node until temp_node.next_node.nil?

  #     temp_node.data
  #   else
  #     nil
  #   end
  # end

  def at(index)
    # Returns the value of the node at the given index
    return nil if index > size - 1 || index < -size
    temp_node = @head
    iter = index.negative? ? size + index : index
    iter.times { temp_node = temp_node.next_node }
    temp_node.data
  end

  # def pop
  #   # Removes the last node (pointing at null)
  #   # In effect, removes the pointer and reroutes the pointer before it
  #   return "The list is empty." if @head.nil?

  #   if @head.next_node.nil?
  #     temp_val = @head.data
  #     @head = nil
  #     return temp_val
  #   end

  #   temp_node = @head
  #   temp_node = temp_node.next_node until temp_node.next_node.next_node.nil?
  
  #   temp_val = temp_node.next_node.data
  #   temp_node.next_node = nil
  #   temp_val
  # end

  # def shift
  #   # Removes the first element in the list and returns the element
  #   # Make head point to @head.next_node.next_node
  #   return "The list is empty." if @head.nil?

  #   if @head.next_node.nil?
  #     temp_val = @head.data
  #     @head = nil
  #     return temp_val
  #   end

  #   temp_val = @head.data
  #   @head = @head.next_node
  #   temp_val
  # end

  def contains?(key)
    # Returns true/false depending on if the given key is in the list
    return true if @head.key == key

    temp_node = @head
    until temp_node.next_node.nil?
      return true if temp_node.next_node.key == key
      temp_node = temp_node.next_node
    end

    false
  end

  # def find(value)
  #   # If the given value exists, return the index of the first node
  #   # Else returns nil

  #   return 0 if @head.data == value

  #   index = 1
  #   temp_node = @head
  #   until temp_node.next_node.nil?
  #     return index if temp_node.next_node.data == value
  #     index += 1
  #     temp_node = temp_node.next_node
  #   end

  #   nil
  # end

  # def insert_at(index, value)
  #   # Inserts a node with the given value at the given index.
  #   # The pointer before starts pointing to the new node
  #   return prepend(value) if index.zero?

  #   return append(value) if index == -1

  #   before_node = @head
  #   iter = index.negative? ? size + index + 1 : index
  #   (iter - 1).times { before_node = before_node.next_node }
  #   after_node = before_node.next_node
  #   new_node = Node.new(value)
  #   new_node.next_node = after_node
  #   before_node.next_node = new_node
  #   value
  # end

  # def remove_at(index)
  #   # Removes the node at the given index
  #   # The pointer from the previous skips to the following one
  #   return shift if index.zero? || index == -size

  #   return nil if index > size - 1 || index < -size

  #   before_node = @head
  #   iter = index.negative? ? size + index : index
  #   (iter - 1).times { before_node = before_node.next_node }
  #   removed_node = before_node.next_node
  #   value = removed_node.data
  #   before_node.next_node = before_node.next_node.next_node
  #   value
  # end

  def remove(key)
    return nil unless @head

    if @head.key == key
      value = @head.value
      @head = @head.next_node
      return value
    else
      temp_node = @head
      until temp_node.next_node.nil?
        if temp_node.next_node.key == key
          value = temp_node.next_node.value
          temp_node.next_node = temp_node.next_node.next_node
          return value
        end
        temp_node = temp_node.next_node
      end
      nil
    end
  end

  def to_s
    # Prints the LinkedList objects as:
    # ( value ) -> ( value ) -> ( value ) -> nil
    if @head
      temp_node = @head
      output = ''
      until temp_node.nil?
        output << "[#{temp_node.key}, #{temp_node.value}] -> "
        temp_node = temp_node.next_node
      end
      output << "nil"
    else
      output = '-> nil'
    end
    output
  end
end
