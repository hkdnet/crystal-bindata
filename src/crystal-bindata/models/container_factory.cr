module Crystal::Bindata::Models
  module ContainerFactory
    def self.create(src_dir, namespace = "", class_name = "data")
      c = Container.new(namespace, class_name)
      Dir.cd(src_dir) do
        Dir.foreach(".") do |filename|
          if File.file?(filename)
            resource = Resource.new(filename, File.read(filename))
            c.add_resource(resource)
          end
        end
      end
      c
    end
  end
end
