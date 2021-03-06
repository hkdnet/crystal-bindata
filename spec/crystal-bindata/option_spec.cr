require "../spec_helper"

describe Crystal::Bindata::Option do
  describe ".parse" do
    it "parse -d" do
      opt = Crystal::Bindata::Option.parse(%w(foo -d bar -n foobar))

      opt.d.should eq "bar"
      opt.dst.should eq opt.d
    end

    it "parse --dst" do
      opt = Crystal::Bindata::Option.parse(%w(foo --dst bar -n foobar))

      opt.d.should eq "bar"
      opt.dst.should eq opt.d
    end
  end

  cases = [
    { input: "foo", namespace: "", class_name: "Foo", dir: "" },
    { input: "foo-bar", namespace: "Foo", class_name: "Bar", dir: "foo/" },
    { input: "foo-foo_bar", namespace: "Foo", class_name: "FooBar", dir: "foo/" },
    { input: "foo_bar-foo_bar", namespace: "FooBar", class_name: "FooBar", dir: "foo_bar/" },
  ]
  cases.each do |kase|
    subject = Crystal::Bindata::Option.parse(["foo", "-d", "#{kase[:input]}", "-n", "foobar"])
    describe "#namespace" do
      it "returns #{kase[:namespace]}" { subject.namespace.should eq kase[:namespace] }
    end
    describe "#class_name" do
      it "returns #{kase[:class_name]}" { subject.class_name.should eq kase[:class_name] }
    end
    describe "#dir" do
      it "returns #{kase[:dir]}" { subject.dir.should eq kase[:dir] }
    end
  end

  describe "#filename" do
    describe "with .cr" do
      subject = Crystal::Bindata::Option.parse(%w(foo -d foo-bar -n piyo))
      it "returns with .cr" do
        subject.filename.should eq "piyo.cr"
      end
    end

    describe "with .cr" do
      subject = Crystal::Bindata::Option.parse(%w(foo -d foo-bar -n piyo.cr))
      it "returns with .cr" do
        subject.filename.should eq "piyo.cr"
      end
    end
  end

  describe "#src_dir" do
    subject = Crystal::Bindata::Option.parse(%w(foo -d foo-bar -n piyo))
    it "returns foo" do
      subject.src_dir.should eq "foo"
    end
  end
end
