class Namespace::Data
  def self.asset(key)
    str0 = <<-EOS
hello, world
hello, world

EOS
    {
      "foo.txt" => str0,
    }[key]
  end
end