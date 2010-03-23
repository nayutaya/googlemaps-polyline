
Gem::Specification.new do |s|
  s.specification_version     = 2
  s.required_rubygems_version = Gem::Requirement.new(">= 0")
  s.required_ruby_version     = Gem::Requirement.new(">= 1.8.6")

  s.name    = "nayutaya-googlemaps-polyline"
  s.version = "0.0.1"
  s.date    = "2010-03-23"

  s.authors = ["Yuya Kato"]
  s.email   = "yuyakato@gmail.com"

  s.summary     = "Google Maps Polyline Utility"
  s.description = "Polyline Encoder/Decoder for Google Maps API"
  s.homepage    = "http://github.com/nayutaya/googlemaps-polyline/"

  s.rubyforge_project = nil
  s.has_rdoc          = false
  s.require_paths     = ["lib"]

  s.files = [
    "lib/googlemaps_polyline/core.rb",
    "lib/googlemaps_polyline/decoder.rb",
    "lib/googlemaps_polyline/encoder.rb",
    "lib/googlemaps_polyline/version.rb",
    "lib/googlemaps_polyline.rb",
    "nayutaya-googlemaps-polyline.gemspec",
    "nayutaya-googlemaps-polyline.gemspec.erb",
    "Rakefile",
    "test/core_test.rb",
    "test/decoder_test.rb",
    "test/encoder_test.rb",
    "test/test_helper.rb",
  ]
  s.test_files = [
    "test/core_test.rb",
    "test/decoder_test.rb",
    "test/encoder_test.rb",
    "test/test_helper.rb",
  ]
  s.extra_rdoc_files = []
end
