module Jekyll
  module OpenStreetMap
    class InputParser
      def self.parse(input)
        parameters = {}
        pieces = input.gsub(/\s+/m, " ").strip.split(" ")
        pieces.each do |piece|
          keyValue = piece.gsub('"', "").split("=") 
          if keyValue.length == 2
            parameters.store keyValue[0].strip, keyValue[1].strip
          end
        end

        parameters
      end
    end
  end
end