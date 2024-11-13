defmodule DID.VerificationMethod do
  use Grax.Schema
  import RDF.Sigils

  schema DID.VerificationMethod do
    # JSON
    property :public_key_jwk, ~I<https://w3id.org/security#publicKeyJwk>, type: :string

    property :public_key_multibase, ~I<https://w3id.org/security#publicKeyMultibase>,
      type: :string
  end
end
