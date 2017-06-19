class Hash
  # Returns a new hash with all keys converted using the +block+ operation.

  def transform_keys
    return enum_for(:transform_keys) { size } unless block_given?
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

Rspec.describe Hash
  it "Returns a new hash with all keys converted using the +block+ operation" do
    hash=Hash.new()
  hash.transform_keys { |key| key.to_s.upcase }
  hash.transform_keys.with_index { |k, i| [k, i].join }

    expect(hash).to_have_key(:k)
    expect(hash).to_have_value(:i)

end



  # Destructively converts all keys using the +block+ operations.
  # Same as +transform_keys+ but modifies +self+.
  def transform_keys!
    return enum_for(:transform_keys!) { size } unless block_given?
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end


  # Returns a new hash with all keys converted to strings.

  Rspec.describe Hash
  it "Returns a new hash with all keys converted to strings" do
  hash=Hash.new(name: 'Oksana', age: '28')
  hash.stringify_keys

  def stringify_keys
    transform_keys(&:to_s)
  end

  # Destructively converts all keys to strings. Same as
  # +stringify_keys+, but modifies +self+.
  def stringify_keys!
    transform_keys!(&:to_s)
  end

  # Returns a new hash with all keys converted to symbols, as long as
  # they respond to +to_sym+.
Rspec.describe Hash
  it "Returns a new hash with all keys converted to symbols, as long as they respond to +to_sym+." do
    hash = Hash('person' => { 'name' => 'Rob', 'age' => '28' } )
    hash.symbolize_keys
  end

  def symbolize_keys
    transform_keys { |key| key.to_sym rescue key }
  end
  alias_method :to_options,  :symbolize_keys

  # Destructively converts all keys to symbols, as long as they respond
  # to +to_sym+. Same as +symbolize_keys+, but modifies +self+.
  def symbolize_keys!
    transform_keys! { |key| key.to_sym rescue key }
  end
  alias_method :to_options!, :symbolize_keys!

  # Validates all keys in a hash match <tt>*valid_keys</tt>, raising
  # +ArgumentError+ on a mismatch.

  describe User do
  it { should alias_from(:username).to(:email) }
  end

  RSpec::Matchers.define :alias_from do p |:to_options!; :symbolize_keys!|
    match do |subject|
      begin
        subject.send(:to_options!, :symbolize_keys!)
      rescue NoMethodError
        raise "expected alias_method from #{:to_options!; :symbolize_keys!} to #{@original_method} but #{:to_options!; :symbolize_keys!} is not defined"
      end

      subject.method(:to_options!, :symbolize_keys!).should eq(subject.method(@original_method))
    end

    description do
      "RSpec matcher for alias_method"
    end

    failure_message_for_should do |text|
      "expected alias_method from #{:to_options!; :symbolize_keys!} to #{@original_method}"
    end

    failure_message_for_should_not do |text|
      "do not expected alias_method from #{:to_options!; :symbolize_keys!} to #{@original_method}"
    end

    chain(:to) { |original_method| @original_method = original_method }
  end

  def assert_valid_keys(*valid_keys)
    valid_keys.flatten!
    each_key do |k|
      unless valid_keys.include?(k)
        raise ArgumentError.new("Unknown key: #{k.inspect}. Valid keys are: #{valid_keys.map(&:inspect).join(', ')}")
      end
    end
  end

  # Returns a new hash with all keys converted by the block operation.
  # This includes the keys from the root hash and from all
  # nested hashes and arrays.

  def deep_transform_keys(&block)
    _deep_transform_keys_in_object(self, &block)
  end

  # Destructively converts all keys by using the block operation.
  # This includes the keys from the root hash and from all
  # nested hashes and arrays.
  def deep_transform_keys!(&block)
    _deep_transform_keys_in_object!(self, &block)
  end

  Rspec.describe Hash
  it "includes the keys from the root hash and from all" do
    hash=Hash.new(name: 'Oksana', age: '28')
    hash.stringify_keys
  def deep_stringify_keys
    deep_transform_keys(&:to_s)
  end
  Rspec.describe Hash
  it "includes the keys from the root hash and from all" do
    hash=Hash.new(name: 'Oksana', age: '28')
    hash.deep_stringify_keys!
  def deep_stringify_keys!
    deep_transform_keys!(&:to_s)
  end

    Rspec.describe Hash
    it "Returns a new hash with all keys converted to symbols, as long as they respond to +to_sym+. This includes the keys from the root hash and from all nested hashes and arrays." do
      hash = Hash('person' => { 'name' => 'Rob', 'age' => '28' } )
      hash.deep_symbolize_keys
    end

  def deep_symbolize_keys
    deep_transform_keys { |key| key.to_sym rescue key }
  end

  def deep_symbolize_keys!
    deep_transform_keys! { |key| key.to_sym rescue key }
  end

  private
    # support methods for deep transforming nested hashes and arrays
    def _deep_transform_keys_in_object(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = _deep_transform_keys_in_object(value, &block)
        end
      when Array
        object.map { |e| _deep_transform_keys_in_object(e, &block) }
      else
        object
      end
    end

  end

  end
  end
end

