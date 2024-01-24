# frozen_string_literal: true

class HashMap
  # attr_reader :bucket_amount

  def initialize
    @hash = []
    @bucket_amount = 16 # or some other appropriate value
  end

  def set(key, value)
    # sets key value pair
    # increase bucket amount if necessary
  end

  def get(key)
    #returns value associated with key, if not found returns nil
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

  def hash(key)
    # produces an integer, and from the key and returns the modulo
    # of that integer with respect to the bucket amount
  end
end
