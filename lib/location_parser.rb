module Jekyll
  module OpenStreetMap
    class LocationParser
      def self.parse(locStr)
        latLon = locStr.split(",").map {|val| val.strip}

        {
          :lat => latLon[0].to_f,
          :lng => latLon[1].to_f
        }
      end
    end
  end
end
