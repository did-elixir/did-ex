defmodule DID.VerificationMethod do
  use Grax.Schema

  alias DID.NS.Security

  schema DID.VerificationMethod do
    # As defined by https://www.w3.org/TR/did-core/#verification-method-properties

    property :controller, Security.controller(), type: :iri, required: true

    property :type, RDF.type(), type: :string, required: true

    property :public_key_jwk, Security.publicKeyJwk(), type: :json

    property :public_key_multibase, Security.publicKeyMultibase(), type: :string
  end
end
