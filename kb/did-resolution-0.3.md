# Decentralized Identifier Resolution (DID Resolution) v0.3
## Algorithms and guidelines for resolving DIDs and dereferencing DID URLs
### W3C Editor's Draft 29 May 2025

## Abstract

Decentralized identifiers (DIDs) are a new type of identifier for verifiable, "self-sovereign" digital identity. DIDs are fully under the control of the DID controller, independent from any centralized registry, identity provider, or certificate authority. DIDs resolve to DID Documents — simple documents that describe how to use that specific DID.

This document specifies the algorithms and guidelines for resolving DIDs and dereferencing DID URLs.

## Status of This Document

_This section describes the status of this document at the time of its publication. A list of current W3C publications and the latest revision of this technical report can be found in the [W3C standards and drafts index](https://www.w3.org/TR/) at https://www.w3.org/TR/._

Comments regarding this document are welcome. Please file issues directly on [GitHub](https://github.com/w3c/did-resolution/issues/), or send them to [public-did-wg@w3.org](mailto:public-did-wg@w3.org) ([subscribe](mailto:public-did-wg-request@w3.org?subject=subscribe), [archives](https://lists.w3.org/Archives/Public/public-did-wg/)).

Portions of the work on this specification have been funded by the United States Department of Homeland Security's Science and Technology Directorate under contracts HSHQDC-17-C-00019. The content of this specification does not necessarily reflect the position or the policy of the U.S. Government and no official endorsement should be inferred.

Work on this specification has also been supported by the Rebooting the Web of Trust community facilitated by Christopher Allen, Shannon Appelcline, Kiara Robles, Brian Weller, Betty Dhamers, Kaliya Young, Kim Hamilton Duffy, Manu Sporny, Drummond Reed, Joe Andrieu, and Heather Vescent.

This document was published by the [Decentralized Identifier Working Group](https://www.w3.org/groups/wg/did) as an Editor's Draft.

Publication as an Editor's Draft does not imply endorsement by W3C and its Members.

This is a draft document and may be updated, replaced, or obsoleted by other documents at any time. It is inappropriate to cite this document as other than work in progress.

This document was produced by a group operating under the [W3C Patent Policy](https://www.w3.org/policies/patent-policy/). W3C maintains a [public list of any patent disclosures](https://www.w3.org/groups/wg/did/ipr) made in connection with the deliverables of the group; that page also includes instructions for disclosing a patent. An individual who has actual knowledge of a patent which the individual believes contains [Essential Claim(s)](https://www.w3.org/policies/patent-policy/#def-essential) must disclose the information in accordance with [section 6 of the W3C Patent Policy](https://www.w3.org/policies/patent-policy/#sec-Disclosure).

This document is governed by the [03 November 2023 W3C Process Document](https://www.w3.org/policies/process/20231103/).

## Table of Contents

1.  [Abstract](https://w3c.github.io/did-resolution/#abstract)
2.  [Status of This Document](https://w3c.github.io/did-resolution/#sotd)
3.  [1. Introduction](https://w3c.github.io/did-resolution/#introduction)
    1.  [1.1 Conformance](https://w3c.github.io/did-resolution/#conformance)
    2.  [1.2 Audience](https://w3c.github.io/did-resolution/#audience)
4.  [2. Terminology](https://w3c.github.io/did-resolution/#terminology)
5.  [3. DID Parameters](https://w3c.github.io/did-resolution/#did-parameters)
6.  [4. DID Resolution](https://w3c.github.io/did-resolution/#resolving)
    1.  [4.1 DID Resolution Options](https://w3c.github.io/did-resolution/#did-resolution-options)
    2.  [4.2 DID Resolution Metadata](https://w3c.github.io/did-resolution/#did-resolution-metadata)
    3.  [4.3 DID Document Metadata](https://w3c.github.io/did-resolution/#did-document-metadata)
    4.  [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm)
7.  [5. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing)
    1.  [5.1 DID URL Dereferencing Options](https://w3c.github.io/did-resolution/#did-url-dereferencing-options)
    2.  [5.2 DID URL Dereferencing Metadata](https://w3c.github.io/did-resolution/#did-url-dereferencing-metadata)
    3.  [5.3 DID URL Dereferencing Algorithm](https://w3c.github.io/did-resolution/#dereferencing-algorithm)
        1.  [5.3.1 Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource)
        2.  [5.3.2 Dereferencing the Fragment](https://w3c.github.io/did-resolution/#dereferencing-algorithm-fragment)
    4.  [5.4 Examples](https://w3c.github.io/did-resolution/#examples)
        1.  [5.4.1 Example: Dereferencing to verification method](https://w3c.github.io/did-resolution/#example-dereferencing-to-verification-method)
        2.  [5.4.2 Example: Dereferencing to service endpoint URL](https://w3c.github.io/did-resolution/#example-dereferencing-to-service-endpoint-url)
8.  [6. Metadata Structure](https://w3c.github.io/did-resolution/#metadata-structure)
9.  [7. DID Resolution Architectures](https://w3c.github.io/did-resolution/#architectures)
    1.  [7.1 Method Architectures](https://w3c.github.io/did-resolution/#method-architectures)
    2.  [7.2 Resolver Architectures](https://w3c.github.io/did-resolution/#resolver-architectures)
        1.  [7.2.1 Multiple Methods](https://w3c.github.io/did-resolution/#resolver-architectures-multiple)
        2.  [7.2.2 Proxied Resolution](https://w3c.github.io/did-resolution/#resolver-architectures-proxied)
        3.  [7.2.3 Client-Side Dereferencing](https://w3c.github.io/did-resolution/#resolver-architectures-client-side)
    3.  [7.3 Examples](https://w3c.github.io/did-resolution/#examples-0)
10.  [8. DID Resolution Result](https://w3c.github.io/did-resolution/#did-resolution-result)
    1.  [8.1 Example](https://w3c.github.io/did-resolution/#example)
    2.  [8.2 DID Document](https://w3c.github.io/did-resolution/#output-diddocument)
    3.  [8.3 DID Resolution Metadata](https://w3c.github.io/did-resolution/#output-resolutionmetadata)
    4.  [8.4 DID Document Metadata](https://w3c.github.io/did-resolution/#output-documentmetadata)
11.  [9. DID URL Dereferencing Result](https://w3c.github.io/did-resolution/#did-url-dereferencing-result)
    1.  [9.1 Example](https://w3c.github.io/did-resolution/#example-0)
    2.  [9.2 Content](https://w3c.github.io/did-resolution/#output-content)
    3.  [9.3 DID URL Dereferencing Metadata](https://w3c.github.io/did-resolution/#output-dereferencingmetadata)
    4.  [9.4 Content Metadata](https://w3c.github.io/did-resolution/#output-contentmetadata)
12.  [10. Errors](https://w3c.github.io/did-resolution/#errors)
13.  [11. Bindings](https://w3c.github.io/did-resolution/#bindings)
    1.  [11.1 HTTP(S) Binding](https://w3c.github.io/did-resolution/#bindings-https)
    2.  [11.2 DID Resolution Examples](https://w3c.github.io/did-resolution/#did-resolution-examples)
    3.  [11.3 DID URL Dereferencing Examples](https://w3c.github.io/did-resolution/#did-url-dereferencing-examples)
14.  [12. Security Considerations](https://w3c.github.io/did-resolution/#security-considerations)
    1.  [12.1 Authentication/Authorization](https://w3c.github.io/did-resolution/#authentication)
    2.  [12.2 Caching](https://w3c.github.io/did-resolution/#caching)
    3.  [12.3 Versioning](https://w3c.github.io/did-resolution/#versioning)
    4.  [12.4 Non-DID Identifiers](https://w3c.github.io/did-resolution/#non-did-identifiers)
15.  [13. Privacy Considerations](https://w3c.github.io/did-resolution/#privacy-considerations)
    1.  [13.1 Non-DID Identifiers](https://w3c.github.io/did-resolution/#profiling-requesters)
16.  [14. Future Work](https://w3c.github.io/did-resolution/#future-work)
    1.  [14.1 Redirect](https://w3c.github.io/did-resolution/#redirect)
    2.  [14.2 Proxy](https://w3c.github.io/did-resolution/#proxy)
    3.  [14.3 JSON Pointer](https://w3c.github.io/did-resolution/#json-pointer)
17.  [A. DID Resolution Resources](https://w3c.github.io/did-resolution/#did-resolution-resources)
18.  [B. References](https://w3c.github.io/did-resolution/#references)
    1.  [B.1 Normative references](https://w3c.github.io/did-resolution/#normative-references)
    2.  [B.2 Informative references](https://w3c.github.io/did-resolution/#informative-references)

[DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) is the process of obtaining a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) for a given [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers). This is one of four required operations that can be performed on any DID ("Read"; the other ones being "Create", "Update", and "Deactivate"). The details of these operations differ depending on the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). Building on top of [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution), [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) is the process of retrieving a representation of a resource for a given [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). Software and/or hardware that is able to execute these processes is called a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).

This specification defines common requirements, algorithms including their inputs and results, architectural options, and various considerations for the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) processes.

Note that while this specification defines some base-level functionality for DID resolution, the actual steps required to communicate with a DID's [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) are defined by the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification.

Note

The difference between "resolving" a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and "dereferencing" a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) is being thoroughly discussed by the community. For example, see [this comment](https://github.com/w3c/did-spec/issues/166#issuecomment-464502719).

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key words _MAY_, _MUST_, _MUST NOT_, _OPTIONAL_, _RECOMMENDED_, _REQUIRED_, and _SHOULD_ in this document are to be interpreted as described in [BCP 14](https://www.rfc-editor.org/info/bcp14) \[[RFC2119](https://w3c.github.io/did-resolution/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] \[[RFC8174](https://w3c.github.io/did-resolution/#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")\] when, and only when, they appear in all capitals, as shown here.

A conforming DID resolver is any algorithm realized as software and/or hardware that complies with the relevant normative statements in [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving).

A conforming DID URL dereferencer is any algorithm realized as software and/or hardware that complies with the relevant normative statements in [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing).

_This section is non-normative._

This specification has three primary audiences: implementers of conformant DID methods; implementers of conformant DID resolvers; and implementers of systems and services that wish to resolve DIDs using DID resolvers. The intended audience includes, but is not limited to, software architects, data modelers, application developers, service developers, testers, operators, and user experience (UX) specialists. Other people involved in a broad range of standards efforts related to decentralized identity, verifiable credentials, and secure storage might also be interested in reading this specification.

This section defines the terms used in this specification and throughout [decentralized identifier](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) infrastructure. A link to these terms is included whenever they appear in this specification.

authenticate

Authentication is a process by which an entity can prove it has a specific attribute or controls a specific secret using one or more [verification methods](https://w3c.github.io/did-resolution/#dfn-verification-method). With [DIDs](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers), a common example would be proving control of the cryptographic private key associated with a public key published in a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

binding

A concrete mechanism through which a [client](https://w3c.github.io/did-resolution/#dfn-client) invokes a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s). This could be a [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding) such as a local command line tool or library API, or a [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) such as the [HTTP(S) binding](https://w3c.github.io/did-resolution/#bindings-https). See Section [7.2 Resolver Architectures](https://w3c.github.io/did-resolution/#resolver-architectures).

client

Software and/or hardware that invokes a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) in order to execute the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and/or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithms. This invocation is done via a [binding](https://w3c.github.io/did-resolution/#dfn-binding). The term [client](https://w3c.github.io/did-resolution/#dfn-client) does not imply any specific network topology.

decentralized identifier (DID)

A globally unique persistent identifier that does not require a centralized registration authority and is often generated and/or registered cryptographically. The generic format of a DID is defined in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-syntax). A specific [DID scheme](https://w3c.github.io/did-resolution/#dfn-did-schemes) is defined in a [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification. Many—but not all—DID methods make use of [distributed ledger technology](https://w3c.github.io/did-resolution/#dfn-distributed-ledger-technology) (DLT) or some other form of decentralized network.

DID controller

An entity that has the capability to make changes to a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). A [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) might have more than one DID controller. The DID controller(s) can be denoted by the optional `controller` property at the top level of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). Note that a DID controller might be the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects).

DID delegate

An entity to whom a [DID controller](https://w3c.github.io/did-resolution/#dfn-did-controllers) has granted permission to use a [verification method](https://w3c.github.io/did-resolution/#dfn-verification-method) associated with a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) via a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). For example, a parent who controls a child's [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) might permit the child to use their personal device in order to [authenticate](https://w3c.github.io/did-resolution/#dfn-authenticated). In this case, the child is the [DID delegate](https://w3c.github.io/did-resolution/#dfn-did-delegate). The child's personal device would contain the private cryptographic material enabling the child to [authenticate](https://w3c.github.io/did-resolution/#dfn-authenticated) using the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers). However, the child might not be permitted to add other personal devices without the parent's permission.

DID document

A set of data describing the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects), including mechanisms, such as cryptographic public keys, that the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) or a [DID delegate](https://w3c.github.io/did-resolution/#dfn-did-delegate) can use to [authenticate](https://w3c.github.io/did-resolution/#dfn-authenticated) itself and prove its association with the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers).

DID fragment

The portion of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) that follows the first hash sign character (`#`). DID fragment syntax is identical to URI fragment syntax.

DID method

A definition of how a specific [DID method scheme](https://w3c.github.io/did-resolution/#dfn-did-schemes) is implemented. A DID method is defined by a DID method specification, which specifies the precise operations by which [DIDs](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and [DID documents](https://w3c.github.io/did-resolution/#dfn-did-documents) are created, resolved, updated, and deactivated. See [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#methods).

DID path

The portion of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) that begins with and includes the first forward slash (`/`) character and ends with either a question mark (`?`) character, a fragment hash sign (`#`) character, or the end of the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). DID path syntax is identical to URI path syntax. See [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#path).

DID query

The portion of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) that follows and includes the first question mark character (`?`). DID query syntax is identical to URI query syntax. See [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#query).

DID resolution

The process that takes as its input a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and a set of resolution options and returns a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) in a conforming [representation](https://w3c.github.io/did-resolution/#dfn-representations) plus additional metadata. This process relies on the "Read" operation of the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). The inputs and outputs of this process are defined in [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving).

DID resolver

A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) is a software and/or hardware component that performs the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function by taking a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) as input and producing a conforming [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) as output.

DID resolution result

A data structure that represents the result of the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm. May contain a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). See Section [8\. DID Resolution Result](https://w3c.github.io/did-resolution/#did-resolution-result).

DID scheme

The formal syntax of a [decentralized identifier](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers). The generic DID scheme begins with the prefix `did:` as defined in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-syntax). Each [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification defines a specific DID method scheme that works with that specific [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). In a specific DID method scheme, the DID method name follows the first colon and terminates with the second colon, e.g., `did:example:`

DID subject

The entity identified by a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and described by a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). Anything can be a DID subject: person, group, organization, physical thing, digital thing, logical thing, etc.

DID URL

A [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) plus any additional syntactic component that conforms to the definition in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-url-syntax). This includes an optional [DID path](https://w3c.github.io/did-resolution/#dfn-did-paths) (with its leading `/` character), optional [DID query](https://w3c.github.io/did-resolution/#dfn-did-queries) (with its leading `?` character), and optional [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) (with its leading `#` character).

DID URL dereferencing

The process that takes as its input a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) and a set of input metadata, and returns a [resource](https://w3c.github.io/did-resolution/#dfn-resources). This resource might be a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) plus additional metadata, a secondary resource contained within the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents), or a resource entirely external to the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). The process uses [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) to fetch a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) indicated by the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) contained within the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). The dereferencing process can then perform additional processing on the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to return the dereferenced resource indicated by the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). The inputs and outputs of this process are defined in [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing).

DID URL dereferencer

A software and/or hardware system that performs the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function for a given [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) or [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

DID URL dereferencing result

A data structure that represents the result of the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithm. May contain a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) or other content. See Section [9\. DID URL Dereferencing Result](https://w3c.github.io/did-resolution/#did-url-dereferencing-result).

distributed ledger (DLT)

A non-centralized system for recording events. These systems establish sufficient confidence for participants to rely upon the data recorded by others to make operational decisions. They typically use distributed databases where different nodes use a consensus protocol to confirm the ordering of cryptographically signed transactions. The linking of digitally signed transactions over time often makes the history of the ledger effectively immutable.

resource

As defined by \[[RFC3986](https://w3c.github.io/did-resolution/#bib-rfc3986 "Uniform Resource Identifier (URI): Generic Syntax")\]: "...the term 'resource' is used in a general sense for whatever might be identified by a URI." Similarly, any resource might serve as a [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) identified by a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers).

representation

As defined for HTTP by \[[RFC7231](https://w3c.github.io/did-resolution/#bib-rfc7231 "Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content")\]: "information that is intended to reflect a past, current, or desired state of a given resource, in a format that can be readily communicated via the protocol, and that consists of a set of representation metadata and a potentially unbounded stream of representation data." A [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) is a representation of information describing a [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects). See [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#representations).

local binding

A [binding](https://w3c.github.io/did-resolution/#dfn-binding) where the [client](https://w3c.github.io/did-resolution/#dfn-client) invokes a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) that runs on the same network host, e.g., via a local command line tool or library API. In this case, the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) is sometimes also called a "local [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s)". See Section [7.2 Resolver Architectures](https://w3c.github.io/did-resolution/#resolver-architectures).

remote binding

A [binding](https://w3c.github.io/did-resolution/#dfn-binding) where the [client](https://w3c.github.io/did-resolution/#dfn-client) invokes a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) that runs on a different network host, e.g., via the [HTTP(S) binding](https://w3c.github.io/did-resolution/#bindings-https). In this case, the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) is sometimes also called a "remote [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s)". See Section [7.2 Resolver Architectures](https://w3c.github.io/did-resolution/#resolver-architectures).

services

Means of communicating or interacting with the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) or associated entities via one or more [service endpoints](https://w3c.github.io/did-resolution/#dfn-service-endpoints). Examples include discovery services, agent services, social networking services, file storage services, and verifiable credential repository services.

service endpoint

A network address, such as an HTTP URL, at which [services](https://w3c.github.io/did-resolution/#dfn-service) operate on behalf of a [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects).

unverifiable read

A low confidence implementation of a [DID method's](https://w3c.github.io/did-resolution/#dfn-did-method-s) "Read" operation between the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry), to obtain the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). There is no guarantee about the integrity and correctness of the result. See Section [7.1 Method Architectures](https://w3c.github.io/did-resolution/#method-architectures).

verifiable data registry

A system that facilitates the creation, verification, updating, and/or deactivation of [decentralized identifiers](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and [DID documents](https://w3c.github.io/did-resolution/#dfn-did-documents). A verifiable data registry might also be used for other cryptographically-verifiable data structures such as [verifiable credentials](https://www.w3.org/TR/vc-data-model/#dfn-verifiable-credential). For more information, see the W3C Verifiable Credentials specification \[[VC-DATA-MODEL](https://w3c.github.io/did-resolution/#bib-vc-data-model "Verifiable Credentials Data Model v1.1")\].

verification method

A set of parameters that can be used together with a process to independently verify a proof. For example, a cryptographic public key can be used as a verification method with respect to a digital signature; in such usage, it verifies that the signer possessed the associated cryptographic private key.

"Verification" and "proof" in this definition are intended to apply broadly. For example, a cryptographic public key might be used during Diffie-Hellman key exchange to negotiate a shared symmetric key for encryption. This guarantees the integrity of the key agreement process. It is thus another type of verification method, even though descriptions of the process might not use the words "verification" or "proof."

verifiable read

A high confidence implementation of a [DID method's](https://w3c.github.io/did-resolution/#dfn-did-method-s) "Read" operation between the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry), to obtain the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). There are guarantees about the integrity and correctness of the result to the extent possible under the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). See Section [7.1 Method Architectures](https://w3c.github.io/did-resolution/#method-architectures).

Universally Unique Identifier (UUID)

A type of globally unique identifier defined by \[[RFC4122](https://w3c.github.io/did-resolution/#bib-rfc4122 "A Universally Unique IDentifier (UUID) URN Namespace")\]. UUIDs are similar to DIDs in that they do not require a centralized registration authority. UUIDs differ from DIDs in that they are not resolvable or cryptographically-verifiable.

Uniform Resource Identifier (URI)

The standard identifier format for all resources on the World Wide Web as defined by \[[RFC3986](https://w3c.github.io/did-resolution/#bib-rfc3986 "Uniform Resource Identifier (URI): Generic Syntax")\]. A [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) is a type of URI scheme.

The [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) syntax supports a simple format for parameters (see section [Query](https://www.w3.org/TR/did-core/#query) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\]). Adding a DID parameter to a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) means that the parameter becomes part of the identifier for a [resource](https://w3c.github.io/did-resolution/#dfn-resources).

[Example 1](https://w3c.github.io/did-resolution/#example-a-did-url-with-a-versiontime-did-parameter)

: A DID URL with a 'versionTime' DID parameter

```
did:example:123?versionTime=2021-05-10T17:00:00Z
```

[Example 2](https://w3c.github.io/did-resolution/#example-a-did-url-with-a-service-and-a-relativeref-did-parameter)

: A DID URL with a 'service' and a 'relativeRef' DID parameter

```
did:example:123?service=files&amp;relativeRef=/resume.pdf
```

Some DID parameters are completely independent of any specific [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) and function the same way for all [DIDs](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers). Other DID parameters are not supported by all [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s). Where optional parameters are supported, they are expected to operate uniformly across the [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) that do support them. The following table provides common DID parameters that function the same way across all [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s). Support for all [DID Parameters](https://w3c.github.io/did-resolution/#did-parameters) is _OPTIONAL_.

| Parameter Name | Description |
| --- | --- |
| `[service](https://w3c.github.io/did-resolution/#dfn-service)` | Identifies a [service](https://www.w3.org/TR/did-core/#services) from the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) by service ID. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). |
| `serviceType` | Identifies a set of one or more [services](https://www.w3.org/TR/did-core/#services) from the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) by service type. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). |
| `relativeRef` | A relative [URI](https://w3c.github.io/did-resolution/#dfn-uri) reference according to [RFC3986 Section 4.2](https://www.rfc-editor.org/rfc/rfc3986#section-4.2) that identifies a [resource](https://w3c.github.io/did-resolution/#dfn-resources) at a [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints), which is selected from a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) by using the `service` parameter. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string) and _MUST_ use percent-encoding for certain characters as specified in [RFC3986 Section 2.1](https://www.rfc-editor.org/rfc/rfc3986#section-2.1). |
| `versionId` | Identifies a specific version of a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to be resolved (the version ID could be sequential, or a [UUID](https://w3c.github.io/did-resolution/#dfn-uuid), or method-specific). If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). |
| `versionTime` | Identifies a certain version timestamp of a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to be resolved. That is, the most recent version of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) that was valid for a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) before the specified `versionTime`. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string) which is a valid XML datetime value, as defined in section 3.3.7 of [W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes](https://www.w3.org/TR/xmlschema11-2/) \[[XMLSCHEMA11-2](https://w3c.github.io/did-resolution/#bib-xmlschema11-2 "W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes")\]. This datetime value _MUST_ be normalized to UTC 00:00:00 and without sub-second decimal precision. For example: `2020-12-20T19:17:47Z`. |
| `hl` | A resource hash of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to add integrity protection, as specified in \[[HASHLINK](https://w3c.github.io/did-resolution/#bib-hashlink "Cryptographic Hyperlinks")\]. This parameter is non-normative. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). |

Implementers as well as [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification authors might use additional DID parameters that are not listed here. For maximum interoperability, it is _RECOMMENDED_ that DID parameters use the DID Specification Registries mechanism \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\], to avoid collision with other uses of the same DID parameter with different semantics.

DID parameters might be used if there is a clear use case where the parameter needs to be part of a URL that references a [resource](https://w3c.github.io/did-resolution/#dfn-resources) with more precision than using the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) alone. It is expected that DID parameters are _not_ used if the same functionality can be expressed by passing input metadata to a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).

Note

: DID parameters and DID resolution

The [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) functions can be influenced by passing [4.1 DID Resolution Options](https://w3c.github.io/did-resolution/#did-resolution-options) or [5.1 DID URL Dereferencing Options](https://w3c.github.io/did-resolution/#did-url-dereferencing-options) to a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) that are not part of the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). This is comparable to HTTP, where certain parameters could either be included in an HTTP URL, or alternatively passed as HTTP headers during the dereferencing process. The important distinction is that DID parameters that are part of the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) should be used to specify _what [resource](https://w3c.github.io/did-resolution/#dfn-resources) is being identified_, whereas input metadata that is not part of the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) should be used to control _how that [resource](https://w3c.github.io/did-resolution/#dfn-resources) is resolved or dereferenced_.

The [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function resolves a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) into a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) by using the "Read" operation of the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) as described in [Method Operations](https://www.w3.org/TR/did-core/#method-operations). All conforming [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implement the function below, which has the following abstract form:

```
resolve(did, resolutionOptions) →
   « didResolutionMetadata, didDocument, didDocumentMetadata »
```

All conformant [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) _MUST_ implement the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function for at least one [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) and _MUST_ be able to return a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) in at least one conformant [representation](https://w3c.github.io/did-resolution/#dfn-representations).

Conforming [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implementations do not alter the signature of this function in any way. [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implementations might map the `resolve` function to a method-specific internal function to perform the actual [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) process. [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implementations might implement and expose additional functions with different signatures in addition to the `resolve` function specified here.

The input variables of the `resolve` function are as follows:

did

This is the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) to resolve. This input is _REQUIRED_ and the value _MUST_ be a conformant [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) as defined in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-syntax).

resolutionOptions

A [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure) containing properties defined in [4.1 DID Resolution Options](https://w3c.github.io/did-resolution/#did-resolution-options). This input is _REQUIRED_, but the structure _MAY_ be empty.

This function returns multiple values, and no limitations are placed on how these values are returned together. The return values of `resolve` are [didResolutionMetadata](https://w3c.github.io/did-resolution/#dfn-didresolutionmetadata), [didDocument](https://w3c.github.io/did-resolution/#dfn-diddocument), and [didDocumentMetadata](https://w3c.github.io/did-resolution/#dfn-diddocumentmetadata). These values are described below:

didResolutionMetadata

A [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure) consisting of values relating to the results of the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) process which typically changes between invocations of the `resolve` function, as it represents data about the resolution process itself. This structure is _REQUIRED_, and in the case of an error in the resolution process, this _MUST NOT_ be empty. This metadata is defined by [4.2 DID Resolution Metadata](https://w3c.github.io/did-resolution/#did-resolution-metadata). If the resolution is not successful, this structure _MUST_ contain an `error` property describing the error. See Section [10\. Errors](https://w3c.github.io/did-resolution/#errors). Additional errors _SHOULD_ be registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\].

didDocument

If the resolution is successful, this _MUST_ be a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) that is capable of being represented in one of the conformant [representations](https://www.w3.org/TR/did-core/#representations) of the [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/) specification. The value of `[id](https://www.w3.org/TR/did-core/#dfn-id)` in the resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) _MUST_ match the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) that was resolved. If the resolution is unsuccessful, this value _MUST_ be empty.

didDocumentMetadata

If the resolution is successful, this _MUST_ be a [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure). This structure contains metadata about the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) contained in the `didDocument` property. This metadata typically does not change between invocations of the `resolve` function unless the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) changes, as it represents metadata about the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). If the resolution is unsuccessful, this output _MUST_ be an empty [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure). Properties defined by this specification are in [4.3 DID Document Metadata](https://w3c.github.io/did-resolution/#did-document-metadata).

The possible properties within this structure and their possible values are registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. This specification defines the following common properties.

accept

The Media Type of the caller's preferred [representation](https://w3c.github.io/did-resolution/#dfn-representations) of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). The Media Type _MUST_ be expressed as an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). The [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implementation _SHOULD_ use this value to determine the [representation](https://w3c.github.io/did-resolution/#dfn-representations) of the returned `didDocument` if such a [representation](https://w3c.github.io/did-resolution/#dfn-representations) is supported and available. This property is _OPTIONAL_.

expandRelativeUrls

A boolean flag which instructs a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) to expand [relative DID URLs](https://www.w3.org/TR/did-core/#relative-did-urls) in the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to absolute DID URLs conformant with [DID URL Syntax](https://www.w3.org/TR/did-core/#did-url-syntax).

versionId

See [3\. DID Parameters](https://w3c.github.io/did-resolution/#did-parameters) for the definition.

versionTime

See [3\. DID Parameters](https://w3c.github.io/did-resolution/#did-parameters) for the definition.

The possible properties within this structure and their possible values are registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. This specification defines the following DID resolution metadata properties:

contentType

The Media Type of the returned `didDocument`. This property is _OPTIONAL_. If present, the value of this property _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string) that is the Media Type of the conformant [representations](https://w3c.github.io/did-resolution/#dfn-representations). In this case, the caller of the `resolve` function _MUST_ use this value when determining how to parse and process the `didDocument`.

error

An error data structure defined in \[[RFC9457](https://w3c.github.io/did-resolution/#bib-rfc9457 "Problem Details for HTTP APIs")\]. This property is _REQUIRED_ when there is an error in the resolution process. The errors defined by this specification and can be found in Section [10\. Errors](https://w3c.github.io/did-resolution/#errors). Additional errors _SHOULD_ be registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\].

The possible properties within this structure and their possible values _SHOULD_ be registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. This specification defines the following common properties.

created

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _SHOULD_ include a `created` property to indicate the timestamp of the [Create operation](https://www.w3.org/TR/did-core/#method-operations). The value of the property _MUST_ be a [string](https://infra.spec.whatwg.org/#string) formatted as an [XML Datetime](https://www.w3.org/TR/xmlschema11-2/#dateTime) normalized to UTC 00:00:00 and without sub-second decimal precision. For example: `2020-12-20T19:17:47Z`.

updated

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _SHOULD_ include an `updated` property to indicate the timestamp of the last [Update operation](https://www.w3.org/TR/did-core/#method-operations) for the document version which was resolved. The value of the property _MUST_ follow the same formatting rules as the `created` property. The `updated` property is omitted if an Update operation has never been performed on the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). If an `updated` property exists, it can be the same value as the `created` property when the difference between the two timestamps is less than one second.

deactivated

If a DID has been [deactivated](https://www.w3.org/TR/did-core/#method-operations), [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _MUST_ include this property with the boolean value `true`. If a DID has not been deactivated, this property is _OPTIONAL_, but if included, _MUST_ have the boolean value `false`.

nextUpdate

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _MAY_ include a `nextUpdate` property if the resolved document version is not the latest version of the document. It indicates the timestamp of the next [Update operation](https://www.w3.org/TR/did-core/#method-operations). The value of the property _MUST_ follow the same formatting rules as the `created` property.

versionId

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _SHOULD_ include a `versionId` property to indicate the version of the last [Update operation](https://www.w3.org/TR/did-core/#method-operations) for the document version which was resolved. The value of the property _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string).

nextVersionId

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _MAY_ include a `nextVersionId` property if the resolved document version is not the latest version of the document. It indicates the version of the next [Update operation](https://www.w3.org/TR/did-core/#method-operations). The value of the property _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string).

equivalentId

A [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) can define different forms of a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) that are logically equivalent. An example is when a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) takes one form prior to registration in a [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) and another form after such registration. In this case, the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification might need to express one or more [DIDs](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) that are logically equivalent to the resolved [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) as a property of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). This is the purpose of the `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` property.

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _MAY_ include an `equivalentId` property. If present, the value _MUST_ be a [set](https://infra.spec.whatwg.org/#ordered-set) where each item is a [string](https://infra.spec.whatwg.org/#string) that conforms to the rules in Section [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-syntax). The relationship is a statement that each `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` value is logically equivalent to the `id` property value and thus refers to the same [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects). Each `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` DID value _MUST_ be produced by, and a form of, the same [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) as the `id` property value. (e.g., `did:example:abc` == `did:example:ABC`)

A conforming [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification _MUST_ guarantee that each `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` value is logically equivalent to the `id` property value.

A requesting party is expected to retain the values from the `id` and `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` properties to ensure any subsequent interactions with any of the values they contain are correctly handled as logically equivalent (e.g., retain all variants in a database so an interaction with any one maps to the same underlying account).

Note

: Stronger equivalence

`[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` is a much stronger form of equivalence than `[alsoKnownAs](https://www.w3.org/TR/did-core/#also-known-as)` because the equivalence _MUST_ be guaranteed by the governing [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` represents a full graph merge because the same [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) describes both the `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) and the `id` property [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers).

If a requesting party does not retain the values from the `id` and `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` properties and ensure any subsequent interactions with any of the values they contain are correctly handled as logically equivalent, there might be negative or unexpected issues that arise. Implementers are strongly advised to observe the directives related to this metadata property.

canonicalId

The `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` property is identical to the `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` property except: a) it is associated with a single value rather than a set, and b) the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) is defined to be the canonical ID for the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) within the scope of the containing [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

[DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) metadata _MAY_ include a `canonicalId` property. If present, the value _MUST_ be a [string](https://infra.spec.whatwg.org/#string) that conforms to the rules in Section [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/#did-syntax). The relationship is a statement that the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value is logically equivalent to the `id` property value and that the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value is defined by the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) to be the canonical ID for the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) in the scope of the containing [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). A `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value _MUST_ be produced by, and a form of, the same [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) as the `id` property value. (e.g., `did:example:abc` == `did:example:ABC`).

A conforming [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) specification _MUST_ guarantee that the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value is logically equivalent to the `id` property value.

A requesting party is expected to use the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value as its primary ID value for the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) and treat all other equivalent values as secondary aliases (e.g., update corresponding primary references in their systems to reflect the new canonical ID directive).

Note

: Canonical equivalence

`[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` is the same statement of equivalence as `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)` except it is constrained to a single value that is defined to be canonical for the [DID subject](https://w3c.github.io/did-resolution/#dfn-did-subjects) in the scope of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). Like `[equivalentId](https://w3c.github.io/did-resolution/#dfn-equivalentid)`, `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` represents a full graph merge because the same [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) describes both the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` DID and the `id` property [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers).

If a resolving party does not use the `[canonicalId](https://w3c.github.io/did-resolution/#dfn-canonicalid)` value as its primary ID value for the DID subject and treat all other equivalent values as secondary aliases, there might be negative or unexpected issues that arise related to user experience. Implementers are strongly advised to observe the directives related to this metadata property.

The following [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm _MUST_ be implemented by a conformant [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).

1.  Validate that the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) conforms to the `did` rule of the [DID Syntax](https://www.w3.org/TR/did-core/#did-syntax). If not, the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) _MUST_ return the following result:
    1.  **didResolutionMetadata**: error object with type set to [INVALID\_DID](https://w3c.github.io/did-resolution/#INVALID_DID)
    2.  **didDocument**: `null`
    3.  **didDocumentMetadata**: `«[ ]»`
2.  Determine whether the DID method of the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) is supported by the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) that implements this algorithm. If not, the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) _MUST_ return the following result:
    1.  **didResolutionMetadata**: error object with type set to [METHOD\_NOT\_SUPPORTED](https://w3c.github.io/did-resolution/#METHOD_NOT_SUPPORTED)
    2.  **didDocument**: `null`
    3.  **didDocumentMetadata**: `«[ ]»`
3.  Obtain the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) for the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) by executing the [Read](https://www.w3.org/TR/did-core/#method-operations) operation against the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers)'s [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry), as defined by the input [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s):
    1.  Besides the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers), all additional resolution options of this algorithm _MUST_ be passed to the [Read](https://www.w3.org/TR/did-core/#method-operations) operation of the input [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s).
    2.  If the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) does not exist, return the following result:
        1.  **didResolutionMetadata**: error object with type set to [NOT\_FOUND](https://w3c.github.io/did-resolution/#NOT_FOUND)
        2.  **didDocument**: `null`
        3.  **didDocumentMetadata**: `«[ ]»`
    3.  If the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) has been deactivated, return the following result:
        1.  **didResolutionMetadata**: `«[ ... ]»`
        2.  **didDocument**: `null`
        3.  **didDocumentMetadata**: `«[ "deactivated" → true, ... ]»`
    4.  Otherwise, the result of the [Read](https://www.w3.org/TR/did-core/#method-operations) operation is called the output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents). This result _MUST_ be represented in a [conformant representation](https://www.w3.org/TR/did-core/#representations) that corresponds to the **accept** input [DID resolution option](https://w3c.github.io/did-resolution/#did-resolution-options).
4.  If the input [DID resolution options](https://w3c.github.io/did-resolution/#did-resolution-options) contain the `expandRelativeUrls` option with a value of `true`:
    1.  Iterate over all [services](https://www.w3.org/TR/did-core/#services), [verification methods](https://www.w3.org/TR/did-core/#verification-methods), and [verification relationships](https://www.w3.org/TR/did-core/#verification-relationships) in the output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).
    2.  If the value of the `id` property of a [service](https://www.w3.org/TR/did-core/#services) or [verification method](https://www.w3.org/TR/did-core/#verification-methods) (including those embedded in [verification relationships](https://www.w3.org/TR/did-core/#verification-relationships)) is a [relative DID URL](https://www.w3.org/TR/did-core/#relative-did-urls), or if a [verification relationship](https://www.w3.org/TR/did-core/#verification-relationships) is a [relative DID URL](https://www.w3.org/TR/did-core/#relative-did-urls):
        1.  Resolve the [relative DID URL](https://www.w3.org/TR/did-core/#relative-did-urls) to an absolute [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) conformant with [DID URL Syntax](https://www.w3.org/TR/did-core/#did-url-syntax), according to the rules of section [Relative DID URLs](https://www.w3.org/TR/did-core/#relative-did-urls) in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/).
    3.  Update the output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) by replacing the [relative DID URLs](https://www.w3.org/TR/did-core/#relative-did-urls) with the resolved absolute [DID URLs](https://w3c.github.io/did-resolution/#dfn-did-urls).
5.  Return the following result:
    1.  **didResolutionMetadata**: `«[ ... ]»`
    2.  **didDocument**: output DID document
    3.  **didDocumentMetadata**: `«[ "contentType" →` output DID document media type`, ... ]»`

There is discussion how a DID that has been [deactivated](https://www.w3.org/TR/did-core/#method-operations) should be treated during the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) process.

Specify how signatures/proofs on a DID document should be verified during the DID resolution process.

Issue

Should we define functionality that enables discovery of the list of [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) or other capabilities that are supported by a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s)? Or is this implementation-specific and out-of-scope for this spec? For example, see [here](https://github.com/w3c/did-resolution/issues/26) and [here](https://github.com/w3c/did-resolution/issues/25).

The [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function dereferences a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) into a [resource](https://w3c.github.io/did-resolution/#dfn-resources) with contents depending on the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls)'s components, including the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s), method-specific identifier, path, query, and fragment. This process depends on [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) of the [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) contained in the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) might involve multiple steps (e.g., when the DID URL being dereferenced includes a fragment), and the function is defined to return the final resource after all steps are completed. The following figure depicts the relationship described above.

![
DIDs resolve to DID documents; DID URLs contains a DID; DID URLs dereferenced to DID document fragments or
external resources.
](https://w3c.github.io/did-resolution/diagrams/section-5/did-url-dereference-overview.svg)

[Figure 1](https://w3c.github.io/did-resolution/#did-url-dereference-overview) Overview of DID URL dereference See also: [narrative description](https://w3c.github.io/did-resolution/#did-url-dereference-overview-longdesc).

All conforming [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implement the following function which has the following abstract form:

```
dereference(didUrl, dereferenceOptions) →
   « dereferencingMetadata, contentStream, contentMetadata »
```

The input variables of the `dereference` function are as follows:

didUrl

A conformant [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) as a single [string](https://infra.spec.whatwg.org/#string). This is the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) to dereference. To dereference a [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments), the complete [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) including the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) _MUST_ be used. This input is _REQUIRED_.

Note

: DID URL dereferencer patterns

While it is valid for any `didUrl` to be passed to a DID URL dereferencer, implementers are expected to refer to [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing) to further understand common patterns for how a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) is expected to be dereferenced.

dereferencingOptions

A [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure) consisting of input options to the `dereference` function in addition to the `didUrl` itself. Properties defined by this specification are in [5.1 DID URL Dereferencing Options](https://w3c.github.io/did-resolution/#did-url-dereferencing-options). This input is _REQUIRED_, but the structure _MAY_ be empty.

This function returns multiple values, and no limitations are placed on how these values are returned together. The return values of the `dereference` include `dereferencingMetadata`, `contentStream`, and `contentMetadata`:

dereferencingMetadata

A [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure) consisting of values relating to the results of the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) process. This structure is _REQUIRED_, and in the case of an error in the dereferencing process, this _MUST NOT_ be empty. Properties defined by this specification are in [5.2 DID URL Dereferencing Metadata](https://w3c.github.io/did-resolution/#did-url-dereferencing-metadata). If the dereferencing is not successful, this structure _MUST_ contain an `error` property describing the error. See Section [10\. Errors](https://w3c.github.io/did-resolution/#errors).

contentStream

If the `dereferencing` function was called and successful, this _MUST_ contain a [resource](https://w3c.github.io/did-resolution/#dfn-resources) corresponding to the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). The `contentStream` _MAY_ be a [resource](https://w3c.github.io/did-resolution/#dfn-resources) such as a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) that is serializable in one of the conformant [representations](https://w3c.github.io/did-resolution/#dfn-representations), a [verification method](https://www.w3.org/TR/did-core/#verification-methods), a [service](https://www.w3.org/TR/did-core/#services), or any other resource format that can be identified via a Media Type and obtained through the resolution process. If the dereferencing is unsuccessful, this value _MUST_ be empty.

contentMetadata

If the dereferencing is successful, this _MUST_ be a [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure), but the structure _MAY_ be empty. This structure contains metadata about the `contentStream`. If the `contentStream` is a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents), this _MUST_ be a [didDocumentMetadata](https://w3c.github.io/did-resolution/#dfn-diddocumentmetadata) structure as described in [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution). If the dereferencing is unsuccessful, this output _MUST_ be an empty [metadata structure](https://w3c.github.io/did-resolution/#metadata-structure).

Conforming [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) implementations do not alter the signature of these functions in any way. [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) implementations might map the `dereference` function to a method-specific internal function to perform the actual [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) process. [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) implementations might implement and expose additional functions with different signatures in addition to the `dereference` function specified here.

The possible properties within this structure and their possible values _SHOULD_ be registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. This specification defines the following common properties for dereferencing options:

accept

The Media Type that the caller prefers for `contentStream`. The Media Type _MUST_ be expressed as an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). The [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) implementation _SHOULD_ use this value to determine the `contentType` of the [representation](https://w3c.github.io/did-resolution/#dfn-representations) contained in the returned value if such a [representation](https://w3c.github.io/did-resolution/#dfn-representations) is supported and available.

`verificationRelationship`

The verificationRelationship for which the caller expects the verificationMethod dereferenced from the DID URL to be authorized. If present, the associated value _MUST_ be an [ASCII string](https://infra.spec.whatwg.org/#ascii-string). If the DID URL does not dereference to a verificationMethod, or the DID document does not authorize the verificationMethod for the specified verificationRelationship, then an error _MUST_ be raised.

The possible properties within this structure and their possible values are registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\]. This specification defines the following common properties.

contentType

The Media Type of the returned `contentStream` _SHOULD_ be expressed using this property if dereferencing is successful. The Media Type value _MUST_ be expressed as an [ASCII string](https://infra.spec.whatwg.org/#ascii-string).

error

An error data structure defined in \[[RFC9457](https://w3c.github.io/did-resolution/#bib-rfc9457 "Problem Details for HTTP APIs")\]. This property is _REQUIRED_ when there is an error in the dereferencing process. The errors defined in this specification can be found in Section [10\. Errors](https://w3c.github.io/did-resolution/#errors). Additional errors _SHOULD_ be registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\].

The following [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithm _MUST_ be implemented by a conformant [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s). In accordance with \[[RFC3986](https://w3c.github.io/did-resolution/#bib-rfc3986 "Uniform Resource Identifier (URI): Generic Syntax")\], it consists of the following three steps: resolving the DID; dereferencing the resource; and dereferencing the fragment (only if the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains a [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments)):

1.  Validate that the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) conforms to the `did-url` rule of the [DID URL Syntax](https://www.w3.org/TR/did-core/#did-url-syntax). If not, the [DID URL dereferencer](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencers) _MUST_ return the following result:
    1.  **dereferencingMetadata**: error object with type set to [INVALID\_DID\_URL](https://w3c.github.io/did-resolution/#INVALID_DID_URL)
    2.  **contentStream**: `null`
    3.  **contentMetadata**: `«[ ]»`
2.  Obtain the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) for the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) by executing the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm as defined in [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving). All dereferencing options and all [DID parameters](https://www.w3.org/TR/did-core/#did-parameters) of the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) _MUST_ be passed as resolution options to the [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm.
3.  If the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) does not exist in the VDR, the [DID URL dereferencer](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencers) _MUST_ return the following result:
    1.  **dereferencingMetadata**: error object with type set to [NOT\_FOUND](https://w3c.github.io/did-resolution/#NOT_FOUND)
    2.  **contentStream**: `null`
    3.  **contentMetadata**: `«[ ]»`
4.  Otherwise, the **didDocument** result of the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm is called the resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).
5.  If present, separate the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) from the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) and continue with the adjusted input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls).
6.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains no [DID path](https://w3c.github.io/did-resolution/#dfn-did-paths) and no [DID query](https://w3c.github.io/did-resolution/#dfn-did-queries):
    
    [Example 3](https://w3c.github.io/did-resolution/#example-3)
    
    ```
    did:example:1234
    ```
    
    The [DID URL dereferencer](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencers) _MUST_ return the resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) and resolved [4.3 DID Document Metadata](https://w3c.github.io/did-resolution/#did-document-metadata) as follows:
    1.  **dereferencingMetadata**: `«[ ... ]»`
    2.  **contentStream**: `resolved DID document`
    3.  **contentMetadata**: ``«[ `resolved DID document metadata` ]»``
7.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `hl`:
    
    [Example 4](https://w3c.github.io/did-resolution/#example-4)
    
    ```
    did:example:1234?hl=zQmWvQxTqbG2Z9HPJgG57jjwR154cKhbtJenbyYTWkjgF3e
    ```
    
    Issue
    
    TODO: Specify the algorithm for processing the `hl` DID parameter.
    
8.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `service` and/or the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `serviceType`, and optionally the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `relativeRef`:
    
    [Example 5](https://w3c.github.io/did-resolution/#example-5)
    
    ```
    did:example:1234?service=files&amp;relativeRef=%2Fmyresume%2Fdoc%3Fversion%3Dlatest
    ```
    
    1.  From the resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents), select all [services](https://www.w3.org/TR/did-core/#services) which fulfill the following conditions:
        
        1.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `service`: Select the [service](https://www.w3.org/TR/did-core/#services) if its `id` property matches the value of the `service` DID parameter. If the `id` property or the `service` DID parameter or both contain relative references, the corresponding absolute URIs _MUST_ be resolved and used for determining the match, using the rules specified in [RFC3986 Section 5: Reference Resolution](https://www.rfc-editor.org/rfc/rfc3986#section-5) and in section [Relative DID URLs](https://www.w3.org/TR/did-core/#relative-did-urls) in [Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/).
        2.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `serviceType`: Select the [service](https://www.w3.org/TR/did-core/#services) if its `type` property matches the value of the `serviceType` DID parameter.
        
        The selected [services](https://www.w3.org/TR/did-core/#services) are a list called the selected [services](https://w3c.github.io/did-resolution/#dfn-service).
    2.  If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `relativeRef`:
        1.  For each selected [service](https://w3c.github.io/did-resolution/#dfn-service):
            1.  If the value of the `serviceEndpoint` property of the selected [service](https://w3c.github.io/did-resolution/#dfn-service) is a [map](https://infra.spec.whatwg.org/#maps), skip this selected [service](https://w3c.github.io/did-resolution/#dfn-service).
            2.  If the value of the `serviceEndpoint` property of the selected [service](https://w3c.github.io/did-resolution/#dfn-service) is a [string](https://infra.spec.whatwg.org/#string), add this value to a list of selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URLs.
            3.  If the value of the `serviceEndpoint` property of the selected [service](https://w3c.github.io/did-resolution/#dfn-service) is a [set](https://infra.spec.whatwg.org/#ordered-set), add all its items that are [strings](https://infra.spec.whatwg.org/#string) to a list of selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URLs.
        2.  For each selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL, execute the algorithm specified in [RFC3986 Section 5: Reference Resolution](https://www.rfc-editor.org/rfc/rfc3986#section-5) as follows:
            1.  The **base URI** value is the selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL.
            2.  The **relative reference** is the value of the [DID parameter](https://www.w3.org/TR/did-core/#did-parameters) `relativeRef`.
            3.  Update the selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL to the result of the "Reference Resolution" algorithm.
    3.  If the **accept** input [DID dereferencing option](https://w3c.github.io/did-resolution/#did-url-dereferencing-options) is missing, or if its value is the Media Type of a [representation](https://w3c.github.io/did-resolution/#dfn-representations) of a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents):
        1.  Update the [services](https://w3c.github.io/did-resolution/#dfn-service) in the resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) to contain only the selected [services](https://w3c.github.io/did-resolution/#dfn-service).
        2.  Return the following result:
            1.  **dereferencingMetadata**: `«[ ... ]»`
            2.  **content**: `resolved DID document with selected services`
            3.  **contentMetadata**: ``«[ `resolved DID document metadata` ]»``
    4.  If the value of the **accept** input [DID resolution option](https://w3c.github.io/did-resolution/#did-resolution-options) is **text/uri-list**:
        1.  Return the following result:
            1.  **dereferencingMetadata**: `«[ ... ]»`
            2.  **content**: `« selected service endpoint URLs »`
            3.  **contentMetadata**: `«[ "contentType" → "text/uri-list", ... ]»`
    5.  Otherwise, return the following result:
        1.  **dereferencingMetadata**: error object with type set to [REPRESENTATION\_NOT\_SUPPORTED](https://w3c.github.io/did-resolution/#REPRESENTATION_NOT_SUPPORTED)
        2.  **content**: `null`
        3.  **contentMetadata**: `«[ ]»`
9.  Otherwise, if the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains a [DID path](https://w3c.github.io/did-resolution/#dfn-did-paths) and/or [DID query](https://w3c.github.io/did-resolution/#dfn-did-queries):
    
    [Example 6](https://w3c.github.io/did-resolution/#example-6)
    
    ```
    did:example:1234/custom/path?customquery
    ```
    
    1.  The applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) _MAY_ specify how to dereference the [DID path](https://w3c.github.io/did-resolution/#dfn-did-paths) and/or [DID query](https://w3c.github.io/did-resolution/#dfn-did-queries) of the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls).
        
        [Example 7](https://w3c.github.io/did-resolution/#example-7)
        
        ```
        did:example:1234/resources/1234
        ```
        
    2.  An extension specification _MAY_ specify how to dereference the [DID path](https://w3c.github.io/did-resolution/#dfn-did-paths) of the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls).
        
        [Example 8](https://w3c.github.io/did-resolution/#example-8)
        
        ```
        did:example:1234/whois
        ```
        
    3.  An extension specification _MAY_ specify how to dereference the [DID query](https://w3c.github.io/did-resolution/#dfn-did-queries) of the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls).
        
        [Example 9](https://w3c.github.io/did-resolution/#example-9)
        
        ```
        did:example:1234?transformKey=JsonWebKey
        ```
        
    4.  The client _MAY_ be able to dereference the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) in an application-specific way.
10.  If neither this algorithm, nor the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s), nor an extension, nor the client is able to dereference the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls), return the following result:
    1.  **dereferencingMetadata**: error object with type set to [NOT\_FOUND](https://w3c.github.io/did-resolution/#NOT_FOUND)
    2.  **contentStream**: `null`
    3.  **contentMetadata**: `«[ ]»`

There have been discussions whether in addition to the DID parameter `service`, there could also be a DID parameter `serviceType` to select services based on their type rather than ID. See [comments by Dave Longley](https://lists.w3.org/Archives/Public/public-credentials/2019Jun/0028.html) about `serviceType`.

If the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains a [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments), then dereferencing of the fragment is dependent on the media type (\[[RFC2046](https://w3c.github.io/did-resolution/#bib-rfc2046 "Multipurpose Internet Mail Extensions (MIME) Part Two: Media Types")\]) of the resource, i.e., on the result of [5.3.1 Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource).

1.  If the result of [5.3.1 Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) is an output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents), and the input [DID URL dereferencing options](https://w3c.github.io/did-resolution/#did-url-dereferencing-options) contain the `verificationRelationship` option:
    1.  Let verificationRelationship be the value of the `verificationRelationship` option.
    2.  Let verificationMethod be the result of dereferencing the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) from the output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) according to the rules of the media type of the DID document.
    3.  If verificationMethod is not a [conforming verification method](https://www.w3.org/TR/cid-1.0/#dfn-conforming-verification-method), an error _MUST_ be raised and _SHOULD_ convey an error type of [INVALID\_VERIFICATION\_METHOD](https://www.w3.org/TR/cid-1.0/#INVALID_VERIFICATION_METHOD).
    4.  If verificationMethod is not associated, either by reference (URL) or by value (object), with the [verification relationship](https://www.w3.org/TR/cid-1.0/#dfn-verification-relationship) array in the output [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) identified by verificationRelationship, an error _MUST_ be raised and _SHOULD_ convey an error type of [INVALID\_RELATIONSHIP\_FOR\_VERIFICATION\_METHOD](https://www.w3.org/TR/cid-1.0/#INVALID_RELATIONSHIP_FOR_VERIFICATION_METHOD).
    5.  Return the verificationMethod.
2.  If the result of [5.3.1 Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) is a selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL, and the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) contains a [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments):
    
    [Example 10](https://w3c.github.io/did-resolution/#example-10)
    
    ```
    did:example:1234?service=files&amp;relativeRef=%2Fmyresume%2Fdoc%3Fversion%3Dlatest#intro
    ```
    
    1.  If the selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL contains a `fragment` component, raise an error.
    2.  Append the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) to the select [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL. In other words, the select [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL "inherits" the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) of the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls).
    3.  Return the select [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL.
3.  Otherwise, dereference the DID fragment as defined by the media type (\[[RFC2046](https://w3c.github.io/did-resolution/#bib-rfc2046 "Multipurpose Internet Mail Extensions (MIME) Part Two: Media Types")\]) of the resource. For example, if the resource is a representation of a DID document with media type `application/did`, then the fragment is treated according to the rules associated with the [JSON-LD 1.1: application/ld+json media type](https://www.w3.org/TR/json-ld11/#iana-considerations) \[JSON-LD11\].

Note

This use of the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) is consistent with the definition of the fragment identifier in \[[RFC3986](https://w3c.github.io/did-resolution/#bib-rfc3986 "Uniform Resource Identifier (URI): Generic Syntax")\]. It identifies a _secondary resource_ which is a subset of the _primary resource_ (the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents)).

Note

This behavior of the [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) is analogous to the handling of a fragment in an HTTP URL in the case when dereferencing it returns an HTTP `3xx` (Redirection) response with a `Location` header (see section 7.1.2 of \[[RFC7231](https://w3c.github.io/did-resolution/#bib-rfc7231 "Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content")\]).

Given the following input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls):

[Example 11](https://w3c.github.io/did-resolution/#example-11)

```
did:example:123456789abcdefghi#keys-1
```

... and the following resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents):

[Example 12](https://w3c.github.io/did-resolution/#example-12)

```
{
"@context":[
"https://www.w3.org/ns/did/v1.1",
"https://didcomm.org/messaging/contexts/v2",
"https://identity.foundation/linked-vp/contexts/v1"
],
"id": "did:example:123456789abcdefghi",
"verificationMethod": [{
"id": "did:example:123456789abcdefghi#keys-1",
"type": "Multikey",
"controller": "did:example:123456789abcdefghi",
"publicKeyMultibase": "z6MkmM42vxfqZQsv4ehtTjFFxQ4sQKS2w6WR7emozFAn5cxu"
}],
"service": [{
"id": "did:example:123456789abcdefghi#messages",
"type": "DIDCommMessaging",
"serviceEndpoint": "https://example.com/messages/8377464"
}, {
"id": "did:example:123456789abcdefghi#linkedvp",
"type": "LinkedVerifiablePresentation",
"serviceEndpoint": "https://example.com/verifiable-presentation.jsonld"
}]
}
```

... then the result of the [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing) algorithm is the following output resource:

[Example 13](https://w3c.github.io/did-resolution/#example-13)

```
{
"@context": "https://www.w3.org/ns/did/v1.1",
"id": "did:example:123456789abcdefghi#keys-1",
"type": "Multikey",
"controller": "did:example:123456789abcdefghi",
"publicKeyMultibase": "z6MkmM42vxfqZQsv4ehtTjFFxQ4sQKS2w6WR7emozFAn5cxu"
}
```

![Diagram showing how a DID URL can be dereferenced to a verification method](https://w3c.github.io/did-resolution/diagrams/section-5/example-dereference-to-verification-method.svg)

[Figure 2](https://w3c.github.io/did-resolution/#figure-dereference-to-verification-method) Dereferencing a DID URL to a verification method.

Given the following input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls):

[Example 14](https://w3c.github.io/did-resolution/#example-14)

```
did:example:123456789abcdefghi?service=messages&amp;relativeRef=%2Fsome%2Fpath%3Fquery#frag
```

... and the same resolved [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) as in the previous section.

... then the result of the [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing) algorithm is the following selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL:

[Example 15](https://w3c.github.io/did-resolution/#example-15)

```
https://example.com/messages/8377464/some/path?query#frag
```

![Diagram showing how a DID URL can be dereferenced to a service endpoint URL](https://w3c.github.io/did-resolution/diagrams/section-5/example-dereference-to-service-endpoint-url.svg)

[Figure 3](https://w3c.github.io/did-resolution/#figure-dereference-to-service-endpoint-url) Dereferencing a DID URL to a service endpoint URL.

Input and output metadata is often involved during the [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution), [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing), and other DID-related processes. The structure used to communicate this metadata _MUST_ be a [map](https://infra.spec.whatwg.org/#maps) of properties. Each property name _MUST_ be a [string](https://infra.spec.whatwg.org/#string). Each property value _MUST_ be a [string](https://infra.spec.whatwg.org/#string), [map](https://infra.spec.whatwg.org/#maps), [list](https://infra.spec.whatwg.org/#list), [set](https://infra.spec.whatwg.org/#ordered-set), [boolean](https://infra.spec.whatwg.org/#boolean), or [null](https://infra.spec.whatwg.org/#nulls). The values within any complex data structures such as maps and lists _MUST_ be one of these data types as well. All metadata property definitions registered in the DID Specification Registries \[[DID-SPEC-REGISTRIES](https://w3c.github.io/did-resolution/#bib-did-spec-registries "Decentralized Identifier Extensions")\] _MUST_ define the value type, including any additional formats or restrictions to that value (for example, a string formatted as a date or as a decimal integer). It is _RECOMMENDED_ that property definitions use strings for values. The entire metadata structure _MUST_ be serializable according to the [JSON serialization rules](https://infra.spec.whatwg.org/#serialize-an-infra-value-to-json-bytes) in the \[[INFRA](https://w3c.github.io/did-resolution/#bib-infra "Infra Standard")\] specification. Implementations _MAY_ serialize the metadata structure to other data formats.

All implementations of functions that use metadata structures as either input or output are able to fully represent all data types described here in a deterministic fashion. As inputs and outputs using metadata structures are defined in terms of data types and not their serialization, the method for [representation](https://w3c.github.io/did-resolution/#dfn-representations) is internal to the implementation of the function and is out of scope of this specification.

The following example demonstrates a JSON-encoded metadata structure that might be used as [DID resolution input metadata](https://w3c.github.io/did-resolution/#did-resolution-options).

This example corresponds to a metadata structure of the following format:

The next example demonstrates a JSON-encoded metadata structure that might be used as [DID resolution metadata](https://w3c.github.io/did-resolution/#did-resolution-options) if a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) was not found.

This example corresponds to a metadata structure of the following format:

The next example demonstrates a JSON-encoded metadata structure that might be used as [DID document metadata](https://w3c.github.io/did-resolution/#did-document-metadata) to describe timestamps associated with the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

This example corresponds to a metadata structure of the following format:

Issue

TODO: Describe how [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) are implemented and used, describe the relevance of [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s). Explain the difference between "method architectures" and "resolver architectures".

The [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm involves executing the [Read](https://www.w3.org/TR/did-core/#method-operations) operation on a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) according to its [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) (see [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving)).

Note

The mechanics of the "Read" operation can vary considerably between [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s). In particular, no assumption should be made that:

-   ... an immutable blockchain is used as (part of) the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry).
-   ... interaction with a remote network is required during execution of the "Read" operation.
-   ... an actual [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) is stored in plain-text on a [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry), or that the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) can simply be retrieved via a standard protocol such as HTTP(S). While some [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) may define their "Read" operation this way, others may define more complex multi-step processes that involve on-the-fly construction of a "virtual" [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

Issue

As an example, mention what it means to "resolve" peer/off-ledger/microledger/edgechain DIDs (for instance, see \[[DID-PEER](https://w3c.github.io/did-resolution/#bib-did-peer "Peer DID Method Specification")\] and [here](https://docs.google.com/presentation/d/1UnC_nfOUK40WS5TD_EhyDuFe5cStX-u0Z7wjoae_PqQ/)).

Issue

As an example, mention what it means to "resolve" DIDs that are simply wrapped public keys (for instance, see \[[DID-KEY](https://w3c.github.io/did-resolution/#bib-did-key "The did:key Method")\] and [here](https://github.com/w3c/did-spec/pull/55)).

Depending on the exact nature of the [DID method's](https://w3c.github.io/did-resolution/#dfn-did-method-s) "Read" operation, the interaction between a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) may be implemented as a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) or [unverifiable read](https://w3c.github.io/did-resolution/#dfn-unverifiable-read):

![Diagram showing a 'verifiable read' implementation of a DID method.](https://w3c.github.io/did-resolution/diagrams/section-7/architecture-method-verifiable.svg)

[Figure 4](https://w3c.github.io/did-resolution/#figure-architecture-method-verifiable) A [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) implementation of a [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s).

![Diagram showing an 'unverifiable read' implementation of a DID method.](https://w3c.github.io/did-resolution/diagrams/section-7/architecture-method-unverifiable.svg)

[Figure 5](https://w3c.github.io/did-resolution/#figure-architecture-method-unverifiable) An [unverifiable read](https://w3c.github.io/did-resolution/#dfn-unverifiable-read) implementation of a [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s).

A [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) maximizes confidence in the integrity and correctness of the result of the "Read" operation ‐ to the extent possible under the applicable [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). It can be implemented in a variety of ways, for example:

-   A "Read" operation may be considered "Verifiable" if access to the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) is possible via a local, trusted network host. In the case of blockchain-based [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s), a blockchain full node may be run on a local network host in order to implement a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read).
-   The [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) may be remotely connected to the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) but have some method to verify the contents of the response of the "Read" operation. In the case of blockchain-based [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s), even if direct access to a blockchain full node is not available, a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) may still be possible by running a light client that processes metadata to verify that the result of the "Read" operation hasn't been tampered with.
-   A [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) may be implemented if access to the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) happens via a remote network host that is considered trusted because it is run on a personal device in the home and accessed via a secure channel.

An [unverifiable read](https://w3c.github.io/did-resolution/#dfn-unverifiable-read) does not have such guarantees and is therefore less desirable, for example:

-   A "Read" operation may be considered "Unverifiable" if access to the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry) happens via a remote, untrusted intermediary. In the case of blockchain-based [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s), a remote blockchain explorer API operated by an third party may be used to look up data from the blockchain.

Whether or not a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) is possible depends not only on a [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) itself, but also on the way how a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implements it. [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) _MAY_ define multiple different ways of implementing their "Read" operation(s) and _SHOULD_ offer guidance on how to implement a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) in at least one way.

Note

The guarantees associated with a [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) are still always limited by the architectures, protocols, cryptography, and other aspects of the underlying [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry). The strongest forms of [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) implementations are considered those that do not require any interaction with a remote network at all (for example, see \[[DID-KEY](https://w3c.github.io/did-resolution/#bib-did-key "The did:key Method")\]), or that minimize dependencies on specific network infrastructure and reduce the "root of trust" to proven entropy and cryptography alone (for example, see \[[KERI](https://w3c.github.io/did-resolution/#bib-keri "Key Event Receipt Infrastructure (KERI)")\]).

Issue

TODO: Describe how a client can potentially verify the result of a "Read" operation independently even if it does not trust the DID resolver (e.g., using state proofs).

The algorithms for [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) are defined as abstract functions (see [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving) and [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing)).

Those algorithms are implemented by [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s). A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) is invoked by a [client](https://w3c.github.io/did-resolution/#dfn-client) via a [binding](https://w3c.github.io/did-resolution/#dfn-binding). Bindings define how the abstract functions are realized using concrete programming or communication interfaces. It is possible to distinguish between [local bindings](https://w3c.github.io/did-resolution/#dfn-local-binding) (such as a local command line tool or library API) and [remote bindings](https://w3c.github.io/did-resolution/#dfn-remote-binding) (such as the [HTTP(S) binding](https://w3c.github.io/did-resolution/#bindings-https)).

![Diagram showing a DID resolver with a 'local binding'.](https://w3c.github.io/did-resolution/diagrams/section-7/architecture-binding-local.svg)

[Figure 6](https://w3c.github.io/did-resolution/#figure-architecture-binding-local) A [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding) for a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).

![Diagram showing a DID resolver with a 'remote binding'.](https://w3c.github.io/did-resolution/diagrams/section-7/architecture-binding-remote.svg)

[Figure 7](https://w3c.github.io/did-resolution/#figure-architecture-binding-remote) A [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) for a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).

TODO: Describe [local bindings](https://w3c.github.io/did-resolution/#dfn-local-binding) vs. [remote bindings](https://w3c.github.io/did-resolution/#dfn-remote-binding), and implications for privacy, security and trust.

Also describe mitigations against potential downsides of [remote bindings](https://w3c.github.io/did-resolution/#dfn-remote-binding), e.g.:

-   A [DID resolver's](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) can use a trusted channel such as VPN or TLS with mutual authentication.
-   A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) can add a data integrity proof (see \[[DATA-INTEGRITY](https://w3c.github.io/did-resolution/#bib-data-integrity "Verifiable Credential Data Integrity 1.0")\]) to a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) and/or the [DID resolution result](https://w3c.github.io/did-resolution/#dfn-did-resolution-result). Discuss what this does and doesn't achieve. Also see [Proving Control and Binding](https://www.w3.org/TR/did-core/#proving-control-and-binding).
-   A client could query multiple [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) over a [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) and compare results.

Issue

TODO: Discuss DID resolution in constrained user agents such as mobile apps and browsers.

A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) _MUST_ support the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm for at least one [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) and _MAY_ support it for multiple [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s):

![Diagram showing a DID resolver that supports multiple DID methods.](https://w3c.github.io/did-resolution/diagrams/section-7/resolver-multiple.svg)

[Figure 8](https://w3c.github.io/did-resolution/#figure-resolver-multiple) A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) that supports multiple [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s).

In this case, the above considerations in [7.1 Method Architectures](https://w3c.github.io/did-resolution/#method-architectures) about [verifiable read](https://w3c.github.io/did-resolution/#dfn-verifiable-read) and [unverifiable read](https://w3c.github.io/did-resolution/#dfn-unverifiable-read) implementations apply to each supported [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) individually.

A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) _MAY_ invoke another [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s), which serves as a proxy that executes the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm as defined in [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving).

The first [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) then acts as a [client](https://w3c.github.io/did-resolution/#dfn-client) and chooses a suitable [binding](https://w3c.github.io/did-resolution/#dfn-binding) for invoking the second [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s). For example, a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) may be invoked via a [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding) (such as a command line tool), which in turn invokes another [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) via a [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) (such as the [HTTP(S) binding](https://w3c.github.io/did-resolution/#bindings-https)).

![Diagram showing two DID resolvers, one invoked via 'local binding', the other invoked via 'remote binding'.](https://w3c.github.io/did-resolution/diagrams/section-7/resolver-proxied.svg)

[Figure 9](https://w3c.github.io/did-resolution/#figure-resolver-proxied) A client invokes a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) via [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding), which invokes another [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) via [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding), which in turn reads from a [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s).

Note

This is similar to a "stub resolver" invoking a "recursive resolver" in DNS architecture, although the concepts are not entirely comparable (DNS Resolution uses a single concrete protocol, whereas DID resolution is an abstract function realized by different [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) and different [bindings](https://w3c.github.io/did-resolution/#dfn-binding)).

Different parts of the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dereferencing) algorithm may be performed by different components of a [Resolver Architecture](https://w3c.github.io/did-resolution/#resolver-architectures).

Specifically, when a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) with a [DID fragment](https://w3c.github.io/did-resolution/#dfn-did-fragments) is dereferenced, then [Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) is done by the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s), and [Dereferencing the Fragment](https://w3c.github.io/did-resolution/#dereferencing-algorithm-fragment) is done by the [client](https://w3c.github.io/did-resolution/#dfn-client).

Given the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) `did:xyz:1234#keys-1`, a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) could be invoked via [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding) for [Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) (i.e., the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents)), and the [client](https://w3c.github.io/did-resolution/#dfn-client) could complete the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithm by [Dereferencing the Fragment](https://w3c.github.io/did-resolution/#dereferencing-algorithm-fragment) (i.e., a part of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents)).

![Diagram showing client-side dereferencing of a DID URL by a DID resolver and a client](https://w3c.github.io/did-resolution/diagrams/section-7/client-side-dereferencing-1.svg)

[Figure 10](https://w3c.github.io/did-resolution/#figure-client-side-dereferencing-1) Client-side dereferencing of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) by a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and a [client](https://w3c.github.io/did-resolution/#dfn-client).

Given the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) `did:xyz:1234?service=agent&relativeRef=%2Fsome%2Fpath%3Fquery#frag`, a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) could be invoked for [Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) (i.e., a [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL), and the [client](https://w3c.github.io/did-resolution/#dfn-client) could complete the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithm by [Dereferencing the Fragment](https://w3c.github.io/did-resolution/#dereferencing-algorithm-fragment) (i.e., a [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL with a fragment).

![Diagram showing client-side dereferencing of a DID URL by a DID resolver and a client](https://w3c.github.io/did-resolution/diagrams/section-7/client-side-dereferencing-2.svg)

[Figure 11](https://w3c.github.io/did-resolution/#figure-client-side-dereferencing-2) Client-side dereferencing of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) by a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and a [client](https://w3c.github.io/did-resolution/#dfn-client).

Given the [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) `did:xyz:1234#keys-1`, a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) could be invoked via [local binding](https://w3c.github.io/did-resolution/#dfn-local-binding), which invokes another [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) via [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding) for [Dereferencing the Resource](https://w3c.github.io/did-resolution/#dereferencing-algorithm-resource) (i.e., the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents)), and the [client](https://w3c.github.io/did-resolution/#dfn-client) could complete the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) algorithm by [Dereferencing the Fragment](https://w3c.github.io/did-resolution/#dereferencing-algorithm-fragment) (i.e., a part of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents)).

![Diagram showing client-side dereferencing of a DID URL by two DID resolvers and a client](https://w3c.github.io/did-resolution/diagrams/section-7/client-side-dereferencing-3.svg)

[Figure 12](https://w3c.github.io/did-resolution/#figure-client-side-dereferencing-3) Client-side dereferencing (in combination with [Proxied Resolution](https://w3c.github.io/did-resolution/#resolver-architectures-proxied)) of a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) by two [DID resolvers](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) and a [client](https://w3c.github.io/did-resolution/#dfn-client).

This section defines a data structure that represents the result of the algorithm described in [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving). A [DID resolution result](https://w3c.github.io/did-resolution/#dfn-did-resolution-result) contains a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) as well as [DID resolution metadata](https://w3c.github.io/did-resolution/#output-resolutionmetadata) and [DID document metadata](https://w3c.github.io/did-resolution/#output-documentmetadata).

The media type of this data structure is defined to be `application/ld+json;profile="https://w3id.org/did-resolution"`.

[Example 22](https://w3c.github.io/did-resolution/#example-example-did-resolution-result)

: Example DID resolution result

```
{
"@context": "https://w3id.org/did-resolution/v1",
"didDocument": {
"@context": "https://www.w3.org/ns/did/v1",
"id": "did:example:123456789abcdefghi",
"authentication": [{
"id": "did:example:123456789abcdefghi#keys-1",
"type": "Ed25519VerificationKey2018",
"controller": "did:example:123456789abcdefghi",
"publicKeyBase58": "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
}],
"service": [{
"id":"did:example:123456789abcdefghi#vcs",
"type": "VerifiableCredentialService",
"serviceEndpoint": "https://example.com/vc/"
}]
},
"didResolutionMetadata": {
"contentType": "application/did+ld+json",
"retrieved": "2024-06-01T19:73:24Z",
},
"didDocumentMetadata": {
"created": "2019-03-23T06:35:22Z",
"updated": "2023-08-10T13:40:06Z",
"method": {
"nymResponse": {
"result": {
"data": "{\"dest\":\"WRfXPg8dantKVubE3HX8pw\",\"identifier\":\"V4SGRU86Z58d6TV7PBUe6f\",\"role\":\"0\",\"seqNo\":11,\"txnTime\":1524055264,\"verkey\":\"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV\"}",
"type": "105",
"txnTime": 1.524055264E9,
"seqNo": 11.0,
"reqId": 1.52725687080231475E18,
"identifier": "HixkhyA4dXGz9yxmLQC4PU",
"dest": "WRfXPg8dantKVubE3HX8pw"
},
"op": "REPLY"
},
"attrResponse": {
"result": {
"identifier": "HixkhyA4dXGz9yxmLQC4PU",
"seqNo": 12.0,
"raw": "endpoint",
"dest": "WRfXPg8dantKVubE3HX8pw",
"data": "{\"endpoint\":{\"xdi\":\"http://127.0.0.1:8080/xdi\"}}",
"txnTime": 1.524055265E9,
"type": "104",
"reqId": 1.52725687092557056E18
},
"op": "REPLY"
}
}
}
}
```

[Issue 23](https://github.com/w3c/did-resolution/issues/23)

: The did is not a url for the did, but for a resolution structure which as yet has no name [pending-close](https://github.com/w3c/did-resolution/issues/?q=is%3Aissue+is%3Aopen+label%3A%22pending-close%22)

See corresponding open issue.

Issue

Need to define how this data structure works exactly, and whether it always contains a [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) or can also contain other results.

A [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) associated with a [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers). The result of [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving).

This is a metadata structure (see section [Metadata Structure](https://www.w3.org/TR/did-core/#metadata-structure) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\]) that contains metadata about the [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) process.

This metadata typically changes between invocations of the [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) functions as it represents data about the resolution process itself.

The source of this metadata is the DID resolver.

Examples of DID Resolution Metadata include:

-   Media type of the returned content (the **contentType** metadata property).
-   Error object (the **error** metadata property).
-   Duration of the DID resolution process.
-   Caching information about the DID document (see Section [12.2 Caching](https://w3c.github.io/did-resolution/#caching)).
-   Various URLs, IP addresses or other network information that was used during the DID resolution process.
-   Proofs added by a DID resolver (e.g., to establish trusted resolution).

See also section [DID Resolution Metadata](https://www.w3.org/TR/did-core/#did-resolution-metadata) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\].

This is a metadata structure (see section [Metadata Structure](https://www.w3.org/TR/did-core/#metadata-structure) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\]) that contains metadata about a [DID Document](https://w3c.github.io/did-resolution/#dfn-did-documents).

This metadata typically does not change between invocations of the [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function unless the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) changes, as it represents data about the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

The sources of this metadata are the [DID controller](https://w3c.github.io/did-resolution/#dfn-did-controllers) and/or the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s).

Examples of DID Document Metadata include:

-   Timestamps when the DID and its associated DID document were created or updated (the **created** and **updated** metadata properties).
-   Metadata about controllers, capabilities, delegations, etc.
-   Versioning information about the DID document (see Section [12.3 Versioning](https://w3c.github.io/did-resolution/#versioning)).
-   Proofs added by a DID controller (e.g., to establish control authority).

DID Document Metadata may also include method-specific metadata, e.g.:

-   State proofs from the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry).
-   Block number, index, transaction hash, number of confirmations, etc. of a record in the blockchain or other [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry).

See also section [DID Document Metadata](https://www.w3.org/TR/did-core/#did-document-metadata) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\].

Issue

For certain data, it may be debatable whether it should be part of the DID document (i.e., data that describes the DID Subject), or whether it is metadata (i.e., data about the DID document or about the DID resolution process). For example the URL of the "Continuation DID document" in the BTCR method.

This section defines a data structure that represents the result of the algorithm described in [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing). A [DID URL dereferencing result](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing-result) contains arbitrary content as well as [DID resolution metadata](https://w3c.github.io/did-resolution/#output-dereferencingmetadata) and [content metadata](https://w3c.github.io/did-resolution/#output-contentmetadata).

See corresponding open issue.

The media type of this data structure is defined to be `application/ld+json;profile="https://w3id.org/did-resolution"`.

[Example 23](https://w3c.github.io/did-resolution/#example-example-did-url-dereferencing-result)

: Example DID URL dereferencing result

```
{
"@context": "https://w3id.org/did-resolution/v1",
"content": {
"@context": "https://www.w3.org/ns/did/v1",
"id": "did:example:123456789abcdefghi",
"authentication": [{
"id": "did:example:123456789abcdefghi#keys-1",
"type": "Ed25519VerificationKey2018",
"controller": "did:example:123456789abcdefghi",
"publicKeyBase58": "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
}],
"service": [{
"id":"did:example:123456789abcdefghi#vcs",
"type": "VerifiableCredentialService",
"serviceEndpoint": "https://example.com/vc/"
}]
},
"didUrlDereferencingMetadata": {
"contentType": "application/did+ld+json",
"retrieved": "2024-06-01T19:73:24Z",
},
"contentMetadata": {
"created": "2019-03-23T06:35:22Z",
"updated": "2023-08-10T13:40:06Z",
"method": {
"nymResponse": {
"result": {
"data": "{\"dest\":\"WRfXPg8dantKVubE3HX8pw\",\"identifier\":\"V4SGRU86Z58d6TV7PBUe6f\",\"role\":\"0\",\"seqNo\":11,\"txnTime\":1524055264,\"verkey\":\"H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV\"}",
"type": "105",
"txnTime": 1.524055264E9,
"seqNo": 11.0,
"reqId": 1.52725687080231475E18,
"identifier": "HixkhyA4dXGz9yxmLQC4PU",
"dest": "WRfXPg8dantKVubE3HX8pw"
},
"op": "REPLY"
},
"attrResponse": {
"result": {
"identifier": "HixkhyA4dXGz9yxmLQC4PU",
"seqNo": 12.0,
"raw": "endpoint",
"dest": "WRfXPg8dantKVubE3HX8pw",
"data": "{\"endpoint\":{\"xdi\":\"http://127.0.0.1:8080/xdi\"}}",
"txnTime": 1.524055265E9,
"type": "104",
"reqId": 1.52725687092557056E18
},
"op": "REPLY"
}
}
}
}
```

Arbitrary content associated with a [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls). The result of [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing).

This is a metadata structure (see section [Metadata Structure](https://www.w3.org/TR/did-core/#metadata-structure) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\]) that contains metadata about the [DID URL Dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) process.

This metadata typically changes between invocations of the [DID URL Dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) functions as it represents data about the dereferencing process itself.

Issue

Add more details how DID URL dereferencing metadata works.

See also section [DID URL Dereferencing Metadata](https://www.w3.org/TR/did-core/#did-url-dereferencing-metadata) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\].

This is a metadata structure (see section [Metadata Structure](https://www.w3.org/TR/did-core/#metadata-structure) in \[[DID-CORE](https://w3c.github.io/did-resolution/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\]) that contains metadata about the content.

This metadata typically does not change between invocations of the [DID URL Dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function unless the content changes, as it represents data about the content.

Issue

Add more details how content metadata works.

The algorithms described in this specification throw specific types of errors. Implementers might find it useful to convey these errors to other libraries or software systems. This section provides specific URLs and descriptions for the errors, such that an ecosystem implementing technologies described by this specification might interoperate more effectively when errors occur. Additionally, this specification uses some errors defined in [Section 3.5 Processing Errors](https://www.w3.org/TR/cid-1.0/#processing-errors) of the \[[CID](https://w3c.github.io/did-resolution/#bib-cid "Controlled Identifiers v1.0")\] specification.

Implementers _SHOULD_ use \[[RFC9457](https://w3c.github.io/did-resolution/#bib-rfc9457 "Problem Details for HTTP APIs")\] to encode the error data structure. If \[[RFC9457](https://w3c.github.io/did-resolution/#bib-rfc9457 "Problem Details for HTTP APIs")\] is used:

-   The `type` value of the error object _MUST_ be a URL. Where the values listed in the section below do not define a URL, the values _MUST_ be prepended with the URL `https://www.w3.org/ns/did#`.
-   The `title` value _SHOULD_ provide a short but specific human-readable string for the error.
-   The `detail` value _SHOULD_ provide a longer human-readable string for the error.

INVALID\_DID

An invalid DID was detected during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution). See Section [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm).

INVALID\_DID\_DOCUMENT

The [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) was malformed. See Section [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm).

NOT\_FOUND

The [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) was unable to find the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) resulting from this resolution request. See Section [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm).

REPRESENTATION\_NOT\_SUPPORTED

The [representation](https://w3c.github.io/did-resolution/#dfn-representations) requested via the `accept` input metadata property is not supported by the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s) and/or [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) implementation. See Section [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm).

INVALID\_DID\_URL

An invalid [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) was detected during [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing). See Section [5.3 DID URL Dereferencing Algorithm](https://w3c.github.io/did-resolution/#dereferencing-algorithm)

METHOD\_NOT\_SUPPORTED

The DID method of the DID is not supported by the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s). See Section [4.4 DID Resolution Algorithm](https://w3c.github.io/did-resolution/#resolving-algorithm).

INVALID\_OPTIONS

One or more of the options provided for [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) are invalid.

INTERNAL\_ERROR

An unexpected error occured during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing).

https://w3id.org/security#INVALID\_PUBLIC\_KEY

An invalid public key value is detected during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing).

https://w3id.org/security#INVALID\_PUBLIC\_KEY\_LENGTH

The byte length of _rawPublicKeyBytes_ did not match the expected public key length for the associated multicodecValue during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing).

https://w3id.org/security#INVALID\_PUBLIC\_KEY\_TYPE

An invalid public key type was detected during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing).

https://w3id.org/security#UNSUPPORTED\_PUBLIC\_KEY\_TYPE

An unsupported public key type was detected during [DID Resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing).

This section defines bindings for the abstract algorithms in sections [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving) and [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing).

This section defines a [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) [binding](https://w3c.github.io/did-resolution/#dfn-binding) which exposes the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and/or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) functions (including all resolution/dereferencing options and metadata) via an HTTP(S) endpoint. See [7.2 Resolver Architectures](https://w3c.github.io/did-resolution/#resolver-architectures).

The HTTP(S) binding is a [remote binding](https://w3c.github.io/did-resolution/#dfn-remote-binding). It requires a known HTTP(S) URL where a remote [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) can be invoked. This URL is called the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) HTTP(S) endpoint

Using this binding, the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function (see [4\. DID Resolution](https://w3c.github.io/did-resolution/#resolving)) and/or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function (see [5\. DID URL Dereferencing](https://w3c.github.io/did-resolution/#dereferencing)) can be executed as follows:

1.  Initialize a request HTTP(S) URL with the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) HTTP(S) endpoint.
    
    [Example 24](https://w3c.github.io/did-resolution/#example-24)
    
    ```
    https://resolver.example/1.0/identifiers/
    ```
    
2.  For the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function:
    1.  Append the input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) to the request HTTP(S) URL.
        
        [Example 25](https://w3c.github.io/did-resolution/#example-25)
        
        ```
        https://resolver.example/1.0/identifiers/did:example:1234
        ```
        
    2.  Set the `Accept` HTTP request header to `application/ld+json;profile="https://w3id.org/did-resolution"` in order to request a complete [8\. DID Resolution Result](https://w3c.github.io/did-resolution/#did-resolution-result), OR
    3.  set the `Accept` HTTP request header to the value of the **accept** resolution option.
    4.  If any other resolution options are provided:
        1.  The input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers) _MUST_ be URL-encoded (as specified in [RFC3986 Section 2.1](https://www.rfc-editor.org/rfc/rfc3986#section-2.1)).
        2.  Encode all resolution options except **accept** as query parameters in the request HTTP(S) URL.
            
            [Example 26](https://w3c.github.io/did-resolution/#example-26)
            
            ```
            https://resolver.example/1.0/identifiers/did%3Aexample%3A1234?option1=value1&amp;option2=value2
            ```
            
3.  For the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function:
    1.  Append the input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) to the request HTTP(S) URL.
        
        [Example 27](https://w3c.github.io/did-resolution/#example-27)
        
        ```
        https://resolver.example/1.0/identifiers/did:example:1234?service=files&amp;relativeRef=/resume.pdf
        ```
        
    2.  Set the `Accept` HTTP request header to `application/ld+json;profile="https://w3id.org/did-url-dereferencing"` in order to request a complete [9\. DID URL Dereferencing Result](https://w3c.github.io/did-resolution/#did-url-dereferencing-result), OR
    3.  set the `Accept` HTTP request header to the value of the **accept** dereferencing option.
    4.  If any other dereferencing options are provided:
        1.  The input [DID URL](https://w3c.github.io/did-resolution/#dfn-did-urls) _MUST_ be URL-encoded (as specified in [RFC3986 Section 2.1](https://www.rfc-editor.org/rfc/rfc3986#section-2.1)).
        2.  Encode all dereferencing options except **accept** as query parameters in the request HTTP(S) URL.
            
            [Example 28](https://w3c.github.io/did-resolution/#example-28)
            
            ```
            https://resolver.example/1.0/identifiers/did%3Aexample%3A1234%3Fservice%3Dfiles%26relativeRef%3D%2Fresume.pdf?option1=value1&amp;option2=value2
            ```
            
4.  Execute an HTTP `GET` request on the request HTTP(S) URL. This invokes the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function at the remote [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s).
5.  If the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function returns an **error** metadata property in the **didResolutionMetadata** or **dereferencingMetadata**, then the HTTP response status code _MUST_ correspond to the value of the **error** metadata property, according to the following table:
    
    | error | HTTP status code |
    | --- | --- |
    | `INVALID_DID` | `400` |
    | `INVALID_DID_URL` | `400` |
    | `INVALID_OPTIONS` | `400` |
    | `NOT_FOUND` | `404` |
    | `REPRESENTATION_NOT_SUPPORTED` | `406` |
    | `INVALID_DID_DOCUMENT` | `500` |
    | `METHOD_NOT_SUPPORTED` | `501` |
    | `INVALID_PUBLIC_KEY` | `500` |
    | `INVALID_PUBLIC_KEY_LENGTH` | `500` |
    | `INVALID_PUBLIC_KEY_TYPE` | `500` |
    | `UNSUPPORTED_PUBLIC_KEY_TYPE` | `501` |
    | `INTERNAL_ERROR` | `500` |
    | (any other value) | `500` |
    
6.  If the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) or [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function returns a **deactivated** metadata property with the value `true` in the **didDocumentMetadata** or **contentMetadata**:
    1.  The HTTP response status code _MUST_ be `410`.
7.  For the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function:
    1.  If the value of the `Content-Type` HTTP response header is `application/ld+json;profile="https://w3id.org/did-resolution"`:
        1.  The HTTP body _MUST_ contain a [DID resolution result](https://w3c.github.io/did-resolution/#dfn-did-resolution-result) (see [8\. DID Resolution Result](https://w3c.github.io/did-resolution/#did-resolution-result)) that is the result of the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function.
    2.  If the function is successful and returns a **didDocument**:
        1.  The HTTP response status code _MUST_ be `200`.
        2.  The HTTP response _MUST_ contain a `Content-Type` HTTP response header. Its value _MUST_ be the value of the **contentType** metadata property in the **didResolutionMetadata** (see [4.2 DID Resolution Metadata](https://w3c.github.io/did-resolution/#did-resolution-metadata)).
        3.  The HTTP response body _MUST_ contain the **didDocument** that is the result of the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) function, in the representation corresponding to the `Content-Type` HTTP response header.
8.  For the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function:
    1.  If the value of the `Content-Type` HTTP response header is `application/ld+json;profile="https://w3id.org/did-url-dereferencing"`:
        1.  The HTTP body _MUST_ contain a [DID URL dereferencing result](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing-result) (see [9\. DID URL Dereferencing Result](https://w3c.github.io/did-resolution/#did-url-dereferencing-result)) that is the result of the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function.
    2.  If the function is successful and returns a **contentStream** and a **contentType** metadata property with the value `text/uri-list` in the **dereferencingMetadata**:
        1.  The HTTP response status code _MUST_ be `303`.
        2.  The HTTP response _MUST_ contain an `Location` header. The value of this header _MUST_ be the selected [service endpoint](https://w3c.github.io/did-resolution/#dfn-service-endpoints) URL.
        3.  the HTTP response body _MUST_ be empty.
    3.  If the function is successful and returns a **contentStream** with any other **contentType**:
        1.  The HTTP response status code _MUST_ be `200`.
        2.  The HTTP response _MUST_ contain a `Content-Type` HTTP response header. Its value _MUST_ be the value of the **contentType** metadata property in the **dereferencingMetadata** (see [5.2 DID URL Dereferencing Metadata](https://w3c.github.io/did-resolution/#did-url-dereferencing-metadata)).
        3.  The HTTP response body _MUST_ contain the **contentStream** that is the result of the [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) function, in the representation corresponding to the `Content-Type` HTTP response header.

See [here](https://github.com/decentralized-identity/universal-resolver/blob/main/openapi/openapi.yaml) for an OpenAPI definition.

Given the following [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) HTTP(S) endpoint:

`https://resolver.example/1.0/identifiers/`

And given the following input [DID](https://w3c.github.io/did-resolution/#dfn-decentralized-identifiers):

`did:sov:WRfXPg8dantKVubE3HX8pw`

Then the request HTTP(S) URL is:

`https://resolver.example/1.0/identifiers/did:sov:WRfXPg8dantKVubE3HX8pw`

The HTTP(S) binding can be invoked as follows:

[Example 29](https://w3c.github.io/did-resolution/#example-example-curl-call-to-a-did-resolver-via-http-s-binding)

: Example curl call to a DID resolver via HTTP(S) binding

```
curl -X GET https://resolver.example/1.0/identifiers/did:sov:WRfXPg8dantKVubE3HX8pw
```

Additional examples of the HTTP(S) binding:

![Diagram showing the invocation of resolve() over HTTPS](https://w3c.github.io/did-resolution/diagrams/https-resolve-example-1.png)

[Figure 13](https://w3c.github.io/did-resolution/#https-resolve-example-1) Invocation of resolve() over HTTP(S).

![Diagram showing the invocation of resolve() over HTTPS](https://w3c.github.io/did-resolution/diagrams/https-resolve-example-2.png)

[Figure 14](https://w3c.github.io/did-resolution/#https-resolve-example-2) Invocation of resolve() over HTTP(S).

Additional examples of the HTTP(S) binding:

![Diagram showing the invocation of dereference() over HTTPS](https://w3c.github.io/did-resolution/diagrams/https-dereference-example-1.png)

[Figure 15](https://w3c.github.io/did-resolution/#https-dereference-example-1) Invocation of dereference() over HTTP(S).

![Diagram showing the invocation of dereference() over HTTPS](https://w3c.github.io/did-resolution/diagrams/https-dereference-example-2.png)

[Figure 16](https://w3c.github.io/did-resolution/#https-dereference-example-2) Invocation of dereference() over HTTP(S).

[DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) do not involve any authentication or authorization functionality. Similar to DNS resolution, anybody can perform the process, without requiring any credentials or non-public knowledge.

The spec should clarify whether or not conformant resolvers MUST be public or MAY restrict access via some authentication and authorization scheme.

The current language doesn't make it clear if authentication is just out of scope or if it is disallowed.

Issue

Explain that DIDs are not necessarily _globally_ resolvable, such as pairwise or N-wise "peer" DIDs.

See \[[RFC3339](https://w3c.github.io/did-resolution/#bib-rfc3339 "Date and Time on the Internet: Timestamps")\]: _URIs have a global scope and are interpreted consistently regardless of context, though the result of that interpretation may be in relation to the end-user's context._

An advanced idea is that the result of DID resolution could be contextual or depend on policies, see [this comment](https://github.com/w3c/did-resolution/issues/28#issuecomment-510592199).

Issue

A related topic is whether (parts of) DID document could be encrypted, e.g., [w3c/did-core/issues/25](https://github.com/w3c/did-core/issues/25). Also see the use of the fragment in the [IPID](https://did-ipid.github.io/ipid-did-method/) DID method.

A [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s) may maintain a generic cache of [DID documents](https://w3c.github.io/did-resolution/#dfn-did-documents). It may also maintain caches specific to certain [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s).

The `noCache` resolution option can be used to request a certain kind of caching behavior.

This resolution option is _OPTIONAL_.

Possible values of this property are:

-   `"false"` (default value): Caching of [DID documents](https://w3c.github.io/did-resolution/#dfn-did-documents) is allowed.
-   `"true"`: Request that caching is disabled and a fresh [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) is retrieved from the [verifiable data registry](https://w3c.github.io/did-resolution/#dfn-verifiable-data-registry).

Caching behavior can be controlled by configuration of the [DID resolver](https://w3c.github.io/did-resolution/#dfn-did-resolver-s), by the `noCache` resolution option, or by contents of the DID document (e.g., a `cacheMaxTtl` field), or by a combination of these properties.

See corresponding open issue.

Issue

Perhaps we can re-use caching mechanisms of other protocols such as HTTP.

If a [`versionId`](https://www.w3.org/TR/did-core/#did-parameters) or [`versionTime`](https://www.w3.org/TR/did-core/#did-parameters) DID parameter is provided, the [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) algorithm returns a specific version of the [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents).

The DID parameters [`versionId`](https://www.w3.org/TR/did-core/#did-parameters) and [`versionTime`](https://www.w3.org/TR/did-core/#did-parameters) are mutually exclusive.

The use of the [`versionId`](https://www.w3.org/TR/did-core/#did-parameters) DID parameter is specific to the [DID method](https://w3c.github.io/did-resolution/#dfn-did-method-s). Its possible values may include sequential numbers, random UUIDs, content hashes, etc..

DID document metadata _MAY_ contain a [`versionId`](https://www.w3.org/TR/did-core/#did-parameters) property that changes with each [Update](https://www.w3.org/TR/did-core/#method-operations) operation that is performed on a DID document.

Note

While most [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) support the [Update](https://www.w3.org/TR/did-core/#method-operations) operation, there is no requirement for [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) to keep all previous [DID document](https://w3c.github.io/did-resolution/#dfn-did-documents) versions, therefore not all [DID methods](https://w3c.github.io/did-resolution/#dfn-did-method-s) support versioning.

See corresponding open issue.

[Issue 8](https://github.com/w3c/did-resolution/issues/8)

: Discover DIDs from other identifiers

There is discussion on the relationship between [DID resolution](https://w3c.github.io/did-resolution/#dfn-did-resolution) and resolution of non-DID identifiers such as domain names, HTTP URIs, or e-mail addresses. This includes the questions how DIDs can be discovered from non-DID identifiers, and how links between identifiers can be verifiable.

Issue

TODO: Define privacy considerations for DID resolution

There is discussion about minimizing the extent of profiling of requesters from DID Resolvers.

Note

This section lists additional [DID URL dereferencing](https://w3c.github.io/did-resolution/#dfn-did-url-dereferencing) features that are under discussion and have not yet been incorporated into the algorithm.

A [service endpoint](https://www.w3.org/TR/did-core/#services) may have a `serviceEndpoint` property with a value that is itself a DID. This is interpreted as a "DID redirect" from the input DID to another. In this case, a "child" DID resolution process can be launched to get to a "final" service endpoint.

The `follow-redirect` resolution option can be supplied by a client as a hint to instruct whether redirects should be followed. This resolution option is _OPTIONAL_.

See corresponding open issue.

DID redirects could not only apply to a single service endpoint, but to an entire DID document, therefore enabling portability use cases.

[Example 30](https://w3c.github.io/did-resolution/#example-30)

```
{
   "id": "did:example:123456789abcdefghi#hub1",
   "type": "HubService",
   "serviceEndpoint": "did:example:xyz"
}
```

A DID document may contain a "proxy" service type which would provide a mapping that needs to be followed in order to resolve to a final service URL.

Keeping track of a proposal here [w3c-ccg/did-spec#90 (comment)](https://github.com/w3c-ccg/did-spec/issues/90#issuecomment-439936749) that a DID Document could contain a "proxy" service type which would provide a mapping that needs to be followed in order to resolve to a final service URL.

[Example 31](https://w3c.github.io/did-resolution/#example-31)

```
{
   "id": "did:example:123456789abcdefghi",
   "type": "ProxyService",
   "serviceEndpoint": "https://mydomain.com/proxy"
}
```

Issue

Several ways of selecting parts of a DID document are being discussed, including the use of JSON pointer.

See corresponding PRs [here](https://github.com/w3c/did-spec/pull/161) and [here](https://github.com/w3c/did-core/pull/257).

1.  [DID resolvers in DID Core specification](https://www.w3.org/TR/did-core/#resolution)
2.  [Universal Resolver](https://github.com/decentralized-identity/universal-resolver/)
3.  [did-client](https://github.com/digitalbazaar/did-client)
4.  [uPort DID resolver](https://github.com/uport-project/did-resolver)

\[CID\]

[Controlled Identifiers v1.0](https://www.w3.org/TR/cid-1.0/). Michael Jones; Manu Sporny. W3C. 15 May 2025. W3C Recommendation. URL: [https://www.w3.org/TR/cid-1.0/](https://www.w3.org/TR/cid-1.0/)

\[DID-CORE\]

[Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/). Manu Sporny; Amy Guy; Markus Sabadello; Drummond Reed. W3C. 19 July 2022. W3C Recommendation. URL: [https://www.w3.org/TR/did-core/](https://www.w3.org/TR/did-core/)

\[INFRA\]

[Infra Standard](https://infra.spec.whatwg.org/). Anne van Kesteren; Domenic Denicola. WHATWG. Living Standard. URL: [https://infra.spec.whatwg.org/](https://infra.spec.whatwg.org/)

\[RFC2046\]

[Multipurpose Internet Mail Extensions (MIME) Part Two: Media Types](https://www.rfc-editor.org/rfc/rfc2046). N. Freed; N. Borenstein. IETF. November 1996. Draft Standard. URL: [https://www.rfc-editor.org/rfc/rfc2046](https://www.rfc-editor.org/rfc/rfc2046)

\[RFC2119\]

[Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119). S. Bradner. IETF. March 1997. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc2119](https://www.rfc-editor.org/rfc/rfc2119)

\[RFC3986\]

[Uniform Resource Identifier (URI): Generic Syntax](https://www.rfc-editor.org/rfc/rfc3986). T. Berners-Lee; R. Fielding; L. Masinter. IETF. January 2005. Internet Standard. URL: [https://www.rfc-editor.org/rfc/rfc3986](https://www.rfc-editor.org/rfc/rfc3986)

\[RFC4122\]

[A Universally Unique IDentifier (UUID) URN Namespace](https://www.rfc-editor.org/rfc/rfc4122). P. Leach; M. Mealling; R. Salz. IETF. July 2005. Proposed Standard. URL: [https://www.rfc-editor.org/rfc/rfc4122](https://www.rfc-editor.org/rfc/rfc4122)

\[RFC7231\]

[Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content](https://httpwg.org/specs/rfc7231.html). R. Fielding, Ed.; J. Reschke, Ed. IETF. June 2014. Proposed Standard. URL: [https://httpwg.org/specs/rfc7231.html](https://httpwg.org/specs/rfc7231.html)

\[RFC8174\]

[Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174). B. Leiba. IETF. May 2017. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc8174](https://www.rfc-editor.org/rfc/rfc8174)

\[RFC9457\]

[Problem Details for HTTP APIs](https://www.rfc-editor.org/rfc/rfc9457). M. Nottingham; E. Wilde; S. Dalal. IETF. July 2023. Proposed Standard. URL: [https://www.rfc-editor.org/rfc/rfc9457](https://www.rfc-editor.org/rfc/rfc9457)

\[VC-DATA-MODEL\]

[Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model/). Manu Sporny; Grant Noble; Dave Longley; Daniel Burnett; Brent Zundel; Kyle Den Hartog. W3C. 3 March 2022. W3C Recommendation. URL: [https://www.w3.org/TR/vc-data-model/](https://www.w3.org/TR/vc-data-model/)

\[XMLSCHEMA11-2\]

[W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes](https://www.w3.org/TR/xmlschema11-2/). David Peterson; Sandy Gao; Ashok Malhotra; Michael Sperberg-McQueen; Henry Thompson; Paul V. Biron et al. W3C. 5 April 2012. W3C Recommendation. URL: [https://www.w3.org/TR/xmlschema11-2/](https://www.w3.org/TR/xmlschema11-2/)

\[DATA-INTEGRITY\]

[Verifiable Credential Data Integrity 1.0](https://www.w3.org/TR/vc-data-integrity/). Dave Longley; Manu Sporny. W3C Verifiable Credentials Working Group. CRD. URL: [https://www.w3.org/TR/vc-data-integrity/](https://www.w3.org/TR/vc-data-integrity/)

\[DID-KEY\]

[The did:key Method](https://w3c-ccg.github.io/did-method-key/). Manu Sporny; Dmitri Zagidulin; Dave Longley. 09 June 2020. unofficial. URL: [https://w3c-ccg.github.io/did-method-key/](https://w3c-ccg.github.io/did-method-key/)

\[DID-PEER\]

[Peer DID Method Specification](https://identity.foundation/peer-did-method-spec/). Oskar Deventer; Christian Lundkvist; Márton Csernai; Kyle Den Hartog; Markus Sabadello; Sam Curren; Dan Gisolfi; Mike Varley; Sven Hammann; John Jordan; Lovesh Harchandani; Devin Fisher; Tobias Looker; Brent Zundel; Stephen Curran. 10 July 2020. W3C Editor's Draft. URL: [https://identity.foundation/peer-did-method-spec/](https://identity.foundation/peer-did-method-spec/)

\[DID-SPEC-REGISTRIES\]

[Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/). Manu Sporny; Markus Sabadello. W3C. 19 February 2025. W3C Working Group Note. URL: [https://www.w3.org/TR/did-extensions/](https://www.w3.org/TR/did-extensions/)

\[HASHLINK\]

[Cryptographic Hyperlinks](https://tools.ietf.org/html/draft-sporny-hashlink-05). Manu Sporny. IETF. December 2018. Internet-Draft. URL: [https://tools.ietf.org/html/draft-sporny-hashlink-05](https://tools.ietf.org/html/draft-sporny-hashlink-05)

\[KERI\]

[Key Event Receipt Infrastructure (KERI)](https://arxiv.org/abs/1907.02143). Samuel M. Smith. July 2019. URL: [https://arxiv.org/abs/1907.02143](https://arxiv.org/abs/1907.02143)

\[RFC3339\]

[Date and Time on the Internet: Timestamps](https://www.rfc-editor.org/rfc/rfc3339). G. Klyne; C. Newman. IETF. July 2002. Proposed Standard. URL: [https://www.rfc-editor.org/rfc/rfc3339](https://www.rfc-editor.org/rfc/rfc3339)