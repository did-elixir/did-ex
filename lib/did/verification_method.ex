defmodule DID.VerificationMethod do
  use Grax.Schema

  alias DID.NS.Security

  schema DID.VerificationMethod do
    # As defined by https://www.w3.org/TR/did-core/#verification-method-properties

    property :controller, Security.controller(), type: :iri, required: true

    # TODO: is RDF.type() correct here?
    property :type, RDF.type(), type: :string, required: true

    # TODO: use rdf:JSON type
    property :public_key_jwk, Security.publicKeyJwk(), type: :string

    property :public_key_multibase, Security.publicKeyMultibase(), type: :string
  end
end
