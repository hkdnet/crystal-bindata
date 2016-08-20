module Crystal::Bindata
  class Cli
    getter opts : Crystal::Bindata::Option
    def initialize(@args = [] of String)
      if @args.includes?("-h") || @args.includes?("--help")
        help
        exit 1
      end
      @opts = Crystal::Bindata::Option.parse(@args)
    end

    # crystal-bindata src_dir -d foo -n bar
    # -> foo/bar.cr
    def run
      container = Crystal::Bindata::Models::ContainerFactory.create(opts.src_dir, opts.dst)
      container.name = opts.name
      container.dump_at(".")
    end

    def help
      puts <<-EOS
      crystal-bindata SRC_DIR --dst DST --name NAME
        SRC_DIR     path to the directory which contains assets
        -d, --dst   path to the directory and namespace (foo/bar = Foo::Bar)
        -n, --name  filename and class name

        $ crystal-bindata foo -d bar -n baz
        This will generate bar/baz.cr. And you can use it as shown below...

        require "bar/baz"
        Bar::Baz.asset("foo/foobarbaz.txt") # => returns the content of foo/foobarbaz.txt
      EOS
    end
  end
end
