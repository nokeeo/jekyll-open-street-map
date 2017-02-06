# Jekyll::OpenStreetMap
A Jekyll plugin that includes a Liquid Tag for embedding an Open Street Map in a page.

## Installation
Unlike Google Maps, Open Street Map does not require an API Key.  Just install the gem.
```
gem install jekyll-open_street_map
```

## Usage
To embed a map in a page use the `open_street_map` tag.
```
{% open_street_map %}
```

### Map Marker
To place a marker on the map assign the location property in a pages front matter to the latitude and longitude delimited by a comma.
```
location: 43.084110, -77.665945
```

### Map Properties
You can set properties on the map tag directly use a `key="value"` style. The tag supportes the following properties:

#### Height/Width
Set the height and/or the width of the map to the specified pixel value. The map is by default 150x150 pixels.
```
{% open_street_map height="100px" width="100px" %}
```

#### Class
Set a custom class name for the map DOM element.

#### ID
Sets a custom id for the map DOM element. The default is open_street_map.

## Contributing
For all feature request and bug reports please submit an issue on the [issues page](https://github.com/nokeeo/jekyll-open_street_map/issues). If you are interested in contributing source please open a PR.

## Licence
The gem is available as open source under the terms of the MIT License.
