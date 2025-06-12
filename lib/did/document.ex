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

    # the property in the security vocabulary is named differently as sec:authentication
    link authentication: ~I<https://w3id.org/security#authenticationMethod>,
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

  def to_json_ld(%__MODULE__{} = document, opts \\ []) do
    context = Keyword.get(opts, :context, [])

    with {:ok, rdf_graph} <- Grax.to_rdf(document),
         {:ok, json_ld_string} <- JSON.LD.write_string(rdf_graph, context: context),
         {:ok, json_ld} <- Jason.decode(json_ld_string) do
      json_ld
      |> frame_json_ld(document)
      |> Jason.encode()
    end
  end

  defp frame_json_ld(json_ld, document) do
    case json_ld do
      %{"@graph" => nodes} ->
        # Find the main DID document
        did_doc =
          Enum.find(nodes, fn node ->
            Map.get(node, "id") == to_string(document.__id__)
          end)

        # Find all verification method nodes
        vm_nodes =
          Enum.filter(nodes, fn node ->
            Map.has_key?(node, "publicKeyMultibase")
          end)

        # Create a map of VM nodes by ID for easy lookup
        vm_map = Map.new(vm_nodes, fn vm -> {vm["id"], vm} end)

        # Transform the document
        did_doc
        |> embed_verification_methods(vm_map)
        |> transform_authentication()
        |> Map.put("@context", json_ld["@context"])

      _ ->
        json_ld
        |> transform_authentication()
        |> Map.put("@context", json_ld["@context"])
    end
  end

  defp embed_verification_methods(doc, vm_map) do
    # Properties that should embed full verification methods
    embed_properties = ["verificationMethod", "keyAgreement"]

    Enum.reduce(embed_properties, doc, fn prop, acc ->
      case Map.get(acc, prop) do
        refs when is_list(refs) ->
          embedded_vms = Enum.map(refs, fn ref -> Map.get(vm_map, ref, ref) end)
          Map.put(acc, prop, embedded_vms)

        ref when is_binary(ref) ->
          embedded_vm = Map.get(vm_map, ref, ref)
          Map.put(acc, prop, [embedded_vm])

        nil ->
          acc
      end
    end)
  end

  defp transform_authentication(doc) do
    case Map.get(doc, "https://w3id.org/security#authentication") do
      nil ->
        doc

      %{"id" => id} ->
        Map.put(doc, "authentication", [id])
        |> Map.delete("https://w3id.org/security#authentication")

      refs when is_list(refs) ->
        Map.put(doc, "authentication", List.wrap(refs))
        |> Map.delete("https://w3id.org/security#authentication")
    end
  end

  # TODO: use RDF typing opt-out of Grax when available instead of this hack
  def on_to_rdf(%__MODULE__{__id__: id}, graph, _opts) do
    {
      :ok,
      graph
      |> RDF.Graph.delete({id, RDF.type(), DID.DIDSubject})
    }
  end
end
