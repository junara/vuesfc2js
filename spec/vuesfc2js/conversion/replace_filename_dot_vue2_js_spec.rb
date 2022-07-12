# frozen_string_literal: true

require "rspec"

RSpec.describe Vuesfc2js::Conversion::ReplaceFilenameDotVue2Js do
  describe "self.call" do
    context "when the input has single quoted import vue" do
      where(:input, :expected) do
        [
          %w[HogeComponent.vue ./HogeComponent.js],
          %w[HogeComponent.js ./HogeComponent.js],
          %w[./HogeComponent.vue ./HogeComponent.js],
          %w[./HogeComponent.js ./HogeComponent.js],
          %w[fuga/HogeComponent.vue fuga/HogeComponent.js],
          %w[fuga/HogeComponent.js fuga/HogeComponent.js],
          %w[./fuga/HogeComponent.vue ./fuga/HogeComponent.js],
          %w[./fuga/HogeComponent.js ./fuga/HogeComponent.js],
          %w[@/fuga/HogeComponent.vue @/fuga/HogeComponent.js],
          %w[@/fuga/HogeComponent.js @/fuga/HogeComponent.js],
          %w[../fuga/HogeComponent.vue ../fuga/HogeComponent.js],
          %w[../fuga/HogeComponent.js ../fuga/HogeComponent.js],
          %w[HogeComponent.txt ./HogeComponent.txt],
          %w[fuga/piyo fuga/piyo]
        ]
      end

      with_them do
        it "returns the expected filename" do
          expect(described_class.call(input)).to eq(expected)
        end
      end
    end
  end
end
