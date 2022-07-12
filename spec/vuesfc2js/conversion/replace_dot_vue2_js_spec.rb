# frozen_string_literal: true

require "rspec"

RSpec.describe Vuesfc2js::Conversion::ReplaceDotVue2Js do
  describe "self.call" do
    context "when the input has single quoted import vue" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        input = <<~SCRIPT
          import HogeComponent from '../../HogeComponent.vue';
          import HogeComponent from '../../HogeComponent.vue';
        SCRIPT
        expect(described_class.call(input)).to eq(
          "import HogeComponent from '../../HogeComponent.js';\nimport HogeComponent from '../../HogeComponent.js';\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when the input has double quoted import vue" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        input = <<~SCRIPT
          import HogeComponent from "../../HogeComponent.vue";
          import HogeComponent from "../../HogeComponent.vue";
        SCRIPT
        expect(described_class.call(input)).to eq(
          "import HogeComponent from \"../../HogeComponent.js\";\nimport HogeComponent from \"../../HogeComponent.js\";\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when the input has double quoted import js" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        input = <<~SCRIPT
          import HogeComponent from "../../HogeComponent.js";
        SCRIPT
        expect(described_class.call(input)).to eq(
          "import HogeComponent from \"../../HogeComponent.js\";\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end
  end
end
