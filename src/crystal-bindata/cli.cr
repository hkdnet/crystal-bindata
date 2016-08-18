module Crystal::Bindata
  class Cli
    getter opts : Crystal::Bindata::Option
    def initialize(@args = [] of String)
      @opts = Crystal::Bindata::Option.parse(@args)
    end

    # crystal-bindata src_dir -d foo -n bar
    # -> foo/bar.cr
    def run
      container = Crystal::Bindata::Models::ContainerFactory.create(opts.src_dir, opts.dst)
      container.name = opts.name
      container.dump_at(opts.dst)
    end

    def self.file_to_str(path)
      File.read(path)
    end

    def file_to_str(path)
      self.file_to_str(path)
    end
  end
end
