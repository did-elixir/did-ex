defmodule DID.Service do
  use Grax.Schema

  schema DID.Service do
    # As defined by https://www.w3.org/TR/did-core/#service-properties

    # TODO: this is not formally defined in TTL files, how to proceed?
    # TODO: type = :string | list_of(:string)
    # property :type, ???, type: list_of(:string), required: true

    # TODO: type = :iri | :json | list_of(:iri | :json)
    property :serviceEndpoint, DID.serviceEndpoint(), type: :iri, required: true
  end
end
