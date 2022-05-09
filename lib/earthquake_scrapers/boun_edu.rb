require "ostruct"

module BounEdu

  URL = "http://www.koeri.boun.edu.tr/scripts/lasteq.asp"
  MAGNITUDE_TYPES = ['MD','ML','Mw'].freeze

  def self.make_request
    uri = URI.parse(URL)
    Net::HTTP.get_response(uri)
  end

  def self.parse_response
    response = make_request
    response = Nokogiri::HTML(response.body)
    response
        .xpath("/html/body/pre")
        .text
        .strip
        .split("\r\n")
  end

  def self.get_earthquakes
    rows = parse_response
    header_index = rows.find_index {|row| row.include? "Long(E)"}

    # TODO: check header and continue if true
    # validate_table_header(rows[header_index])

    rows[(header_index+2)..-1].map do |row|
        columns  = row.split
        time     = DateTime.parse(columns[0..1].join(' '))
        lat      = columns[2].to_f
        long     = columns[3].to_f
        depth    = columns[4].to_f
        mag_type, mag_val = parse_magnitude(columns[5..7])
        location = columns[8..-2].join(' ')

        OpenStruct.new( time: time, lat: lat, long: long, depth: depth,
          magnitude_type: mag_type, magnitude: mag_val, location_desc: location )
    end
  end

  def self.parse_magnitude(magnitudes)
    index = magnitudes.find_index {|val| !Float(val, exception: false).nil? }
    if index.nil?
        raise StandardError.new "Couldn't find any magnitude value"
    end
    [ MAGNITUDE_TYPES[index], magnitudes[index].to_f ]
  end

  def self.validate_table_header(header_string)
    header_string.eql? "Date       Time      Latit(N)  Long(E)   Depth(km)     MD   ML   Mw    Region"
  end

end