defmodule DID.VerificationMethod do
  use Grax.Schema

  alias DID.NS.Security
  import RDF.Sigils

  schema DID.VerificationMethod do
    # As defined by https://www.w3.org/TR/did-core/#verification-method-properties

    property :controller, Security.controller(), type: :iri, required: true

    property :type, RDF.type(), type: :iri, required: true

    property :public_key_jwk, Security.publicKeyJwk(), type: :json

    property :public_key_multibase, Security.publicKeyMultibase(),
      type: :string,
      to_rdf: :public_key_multibase_to_rdf
  end

  def public_key_multibase_to_rdf(multibase, _document) do
    {:ok, RDF.Literal.new(multibase, datatype: ~I<https://w3id.org/security#multibase>)}
  end

  # TODO: use RDF typing opt-out of Grax when available instead of this hack
  def on_to_rdf(%__MODULE__{__id__: id}, graph, _opts) do
    {
      :ok,
      graph
      |> RDF.Graph.delete({id, RDF.type(), DID.VerificationMethod})
    }
  end
end
