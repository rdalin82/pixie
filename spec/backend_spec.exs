defmodule PixieBackendSpec do
  use ESpec

  describe "start_link" do
    context "When called with no arguments" do
      it "defaults to the Memory backend" do
        allow(Pixie.Backend.Memory).to accept(:start_link, fn(_)-> :FAKE end)
        expect(Pixie.Backend.start_link :Memory).to eq(:FAKE)
      end
    end

    context "When called with a specific name" do
      it "attempts to start the named backend" do
        allow(Pixie.Backend.Foo).to accept(:start_link, fn(_)-> :FAKE2 end)
        expect(Pixie.Backend.start_link :Foo).to eq(:FAKE2)
      end
    end
  end

  describe "generate_namespace" do
    before do
      {:ok, pid} = Pixie.Backend.start_link :ETS
      {:ok, pid: pid}
    end
    finally do: Process.exit shared.pid, :normal

    context "When called with no arguments" do
      it "defaults to a length of 32" do
        expect(Pixie.Backend.generate_namespace).to have_length(32)
      end
    end

    context "When called with a length argument" do
      it "returns a namespace of the correct length" do
        expect(Pixie.Backend.generate_namespace 6).to have_length(6)
      end
    end
  end
end
