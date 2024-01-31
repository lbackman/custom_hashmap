require_relative 'node'

class LinkedList
  attr_reader :head, :size

  def initialize
    @head = nil
    @size = 0
  end

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
      @size += 1
      [key, value]
    end
  end

  def prepend(key, value)
    # Creates a new instance of the Node class at the beginning of the list
    new_node = Node.new(key, value)
    new_node.next_node = @head
    @head = new_node
    @size += 1
    [key, value]
  end

  def head
    # Returns the value of the first node
    @head ? [@head.key, @head.value] : nil
  end

  def contains?(key)
    # Returns true/false depending on if the given key is in the list
    if head.nil?
      return false
    elsif @head.key == key
      return true
    else
      temp_node = @head
      until temp_node.next_node.nil?
        return true if temp_node.next_node.key == key
        temp_node = temp_node.next_node
      end
    end
    false
  end

  def get(key)
    # If the given key exists return the value, else return nil
    if @head.key.nil?
      return nil
    elsif @head.key == key
      return @head.value
    else
      temp_node = @head
      until temp_node.next_node.nil?
        return temp_node.next_node.value if temp_node.next_node.key == key
        temp_node = temp_node.next_node
      end
    end
    nil
  end

  def remove(key)
    return nil unless @head

    if @head.key == key
      value = @head.value
      @head = @head.next_node
      @size -= 1
      return value
    else
      temp_node = @head
      until temp_node.next_node.nil?
        if temp_node.next_node.key == key
          value = temp_node.next_node.value
          temp_node.next_node = temp_node.next_node.next_node
          @size -= 1
          return value
        end
        temp_node = temp_node.next_node
      end
      nil
    end
  end

  def remove_all
    @head = nil
    @size = 0
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

  def each
    return nil unless head
    temp_node = @head
    until temp_node.next_node.nil?
      yield temp_node
      temp_node = temp_node.next_node
    end
    yield temp_node
  end
end
