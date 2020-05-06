class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    num = key.hash
    if self.include?(num) == false
      @count += 1
      self[num] << num
    end
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    if self.include?(key)
      self[key.hash].delete(key.hash)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each { |num| insert(num)}
  end
end
