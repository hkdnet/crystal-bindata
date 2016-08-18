require "optarg"

module Crystal::Bindata
  class Option < Optarg::Model
    arg "src_dir", required: true
    string %w(-d --dst), required: true
    string %w(-n --name), required: true

    @parsed : Bool

    def initialize(*args)
      super(*args)
      @parsed = false
      @namespace = ""
      @class_name = ""
      @dir = ""
    end

    def namespace
      build_namespace unless @parsed
      @namespace
    end

    def class_name
      build_namespace unless @parsed
      @class_name
    end

    def build_namespace
      idents = dst.split("-")
      @class_name = idents.pop.camelcase
      @namespace = idents.map(&.camelcase).join("::")
      @dir = idents.join("/")
      @dir += "/" if @dir != ""
      @parsed = true
    end

    def dir
      build_namespace unless @parsed
      @dir
    end

    def filename
      File.extname(name) == ".cr" ? name : "#{name}.cr"
    end
  end
end
