defmodule DID.Document do
  use Grax.Schema
  import RDF.Sigils

  schema DID.DIDSubject do
    property :also_known_as, ~I<https://www.w3.org/ns/activitystreams#alsoKnownAs>,
      type: list_of(:iri)

    property :controller, ~I<https://w3id.org/security#controller>, type: list_of(:iri)

    link :verification_method, ~I<https://w3id.org/security#verificationMethod>,
      type: list_of(DID.VerificationMethod)

    # link :authentication

    # link :assertion_method

    # link :key_agreement

    # link :capability_invocation

    # link :capability_delegation

    # link :service, type: DID.Service
  end
end
