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
      container.dump_at(".")
    end
  end
end
