# frozen_string_literal: true

require_relative 'linked_list'

class HashMap
  LOAD_FACTOR = 0.75
  attr_reader :hash, :buckets_occupied

  def initialize
    @hash = Array.new(16, LinkedList.new)
    @buckets_occupied = 0
  end

  def set(key, value)
    # sets key value pair
    # increase bucket amount if necessary
    index = hash_index(key)
    bucket = hash[index]
    if bucket.head.nil?
      @buckets_occupied += 1
    end
    # set key-value pair
    bucket.add(key, value)
    if buckets_occupied.to_f / hash.size > LOAD_FACTOR
      # grow_hash_table
    end
  end

  def get(key)
    #returns value associated with key, if not found returns nil
    index = hash_index(key)
    raise IndexError if index.negative? || index >= @hash.size

    bucket = hash[index]
    return nil if bucket.head.nil?

    bucket.get(key)
  end

  def key?(key)
    # return true/false depending on if key is in the hash map
  end

  def remove(key)
    # removes k-v pair and returns the value
    # if key not in hash, return nil
  end

  def length
    # amount of keys in hash
  end

  def clear
    # removes all entries
  end

  def keys
    # return all keys as an array
  end

  def values
    # return all entries as an array
  end

  def entries
    # return all k-v pairs as an array: [[k1, v1], [k2, v2], ... ]
  end

  private

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
end
