# frozen_string_literal: true

require_relative 'linked_list'

class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    set_up
  end

  def set(key, value)
    # sets key value pair
    index = hash_index(key)
    bucket = @hash[index]
    bucket.add(key, value)
    @key_value_pairs += 1
    # increase bucket amount if necessary
    if @key_value_pairs.to_f / @hash.size > LOAD_FACTOR
      grow_hash_table
    end
    value
  end
  alias_method :[]=, :set

  def get(key)
    #returns value associated with key, if not found returns nil
    index = hash_index(key)
    raise IndexError if index.negative? || index >= @hash.size

    bucket = @hash[index]
    return nil if bucket.head.nil?

    bucket.get(key)
  end
  alias_method :[], :get

  def key?(key)
    # return true/false depending on if key is in the hash map
    index = hash_index(key)
    @hash[index].contains?(key)
  end

  def remove(key)
    # removes k-v pair and returns the value
    # if key not in hash, return nil
    index = hash_index(key)
    @key_value_pairs -= 1 if @hash[index].contains?(key)
    @hash[index].remove(key)
  end

  def length
    # amount of keys in hash
    @key_value_pairs
  end

  def clear
    # removes all entries
    set_up
  end

  def keys
    # return all keys as an array
    keys = []
    @hash.each do |bucket|
      unless bucket.head.nil?
        bucket.each { |node| keys << node.key }
      end
    end
    keys
  end

  def values
    # return all entries as an array
    values = []
    @hash.each do |bucket|
      bucket.each { |node| values << node.value }
    end
    values
  end

  def entries
    # return all k-v pairs as an array: [[k1, v1], [k2, v2], ... ]
    entries = []
    @hash.each do |bucket|
      bucket.each { |node| entries << [node.key, node.value] }
    end
    entries
  end

  def to_s
    s = []
    entries.each do |entry|
      s << entry.join(' => ')
    end
    "{#{s.join(', ')}}"
  end

  private

  def set_up(bucket_amount = 16)
    @bucket_amount = bucket_amount
    @hash = Array.new(bucket_amount) { LinkedList.new }
    @key_value_pairs = 0
  end

  def hash_code(key)
    # produces an integer, and from the key and returns the modulo
    # of that integer with respect to the bucket amount
    string = key.to_s
    hash_code = 0
    prime_number = 31

    string.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def hash_index(key)
    # If the table has size 2^n, we can use "& (length - 1)" instead "% length"
    hash_code(key) & hash.size - 1
  end

  def grow_hash_table
    temp_entries = entries
    set_up(@bucket_amount * 2)
    temp_entries.each { |key, val| set(key, val) }
  end
end
