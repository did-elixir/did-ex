# DID Document Property Extensions
## Known Extensions for DID Document properties and values
### W3C Group Note 19 February 2025

## Abstract

This document serves as a collection of known DID Document properties and property values.

## Status of This Document

_This section describes the status of this document at the time of its publication. A list of current W3C publications and the latest revision of this technical report can be found in the [W3C technical reports index](https://www.w3.org/TR/) at https://www.w3.org/TR/._

Comments regarding this document are welcome. Please file issues directly on [GitHub](https://github.com/w3c/did-extensions/issues/), or send them to [public-did-wg@w3.org](mailto:public-did-wg@w3.org) ( [subscribe](mailto:public-did-wg-request@w3.org?subject=subscribe), [archives](https://lists.w3.org/Archives/Public/public-did-wg/)).

Portions of the work on this specification have been funded by the United States Department of Homeland Security's Science and Technology Directorate under contracts HSHQDC-16-R00012-H-SB2016-1-002, 70RSAT20T00000010, and HSHQDC-17-C-00019. The content of this specification does not necessarily reflect the position or the policy of the U.S. Government and no official endorsement should be inferred.

Work on this registry has also been supported by the Rebooting the Web of Trust community facilitated by Christopher Allen, Shannon Appelcline, Kiara Robles, Brian Weller, Betty Dhamers, Kaliya Young, Kim Hamilton Duffy, Manu Sporny, Drummond Reed, Joe Andrieu, and Heather Vescent, Dmitri Zagidulin, and Dan Burnett.

This document was published by the [Decentralized Identifier Working Group](https://www.w3.org/groups/wg/did) as a Group Note using the [Note track](https://www.w3.org/policies/process/20231103/#recs-and-notes).

This Group Note is endorsed by the [Decentralized Identifier Working Group](https://www.w3.org/groups/wg/did), but is not endorsed by W3C itself nor its Members.

This is a draft document and may be updated, replaced or obsoleted by other documents at any time. It is inappropriate to cite this document as other than work in progress.

The [W3C Patent Policy](https://www.w3.org/policies/patent-policy/) does not carry any licensing requirements or commitments on this document.

This document is governed by the [03 November 2023 W3C Process Document](https://www.w3.org/policies/process/20231103/).

## Table of Contents

1.  [Abstract](https://www.w3.org/TR/did-extensions-properties/#abstract)
2.  [Status of This Document](https://www.w3.org/TR/did-extensions-properties/#sotd)
3.  [1\. Introduction](https://www.w3.org/TR/did-extensions-properties/#introduction)
    1.  [1.1 The Registration Process](https://www.w3.org/TR/did-extensions-properties/#the-registration-process)
    2.  [1.2 Conformance](https://www.w3.org/TR/did-extensions-properties/#conformance)
4.  [2\. Property Names](https://www.w3.org/TR/did-extensions-properties/#property-names)
    1.  [2.1 DID document properties](https://www.w3.org/TR/did-extensions-properties/#did-document-properties)
        1.  [2.1.1 id](https://www.w3.org/TR/did-extensions-properties/#id)
        2.  [2.1.2 alsoKnownAs](https://www.w3.org/TR/did-extensions-properties/#alsoknownas)
        3.  [2.1.3 controller](https://www.w3.org/TR/did-extensions-properties/#controller)
        4.  [2.1.4 verificationMethod](https://www.w3.org/TR/did-extensions-properties/#verificationmethod)
        5.  [2.1.5 publicKey](https://www.w3.org/TR/did-extensions-properties/#publickey)
        6.  [2.1.6 service](https://www.w3.org/TR/did-extensions-properties/#service)
        7.  [2.1.7 linkedResource](https://www.w3.org/TR/did-extensions-properties/#linkedresource)
        8.  [2.1.8 dnsValidationDomain](https://www.w3.org/TR/did-extensions-properties/#dnsvalidationdomain)
    2.  [2.2 Verification relationships](https://www.w3.org/TR/did-extensions-properties/#verification-relationships)
        1.  [2.2.1 assertionMethod](https://www.w3.org/TR/did-extensions-properties/#assertionmethod)
        2.  [2.2.2 authentication](https://www.w3.org/TR/did-extensions-properties/#authentication)
        3.  [2.2.3 capabilityDelegation](https://www.w3.org/TR/did-extensions-properties/#capabilitydelegation)
        4.  [2.2.4 capabilityInvocation](https://www.w3.org/TR/did-extensions-properties/#capabilityinvocation)
        5.  [2.2.5 keyAgreement](https://www.w3.org/TR/did-extensions-properties/#keyagreement)
    3.  [2.3 Verification method properties](https://www.w3.org/TR/did-extensions-properties/#verification-method-properties)
        1.  [2.3.1 publicKeyJwk](https://www.w3.org/TR/did-extensions-properties/#publickeyjwk)
        2.  [2.3.2 publicKeyBase58](https://www.w3.org/TR/did-extensions-properties/#publickeybase58)
        3.  [2.3.3 publicKeyHex](https://www.w3.org/TR/did-extensions-properties/#publickeyhex)
        4.  [2.3.4 publicKeyMultibase](https://www.w3.org/TR/did-extensions-properties/#publickeymultibase)
        5.  [2.3.5 blockchainAccountId](https://www.w3.org/TR/did-extensions-properties/#blockchainaccountid)
        6.  [2.3.6 ethereumAddress](https://www.w3.org/TR/did-extensions-properties/#ethereumaddress)
    4.  [2.4 Service properties](https://www.w3.org/TR/did-extensions-properties/#service-properties)
        1.  [2.4.1 serviceEndpoint](https://www.w3.org/TR/did-extensions-properties/#serviceendpoint)
5.  [3\. Property Values](https://www.w3.org/TR/did-extensions-properties/#property-values)
    1.  [3.1 Verification method types](https://www.w3.org/TR/did-extensions-properties/#verification-method-types)
        1.  [3.1.1 JsonWebKey2020](https://www.w3.org/TR/did-extensions-properties/#jsonwebkey2020)
        2.  [3.1.2 EcdsaSecp256k1VerificationKey2019](https://www.w3.org/TR/did-extensions-properties/#ecdsasecp256k1verificationkey2019)
        3.  [3.1.3 Ed25519VerificationKey2018](https://www.w3.org/TR/did-extensions-properties/#ed25519verificationkey2018)
        4.  [3.1.4 Bls12381G1Key2020](https://www.w3.org/TR/did-extensions-properties/#bls12381g1key2020)
        5.  [3.1.5 Bls12381G2Key2020](https://www.w3.org/TR/did-extensions-properties/#bls12381g2key2020)
        6.  [3.1.6 PgpVerificationKey2021](https://www.w3.org/TR/did-extensions-properties/#pgpverificationkey2021)
        7.  [3.1.7 RsaVerificationKey2018](https://www.w3.org/TR/did-extensions-properties/#rsaverificationkey2018)
        8.  [3.1.8 X25519KeyAgreementKey2019](https://www.w3.org/TR/did-extensions-properties/#x25519keyagreementkey2019)
        9.  [3.1.9 EcdsaSecp256k1RecoveryMethod2020](https://www.w3.org/TR/did-extensions-properties/#ecdsasecp256k1recoverymethod2020)
        10.  [3.1.10 VerifiableCondition2021](https://www.w3.org/TR/did-extensions-properties/#verifiablecondition2021)
    2.  [3.2 Service types](https://www.w3.org/TR/did-extensions-properties/#service-types)
        1.  [3.2.1 LinkedDomains](https://www.w3.org/TR/did-extensions-properties/#linkeddomains)
        2.  [3.2.2 LinkedVerifiablePresentation](https://www.w3.org/TR/did-extensions-properties/#linkedverifiablepresentation)
        3.  [3.2.3 DIDCommMessaging](https://www.w3.org/TR/did-extensions-properties/#didcommmessaging)
        4.  [3.2.4 Web of Things (WoT) Discovery](https://www.w3.org/TR/did-extensions-properties/#wot-discovery-service-type)
        5.  [3.2.5 CredentialRegistry](https://www.w3.org/TR/did-extensions-properties/#credentialregistry)
        6.  [3.2.6 OpenID4 Verifiable Credential Issuance](https://www.w3.org/TR/did-extensions-properties/#openid4-verifiable-credential-issuance)
        7.  [3.2.7 OpenID4 Verifiable Presentation](https://www.w3.org/TR/did-extensions-properties/#openid4-verifiable-presentation)
6.  [A. References](https://www.w3.org/TR/did-extensions-properties/#references)
    1.  [A.1 Normative references](https://www.w3.org/TR/did-extensions-properties/#normative-references)
    2.  [A.2 Informative references](https://www.w3.org/TR/did-extensions-properties/#informative-references)

_This section is non-normative._

This document serves as a collection of known DID Document properties and property values.

The registration process is described in the [Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/).

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key word _MUST_ in this document is to be interpreted as described in [BCP 14](https://datatracker.ietf.org/doc/html/bcp14) \[[RFC2119](https://www.w3.org/TR/did-extensions-properties/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] \[[RFC8174](https://www.w3.org/TR/did-extensions-properties/#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")\] when, and only when, they appear in all capitals, as shown here.

The following section defines the properties available for use in a DID document. Note that some of these properties are defined in the [DID Core Specification](https://www.w3.org/TR/did-core), and others are defined elsewhere and may be method- or domain-specific. Please read the associated specifications to ensure that the properties you use are appropriate for your implementation. The properties are arranged here according to the purpose they serve.

Issue

This registry is a work in progress and some properties are missing normative definitions. We are working on this! This does NOT mean that in future it will be possible to submit items to the registry without normative definitions (see [1.1 The Registration Process](https://www.w3.org/TR/did-extensions-properties/#the-registration-process)).

These properties are foundational to DID documents, and are expected to be useful to all DID methods.

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-subject) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 1](https://www.w3.org/TR/did-extensions-properties/#example-example-of-id-property)

: Example of id property

```
{
  "id": <span>"did:example:123"</span>,
  ...
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#also-known-as) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 2](https://www.w3.org/TR/did-extensions-properties/#example-example-of-alsoknownas-property)

: Example of alsoKnownAs property

```
{
  "alsoKnownAs": <span>"https://example.com/"</span>,
  ...
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-controller) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 3](https://www.w3.org/TR/did-extensions-properties/#example-example-of-controller-property)

: Example of controller property

```
{
  "controller": <span>"did:example:123"</span>,
  ...
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core Terminology](https://www.w3.org/TR/did-core/#dfn-verification-method) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 4](https://www.w3.org/TR/did-extensions-properties/#example-example-of-verificationmethod-property)

: Example of verificationMethod property

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#key-1"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"Ed25519VerificationKey2018"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"publicKeyBase58"</span><span>:</span> <span>"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#key-2"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"JsonWebKey2020"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
        <span>"kty"</span><span>:</span> <span>"OKP"</span><span>,</span>
        <span>"crv"</span><span>:</span> <span>"Ed25519"</span><span>,</span>
        <span>"x"</span><span>:</span> <span>"r7V8qmdFbwqSlj26eupPew1Lb22vVG5vnjhn3vwEA1Y"</span>
      <span>}</span><span>,</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

Deprecated

This property has been deprecated, use [verificationMethod](https://www.w3.org/TR/did-extensions-properties/#verificationmethod) instead.

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security/#publicKey) | [security-vocab context](https://w3id.org/security/v1) |

[Example 5](https://www.w3.org/TR/did-extensions-properties/#example-example-of-publickey-property)

: Example of publicKey property

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKey"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#ZC2jXTO6t4R501bfCXv3RxarZyUbdP2w_psLwMuY6ec"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"Ed25519VerificationKey2018"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"publicKeyBase58"</span><span>:</span> <span>"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1VerificationKey2019"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
        <span>"crv"</span><span>:</span> <span>"secp256k1"</span><span>,</span>
        <span>"x"</span><span>:</span> <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span><span>,</span>
        <span>"y"</span><span>:</span> <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span><span>,</span>
        <span>"kty"</span><span>:</span> <span>"EC"</span><span>,</span>
        <span>"kid"</span><span>:</span> <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
      <span>}</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#services) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 6](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties)

: Example of service and serviceEndpoint properties

```
{
  ...
  "service": [{
    "id": <span>"did:example:123#edv"</span>,
    <span>"type"</span>: <span>"EncryptedDataVault"</span>,
    <span>"serviceEndpoint"</span>: <span>"https://edv.example.com/"</span>
  }]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Cosmos Linked Resources](https://w3id.org/earth/did-cosmos#linked-resources) | [Cosmos JSON-LD Context](https://w3id.org/earth/NS/iid/v1) |

[Example 7](https://www.w3.org/TR/did-extensions-properties/#example-example-of-linked-resource-properties)

: Example of linked resource properties

```
{
    ...
    "linkedResource" : [{
      "id": <span>"did:cosmos:1:impacthub:nft:abc123#resourceHashgraph"</span>,
      <span>"path"</span>: <span>"did:cosmos:1:impacthub:nft:abc123/resourceHashgraph"</span>,
      <span>"type"</span>: <span>"hashgraph"</span>,
      <span>"proof"</span>: <span>"afybeiemxf5abjwjbikoz4mcb3a3dla6ual3jsgpdr4cjr3oz"</span>,
      <span>"endpoint"</span> : <span>"did:cosmos:1:impacthub:nft:abc123?service=mediator"</span>
  }]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [High Assurance DIDs with DNS](https://w3id.org/hadids#dnsValidationDomain) | [dnsValidationDomain JSON-LD Context](https://w3id.org/hadids/v0.5) |

[Example 8](https://www.w3.org/TR/did-extensions-properties/#example-example-of-dnsvalidationdomain-property)

: Example of dnsValidationDomain property

```
{
  "dnsValidationDomain": <span>"mydomain.example"</span>
  ...
}
```

These are properties that express the relationship between the DID subject and a verification method using a [verification relationship](https://w3c.github.io/did-core/#dfn-verification-relationship).

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#assertion) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 9](https://www.w3.org/TR/did-extensions-properties/#example-example-of-assertionmethod-property)

: Example of assertionMethod property

```
{
  ...
  <span>"verificationMethod"</span>: [{
    <span>"id"</span>: <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>,
    <span>"type"</span>: <span>"EcdsaSecp256k1VerificationKey2019"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyJwk"</span>: {
      <span>"crv"</span>: <span>"secp256k1"</span>,
      <span>"x"</span>: <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span>,
      <span>"y"</span>: <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span>,
      <span>"kty"</span>: <span>"EC"</span>,
      <span>"kid"</span>: <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
    }
  }],
  <span>"assertionMethod"</span>: [{
    <span>"id"</span>: <span>"did:example:123#z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>,
    <span>"type"</span>: <span>"Ed25519VerificationKey2018"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyBase58"</span>: <span>"BYEz8kVpPqSt5T7DeGoPVUrcTZcDeX5jGkGhUQBWmoBg"</span>
  },
  <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
  ]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#authentication) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 10](https://www.w3.org/TR/did-extensions-properties/#example-example-of-authentication-property)

: Example of authentication property

```
{
  ...
  <span>"verificationMethod"</span>: [{
    <span>"id"</span>: <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>,
    <span>"type"</span>: <span>"EcdsaSecp256k1VerificationKey2019"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyJwk"</span>: {
      <span>"crv"</span>: <span>"secp256k1"</span>,
      <span>"x"</span>: <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span>,
      <span>"y"</span>: <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span>,
      <span>"kty"</span>: <span>"EC"</span>,
      <span>"kid"</span>: <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
    }
  }],
  <span>"authentication"</span>: [{
    <span>"id"</span>: <span>"did:example:123#z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>,
    <span>"type"</span>: <span>"Ed25519VerificationKey2018"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyBase58"</span>: <span>"BYEz8kVpPqSt5T7DeGoPVUrcTZcDeX5jGkGhUQBWmoBg"</span>
  },
  <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
  ]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#capability-invocation) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 11](https://www.w3.org/TR/did-extensions-properties/#example-example-of-capabilitydelegation-property)

: Example of capabilityDelegation property

```
{
  ...
  <span>"verificationMethod"</span>: [{
    <span>"id"</span>: <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>,
    <span>"type"</span>: <span>"EcdsaSecp256k1VerificationKey2019"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyJwk"</span>: {
      <span>"crv"</span>: <span>"secp256k1"</span>,
      <span>"x"</span>: <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span>,
      <span>"y"</span>: <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span>,
      <span>"kty"</span>: <span>"EC"</span>,
      <span>"kid"</span>: <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
    }
  }],
  <span>"capabilityDelegation"</span>: [{
    <span>"id"</span>: <span>"did:example:123#z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>,
    <span>"type"</span>: <span>"Ed25519VerificationKey2020"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyMultibase"</span>: <span>"z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>
  },
  <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
  ]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#capability-invocation) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 12](https://www.w3.org/TR/did-extensions-properties/#example-example-of-capabilityinvocation-property)

: Example of capabilityInvocation property

```
{
  ...
  <span>"verificationMethod"</span>: [{
    <span>"id"</span>: <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>,
    <span>"type"</span>: <span>"EcdsaSecp256k1VerificationKey2019"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyJwk"</span>: {
      <span>"crv"</span>: <span>"secp256k1"</span>,
      <span>"x"</span>: <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span>,
      <span>"y"</span>: <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span>,
      <span>"kty"</span>: <span>"EC"</span>,
      <span>"kid"</span>: <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
    }
  }],
  <span>"capabilityInvocation"</span>: [{
    <span>"id"</span>: <span>"did:example:123#z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>,
    <span>"type"</span>: <span>"Ed25519VerificationKey2020"</span>,
    <span>"controller"</span>: <span>"did:example:123"</span>,
    <span>"publicKeyMultibase"</span>: <span>"z6MkpzW2izkFjNwMBwwvKqmELaQcH8t54QL5xmBdJg9Xh1y4"</span>
  },
  <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
  ]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#key-agreement) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 13](https://www.w3.org/TR/did-extensions-properties/#example-example-of-keyagreement-property)

: Example of keyAgreement property

```
{
  ...
  "keyAgreement": [
    {
      "id": <span>"did:example:123#zC9ByQ8aJs8vrNXyDhPHHNNMSHPcaSgNpjjsBYpMMjsTdS"</span>,
      <span>"type"</span>: <span>"X25519KeyAgreementKey2019"</span>,
      <span>"controller"</span>: <span>"did:example:123"</span>,
      <span>"publicKeyMultibase"</span>: <span>"zC9ByQ8aJs8vrNXyDhPHHNNMSHPcaSgNpjjsBYpMMjsTdS"</span>
    }
  ]
}
```

Note

These properties are for use on a verification method object, in the value of [`verificationMethod`](https://www.w3.org/TR/did-extensions-properties/#verificationmethod). An implementer is expected to not be relying directly on the linked contexts registered below in nearly every case and instead should be including the context definitions registered by the [`verificationMethod`](https://www.w3.org/TR/did-extensions-properties/#verificationmethod).

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security#publicKeyJwk) | [https://w3id.org/security/suites/jws-2020/v1](https://w3id.org/security/suites/jws-2020/v1) |

[Example 14](https://www.w3.org/TR/did-extensions-properties/#example-example-of-publickeyjwk-property)

: Example of publicKeyJwk property

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#_Qq0UL2Fq651Q0Fjd6TvnYE-faHiOpRlPVQcY_-tA4A"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"JsonWebKey2020"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
    <span>"crv"</span><span>:</span> <span>"Ed25519"</span><span>,</span>
    <span>"x"</span><span>:</span> <span>"VCpo2LMLhn6iWku8MKvSLg2ZAoC-nlOyPVQaO3FxVeQ"</span><span>,</span>
    <span>"kty"</span><span>:</span> <span>"OKP"</span><span>,</span>
    <span>"kid"</span><span>:</span> <span>"_Qq0UL2Fq651Q0Fjd6TvnYE-faHiOpRlPVQcY_-tA4A"</span>
  <span>}</span>
<span>}</span><span>,</span>
```

Deprecated

This property is deprecated in favor of `publicKeyMultibase` or `publicKeyJwk`. It's generally expected that this term will still be used in older suites and therefore needs be supported for legacy compatibility, but is expected to not be used for newly defined suites.

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security/#publicKeyBase58) | [https://w3id.org/security/v2](https://w3id.org/security/v2) |

Deprecated

This property is deprecated in favor of `publicKeyMultibase` or `publicKeyJwk`. It's generally expected that this term will still be used in older suites and therefore needs be supported for legacy compatibility, but is expected to not be used for newly defined suites.

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security#publicKeyHex) | [https://w3id.org/security/v3-unstable](https://w3id.org/security/v3-unstable) |  |

[Example 15](https://www.w3.org/TR/did-extensions-properties/#example-example-of-publickeyhex-property)

: Example of publicKeyHex property

```
<span>{</span>
  <span>"@context"</span><span>:</span><span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://identity.foundation/EcdsaSecp256k1RecoverySignature2020#"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span><span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span><span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#vm-2"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
    <span>"publicKeyHex"</span><span>:</span> <span>"027560af3387d375e3342a6968179ef3c6d04f5d33b2b611cf326d4708badd7770"</span>
  <span>}</span><span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security#publicKeyMultibase) | [https://w3id.org/security/v3-unstable](https://w3id.org/security/v3-unstable) |

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security#blockchainAccountId) | [https://w3id.org/security/v3-unstable](https://w3id.org/security/v3-unstable) |

[Example 16](https://www.w3.org/TR/did-extensions-properties/#example-example-of-blockchainaccountid-property)

: Example of blockchainAccountId property

```
<span>{</span>
  <span>"@context"</span><span>:</span><span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://identity.foundation/EcdsaSecp256k1RecoverySignature2020#"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span><span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span><span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#vm-3"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
    <span>"blockchainAccountId"</span><span>:</span><span>"eip155:1:0xab16a96d359ec26a11e2c2b3d8f8b8942d5bfcdb"</span>
  <span>}</span><span>]</span>
<span>}</span>
```

Deprecated

This property is deprecated in favor of `blockchainAccountId`. It's generally expected that this term will still be used in older suites and therefore needs be supported for legacy compatibility, but is expected to not be used for newly defined suites.

| Normative Definition | JSON-LD |
| --- | --- |
| [security-vocab](https://w3id.org/security#ethereumAddress) | [https://w3id.org/security/v3-unstable](https://w3id.org/security/v3-unstable) |

[Example 17](https://www.w3.org/TR/did-extensions-properties/#example-example-of-ethereumaddress-property)

: Example of ethereumAddress property

```
<span>{</span>
  <span>"@context"</span><span>:</span><span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://identity.foundation/EcdsaSecp256k1RecoverySignature2020#"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span><span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span><span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#vm-3"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
    <span>"ethereumAddress"</span><span>:</span> <span>"0xF3beAC30C498D9E26865F34fCAa57dBB935b0D74"</span>
  <span>}</span><span>]</span>
<span>}</span>
```

These properties are for use on a service object, in the value of [`service`](https://www.w3.org/TR/did-extensions-properties/#service).

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#service-endpoints) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 18](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-0)

: Example of service and serviceEndpoint properties

```
{
  ...
  "service": [{
    "id": <span>"did:example:123#edv"</span>,
    <span>"type"</span>: <span>"EncryptedDataVault"</span>,
    <span>"serviceEndpoint"</span>: <span>"https://edv.example.com/"</span>
  }]
}
```

These are values to be used for the `type` in a verification method object.

Do not include private or extraneous information in verification methods. The class of private information related to JWKs is defined [here](https://tools.ietf.org/html/rfc7517#section-8.1.1). Please review the [DID Core specification](https://w3c.github.io/did-core/#verification-material) for additional details on this topic.

| Normative Definition | JSON-LD |
| --- | --- |
| [JSON Web Signature 2020](https://w3c-ccg.github.io/lds-jws2020/) | [https://w3id.org/security/suite/jws-2020/v1](https://w3id.org/security/suite/jws-2020/v1) |

[Example 19](https://www.w3.org/TR/did-extensions-properties/#example-example-of-jsonwebkey2020-class)

: Example of JsonWebKey2020 class

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#_TKzHv2jFIyvdTGF1Dsgwngfdg3SH6TpDv0Ta1aOEkw"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"JsonWebKey2020"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
    <span>"crv"</span><span>:</span> <span>"P-256"</span><span>,</span>
    <span>"x"</span><span>:</span> <span>"38M1FDts7Oea7urmseiugGW7tWc3mLpJh6rKe7xINZ8"</span><span>,</span>
    <span>"y"</span><span>:</span> <span>"nDQW6XZ7b_u2Sy9slofYLlG03sOEoug3I0aAPQ0exs4"</span><span>,</span>
    <span>"kty"</span><span>:</span> <span>"EC"</span><span>,</span>
    <span>"kid"</span><span>:</span> <span>"_TKzHv2jFIyvdTGF1Dsgwngfdg3SH6TpDv0Ta1aOEkw"</span>
  <span>}</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [Ecdsa Secp256k1 Signature 2019](https://w3c-ccg.github.io/lds-ecdsa-secp256k1-2019/) | [https://w3id.org/security/suites/secp256k1-2019/v1](https://w3id.org/security/suites/secp256k1-2019/v1) |

[Example 20](https://www.w3.org/TR/did-extensions-properties/#example-example-of-ecdsasecp256k1verificationkey2019-class)

: Example of EcdsaSecp256k1VerificationKey2019 class

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1VerificationKey2019"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
    <span>"crv"</span><span>:</span> <span>"secp256k1"</span><span>,</span>
    <span>"x"</span><span>:</span> <span>"NtngWpJUr-rlNNbs0u-Aa8e16OwSJu6UiFf0Rdo1oJ4"</span><span>,</span>
    <span>"y"</span><span>:</span> <span>"qN1jKupJlFsPFc1UkWinqljv4YE0mq_Ickwnjgasvmo"</span><span>,</span>
    <span>"kty"</span><span>:</span> <span>"EC"</span><span>,</span>
    <span>"kid"</span><span>:</span> <span>"WjKgJV7VRw3hmgU6--4v15c0Aewbcvat1BsRFTIqa5Q"</span>
  <span>}</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [Ed25519 Signature 2018](https://w3c-ccg.github.io/lds-ed25519-2018/) | [https://w3id.org/security/suites/ed25519-2018/v1](https://w3id.org/security/suites/ed25519-2018/v1) |

[Example 21](https://www.w3.org/TR/did-extensions-properties/#example-example-of-ed25519verificationkey2018-class)

: Example of Ed25519VerificationKey2018 class

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#ZC2jXTO6t4R501bfCXv3RxarZyUbdP2w_psLwMuY6ec"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"Ed25519VerificationKey2018"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyBase58"</span><span>:</span> <span>"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [BBS+ Signatures 2020](https://w3c-ccg.github.io/ldp-bbs2020/) | [https://w3id.org/security/suites/bls12381-2020/v1](https://w3id.org/security/suites/bls12381-2020/v1) |

[Example 22](https://www.w3.org/TR/did-extensions-properties/#example-example-of-bls12381g1key2020-class)

: Example of Bls12381G1Key2020 class

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#z3tEGVtEKzdhJB2rT5hLVjwQPis8k7bTM16t7vDZrQaoddk6wZ7or6xPPs1P8H9U16Xe75"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"Bls12381G1Key2020"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyBase58"</span><span>:</span> <span>"7bXhTVonHPizXP72AE92PPmRiaXipC519yU7F6NxUFExWpyQo57LuKKBoTyuZ3uWm9"</span><span>,</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [BBS+ Signatures 2020](https://w3c-ccg.github.io/ldp-bbs2020/) | [https://w3id.org/security/suites/bls12381-2020/v1](https://w3id.org/security/suites/bls12381-2020/v1) |

[Example 23](https://www.w3.org/TR/did-extensions-properties/#example-example-of-bls12382g2key2020-class)

: Example of Bls12382G2Key2020 class

```
<span>{</span>
  <span>"id"</span><span>:</span> <span>"did:example:123#zUC7K51WYEsj8y6KPVa1XfwdW5ZJrW5kSbMV619j128T6atCLLXJjjovMZsJ3Ay4STdngRkvM4ygT4qm1mk6HR8FvipSY435nLgYS1TTcaqJAzDWzM1iB9vh3hTL1DEKitwn56i"</span><span>,</span>
  <span>"type"</span><span>:</span> <span>"Bls12381G2Key2020"</span><span>,</span>
  <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"publicKeyBase58"</span><span>:</span> <span>"25ETdUZDVnME6yYuAMjFRCnCPcDmYQcoZDcZuXAfeMhXPvjZg35QmZ7uctBcovA69YDM3Jf7s5BHo4u1y89nY6mHiji8yphZ4AMm4iNCRh35edSg76Dkasu3MY2VS9LnuaVQ"</span><span>,</span>

<span>}</span>
```

| Normative Definition | JSON-LD | Additional Details |
| --- | --- | --- |
| [Linked Data Signatures for PGP](https://w3id.org/security/suites/pgp-2021#PgpVerificationKey2021) | [https://w3id.org/security/suites/pgp-2021/v1](https://w3id.org/security/suites/pgp-2021/v1) | Use of this verification key should be in line with the OpenPGP Message Format as defined in [RFC 4880](https://datatracker.ietf.org/doc/html/rfc4880) |

[Example 24](https://www.w3.org/TR/did-extensions-properties/#example-24)

```
<span>{</span>
  <span>"@context"</span><span>:</span><span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://gpg.jsld.org/contexts/lds-gpg2020-v0.0.jsonld"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span><span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span><span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#989ed1057a294c8a3665add842e784c4d08de1e2"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"PgpVerificationKey2021"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"publicKeyPgp"</span><span>:</span> <span>"-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: OpenPGP.js v4.9.0\r\nComment: https://openpgpjs.org\r\n\r\nxjMEXkm5LRYJKwYBBAHaRw8BAQdASmfrjYr7vrjwHNiBsdcImK397Vc3t4BL\r\nE8rnN......v6\r\nDw==\r\n=wSoi\r\n-----END PGP PUBLIC KEY BLOCK-----\r\n"</span>
  <span>}</span><span>]</span>
<span>}</span>
```

Issue

[DID Specification Registries Issue 370](https://github.com/w3c/did-extensions/issues/370) This property should be moved into a separate suite and linked to here rather than relying on the Verifiable Credentials vocabulary. There are known issues with the first version of the Security vocabulary JSON-LD context and the first version of the Verifiable Credentials JSON-LD context which will prevent these contexts from being listed in the same document. For now it's suggested that implementers rely upon the first version of the Verifiable Credentials JSON-LD context and not rely on the Security vocabulary JSON-LD context in the same document.

| Normative Definition | JSON-LD |
| --- | --- |
| [RSA Signature Suite 2018](https://w3c-ccg.github.io/lds-rsa2018/) | [https://www.w3.org/2018/credentials/v1](https://www.w3.org/2018/credentials/v1) |

[Example 25](https://www.w3.org/TR/did-extensions-properties/#example-25)

```
{
  "id": "did:example:123#key-0",
  "type": "RsaVerificationKey2018",
  "controller": "did:example:123",
  "publicKeyJwk": {
    "kty":"RSA",
    "e":"AQAB",
    "use":"sig",
    "kid":"tNksV42EUs3Xct9AkgZyFWglItRGMxVZ1A1XM68SNq0
    "n":"kO2d_qQTEBjYFGcoY_da7ziFY4L2QX14K7snCee09n-cY2eP-oJXk8T2_lL20YnpYhf4i
    jhkWHGU8kY8-FWPRrzSeu3JUMVSZoqTgoAiKWdnSLNvPVxvGuD2CiA3T6AkwUC03D2AkOLCcJV
    8h_hxUEPeDawF7ArpuJW5DXzEJjE7gOjN4r6d7VB6sd5y-3la54H2ADz2amHLdBWs30fL4BRBH
    lVdx0YmF37V4u5yvnnb5Iyr3kBXJes8t0MUMPkjqEEXRmukpKUzZYNpWDXY0tVcXeK5sRx0DAn
    lNgNNf14-vsyjGkj2Rz0oGW73jjWa8dw-yVlDEHyIkQU9-UY4dFXbVjdIO8j_5ghh62o1T7Y4w
    5CWMc-FxPE3LHe-_teW97X__NN-ToYgfi42IvV2mYOdQMCbvnvY2oMdK3b9wmeVi0marToauL5
    LMg5xHDKopmIR7E3VyRtNYwDFAZ89kadcbSrZ8zTR5APaB7Tmp2L2ZfXKxqKQuxlFTTCcZtg4e
    5AN8QuYdI18DEDQn2umUU_Twj7k4CXvuIKVL8p4yRHC4CHAGIm9cH_t11dF3wXygaENVOGRXQu
    0g1iKq0mO2rWpOqkGJ5uXMFb5lx54i8uOjCdZ9y2el28xA55Ve95KCxeTHp997Bn3TIgbeQ-B_
    -3PBVTuuAAH8y9fFNKtu5E"
  }
}
```

[Issue 164](https://github.com/w3c/did-extensions/issues/164): X25519KeyAgreementKey2019 has no normative definition

Normative definition in a suite is required for registration, this entry should be updated or removed.

| Normative Definition | JSON-LD |
| --- | --- |
| Normative definition pending | [https://w3id.org/security/suites/x25519-2019/v1](https://w3id.org/security/suites/x25519-2019/v1) |

[Example 26](https://www.w3.org/TR/did-extensions-properties/#example-example-of-x25519keyagreementkey2019)

: Example of X25519KeyAgreementKey2019

```
{
  ...
  "keyAgreement": [
    {
      "id": <span>"did:example:123#zC9ByQ8aJs8vrNXyDhPHHNNMSHPcaSgNpjjsBYpMMjsTdS"</span>,
      <span>"type"</span>: <span>"X25519KeyAgreementKey2019"</span>,
      <span>"controller"</span>: <span>"did:example:123"</span>,
      <span>"publicKeyBase58"</span>: <span>"9hFgmPVfmBZwRvFEyniQDBkz9LmV7gDEqytWyGZLmDXE"</span>
    }
  ]
}
```

| Normative Definition | JSON-LD |
| --- | --- |
| [ECDSA Secp256k1 Recovery Signature 2020](https://identity.foundation/EcdsaSecp256k1RecoverySignature2020/#ES256K-R) | [https://w3id.org/security/suites/secp256k1recovery-2020/v1](https://w3id.org/security/suites/secp256k1recovery-2020/v1) |

[Example 27](https://www.w3.org/TR/did-extensions-properties/#example-27)

```
<span>{</span>
  <span>"@context"</span><span>:</span> <span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://identity.foundation/EcdsaSecp256k1RecoverySignature2020#"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span><span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#vm-1"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
      <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
        <span>"crv"</span><span>:</span> <span>"secp256k1"</span><span>,</span>
        <span>"kid"</span><span>:</span> <span>"JUvpllMEYUZ2joO59UNui_XYDqxVqiFLLAJ8klWuPBw"</span><span>,</span>
        <span>"kty"</span><span>:</span> <span>"EC"</span><span>,</span>
        <span>"x"</span><span>:</span> <span>"dWCvM4fTdeM0KmloF57zxtBPXTOythHPMm1HCLrdd3A"</span><span>,</span>
        <span>"y"</span><span>:</span> <span>"36uMVGM7hnw-N6GnjFcihWE3SkrhMLzzLCdPMXPEXlA"</span>
      <span>}</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#vm-2"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
      <span>"publicKeyHex"</span><span>:</span> <span>"027560af3387d375e3342a6968179ef3c6d04f5d33b2b611cf326d4708badd7770"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#vm-3"</span><span>,</span>
      <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1RecoveryMethod2020"</span><span>,</span>
      <span>"ethereumAddress"</span><span>:</span> <span>"0xF3beAC30C498D9E26865F34fCAa57dBB935b0D74"</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [Verifiable Conditions Verification Method Suite 2021](https://w3c-ccg.github.io/verifiable-conditions) | [https://w3c-ccg.github.io/verifiable-conditions/contexts/verifiable-conditions-2021-v1.json](https://w3c-ccg.github.io/verifiable-conditions/contexts/verifiable-conditions-2021-v1.json) |

[Example 28](https://www.w3.org/TR/did-extensions-properties/#example-28)

```
<span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#1"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"VerifiableCondition2021"</span><span>,</span>
    <span>"conditionAnd"</span><span>:</span> <span>[</span><span>{</span>
        <span>"id"</span><span>:</span> <span>"did:example:123#1-1"</span><span>,</span>
        <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
        <span>"type"</span><span>:</span> <span>"VerifiableCondition2021"</span><span>,</span>
        <span>"conditionOr"</span><span>:</span> <span>[</span><span>{</span>
            <span>"id"</span><span>:</span> <span>"did:example:123#1-1-1"</span><span>,</span>
            <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
            <span>"type"</span><span>:</span> <span>"EcdsaSecp256k1VerificationKey2019"</span><span>,</span>
            <span>"publicKeyBase58"</span><span>:</span> <span>"5JBxKqYKzzoHrzeqwp6zXk8wZU3Ah94ChWAinSj1fYmyJvJS5rT"</span>
        <span>}</span><span>,</span> <span>{</span>
            <span>"id"</span><span>:</span> <span>"did:example:123#1-1-2"</span><span>,</span>
            <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
            <span>"type"</span><span>:</span> <span>"Ed25519VerificationKey2018"</span><span>,</span>
            <span>"publicKeyBase58"</span><span>:</span> <span>"PZ8Tyr4Nx8MHsRAGMpZmZ6TWY63dXWSCzamP7YTHkZc78MJgqWsAy"</span>
        <span>}</span><span>]</span>
    <span>}</span><span>,</span> <span>{</span>
        <span>"id"</span><span>:</span> <span>"did:example:123#1-2"</span><span>,</span>
        <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
        <span>"type"</span><span>:</span> <span>"Ed25519VerificationKey2018"</span><span>,</span>
        <span>"publicKeyBase58"</span><span>:</span> <span>"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"</span>
    <span>}</span><span>]</span>
<span>}</span>
```

These are values to be used for the `type` property in a service object.

| Normative Definition | JSON-LD |
| --- | --- |
| [Well Known DID Configuration](https://identity.foundation/.well-known/resources/did-configuration/) | [Well Known DID Configuration](https://identity.foundation/.well-known/did-configuration/v1) |

[Example 29](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-1)

: Example of service and serviceEndpoint properties

```
<span>{</span>
  <span>"@context"</span><span>:</span> <span>[</span><span>"https://www.w3.org/ns/did/v1"</span><span>,</span><span>"https://identity.foundation/.well-known/did-configuration/v1"</span><span>]</span><span>,</span>
  <span>"id"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span> <span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#456"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"JsonWebKey2020"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
      <span>"kty"</span><span>:</span> <span>"OKP"</span><span>,</span>
      <span>"crv"</span><span>:</span> <span>"Ed25519"</span><span>,</span>
      <span>"x"</span><span>:</span> <span>"VCpo2LMLhn6iWku8MKvSLg2ZAoC-nlOyPVQaO3FxVeQ"</span>
    <span>}</span>
  <span>}</span><span>]</span><span>,</span>
  <span>"service"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"id"</span><span>:</span><span>"did:example:123#foo"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"LinkedDomains"</span><span>,</span>
      <span>"serviceEndpoint"</span><span>:</span> <span>{</span>
        <span>"origins"</span><span>:</span> <span>[</span><span>"https://foo.example.com"</span><span>,</span> <span>"https://identity.foundation"</span><span>]</span>
      <span>}</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span><span>"did:example:123#bar"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"LinkedDomains"</span><span>,</span>
      <span>"serviceEndpoint"</span><span>:</span> <span>"https://bar.example.com"</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [Linked Verifiable Presentation](https://identity.foundation/linked-vp/) | [Linked Verifiable Presentation](https://identity.foundation/linked-vp/contexts/v1) |

[Example 30](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-2)

: Example of service and serviceEndpoint properties

```
<span>{</span>
  <span>"@context"</span><span>:</span> <span>[</span>
    <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
    <span>"https://identity.foundation/linked-vp/contexts/v1"</span>
  <span>]</span><span>,</span>
  <span>"id"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
  <span>"verificationMethod"</span><span>:</span> <span>[</span><span>{</span>
    <span>"id"</span><span>:</span> <span>"did:example:123#_Qq0UL2Fq651Q0Fjd6TvnYE-faHiOpRlPVQcY_-tA4A"</span><span>,</span>
    <span>"type"</span><span>:</span> <span>"JsonWebKey2020"</span><span>,</span>
    <span>"controller"</span><span>:</span> <span>"did:example:123"</span><span>,</span>
    <span>"publicKeyJwk"</span><span>:</span> <span>{</span>
      <span>"kty"</span><span>:</span> <span>"OKP"</span><span>,</span>
      <span>"crv"</span><span>:</span> <span>"Ed25519"</span><span>,</span>
      <span>"x"</span><span>:</span> <span>"VCpo2LMLhn6iWku8MKvSLg2ZAoC-nlOyPVQaO3FxVeQ"</span>
    <span>}</span>
  <span>}</span><span>]</span><span>,</span>
  <span>"service"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#foo"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"LinkedVerifiablePresentation"</span><span>,</span>
      <span>"serviceEndpoint"</span><span>:</span> <span>[</span><span>"https://bar.example.com/verifiable-presentation.jsonld"</span><span>]</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"id"</span><span>:</span> <span>"did:example:123#baz"</span><span>,</span>
      <span>"type"</span><span>:</span> <span>"LinkedVerifiablePresentation"</span><span>,</span>
      <span>"serviceEndpoint"</span><span>:</span> <span>"ipfs://bafybeihkoviema7g3gxyt6la7vd5ho32ictqbilu3wnlo3rs7ewhnp7lly/verifiable-presentation.jwt"</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DIDComm Messaging](https://didcomm.org/messaging/v2/) | A valid JSON-LD context needs to be published. [DIDComm Messaging](https://didcomm.org/messaging/contexts/v2) |

[Example 31](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-3)

: Example of service and serviceEndpoint properties

```
<span>{</span>
  <span>"@context"</span><span>:</span><span>[</span>
      <span>"https://www.w3.org/ns/did/v1"</span><span>,</span>
      <span>"https://didcomm.org/messaging/contexts/v2"</span>
  <span>]</span><span>,</span>
  <span>"type"</span><span>:</span><span>"DIDCommMessaging"</span><span>,</span>
  <span>"serviceEndpoint"</span><span>:</span> <span>{</span>
    <span>"uri"</span><span>:</span> <span>"http://example.com/path"</span><span>,</span>
    <span>"accept"</span><span>:</span><span>[</span> <span>"didcomm/v2"</span><span>,</span> <span>"didcomm/aip2;env=rfc587"</span> <span>]</span><span>,</span>
    <span>"routingKeys"</span><span>:</span><span>[</span> <span>"did:example:somemediator#somekey"</span> <span>]</span>
  <span>}</span>
<span>}</span>
```

The `WotThing` and `WotDirectory` endpoints allow publication of service endpoints in a DID document that can be used to fetch Web of Things (WoT) Thing Descriptions (TDs). The `WotThing` endpoint is a REST service that returns a TD when the `GET` method is used. This can be used for self-describing devices or services, or be a service separate from the actual device or service described by the TD. The `WotDirectory` is also a REST service that returns a TD, but this service is always a Web of Things (WoT) Thing Description Directory (TDD), and the TD returned by a `GET` always describes the TDD's interface. Details (including normative statements covering the above) are in the [WoT Discovery](https://www.w3.org/TR/wot-discovery/) specification.

| Normative Definition | JSON-LD |
| --- | --- |
| [WoT Discovery](https://www.w3.org/TR/wot-discovery/) | [WotThing](https://www.w3.org/2022/wot/discovery-did#WotThing) |
| [WoT Discovery](https://www.w3.org/TR/wot-discovery/) | [WotDirectory](https://www.w3.org/2022/wot/discovery-did#WotDirectory) |

[Example 32](https://www.w3.org/TR/did-extensions-properties/#example-example-of-wotthing-serviceendpoint-properties)

: Example of WotThing serviceEndpoint properties

```
{
  <span>"@context"</span>:[
      <span>"https://www.w3.org/ns/did/v1"</span>,
      <span>"https://www.w3.org/2022/wot/discovery-did"</span>
  ],
  ...
  <span>"service"</span>: [{
      <span>"id"</span>: <span>"did:example:wotdiscoveryexample#td"</span>,
      <span>"type"</span>: <span>"WotThing"</span>,
      <span>"serviceEndpoint"</span>:
          <span>"https://wot.example.com/.well-known/wot"</span>
  }]
  ...
}
```

[Example 33](https://www.w3.org/TR/did-extensions-properties/#example-example-of-wotdirectory-serviceendpoint-properties)

: Example of WotDirectory serviceEndpoint properties

```
{
  <span>"@context"</span>:[
      <span>"https://www.w3.org/ns/did/v1"</span>,
      <span>"https://www.w3.org/2022/wot/discovery-did"</span>
  ],
  ...
  <span>"service"</span>: [{
      <span>"id"</span>: <span>"did:example:wotdiscoveryexample#tdd"</span>,
      <span>"type"</span>: <span>"WotDirectory"</span>,
      <span>"serviceEndpoint"</span>:
          <span>"https://wot.example.com/tdd"</span>
  }]
  ...
}
```

The `CredentialRegistry` endpoint allows publication of a dedicated service endpoint in a DID document, through which verifiable credentials can be queried. Each registry endpoint is a REST endpoint. When a `GET` request is sent to the URI formed by appending the `credentialSubject.id` as a URL-encoded string to the given endpoint URI, the registry _MUST_ return an array of verifiable credentials associated with the subject ID. A sample registry endpoint can be found [here](https://ssi.eecc.de/api/registry/swagger/#/Credentials/get_api_registry_vcs__id_).

Note

Verifiable credential registries are supposed to hold credentials that are publicly accessible by default, e.g., for product passports on a product type level. An additional authentication for limiting access to certain credentials is currently under development.

| Normative Definition | JSON-LD |
| --- | --- |
| [Verifiable Credential Registry](https://ssi.eecc.de/api/registry/swagger/#/Credentials/get_api_registry_vcs__id_) | [Verifiable Credential Registry](https://ssi.eecc.de/api/registry/context/credentialregistry) |

[Example 34](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-4)

: Example of service and serviceEndpoint properties

```
{
  ...
  "service": [
    {
      "id": <span>"did:example:123#vcregistry-1"</span>,
      <span>"type"</span>: <span>"CredentialRegistry"</span>,
      <span>"serviceEndpoint"</span>: {
        "registries": [<span>"https://registry.example.com/{credentialSubject.id}"</span>, <span>"https://identity.foundation/vcs/{credentialSubject.id}"</span>]
      }
    },
    {
      "id": <span>"did:example:123#vcregistry-2"</span>,
      <span>"type"</span>: <span>"CredentialRegistry"</span>,
      <span>"serviceEndpoint"</span>: <span>"https://ssi.eecc.de/api/registry/vcs/{credentialSubject.id}"</span>
    }
  ]
}
```

[Example 35](https://www.w3.org/TR/did-extensions-properties/#example-example-of-a-concrete-call-to-the-specified-serviceendpoint-and-example-answer)

: Example of a concrete call to the specified serviceEndpoint and example answer

```
$ curl <span>'https://ssi.eecc.de/api/registry/vcs/https%3A%2F%2Ftest.de%2Ftest1'</span> -H <span>'accept: application/ld+json, application/json'</span>

[
  {
    <span>"@context"</span>: [<span>"https://www.w3.org/2018/credentials/v1"</span>,... ],
    <span>"type"</span>: [<span>"VerifiableCredential"</span>,...],
    <span>"credentialSubject"</span>: {...},
    <span>"proof"</span>: {...},
    ...
  },
  ...
]
```

The `OID4VCI` service allows publication of a credential issuer that conforms to the [OpenID for Verifiable Credential Issuance (OID4VCI)](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) specification.

The service endpoint `id` _MUST_ be the Credential Issuer Identifier to get the Credential Issuer Metadata as described in Section [Credential Issuer Metadata](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html#credential-issuer-metadata) of [OpenIDVCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html).

| Normative Definition | JSON-LD |
| --- | --- |
| [OpenID4VCI](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) | [OpenID4VCI](https://ssi.eecc.de/api/registry/context/openid4vc) |

[Example 36](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-5)

: Example of service and serviceEndpoint properties

```
{
  ...
  "service": [
    {
      "id": <span>"did:example:123#oid4vci"</span>,
      <span>"type"</span>: <span>"OID4VCI"</span>,
      <span>"serviceEndpoint"</span>: <span>"https://issuer.example.com/"</span>
    }
  ]
}
```

The `OID4VP` service allows publication of how to interact with a credential wallet that conforms with the [OpenID for Verifiable Presentation (OID4VP)](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) specification.

The service endpoint `id` _MUST_ be the Wallet (OAuth2) Issuer Identifier to obtain Wallet Metadata to invoke the wallet as described in section [Wallet Invocation](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html#name-wallet-invocation).

| Normative Definition | JSON-LD |
| --- | --- |
| [OpenID4VP](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html#name-authorization-request) | [OpenID4VP](https://ssi.eecc.de/api/registry/context/openid4vc) |

[Example 37](https://www.w3.org/TR/did-extensions-properties/#example-example-of-service-and-serviceendpoint-properties-6)

: Example of service and serviceEndpoint properties

```
{
  ...
  "service": [
    {
      "id": <span>"did:example:123#oid4vp"</span>,
      <span>"type"</span>: <span>"OID4VP"</span>,
      <span>"serviceEndpoint"</span>: <span>"https://wallet.example.com"</span>
    }
  ]
}
```

\[RFC2119\]

[Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119). S. Bradner. IETF. March 1997. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc2119](https://www.rfc-editor.org/rfc/rfc2119)

\[RFC8174\]

[Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174). B. Leiba. IETF. May 2017. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc8174](https://www.rfc-editor.org/rfc/rfc8174)

\[DID-EXTENSIONS\]

[Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/). Manu Sporny. Decentralized Identifier Working Group. W3C Working Group Note. URL: [https://www.w3.org/TR/did-extensions/](https://www.w3.org/TR/did-extensions/)