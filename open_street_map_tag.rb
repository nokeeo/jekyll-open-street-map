module Jekyll
  module OpenStreetMap
    class Tag < Liquid::Tag

      @@JS_FILE_NAME = "openStreetMap.js"

      @@DEFAULTS = {
        "height" => "150px",
        "width" => "150px",
        "class" => "open-street-map",
        "id" => "open-stree-map"
      }

      def initialize(_, input, _)
        @parameters = Jekyll::OpenStreetMap::InputParser.parse(input)
        super
      end

      def render(context)
        @parameters["locations"] = [LocationParser.parse(context.registers[:page]["location"])]
        "<div #{render_id} #{render_class}></div>
<script>
var OSMParameters = #{inline_json}
#{inline_js}
</script>"
      end

      private 
      def render_styles
        "style=\"#{render_dimensions}\""
      end

      private
      def render_class
        "class=\"#{map_class}\""
      end

      private 
      def render_id
        "id=\"#{map_id}\""
      end

      private 
      def map_class
        @parameters["class"] || @@DEFAULTS["class"]
      end

      private
      def map_id
        @parameters["id"] || @@DEFAULTS["id"]
      end

      private 
      def inline_js
        File.read(File.expand_path("./#{@@JS_FILE_NAME}", File.dirname(__FILE__)))
      end

      private
      def inline_json
        json = @@DEFAULTS.merge(@parameters)

        json.to_json
      end
    end
  end
end

Liquid::Template.register_tag(:open_street_map, Jekyll::OpenStreetMap::Tag)
