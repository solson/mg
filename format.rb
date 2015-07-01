require 'pp'
require 'set'

MusicGraph = Struct.new(:bands, :musicians, :connections)
Connection = Struct.new(:source, :target, :label)

def musician_variable_name(human_name)
  name_parts = human_name.gsub(/[^a-zA-Z0-9 ]/, '').downcase.split
  name_parts.last + '_' + name_parts.first[0]
end

def band_variable_name(human_name)
  human_name.gsub(/[^a-zA-Z0-9 ]/, ' ').downcase.split.join('_')
end

def parse(source)
  bands = Set.new
  musicians = Set.new
  connections = []
  current_band = nil

  lines = source.split("\n")
  lines.each do |line|
    # Ignore lines starting with question marks.
    next if line.match(/^\s*\?/)

    if line.match(/^\s/)
      # Parsing an indented line within a band section. This is a connection to
      # that band.
      abort "Unexpected indented line: '#{line}'" unless current_band

      if m = line.match(/^\s+\{(?<label>[^}]*)\}\s*(?<band>.+)$/)
        band = m[:band].strip
        bands.add(band)
        connections.push(Connection.new(band_variable_name(band),
                                        band_variable_name(current_band),
                                        m[:label]))
      elsif m = line.match(/^\s+(?:\[(?<label>[^}]*)\]\s*)?(?<musician>.+)$/)
        musician = m[:musician].strip
        musicians.add(musician)
        connections.push(Connection.new(musician_variable_name(musician),
                                        band_variable_name(current_band),
                                        m[:label]))
      else
        abort "Malformed line: '#{line}'"
      end
    else
      # Parsing a new band section.
      current_band = line.strip
      bands.add(current_band)
    end
  end

  MusicGraph.new(bands, musicians, connections)
end

def format(graph)
  graph.bands.each do |band|
    puts "#{band_variable_name(band)} = g.band '#{band}'"
  end
  puts

  graph.musicians.each do |musician|
    puts "#{musician_variable_name(musician)} = g.person '#{musician}'"
  end
  puts

  graph.connections.each do |connection|
    label = connection.label || 'member'
    puts "#{connection.target}.#{label} #{connection.source}"
  end
end

graph = parse(File.read(ARGV[0]))
format(graph)
