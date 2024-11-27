defmodule DID.Document do
  use Grax.Schema
  import RDF.Sigils

  alias DID.NS.Security

  schema DID.DIDSubject do
    # As defined by https://www.w3.org/TR/did-core/#did-document-properties

    property :also_known_as,
             ~I<https://www.w3.org/ns/activitystreams#alsoKnownAs>,
             type: list_of(:iri)

    # TODO: type = :iri | list_of(:iri)
    property :controller,
             Security.controller(),
             type: list_of(:iri)

    link verification_method: Security.verificationMethod(),
         type: list_of(DID.VerificationMethod)

    # TODO: type = list_of(:iri | :json)
    link authentication: Security.authentication(),
         type: list_of(DID.VerificationMethod)

    # TODO: type = list_of(:iri | :json)
    link assertion_method: Security.assertionMethod(),
         type: list_of(DID.VerificationMethod)

    # TODO: type = list_of(:iri | :json)
    link key_agreement: Security.keyAgreementMethod(),
         type: list_of(DID.VerificationMethod)

    # TODO: type = list_of(:iri | :json)
    link capability_invocation: Security.capabilityInvocationMethod(),
         type: list_of(DID.VerificationMethod)

    # TODO: type = list_of(:iri | :json)
    link capability_delegation: Security.capabilityDelegationMethod(),
         type: list_of(DID.VerificationMethod)

    link service: DID.service(), type: list_of(DID.Service)
  end
end
