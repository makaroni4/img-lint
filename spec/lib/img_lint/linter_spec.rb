require "spec_helper"

describe IMGLint::Linter do
  describe "#lint" do
    let(:fixture_path) { File.join(File.dirname(__FILE__), "../../fixtures") }
    let(:linted_images) { linter.lint(verbose: false).map { |f| File.basename(f) } }
    let(:linter) { described_class.new(config: config) }

    context "with default config" do
      let(:linter) { described_class.new }
      let(:config) { {} }

      it "finds images that exceed 150Kb default limit" do
        expect(linted_images).to match_array(["170kb_image.jpg", "excluded_big_image_1.jpg", "excluded_big_image_2.jpg"])
      end
    end

    context "with custom config" do
      context "when file size limit is very low" do
        let(:config) { { "max_file_size" => 30 } }

        it "finds all images above the limit" do
          expect(linted_images).to match_array(["170kb_image.jpg", "40kb_image.jpg", "excluded_big_image_1.jpg", "excluded_big_image_2.jpg"])
        end
      end

      context "when file size limit is too high" do
        let(:config) { { "max_file_size" => 200 } }

        it "find no images" do
          expect(linted_images).to eq([])
        end
      end

      context "when image format is not present in config" do
        let(:config) { { "image_formats" => "png,gif" } }

        it "find no images" do
          expect(linted_images).to eq([])
        end
      end

      context "when image is excluded" do
        let(:config) { { "exclude" => [
          "spec/fixtures/excluded_big_image_1.jpg",
          "spec/fixtures/excluded_folder/**.jpg"
        ]} }

        it "excludes specified images" do
          expect(linted_images).to match_array(["170kb_image.jpg"])
        end
      end
    end
  end
end
