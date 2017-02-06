require 'pp'

module Jekyll
  module OpenStreetMap
    class API
      @@css_file_name = "leaflet.css"
      @@js_file_name = "leaflet.js"
      @@images_dir_name = "images/"

      def self.head_includes(site)
        siteUrl = site.config["url"]
        baseUrl = "#{siteUrl}/#{site.baseurl}"
        "#{css_include baseUrl}#{js_include baseUrl}"
      end

      def self.write_css(site)
        css = File.read css_read_path

        if !Dir.exist?(css_write_parent_dir(site.dest))
          Dir.mkdir css_write_parent_dir(site.dest)
        end

        File.open(css_write_path(site.dest), "w+") do |file|
          file.write css
          file.close
        end
      end

      def self.write_js(site)
        js = File.read js_read_path

        if !Dir.exist?(js_write_parent_dir(site.dest))
          Dir.mkdir js_write_parent_dir(site.dest)
        end

        File.open(js_write_path(site.dest), "w+") do |file|
          file.write js
          file.close
        end

        def self.write_images(site)
          FileUtils.cp_r images_dir_read_path, "#{site.dest}/assets/"
        end
      end

      def self.images_dir_read_path
        File.expand_path("./#{@@images_dir_name}", File.dirname(__FILE__))
      end

      def self.css_include(baseUrl)
        "<link rel=\"stylesheet\" href=\"#{css_write_path baseUrl}\" />"
      end

      def self.css_read_path
        File.expand_path("./#{@@css_file_name}", File.dirname(__FILE__))
      end

      def self.css_write_path(baseUrl)
        "#{css_write_parent_dir baseUrl}#{@@css_file_name}"
      end

      def self.css_write_parent_dir(baseUrl)
        "#{baseUrl}/assets/"
      end

      def self.js_include(baseUrl)
        "<script type=\"text/javascript\" src=\"#{js_write_path baseUrl}\"></script>"
      end

      def self.js_read_path
        File.expand_path("./#{@@js_file_name}", File.dirname(__FILE__))
      end 

      def self.js_write_path(baseUrl)
        "#{js_write_parent_dir baseUrl}#{@@js_file_name}"
      end

      def self.js_write_parent_dir(baseUrl)
        "#{baseUrl}/assets/scripts/"
      end
    end
  end
end

Jekyll::Hooks.register [:documents], :post_render do |doc|
  includes = Jekyll::OpenStreetMap::API.head_includes doc.site
  doc.output = doc.output.sub("</head>", "#{includes}</head>")
end

Jekyll::Hooks.register :site, :post_write do |site|
  Jekyll::OpenStreetMap::API.write_css site
  Jekyll::OpenStreetMap::API.write_js site
  Jekyll::OpenStreetMap::API.write_images site
end