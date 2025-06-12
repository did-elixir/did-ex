# DID Implementation Guide v1.0
## A DID developer's guide to understanding and implementing Decentralized Identifiers
### 04 November 2021

## Abstract

This document provides guidance to [DID method](https://www.w3.org/TR/did-core/#dfn-did-methods) developers, related to serialization, cryptographic primitive selection, governance, and interoperability.

This document acts as a technical narrative for the implementation of DID methods and is expected to cover many topics related to that subject that a developer may wish to consider, including guidance around implementation details that may also be used for third party evaluation of an authored DID method via the [DID-RUBRIC](https://w3c.github.io/did-rubric/).

Inclusion of discussion related to one subject matter or another does not imply a greater or lesser level of importance for that topic, only that some members of the [W3C DID WG](https://www.w3.org/2019/did-wg/) found importance in bringing a developer's attention to a particular topic.

Guidance provided in this document does not necessarily reflect consensus of the [W3C DID WG](https://www.w3.org/2019/did-wg/), although some members of the WG have contributed to it.

## Status of This Document

This document is merely a W3C\-internal document. It has no official standing of any kind and does not represent consensus of the W3C Membership.

Implementers are advised to consult this guide if they are directly involved with the W3C DID Working Group or are actively involved in authoring a DID method.

## Table of Contents

1.  [Abstract](https://w3c.github.io/did-imp-guide/#abstract)
2.  [Status of This Document](https://w3c.github.io/did-imp-guide/#sotd)
3.  [1. Conformance](https://w3c.github.io/did-imp-guide/#conformance)
4.  [2. Terminology](https://w3c.github.io/did-imp-guide/#terminology)
    1.  [2.1 Index](https://w3c.github.io/did-imp-guide/#index)
        1.  [2.1.1 Terms defined by this specification](https://w3c.github.io/did-imp-guide/#index-defined-here)
        2.  [2.1.2 Terms defined by reference](https://w3c.github.io/did-imp-guide/#index-defined-elsewhere)
5.  [3. Methods](https://w3c.github.io/did-imp-guide/#methods)
    1.  [3.1 Method Reuse is Encouraged](https://w3c.github.io/did-imp-guide/#method-reuse-is-encouraged)
    2.  [3.2 DID Syntax](https://w3c.github.io/did-imp-guide/#did-syntax)
    3.  [3.3 Verifiable Data Registry](https://w3c.github.io/did-imp-guide/#verifiable-data-registry)
    4.  [3.4 Establishing a DID](https://w3c.github.io/did-imp-guide/#establishing-a-did)
    5.  [3.5 DID Resolution](https://w3c.github.io/did-imp-guide/#did-resolution)
        1.  [3.5.1 DID URL Syntax](https://w3c.github.io/did-imp-guide/#did-url-syntax)
            1.  [3.5.1.1 Path](https://w3c.github.io/did-imp-guide/#path)
            2.  [3.5.1.2 Query](https://w3c.github.io/did-imp-guide/#query)
            3.  [3.5.1.3 Fragment](https://w3c.github.io/did-imp-guide/#fragment)
        2.  [3.5.2 Representations](https://w3c.github.io/did-imp-guide/#representations)
            1.  [3.5.2.1 DID URL Dereferencing](https://w3c.github.io/did-imp-guide/#did-url-dereferencing)
            2.  [3.5.2.2 application/did+json](https://w3c.github.io/did-imp-guide/#application-did-json)
            3.  [3.5.2.3 application/did+ld+json](https://w3c.github.io/did-imp-guide/#application-did-ld-json)
    6.  [3.6 Verification Relationships](https://w3c.github.io/did-imp-guide/#verification-relationships)
        1.  [3.6.1 Authentication](https://w3c.github.io/did-imp-guide/#authentication)
        2.  [3.6.2 Assertion Method](https://w3c.github.io/did-imp-guide/#assertion-method)
6.  [4. Data Model and Representations](https://w3c.github.io/did-imp-guide/#data-model-and-representations)
    1.  [4.1 Drawbacks](https://w3c.github.io/did-imp-guide/#drawbacks)
        1.  [4.1.1 Avoid representation-foreign entries](https://w3c.github.io/did-imp-guide/#avoid-representation-foreign-entries)
        2.  [4.1.2 Reliance on representation-foreign entries](https://w3c.github.io/did-imp-guide/#reliance-on-representation-foreign-entries)
        3.  [4.1.3 Security problems with representation-foreign entries](https://w3c.github.io/did-imp-guide/#security-problems-with-representation-foreign-entries)
        4.  [4.1.4 Conversion between Representations](https://w3c.github.io/did-imp-guide/#conversion-between-representations)
    2.  [4.2 Benefits](https://w3c.github.io/did-imp-guide/#benefits)
7.  [5. Privacy Considerations](https://w3c.github.io/did-imp-guide/#privacy-considerations)
    1.  [5.1 Dealing with Personal Data](https://w3c.github.io/did-imp-guide/#dealing-with-personal-data)
    2.  [5.2 Avoid correlation](https://w3c.github.io/did-imp-guide/#avoid-correlation)
    3.  [5.3 Anonymity](https://w3c.github.io/did-imp-guide/#anonymity)
    4.  [5.4 Compliance](https://w3c.github.io/did-imp-guide/#compliance)
8.  [6. Security Considerations](https://w3c.github.io/did-imp-guide/#security-considerations)
    1.  [6.1 Vendor Lock In](https://w3c.github.io/did-imp-guide/#vendor-lock-in)
    2.  [6.2 Digital Signatures](https://w3c.github.io/did-imp-guide/#digital-signatures)
    3.  [6.3 Hashing Algorithms](https://w3c.github.io/did-imp-guide/#hashing-algorithms)
    4.  [6.4 Randomness](https://w3c.github.io/did-imp-guide/#randomness)
    5.  [6.5 Zero Knowledge Proofs](https://w3c.github.io/did-imp-guide/#zero-knowledge-proofs)
    6.  [6.6 Biometrics](https://w3c.github.io/did-imp-guide/#biometrics)
9.  [7. Ethical Considerations](https://w3c.github.io/did-imp-guide/#ethical-considerations)
    1.  [7.1 Broad Ethical Principles](https://w3c.github.io/did-imp-guide/#broad-ethical-principles)
    2.  [7.2 Other concerns as applied to DID method development](https://w3c.github.io/did-imp-guide/#other-concerns-as-applied-to-did-method-development)
        1.  [7.2.1 Environmental Considerations](https://w3c.github.io/did-imp-guide/#environmental-considerations)
10.  [8. Additional Guidelines](https://w3c.github.io/did-imp-guide/#additional-guidelines)
11.  [9. Future Work](https://w3c.github.io/did-imp-guide/#future-work)
    1.  [9.1 Upper Limits on DID Character Length](https://w3c.github.io/did-imp-guide/#upper-limits-on-did-character-length)
    2.  [9.2 Verifiable Timestamps](https://w3c.github.io/did-imp-guide/#verifiable-timestamps)
    3.  [9.3 Verifiable Credentials](https://w3c.github.io/did-imp-guide/#verifiable-credentials)
    4.  [9.4 Alternate Serializations and Graph Models](https://w3c.github.io/did-imp-guide/#alternate-serializations-and-graph-models)
12.  [A. References](https://w3c.github.io/did-imp-guide/#references)
    1.  [A.1 Normative references](https://w3c.github.io/did-imp-guide/#normative-references)
    2.  [A.2 Informative references](https://w3c.github.io/did-imp-guide/#informative-references)

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key word _SHOULD_ in this document is to be interpreted as described in [BCP 14](https://www.rfc-editor.org/info/bcp14) \[[RFC2119](https://w3c.github.io/did-imp-guide/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] \[[RFC8174](https://w3c.github.io/did-imp-guide/#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")\] when, and only when, it appears in all capitals, as shown here.

_This section is non-normative._

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for definitions of commonly-used [DID terminology](https://www.w3.org/TR/did-core/#terminology).

-   [representation-foreign entries](https://w3c.github.io/did-imp-guide/#dfn-representation-foreign-entries)
-   [representation-foreign entry](https://w3c.github.io/did-imp-guide/#dfn-representation-foreign-entry)

-   \[[DID-CBOR-REPRESENTATION](https://w3c.github.io/did-imp-guide/#bib-did-cbor-representation)\] defines the following:
    -   Plain CBOR Representation
-   \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core)\] defines the following:
    -   @context
    -   Assertion verification relationships
    -   Authentication verification relationships
    -   Create operation
    -   Data Model
    -   DID
    -   DID controller
    -   DID core properties
    -   DID document
    -   DID method
    -   DID methods
    -   DID Resolution
    -   DID resolver
    -   DID subject
    -   DID subject
    -   DID Syntax
    -   DID terminology
    -   DID URL Dereferencing
    -   DID URL Syntax
    -   DID URLs
    -   DLTs
    -   Fragment
    -   JSON representation
    -   JSON-LD representation
    -   Path
    -   Query
    -   representation
    -   representation-specific entries
    -   Representations
    -   Verifiable Data Registries
    -   Verifiable Timestamps
    -   verification relationship
-   \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries)\] defines the following:
    -   property listed in the DID Specification Registries
-   \[[VC-DATA-MODEL](https://w3c.github.io/did-imp-guide/#bib-vc-data-model)\] defines the following:
    -   AnonCredDerivedCredentialv1
    -   Proofs

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [DID methods](https://www.w3.org/TR/did-core/#methods).

Avoid introducing requirements in your DID method specification that are neither described in \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] nor registered in the \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries "Decentralized Identifier Extensions")\].

Avoid constructing a new DID Method that is nearly identical to an existing DID Method.

There are several "families" of DID methods, including [Hyperledger Indy](https://hyperledger-indy.readthedocs.io/en/latest/index.html), [Sidetree](https://identity.foundation/sidetree/spec/), and various methods that share similar smart contracts or rely on shared content addressing technology.

Implementers are cautioned to write and regularly run integration and interoperability tests that span these "families", in order to ensure methods have sufficient support for open standards and real interoperability.

The primary user-facing aspects of a DID method are its [DID Syntax](https://w3c.github.io/did-imp-guide/#did-syntax) and its [Verifiable Data Registry](https://w3c.github.io/did-imp-guide/#verifiable-data-registry). Together these determine most of the unique properties of a DID method, and its privacy and security properties for comparison to other methods.

DID method developers are encouraged to review and apply the \[[DID-RUBRIC](https://w3c.github.io/did-imp-guide/#bib-did-rubric "DID Method Rubric v1.0")\] as early as possible in their development process to ensure that they are evaluating their DID method appropriately for the requirements of the problem they are attempting to solve with the introduction of a new DID method.

_This section is non-normative._

While many forms of decentralization are desired, some convergence upon widely useful DID methods is considered beneficial. If you are considering defining a new DID method, consider first surveying existing defined DID methods to see if there may be an already existing method that may meet your needs. Many DID method specifications can be found listed in the \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. Some DID methods have been evaluated against various criteria in the \[[DID-RUBRIC](https://w3c.github.io/did-imp-guide/#bib-did-rubric "DID Method Rubric v1.0")\]. Some DID methods have implementation data in the [DID Test Suite](https://github.com/w3c/did-test-suite/), which could be useful as references for some criteria. If no existing DID method fully meets your needs, but some appear that they may be modifiable or extensible to do so, consider contacting the DID method specification author(s) or following other established procedures to see if collaboration may be possible to support your use case. Some DID methods have built-in extensibility points (such as registry-like mechanisms) to support new key types, discovery methods, etc.

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [DID Syntax](https://www.w3.org/TR/did-core/#did-syntax).

Avoid allowing users to control the structure of the DID Unique Suffix, also referred to as the `method-specific-id` in the [DID Syntax ABNF](https://www.w3.org/TR/did-core/#did-syntax). This can be accomplished by coupling the [Create operation](https://www.w3.org/TR/did-core/#method-operations) canonical representation to the `method-specific-id`. It can also be accomplished by leveraging sources of entropy.

Avoid vanity DIDs such as, for example, `did:example:deadbeef1f236...`. The structure of the identifier should not be relied on for anything other than collision resistance. Be especially careful of trusting a relationship between a [DID subject](https://www.w3.org/TR/did-core/#dfn-did-subjects) and [DID controller](https://www.w3.org/TR/did-core/#dfn-did-controllers) without relying on a cryptographically secure [verification relationship](https://www.w3.org/TR/did-core/#verification-relationships) for [authentication](https://w3c.github.io/did-imp-guide/#authentication). Anyone can claim a DID, but only someone who controls the associated keys can authenticate their association with the DID. For example `did:example:xyzcorp` should not be assumed to belong to XYZ Corp.

Depending on the nature of the [VDR](https://w3c.github.io/did-imp-guide/#verifiable-data-registry), publishing `type` or `kind` might be advantageous for decentralized discovery or mass surveillance. Implementers are not to rely on conformance to specification text while implementing decentralized identifiers.

_This section is non-normative._

The [VDR](https://w3c.github.io/did-imp-guide/#verifiable-data-registry) is the system to which [DID method operations](https://www.w3.org/TR/did-core/#method-operations) such as Create, Resolve, Update, and Deactivate are applied.

Typically a globally-unique, tamper-evident, immutable log is used to produce a verifiable data registry.

Blockchains or distributed ledgers are popular choices for building verifiable data registries, but there are other solutions. Each yield unique security pros and cons.

Some DID methods rely on centralized trusted service providers and Merkle proofs to provide tamper-evident logs without the costs associated with distributed consensus.

Some DID methods rely on multiple registries that may not be globally available.

Some DID methods might rely on legacy security infrastructure, such as [Transport Layer Security](https://www.rfc-editor.org/rfc/rfc8446) or [Tor](https://www.torproject.org/).

Few DID methods support portability across verifiable data registries. Altering the VDR associated with a DID will almost certainly impact Privacy and Security considerations.

Instead of designing complex DID methods with registry portability, consider supporting multiple DID methods that have each been designed to support disjoint security and/or privacy consideration, such as global discoverability, offline functionality, pairwise uniqueness, linkage to existing roots of trust such as websites, etc.

Depending on the nature of the VDR, it may be desirable to store data other than DID documents, such as verifiable credentials, templates or schemas for credentials, discovery metadata, or integrity- or content-addressable identifiers for related information.

_This section is non-normative._

In order to create secure DID systems, it is important to consider the process of establishing a Decentralized Identifier.

Establishing cryptographic assurances for the identifier from its inception is critical to ensuring that the security of the system isn't compromised through attacks against the creation process.

A commonly observed process for establishing a decentralized identifier is:

1.  Obtain `entropy` from a source of randomness that is as close to actually random as possible.
2.  Generate a first verification method from `entropy`.
3.  Use the first verification method to perform a [DID Create operation](https://www.w3.org/TR/did-core/#method-operations).

Note

The Create Operation will often use the first verification method directly, or a deterministic function thereof, such as a hash, to construct and register the DID.

Note

True randomness is **hard** to get. Public sources such as the [NIST Randomness Beacon](https://csrc.nist.gov/projects/interoperable-randomness-beacons) are reliable but not appropriate for use directly as a secret key. See the section on [Randomness](https://w3c.github.io/did-imp-guide/#randomness) for more information.

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [DID Resolution](https://www.w3.org/TR/did-core/#did-resolution).

DID resolution is a function which takes a DID, and produces a DID resolution result in a representation, most commonly [JSON](https://www.rfc-editor.org/rfc/rfc8259).

DID resolution can be proxied through intermediaries such as command-line tools or HTTP servers. Because the DID document contains key material, such intermediaries represent excellent targets for attackers, who can use the intermediaries to tamper with verification relationships.

Avoid tampering with a DID document that has been returned by a [DID resolver](https://www.w3.org/TR/did-core/#dfn-did-resolvers). It is better to throw an error than to attempt to solve problems in the underlying DID method.

Avoid transforming DID documents without the consent of the DID subject or controller.

Whenever possible, run all software necessary to support a DID Method yourself.

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [DID URL Syntax](https://www.w3.org/TR/did-core/#did-url-syntax).

[DID URLs](https://www.w3.org/TR/did-core/#dfn-did-urls) can be used to identify sub-resources inside a DID document, older versions of a DID document, or resources outside of a DID document.

[Example 1](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-verification-method-in-a-did-document)

: DID URL identifying a verification method in a DID document

```
did:example:123#primary
```

[Example 2](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-service-in-a-did-document)

: DID URL identifying a service in a DID document

```
did:example:123#agent
```

[Example 3](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-resource-outside-a-did-document)

: DID URL identifying a resource outside a DID document

```
<span>did</span>:<span>example</span>:<span>123</span>?service=packages@relativeRef=<span>/jose/</span>versions/v0<span>.1</span><span>.2</span>/archive.<span>zip</span>
```

Adjusting any part of a DID URL, including the `did`, `path`, or `query`, changes the identifier.

The resource identifiers `did:example:123`, `did:example:123/path` and `did:example:123?args=1` each identify a unique resource.

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [Path](https://www.w3.org/TR/did-core/#path).

Avoid using `path`; as of this writing, there are not enough implementations that make use of it.

[Example 4](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-resource-outside-a-did-document-0)

: DID URL identifying a resource outside a DID document

```
did:example:123/ephemeral/77d66171-b290-489c-abf1-95ae10725201#primary
```

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [Query](https://www.w3.org/TR/did-core/#query).

Avoid using `query`; as of this writing, there are not enough implementations that make use of it.

[Example 5](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-verification-method-in-an-older-version-of-a-did-document)

: DID URL identifying a verification method in an older version of a DID document

```
did:example:123?versionId=77d66171-b290-489c-abf1-95ae10725201#primary
```

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [Fragment](https://www.w3.org/TR/did-core/#fragment).

[Example 6](https://w3c.github.io/did-imp-guide/#example-did-url-identifying-a-verification-method-in-a-did-document-0)

: DID URL identifying a verification method in a DID document

```
did:example:123#primary
```

Fragments identify sub-resources of a resource identified with a [DID URL](https://www.w3.org/TR/did-core/#dfn-did-urls).

The interpretation of the fragment is determined by the [Media Type](https://www.rfc-editor.org/rfc/rfc6838) (formerly known as a MIME type).

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with developing [Representations](https://www.w3.org/TR/did-core/#representations).

The \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] specification describes representations. The \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries "Decentralized Identifier Extensions")\] supports the registration of an unbounded number of alternative representations.

Each representation has unique pros and cons.

DID methods are responsible for producing a DID document in the requested representation.

DID method implementers may choose to return verification methods in alternate formats for representations, for example, an implementer might prefer to return verification material encoded with `publicKeyJwk` for `application/did+json` and `publicKeyBase58` for `application/did+ld+json`.

Avoid allowing arbitrary unknown properties such as `__proto__` or other characters that might be used to attack JSON parsing into `application/did+json` .

While `application/did+json` is very flexible and allows for arbitrary JSON, implementers are cautioned to implement security in depth.

Implementers are cautioned to review [OWASP Top 10](https://owasp.org/www-project-top-ten/)

Implementers should confirm that each representation they decide to support is interoperable with the same representation in other DID Methods.

Implementers should avoid guessing about conformance to \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\].

_This section is non-normative._

Dereferencing is critical to integrating with cryptographic toolkits such as [Linked Data Proofs](https://w3c-ccg.github.io/ld-proofs/), [JOSE](https://www.iana.org/assignments/jose/jose.xhtml), [PGP](https://www.rfc-editor.org/rfc/rfc4880), or [Anon Creds](https://github.com/hyperledger/ursa-docs/tree/main/specs/anoncreds2).

_This section is non-normative._

_This section is non-normative._

_This section is non-normative._

Verification relationships are loosely equivalent to the concept of key purpose.

It is considered a security best practice not to reuse the same key for multiple purposes.

_This section is non-normative._

Implementers are advised to implement support for this relationship.

Use this relationship for proofs or signatures associated with DID Subject authentication.

Avoid conflating authentication and authorization.

Avoid leveraging alternative relationships for the purpose of authentication.

_This section is non-normative._

Implementers are advised to implement support for this relationship.

Use this relationship for proofs or signatures associated with claims issued by this DID Subject about another identifier, which might be a DID.

This method is described in the \[[VC-DATA-MODEL](https://w3c.github.io/did-imp-guide/#bib-vc-data-model "Verifiable Credentials Data Model v1.1")\], see [Proofs](https://www.w3.org/TR/vc-data-model/#proofs-signatures-0).

Avoid leveraging alternative relationships for the purpose of issuing credentials.

_This section is non-normative._

Note

See \[[DID-CORE](https://w3c.github.io/did-imp-guide/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] for normative requirements associated with the [Data Model](https://www.w3.org/TR/did-core/#data-model).

There is no strong consensus regarding preserving data model properties across representations. Removing properties when converting a [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents) can result in an inability to maintain interoperability with \[[VC-DATA-MODEL](https://w3c.github.io/did-imp-guide/#bib-vc-data-model "Verifiable Credentials Data Model v1.1")\]. See Drawbacks and Benefits.

The [DID document data model](https://www.w3.org/TR/did-core/#data-model) contains [properties](https://www.w3.org/TR/did-core/#core-properties) (such as `id`, `verificationMethod`, and `service`), which are defined in a way that is independent of a concrete representation. There are a number of known [representations](https://www.w3.org/TR/did-core/#representations), including [JSON](https://www.w3.org/TR/did-core/#json) and [JSON-LD](https://www.w3.org/TR/did-core/#json-ld) (defined by DID Core), and [CBOR](https://www.w3.org/TR/did-cbor-representation/#the-plain-cbor-representation) (defined by a DID WG Note). Additional representations (such as XML, YAML, CBOR-LD, and others) are possible and could be defined in the future. For each of these representations, a combination of production and consumption rules defines the concrete syntax of properties, but the semantics of properties are independent of any given representation. In other words, in every [representation](https://www.w3.org/TR/did-core/#dfn-representations) of a [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents), there is always a way to represent a `service` or a `verificationMethod`, and their meanings are consistent across conformant representations.

In addition to [properties](https://www.w3.org/TR/did-core/#core-properties), a DID document may contain [representation-specific entries](https://www.w3.org/TR/did-core/#dfn-representation-specific-entry) which may be required by certain representations in order to fully represent the [DID document data model](https://www.w3.org/TR/did-core/#data-model) and its properties. For example, the [JSON-LD representation](https://www.w3.org/TR/did-core/#json-ld) of a DID document (with media type `application/did+ld+json`) requires the `@context` representation-specific entry, in order to correctly express the semantics of properties such as `id`, `verificationMethod` or `service` within the JSON-LD representation. This enables JSON-LD’s semantics which are based on a decentralized, permissionless, open-world data model.

In contrast to this, the (non-LD) [JSON representation](https://www.w3.org/TR/did-core/#json) (with media type `application/did+json`) does not have this semantic capability; instead, (non-LD) JSON documents always need agreement on semantics in some out-of-band way that is not part of the document itself. In the case of DID documents using the (non-LD) JSON representation, those semantics are typically established by the [DID Spec Registries](https://w3c.github.io/did-spec-registries/). Therefore, establishing semantics of DID document properties in the (non-LD) JSON representation does not require the representation-specific `@context` entry, as is required by the JSON-LD representation.

As with the (non-LD) JSON representation compared to the JSON-LD representation, similar considerations apply between the (non-LD) CBOR representation and the CBOR-LD representation.

Other examples of [representation-specific entries](https://www.w3.org/TR/did-core/#dfn-representation-specific-entry) could be XML namespace definitions or YAML tags, although these particular representations have not been defined at the time of this writing.

If an entry that is specific to one representation appears in another representation, it can be called a representation-foreign entry. An example of this is a `@context` entry appearing in the `application/did+json` representation.

Examples of [representation-specific entries](https://www.w3.org/TR/did-core/#dfn-representation-specific-entry) and [representation-foreign entries](https://w3c.github.io/did-imp-guide/#dfn-representation-foreign-entries):

![Examples of representation-specific and representation-foreign entries in various representations.](https://w3c.github.io/did-imp-guide/diagrams/representation-specific-and-foreign-entries.png)

[Figure 1](https://w3c.github.io/did-imp-guide/#representation-entries) Representation-specific and representation-foreign entries.

_This section is non-normative._

It is bad practice and potentially harmful for producers to include "representation-foreign entries" in DID documents.

Different implementations of DID document consumers may or may not be able to properly understand the meaning and processing rules of representation-foreign entries. Since DIDs and DID documents form an open ecosystem with many producers and consumers, a producer cannot anticipate the behavior of a consumer with regard to representation-foreign entries.

For example, if a producer adds an [`@context`](https://www.w3.org/TR/did-core/#dfn-context) entry to a DID document in the [`application/did+json`](https://www.w3.org/TR/did-core/#json) representation, some consumers (those that understand JSON-LD, such as JSON-LD document loaders) may process it in one way, while other consumers (those that only understand plain JSON, without any JSON-LD specific rules) may process it in a different way.

This can lead to inconsistent behavior by consumers that cannot be predicted by a producer.

_This section is non-normative._

It is bad practice and potentially harmful for consumers to rely on representation-foreign entries in DID documents.

As a special case of the previous section, certain consumers may go as far as relying on the presence of representation-foreign entries. For example, an incorrectly implemented consumer of DID documents in the `application/did+json` representation may attempt to apply JSON-LD tooling to that representation. That tooling is dependent on the presence of the `@context` representation-foreign entry, which is not actually required (and in fact discouraged) to be used in the `application/did+json` representation.

The result is lack of interoperability, since such consumers will throw errors even if the returned DID document representation is actually conformant.

_This section is non-normative._

If some implementations of DID document consumers process representation-foreign entries, and others don’t, then this can lead to security holes, since the semantics of DID document properties will not be interpreted in a predictable way.

For example, consider the following DID document, and assume that the JSON-LD context `https://example.com/myextensions/other-definitions.jsonld` defines `blockchainAccountId` in a way that is different from the [property listed in the DID Specification Registries](https://www.w3.org/TR/did-extensions/#blockchainaccountid).

[Example 7](https://w3c.github.io/did-imp-guide/#example-a-did-document-in-the-application-did-json-representation-with-the-context-representation-foreign-entry)

: A DID document in the \`application/did+json\` representation with the \`@context\` representation-foreign entry

```
{
  "@context":[
    "https://www.w3.org/ns/did/v1",
    "https://example.com/myextensions/other-definitions.jsonld"
  ],
  "id":"did:example:123456789abcdefghi",
  "verificationMethod":[{
    "id": "did:example:123456789abcdefghi#vm-3",
    "controller": "did:example:123456789abcdefghi",
    "type": "EcdsaSecp256k1RecoveryMethod2020",
    "blockchainAccountId": "eip155:1:0xF3beAC30C498D9E26865F34fCAa57dBB935b0D74"
  }]
}
```

If this DID document is consumed as `application/did+json` by an implementation that doesn't understand JSON-LD, it will interpret `blockchainAccountId` as the [property listed in the DID Specification Registries](https://www.w3.org/TR/did-extensions/#blockchainaccountid), and it will process it accordingly.

If the exact same DID document is consumed as `application/did+json` by an implementation that understands JSON-LD, it may interpret `blockchainAccountId` using the provided JSON-LD context, and therefore process it differently.

It is a common mistake to claim that "JSON-LD is just JSON", and to justify injecting the `@context` representation-foreign entry into a DID document in the `application/did+json` representation. This claim however is true only on the syntax level, but wrong and dangerous on the semantic level, especially when security-related properties are involved. In the example above, different consumer implementations are likely to come to different conclusions on how the DID can be controlled.

Representation-foreign entries in DID documents should be avoided, since they can lead to inconsistent and unpredictable DID control decisions.

_This section is non-normative._

The DID document data model and the production/consumption rules of representations have been designed to enable lossless conversion between representations. Conversion between representations is achieved by executing the consumption rules of the source representation, and then the production rules of the target representation.

The DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries "Decentralized Identifier Extensions")\] provide additional information about properties as well as representation-specific entries that help with such conversion. For example, a DID document in the `application/did+json` representation can be converted to the `application/did+ld+json` representation by adding a `@context` representation-specific entry during production, using the JSON-LD context information in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-imp-guide/#bib-did-spec-registries "Decentralized Identifier Extensions")\].

Conversely, a DID document in the `application/did+ld+json` representation can be converted to the `application/did+json` representation by removing the `@context` representation-specific entry during consumption.

Representation-foreign entries in DID documents should be avoided, since the implications on lossless conversion between representations is unclear.

Implementers are not required to support all representations. For example, an implementation might choose to only support `application/did+json`, and choose not to support `application/did+ld+json`, `application/did+dag+cbor`, `application/did+xml`, `application/did+yaml`, etc...

Implementers might prefer to use JSON or YAML representations to implement both the abstract data model and concrete reprepresentations.

When converting between an implementation of the abstract data model and a representation that is capable of preserving all properties, all properties _SHOULD_ be preserved.

For example, preserving `@context` in YAML, allows for the document to later be used with [documentLoaders](https://www.w3.org/TR/json-ld11-api/#loaddocumentcallback) that use [JSON-LD Framing](https://www.w3.org/TR/json-ld11-framing/) to perform dereferencing.

[Example 8](https://w3c.github.io/did-imp-guide/#example-did-document-preserving-context-in-a-hypothetical-yaml-representation)

: DID document preserving @context in a hypothetical YAML representation

```
<span>---</span>
<span>"@context":</span>
<span>-</span> <span>https://www.w3.org/ns/did/v1</span>
<span>-</span> <span>https://w3id.org/security/suites/jws-2020/v1</span>
<span>id:</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
<span>verificationMethod:</span>
<span>-</span> <span>id:</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
  <span>type:</span> <span>JsonWebKey2020</span>
  <span>controller:</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
  <span>publicKeyJwk:</span>
    <span>kty:</span> <span>EC</span>
    <span>crv:</span> <span>P-384</span>
    <span>x:</span> <span>ELYfgFzSi43VGgKlyuYBKeoW00DmNqf5VuMWD1iUTTHQ8NRQrR4KHShzH_DrvOhh</span>
    <span>y:</span> <span>sftqdHdso4JPQO3MLnsXmWbAFqjmHLgP8H_DZSLxx3ei9kLj_W3R6NhtH03bwE1C</span>
<span>assertionMethod:</span>
<span>-</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
<span>authentication:</span>
<span>-</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
<span>capabilityInvocation:</span>
<span>-</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
<span>capabilityDelegation:</span>
<span>-</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
<span>keyAgreement:</span>
<span>-</span> <span>did:key:z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6#z82Lkm8gN2PGD7WbUiTUKRHgSptPhGPAQG9HT9HybYE9LoKYwcikh5rAU9gGo3qTne3ZHf6</span>
```

DID methods that support both `application/did+ld+json` and `application/did+json` ought to return `application/did+json` with an `@context`, because it enables both representations to be used with tooling and standards that support semantics (such as \[[VC-DATA-MODEL](https://w3c.github.io/did-imp-guide/#bib-vc-data-model "Verifiable Credentials Data Model v1.1")\]), and because the default behavior of JSON processors is to ignore object members that are not understood.

DID document representations produced by an implementation ought to be treated as immutable, since any tampering, including adding, removing, or reordering core or representation specific entries might be considered malicious, since it alters the integrity of the produced DID document.

_This section is non-normative._

Decentralized Identifiers, like any other technology, can be used to enhance privacy as well as harm privacy. This section speaks to topics that implementers might consider when thinking about the privacy characteristics of their software systems.

_This section is non-normative._

Never store personal data, even in an encrypted format, on any verifiable data registry backed by immutable storage.

It is the DID method implementer's responsibility to think about and identify the extent to which personal data may be included in a DID document.

Software should at least display a warning and ask for confirmation before creating or updating any properties of a DID document that depend on user provided inputs.

A DID method specification should have a section dedicated to personal data covering the extent to which information published on the corresponding ledger can be updated or deleted. It should provide specific instructions of how to do so, if it is possible. Otherwise, it should clearly state that it is not possible.

A DID method should avoid "phone home" or tracking characteristics that would permit tracing of a user in manner not understood or authorized by the user by some third party.

_This section is non-normative._

Avoid reusing verification methods across DID Methods.

Avoid reusing services with unique parameters across DID Methods.

Any anonymous identifier, even if it is generated randomly, can be used to infer sensitive information about a [DID subject](https://www.w3.org/TR/did-core/#did-subject) if it is reused enough times.

A DID method implementer should rotate keys and identifiers as often as possible to avoid correlation

_This section is non-normative._

Consider formally modeling the privacy implications associated with your implementation using [t-closeness](https://en.wikipedia.org/wiki/T-closeness) or other mechanisms.

If your DID Method supports global enumeration and indexing, consider exposing this information publicly. You may wish to provide alerts similar to services that watch version control systems for sensitive information that is accidentally leaked.

_This section is non-normative._

Review any applicable local law when considering developing or operating a decentralized identifier method.

Consider [GDPR](https://gdpr.eu/).

Consider [CCPA](https://oag.ca.gov/privacy/ccpa).

Consider [EAR](https://www.bis.doc.gov/index.php/policy-guidance/encryption).

_This section is non-normative._

Decentralized Identifiers are security primitives that are often used to secure important systems. This section speaks to topics that implementers might consider when thinking about the security characteristics of their software systems.

Pay very close attention to the defense, cryptographic agility, and political acceptability of any cryptography you rely on for DID Method security.

Avoid complex or slow signature formats, especially if they are poorly documented, or do not have an open standard with well documented test vectors.

Avoid open source implementations that are declared a "defacto standard", but lack open standard technical specifications.

Support for legacy cryptography systems such as [JOSE](https://www.iana.org/assignments/jose/jose.xhtml) and [OpenPGP](https://www.openpgp.org/) should be considered due to their prevalence in existing systems.

_This section is non-normative._

Competition, direct substitutability, interoperability, and mutual feature support are key to reducing the barriers to adoption of, and increasing confidence in, your DID Method.

Avoid inventing "new features". Work with others to find a common way to express any new features that are not unique to your DID Method.

Avoid hard coupling to specific networks, such as Bitcoin or Hyperledger Fabric. Design your method such that it may be adapted to support multiple ledger systems.

Transparency and openness in approaches related to security not only lead to greater security, but promote interoprability and adoption.

_This section is non-normative._

We recommend the user review [safecurves.cr.yp.to](https://safecurves.cr.yp.to/) before selecting elliptic curve types. A key note however, is that several items on safecurves are less frequently updated. In addition to safecurves you should always check the top level standards and any docs which superseed referenced standards in safecurves, especially [FIPS 186-4](https://csrc.nist.gov/publications/detail/fips/186/4/final) and [SP 800-56A Rev 3](https://csrc.nist.gov/publications/detail/sp/800-56a/rev-3/final) when evalutating curves for use.

Avoid secp256k1, RSA, P-256, P-384 and P-521.

Avoid relying on smart contracts for complex data management. If you must use a smart contract, keep it simple and architect a solution that supports data migration.

_This section is non-normative._

Avoid MD5, SHA1, and other legacy hashing algorithms with known weaknesses or high collision rates.

When in doubt in selection of a hashing algorithm, consult the [NIST documentation](https://csrc.nist.gov/projects/hash-functions) related to hash function selection, [SHA-3 as described in FIPS 202](https://csrc.nist.gov/publications/detail/fips/202/final) should be strongly considered for new implementations

_This section is non-normative._

When making an implemention carefully consider how you are sourcing random numbers. Consult [RFC 4086: Randomness Requirements for Security](https://datatracker.ietf.org/doc/html/RFC4086) when selecting an approach to get random bits, and pay careful attention to the platform and any underlying hardware that may be in use as multiple attacks have been performed in the wild due to improper selection of random values in key material and other aspects of cryptography.

_This section is non-normative._

Consider using [BBS+ Signatures](https://w3c-ccg.github.io/ldp-bbs2020/) for selective disclosure and linked-secret–based JSON-LD verifiable credentials.

The IETF document on [Pairing Friendly Curves](https://www.ietf.org/archive/id/draft-irtf-cfrg-pairing-friendly-curves-10.txt) should be consulted when selecting curves for usage with zero knowledge proofs, especially to ensure that appropriate embedding degrees are selected, and that the resulting equivalent bit characteristics are sufficient.

Avoid zero knowledge proofs as described in the [AnonCredDerivedCredentialv1](https://www.w3.org/TR/vc-data-model/#example-25-a-verifiable-presentation-that-supports-cl-signatures). This proof format is coupled to specific ledger technologies, similar to the concept of an ethereum virtual machine smart contract only running on EVM compatible ledgers. Ledger-specific technologies should be avoided when designing for portable, interoperable, and open-standards–based zero knowledge proofs.

Avoid storing credential schemas on ledgers. Many DID methods cannot store information other than a DID Document, which reduces the direct interoperability, substitutability, and cost effectiveness of solutions that make use of rare or poorly supported features such as credential schema definition storage.

_This section is non-normative._

Avoid relying exclusively on biometrics.

Hardware-isolated keys protected by biometrics on devices may increase the usability of DIDs.

The addition of biometrics to other techniques can aid in certain tasks such as reauthentication. [NIST SP 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html) deals directly with digital identity and has several useful sections that address appropriate language for describing biometrics usage as well as techniques for incorporating biometrics into an approach for solving problems related to digital identity.

_This section is non-normative._

The following section details certain key areas of focus when implementing a new DID method, or implementing a solution that incorporates DIDs.

The [W3C TAG Ethical Web Principles](https://www.w3.org/2001/tag/doc/ethical-web-principles/) document is a helpful guide when weighing ethical considerations of various technologies.

_This section is non-normative._

Decentralized Identifiers may come to underpin much of our digital life. This may include public social and career personas, as well as more private personas shared among friends and family. Identifiers representing these personas and relationships may be some of the most important in our lives, so great care will be taken when choosing an identifier system to support these critical activities. As with all things, the appropriate and ethical use of technology will be strongly considered when implementing items related to DIDs.

As noted in the [Principles](https://www.w3.org/2001/tag/doc/ethical-web-principles/#principles) section of the Ethical Web Principles, there are key goals that apply to all Web standards and technologies. DIDs are explicitly intended to help users get closer to several of these goals, especially the following:

-   [Privacy](https://www.w3.org/2001/tag/doc/ethical-web-principles/#privacy)
-   [Individual Control](https://www.w3.org/2001/tag/doc/ethical-web-principles/#control)
-   [Device Independence](https://www.w3.org/2001/tag/doc/ethical-web-principles/#multi)

_This section is non-normative._

The following section reflects the views of some members of the working group. Additional PRs are welcome from the working group with additional points of view.

_This section is non-normative._

The guiding principle that [the web must be an environmentally sustainable platform](https://www.w3.org/2001/tag/doc/ethical-web-principles/#sustainable) should be followed.  
When implementing or utilizing a DID method, consideration should be given to the environmental impacts caused by the method.

Issue 2

Some members of the working group feel it important that the \[[DID-RUBRIC](https://w3c.github.io/did-imp-guide/#bib-did-rubric "DID Method Rubric v1.0")\] include environmental considerations in order that users might appropriately evaluate and compare relevant aspects of DID methods that might be applicable to their use cases.

Many methods minimize environmental impact by leveraging existing infrastructure, such as the World Wide Web (with did:web) and Bitcoin (with did:btcr and did:ion). When considering any particular approach, whether creating a new method or selecting among current methods, care should be taken to distinguish between the marginal impact of the additional use of such infrastructure as a result of the DID method and the existing impact from current use. For example, the did:web implementation is unlikely to have a significant additive environmental impact above and beyond the existing World Wide Web.

-   [Security and Privacy Assessment Criteria for Decentralized Identifiers](https://w3c.github.io/reports/did-criteria-v4.0-public.pdf)
-   [Approach to Developing Security and Privacy Assessment Criteria for Decentralized Identifiers](https://w3c.github.io/reports/did-sec-priv-criteria-overview-public.pdf)
-   [Methods for Decentralized Identities: Evaluation and Insights](https://eprint.iacr.org/2021/1087)
-   [External Evaluation of DID Methods using the DID Rubric](https://docs.google.com/document/d/1jP-76ul0FZ3H8dChqT2hMtlzvL6B3famQbseZQ0AGS8/)

Note

This section was copied from [w3c/did-imp-guide](https://github.com/w3c/did-imp-guide/), and adjusted based on changes made to DID Core.

The current specification does not take a position on the maximum length of a [DID](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers). The maximum interoperable URL length is currently about 2048 characters. QR codes can handle about 4096 characters. Clients using [DIDs](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) will be responsible for storing many [DIDs](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers), and some methods would be able to externalize some of their costs onto clients by relying on more complicated signature schemes or by adding state into [DIDs](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) intended for temporary use. A future version of this specification should set reasonable limits on [DID](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) character length to minimize externalities.

[Verifiable Timestamps](https://www.w3.org/TR/did-core/#dfn-verifiable-timestamp) have significant utility for identifier records. This is a good fit for [DLTs](https://www.w3.org/TR/did-core/#dfn-distributed-ledger-technology), since most offer some type of timestamp mechanism. Despite some transactional cost, they are the among the most censorship-resistant transaction ordering systems at the present, so they are nearly ideal for [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents) timestamping. In some cases a [DLT](https://www.w3.org/TR/did-core/#dfn-distributed-ledger-technology)'s immediate timing is approximate, however their sense of "median time past" [(see Bitcoin BIP 113)](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki) can be precisely defined. A generic [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents) timestamping mechanism could would work across all [DLTs](https://www.w3.org/TR/did-core/#dfn-distributed-ledger-technology) and might operate via a mechanism including either individual transactions or transaction batches. Such a generic mechanism was deemed out of scope for this version, although it may be included in a future version of this specification.

Although [DIDs](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) and [DID documents](https://www.w3.org/TR/did-core/#dfn-did-documents) form a foundation for decentralized identity, they are only the first step in describing their subjects. The rest of the descriptive power comes through collecting and selectively using Verifiable Credentials \[[VC-DATA-MODEL](https://w3c.github.io/did-imp-guide/#bib-vc-data-model "Verifiable Credentials Data Model v1.1")\]. Future versions of the specification will describe in more detail how [DIDs](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) and [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents) can be integrated with — and help enable — the Verifiable Credentials ecosystem.

This version of the specification relies on JSON-LD and the RDF graph model for expressing a [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents). Future versions of this specification might specify other semantic graph formats for a [DID document](https://www.w3.org/TR/did-core/#dfn-did-documents).

\[DID-CORE\]

[Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/). Manu Sporny; Amy Guy; Markus Sabadello; Drummond Reed. W3C. 19 July 2022. W3C Recommendation. URL: [https://www.w3.org/TR/did-core/](https://www.w3.org/TR/did-core/)

\[RFC2119\]

[Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119). S. Bradner. IETF. March 1997. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc2119](https://www.rfc-editor.org/rfc/rfc2119)

\[RFC8174\]

[Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174). B. Leiba. IETF. May 2017. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc8174](https://www.rfc-editor.org/rfc/rfc8174)

\[VC-DATA-MODEL\]

[Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model/). Manu Sporny; Grant Noble; Dave Longley; Daniel Burnett; Brent Zundel; Kyle Den Hartog. W3C. 3 March 2022. W3C Recommendation. URL: [https://www.w3.org/TR/vc-data-model/](https://www.w3.org/TR/vc-data-model/)

\[DID-CBOR-REPRESENTATION\]

[The Plain CBOR Representation v1.0](https://www.w3.org/TR/did-cbor-representation/). Drummond Reed; Manu Sporny. W3C. 29 June 2021. W3C Working Group Note. URL: [https://www.w3.org/TR/did-cbor-representation/](https://www.w3.org/TR/did-cbor-representation/)

\[DID-RUBRIC\]

[DID Method Rubric v1.0](https://www.w3.org/TR/did-rubric/). Joe Andrieu; Daniel Hardman. W3C. 19 November 2021. W3C Working Group Note. URL: [https://www.w3.org/TR/did-rubric/](https://www.w3.org/TR/did-rubric/)

\[DID-SPEC-REGISTRIES\]

[Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/). Manu Sporny; Markus Sabadello. W3C. 19 February 2025. W3C Working Group Note. URL: [https://www.w3.org/TR/did-extensions/](https://www.w3.org/TR/did-extensions/)