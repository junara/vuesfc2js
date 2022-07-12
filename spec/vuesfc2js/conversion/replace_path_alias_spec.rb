# frozen_string_literal: true

require "rspec"

RSpec.describe Vuesfc2js::Conversion::ReplacePathAlias do
  describe "self.call" do
    context "when the input has single quoted at_sign_path" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        at_sign_path = { "@" => "fuga/puyo" }
        input = <<~SCRIPT
          import HogeComponent from '@/HogeComponent.js';
          import HogeComponent from '@/HogeComponent.js';
        SCRIPT
        expect(described_class.call(input, at_sign_path)).to eq(
          "import HogeComponent from 'fuga/puyo/HogeComponent.js';\nimport HogeComponent from 'fuga/puyo/HogeComponent.js';\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when the input has double quoted at_sign_path" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        at_sign_path = { "@" => "fuga/puyo" }
        input = <<~SCRIPT
          import HogeComponent from "@/HogeComponent.js";
          import HogeComponent from "@/HogeComponent.js";
        SCRIPT
        expect(described_class.call(input, at_sign_path)).to eq(
          "import HogeComponent from \"fuga/puyo/HogeComponent.js\";\nimport HogeComponent from \"fuga/puyo/HogeComponent.js\";\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when at_sign_path is none" do
      let(:input) do
        <<~SCRIPT
          import HogeComponent from "@/HogeComponent.js";
          import HogeComponent from "@/HogeComponent.js";
        SCRIPT
      end

      it "nothing is happened" do
        at_sign_path = nil
        expect(described_class.call(input, at_sign_path)).to eq(
          "import HogeComponent from \"@/HogeComponent.js\";\nimport HogeComponent from \"@/HogeComponent.js\";\n"
        )
      end
    end

    context "when at_sign_path is nil" do
      let(:input) do
        <<~SCRIPT
          import HogeComponent from "@/HogeComponent.js";
          import HogeComponent from "@/HogeComponent.js";
        SCRIPT
      end

      it "nothing is happened" do
        expect(described_class.call(input)).to eq(
          "import HogeComponent from \"@/HogeComponent.js\";\nimport HogeComponent from \"@/HogeComponent.js\";\n"
        )
      end
    end
  end
end
