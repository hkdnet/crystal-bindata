module Crystal::Bindata::Models
  class Resource
    getter name : String
    getter value : String
    def initialize(@name, @value)
    end

    def to_value_str(idx, indent = 4)
      <<-OEOS
      str#{idx} = <<-EOS
      #{value}
      EOS
      OEOS
    end

    def to_tuple_str(idx, indent = 4)
      <<-EOS
      "#{name}" => str#{idx},
      EOS
    end
  end
end

