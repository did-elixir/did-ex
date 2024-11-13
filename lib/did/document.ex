defmodule DID.Document do
  use Grax.Schema
  import RDF.Sigils

  alias DID.NS.Security

  schema DID.DIDSubject do
    property :also_known_as, ~I<https://www.w3.org/ns/activitystreams#alsoKnownAs>,
      type: list_of(:iri)

    property :controller, Security.controller(), type: list_of(:iri)

    link :verification_method, Security.verificationMethod(),
      type: list_of(DID.VerificationMethod)

    # link :authentication

    # link :assertion_method

    # link :key_agreement

    # link :capability_invocation

    # link :capability_delegation

    # link :service, type: DID.Service
  end
end
