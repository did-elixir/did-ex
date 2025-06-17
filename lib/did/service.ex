defmodule DID.Service do
  use Grax.Schema

  schema DID.Service do
    # As defined by https://www.w3.org/TR/did-core/#service-properties

    # TODO: DID-16 support non-IRI values
    property :type, RDF.type(), required: true, type: list_of(:iri)

    # TODO: type = :iri | :json | list_of(:iri | :json)
    property :serviceEndpoint, DID.serviceEndpoint(), required: true
  end
end
