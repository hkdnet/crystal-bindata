module Crystal::Bindata::Models
  class Container
    getter namespace : String
    getter name : String
    getter resources : Array(Resource)

    def initialize(@namespace, @name)
      @namespace = @namespace.camelcase
      @name = @name.camelcase
      @resources = [] of Resource
    end

    def to_class(indent = 0, heredoc = "EOS")
      class_name = namespace == "" ? name : "#{namespace}::#{name}"
      str = ["class #{class_name}"]
      str << "  def self.asset(key)"
      resources.sort_by(&.name).each_with_index do |e, i|
        str << "    " + e.to_value_str(i)
      end
      str << "    {"
      resources.sort_by(&.name).each_with_index do |e, i|
        str << "      " + e.to_tuple_str(i)
      end
      str << "    }[key]"
      str << "  end"
      str << "end"
      str.join("\n").split("\n").map { |e| " " * indent + e }.join("\n")
    end

    def add_resource(resource)
      resources.push(resource)
    end

    def dump_at(base_dir)
      dir = File.join(namespace.split("::").map(&.underscore).unshift(base_dir))
      Dir.mkdir_p(dir)
      path = File.join(dir, "#{name.underscore}.cr")
      File.write(path, to_class)
    end
  end
end
