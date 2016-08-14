describe "E2E" do
  it "" do
    c = Crystal::Bindata::Models::ContainerFactory.create("spec/integration/fixture/data", namespace: "namespace")
    c.dump_at("spec/integration/dist")
    io = MemoryIO.new
    Process.run("crystal", ["run", "spec/integration/dist/main.cr"], output: io)
    expected = <<-EOS
    hello, world
    hello, world
    EOS
    io.to_s.chomp.should eq expected
  end
end
