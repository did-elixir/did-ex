defmodule DID.NS do
  @moduledoc """
  `RDF.Vocabulary.Namespace`s for the used vocabularies within DID.
  """

  use RDF.Vocabulary.Namespace

  @vocabdoc """
  The vocabulary for DID Core v1.0 Terms.

  See <https://www.w3.org/ns/did#>
  """
  defvocab DID,
    base_iri: "https://www.w3.org/ns/did#",
    file: "did.ttl",
    case_violations: :fail
end
