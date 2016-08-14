module Crystal::Bindata
  class Cli
    def initialize(@args = [] of String)
      @opts = Crystal::Bindata::Option.parse(@args)
    end

    def run
    end

    def self.file_to_str(path)
      File.read(path)
    end

    def file_to_str(path)
      self.file_to_str(path)
    end
  end
end
