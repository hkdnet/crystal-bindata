module Crystal::Bindata::Models
  module ContainerFactory
    EXCLUDE_PATTERNS = %w(.git .gitmodules .gitignore)
    def self.create(src_dir, namespace = "", class_name = "data")
      c = Container.new(namespace, class_name)
      Dir.cd(src_dir) do
        Dir.foreach(".") do |filename|
          if !EXCLUDE_PATTERNS.includes?(filename) && File.file?(filename)
            resource = Resource.new(filename, File.read(filename))
            c.add_resource(resource)
          end
        end
      end
      c
    end
  end
end
