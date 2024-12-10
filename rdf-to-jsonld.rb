# frozen_string_literal: true

require 'rubygems'
require 'json/ld'
require 'rdf/turtle'

infile = ARGV[0]

context = [
  'https://www.w3.org/ns/did/v1',
  'https://w3id.org/security/suites/ed25519-2020/v1',
  'https://w3id.org/security/suites/x25519-2020/v1'
]

graph = File.open(infile, 'r') do |io|
  RDF::Graph.new << RDF::Turtle::Reader.new(io.read)
end

JSON::LD::API.fromRdf(graph, useNativeTypes: true, useRdfType: false) do |expanded|
  # compacted = JSON::LD::API.compact(expanded, context)

  # compacted = StringIO.new
  # writer = JSON::LD::Writer.new(compacted) do |writer|
  #   writer.context = context
  #   writer.graph = false
  # end
  # writer.dump(expanded)

  compacted = JSON::LD::API.frame(expanded, { '@context' => context })

  puts compacted.to_json
end
