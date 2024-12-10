defmodule DIDTest do
  use ExUnit.Case
  doctest DID

  alias DID.TestNamespaces.EX
  import RDF.Sigils

  {properties, classes} = Enum.split_with(DID.NS.DID.__terms__(), &RDF.Utils.downcase?/1)
  @classes classes
  @properties properties

  describe "RDF.Vocabulary.Namespace compatibility" do
    Enum.each(@classes, fn class ->
      test "DID.#{class} can be resolved to a RDF.IRI" do
        assert DID
               |> Module.concat(unquote(class))
               |> RDF.iri() ==
                 DID.NS.DID
                 |> Module.concat(unquote(class))
                 |> RDF.iri()
      end
    end)

    Enum.each(@properties, fn property ->
      test "DID.#{property}/0" do
        assert apply(DID, unquote(property), []) ==
                 apply(DID.NS.DID, unquote(property), [])
      end

      test "DID.#{property}/2" do
        assert apply(DID, unquote(property), [EX.S, EX.O]) ==
                 apply(DID.NS.DID, unquote(property), [EX.S, EX.O])
      end

      test "DID.#{property}/1" do
        o = RDF.iri(EX.O)
        desc = apply(DID.NS.DID, unquote(property), [EX.S, o])
        assert apply(DID, unquote(property), [desc]) == [o]
      end
    end)

    test "__file__/0" do
      assert DID.__file__() == DID.NS.DID.__file__()
    end
  end

  describe "emit example JSON-LD document" do
    @example """
    {
        "@context": [
          "https://www.w3.org/ns/did/v1",
          "https://w3id.org/security/suites/ed25519-2020/v1",
          "https://w3id.org/security/suites/x25519-2020/v1"
        ],
        "id": "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK",
        "verificationMethod": [{
          "id": "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK",
          "type": "Ed25519VerificationKey2020",
          "controller": "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK",
          "publicKeyMultibase": "z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
        }],
        "authentication": [
          "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
        ],
        "assertionMethod": [
          "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
        ],
        "capabilityDelegation": [
          "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
        ],
        "capabilityInvocation": [
          "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK"
        ],
        "keyAgreement": [{
          "id": "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6LSj72tK8brWgZja8NLRwPigth2T9QRiG1uH9oKZuKjdh9p",
          "type": "X25519KeyAgreementKey2020",
          "controller": "did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK",
          "publicKeyMultibase": "z6LSj72tK8brWgZja8NLRwPigth2T9QRiG1uH9oKZuKjdh9p"
        }]
    }
    """

    test "generates expected output" do
      schema =
        DID.Document.build!(
          ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
          verification_method: [
            DID.VerificationMethod.build!(
              ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK#z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
              type: "Ed25519VerificationKey2020",
              controller: ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
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
              type: "X25519KeyAgreementKey2020",
              controller: ~I<did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK>,
              public_key_multibase: "z6LSj72tK8brWgZja8NLRwPigth2T9QRiG1uH9oKZuKjdh9p"
            )
          ]
        )

      # require IEx
      # IEx.pry()

      result =
        schema
        |> Grax.to_rdf!()
        |> RDF.Turtle.write_file!("example.ttl",
          prefixes: [did: DID, sec: DID.NS.Security],
          force: true
        )

      # |> JSON.LD.write_string!(
      #   context: "https://www.w3.org/ns/did/v1"
      #   # context: [
      #   #   "https://www.w3.org/ns/did/v1"
      #   #   "https://w3id.org/security/suites/ed25519-2020/v1",
      #   #   "https://w3id.org/security/suites/x25519-2020/v1"
      #   # ]
      # )
      # |> Jason.decode!()

      # expected =
      # @example
      # |> Jason.decode!()

      # assert expected == result
    end
  end
end
