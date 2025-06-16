defmodule DID.DocumentTest do
  use ExUnit.Case
  doctest DID.Document

  import RDF.Sigils

  alias DID.NS.Security

  @example_json_ld File.read!("test/fixtures/did-key.jsonld")

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
                        ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>
                      ],
                      assertion_method: [
                        ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>
                      ],
                      capability_delegation: [
                        ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>
                      ],
                      capability_invocation: [
                        ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>
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
    assert DID.Document.to_rdf(@example_document) == JSON.LD.read_string!(@example_json_ld)
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
end
