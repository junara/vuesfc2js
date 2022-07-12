# frozen_string_literal: true

require "rspec"

RSpec.describe Vuesfc2js::Conversion::ScriptExtraction do
  describe "self.call" do
    context "when the input has script tag" do
      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag" do
        input = <<~SFC
          <template>
            <div>
              hoge
            </div>
          </template>
          <script>
            console.log("Hello World!");
          </script>
          <style>
            display: flex;
          </style>
        SFC
        expect(described_class.call(input)).to eq(
          "  console.log(\"Hello World!\");\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength

      # rubocop:disable RSpec/ExampleLength
      it "returns the script tag with setup" do
        input = <<~SFC
          <template>
            <div>
              hoge
            </div>
          </template>
          <script setup>
            console.log("Hello World!");
          </script>
          <style>
            display: flex;
          </style>
        SFC
        expect(described_class.call(input)).to eq(
          "  console.log(\"Hello World!\");\n"
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when the input has no script tag" do
      # rubocop:disable RSpec/ExampleLength
      it "returns empty string" do
        input = <<~SFC
          <template>
            <div>
              hoge
            </div>
          </template>
          <style>
            display: flex;
          </style>
        SFC
        expect(described_class.call(input)).to eq("")
      end
      # rubocop:enable RSpec/ExampleLength
    end
  end
end
