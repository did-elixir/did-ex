defmodule DID.DocumentTest do
  use ExUnit.Case
  doctest DID.Document

  import RDF.Sigils

  alias DID.NS.Security

  @example_json_ld File.read!("test/fixtures/did-key.jsonld")
  @example_json_ld_missing_required File.read!("test/fixtures/did-key-missing-required.jsonld")

  @example_document DID.Document.build!(
                      ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                      verification_method: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          type: RDF.iri(Security.Ed25519VerificationKey2020),
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
                        )
                      ],
                      authentication: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          type: RDF.iri(Security.Ed25519VerificationKey2020),
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
                        )
                      ],
                      assertion_method: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          type: RDF.iri(Security.Ed25519VerificationKey2020),
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
                        )
                      ],
                      capability_delegation: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          type: RDF.iri(Security.Ed25519VerificationKey2020),
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
                        )
                      ],
                      capability_invocation: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          type: RDF.iri(Security.Ed25519VerificationKey2020),
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
                        )
                      ],
                      key_agreement: [
                        DID.VerificationMethod.build!(
                          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6LSj72tK8brWgZja8NLRwPigth2T9QRiG1uH9oKZuKjdh9p>,
                          type: ~I<https://w3id.org/security#X25519KeyAgreementKey2020>,
                          controller:
                            ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
                          public_key_multibase: "z6LSj72tK8brWgZja8NLRwPigth2T9QRiG1uH9oKZuKjdh9p"
                        )
                      ]
                    )

  test "to_rdf/1" do
    assert DID.Document.to_rdf(@example_document) ==
             JSON.LD.read_string!(@example_json_ld)
             |> RDF.Dataset.default_graph()
  end

  test "to_json_ld/2" do
    assert {:ok, result} =
             DID.Document.to_json_ld(@example_document,
               context: [
                 "https://www.w3.org/ns/did/v1",
                 "https://w3id.org/security/suites/ed25519-2020/v1",
                 "https://w3id.org/security/suites/x25519-2020/v1"
               ]
             )

    assert Jason.decode!(result) == Jason.decode!(@example_json_ld)
  end

  describe "from_json_ld/1" do
    test "with valid document" do
      assert {:ok, result} = DID.Document.from_json_ld(@example_json_ld)
      assert @example_document == result
    end

    test "with invalid JSON" do
      assert {:error, %Jason.DecodeError{}} = DID.Document.from_json_ld("{")
    end

    test "with missing ID" do
      assert {:error, :missing_id} = DID.Document.from_json_ld("{}")
    end

    test "with invalid IRI" do
      assert {:error, :invalid_iri} = DID.Document.from_json_ld("{\"id\": 1337}")
    end

    test "without required fields" do
      assert {:error,
              %Grax.ValidationError{errors: [controller: %Grax.Schema.CardinalityError{}]}} =
               DID.Document.from_json_ld(@example_json_ld_missing_required)
    end
  end
end
