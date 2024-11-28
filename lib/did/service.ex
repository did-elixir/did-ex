defmodule DID.Service do
  use Grax.Schema

  schema DID.Service do
    # As defined by https://www.w3.org/TR/did-core/#service-properties

    # TODO: type = :string | list_of(:string)
    # TODO: is RDF.type() correct here?
    property :type, RDF.type(), required: true

    # TODO: type = :iri | :json | list_of(:iri | :json)
    property :serviceEndpoint, DID.serviceEndpoint(), required: true
  end
end
