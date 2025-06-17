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

  @vocabdoc """
  The Security Vocabulary.

  See <https://w3id.org/security>
  """
  defvocab Security,
    base_iri: "https://w3id.org/security#",
    file: "security.ttl",
    case_violations: :fail,
    alias: [
      CryptosuiteString: "cryptosuiteString",
      Multibase: "multibase"
    ]
end
