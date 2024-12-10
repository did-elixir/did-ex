defmodule DID.Document do
  use Grax.Schema
  import RDF.Sigils

  alias DID.NS.Security

  schema DID.DIDSubject do
    # As defined by https://www.w3.org/TR/did-core/#did-document-properties

    property :also_known_as,
             ~I<https://www.w3.org/ns/activitystreams#alsoKnownAs>,
             type: list_of(:iri)

    property :controller, Security.controller(), type: list_of(:iri)

    link verification_method: Security.verificationMethod(),
         type: list_of(DID.VerificationMethod)

    link authentication: Security.authentication(),
         type: list_of(DID.VerificationMethod),
         on_missing_description: :use_rdf_node

    link assertion_method: Security.assertionMethod(),
         type: list_of(DID.VerificationMethod),
         on_missing_description: :use_rdf_node

    link key_agreement: Security.keyAgreementMethod(),
         type: list_of(DID.VerificationMethod),
         on_missing_description: :use_rdf_node

    link capability_invocation: Security.capabilityInvocationMethod(),
         type: list_of(DID.VerificationMethod),
         on_missing_description: :use_rdf_node

    link capability_delegation: Security.capabilityDelegationMethod(),
         type: list_of(DID.VerificationMethod),
         on_missing_description: :use_rdf_node

    link service: DID.service(), type: list_of(DID.Service)
  end
end
