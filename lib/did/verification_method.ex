defmodule DID.VerificationMethod do
  use Grax.Schema

  alias DID.NS.Security

  schema DID.VerificationMethod do
    # TODO: use rdf:JSON type
    property :public_key_jwk, Security.publicKeyJwk(), type: :string

    property :public_key_multibase, Security.publicKeyMultibase(), type: :string
  end
end
