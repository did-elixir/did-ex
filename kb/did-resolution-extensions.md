# DID Resolution Extensions
## Known Extensions for DID Resolution and Dereferencing
### W3C Group Note 19 November 2024

## Abstract

This document serves as a collection of known DID Resolution and Dereferencing extensions.

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

1.  [Abstract](https://www.w3.org/TR/did-extensions-resolution/#abstract)
2.  [Status of This Document](https://www.w3.org/TR/did-extensions-resolution/#sotd)
3.  [1\. Introduction](https://www.w3.org/TR/did-extensions-resolution/#introduction)
    1.  [1.1 The Registration Process](https://www.w3.org/TR/did-extensions-resolution/#the-registration-process)
    2.  [1.2 Conformance](https://www.w3.org/TR/did-extensions-resolution/#conformance)
4.  [2\. Representations](https://www.w3.org/TR/did-extensions-resolution/#representations)
5.  [3\. Representation-Specific Entries](https://www.w3.org/TR/did-extensions-resolution/#representation-specific-entries)
    1.  [3.1 JSON](https://www.w3.org/TR/did-extensions-resolution/#json)
    2.  [3.2 JSON-LD](https://www.w3.org/TR/did-extensions-resolution/#json-ld)
        1.  [3.2.1 @context](https://www.w3.org/TR/did-extensions-resolution/#context)
    3.  [3.3 CBOR](https://www.w3.org/TR/did-extensions-resolution/#cbor)
6.  [4\. DID Resolution Options](https://www.w3.org/TR/did-extensions-resolution/#did-resolution-options)
    1.  [4.1 accept](https://www.w3.org/TR/did-extensions-resolution/#accept)
7.  [5\. DID Resolution Metadata](https://www.w3.org/TR/did-extensions-resolution/#did-resolution-metadata)
    1.  [5.1 contentType](https://www.w3.org/TR/did-extensions-resolution/#contenttype)
    2.  [5.2 error](https://www.w3.org/TR/did-extensions-resolution/#error)
        1.  [5.2.1 invalidDid](https://www.w3.org/TR/did-extensions-resolution/#invaliddid)
        2.  [5.2.2 notFound](https://www.w3.org/TR/did-extensions-resolution/#notfound)
        3.  [5.2.3 representationNotSupported](https://www.w3.org/TR/did-extensions-resolution/#representationnotsupported)
        4.  [5.2.4 methodNotSupported](https://www.w3.org/TR/did-extensions-resolution/#methodnotsupported)
        5.  [5.2.5 internalError](https://www.w3.org/TR/did-extensions-resolution/#internalerror)
        6.  [5.2.6 invalidPublicKey](https://www.w3.org/TR/did-extensions-resolution/#invalidpublickey)
        7.  [5.2.7 invalidPublicKeyLength](https://www.w3.org/TR/did-extensions-resolution/#invalidpublickeylength)
        8.  [5.2.8 invalidPublicKeyType](https://www.w3.org/TR/did-extensions-resolution/#invalidpublickeytype)
        9.  [5.2.9 unsupportedPublicKeyType](https://www.w3.org/TR/did-extensions-resolution/#unsupportedpublickeytype)
        10.  [5.2.10 notAllowedVerificationMethodType](https://www.w3.org/TR/did-extensions-resolution/#notallowedverificationmethodtype)
        11.  [5.2.11 notAllowedKeyType](https://www.w3.org/TR/did-extensions-resolution/#notallowedkeytype)
        12.  [5.2.12 notAllowedMethod](https://www.w3.org/TR/did-extensions-resolution/#notallowedmethod)
        13.  [5.2.13 notAllowedCertificate](https://www.w3.org/TR/did-extensions-resolution/#notallowedcertificate)
        14.  [5.2.14 notAllowedLocalDuplicateKey](https://www.w3.org/TR/did-extensions-resolution/#notallowedlocalduplicatekey)
        15.  [5.2.15 notAllowedLocalDerivedKey](https://www.w3.org/TR/did-extensions-resolution/#notallowedlocalderivedkey)
        16.  [5.2.16 notAllowedGlobalDuplicateKey](https://www.w3.org/TR/did-extensions-resolution/#notallowedglobalduplicatekey)
8.  [6\. DID Dereferencing Metadata](https://www.w3.org/TR/did-extensions-resolution/#did-dereferencing-metadata)
    1.  [6.1 error](https://www.w3.org/TR/did-extensions-resolution/#error-0)
        1.  [6.1.1 invalidDidUrl](https://www.w3.org/TR/did-extensions-resolution/#invaliddidurl)
        2.  [6.1.2 notFound](https://www.w3.org/TR/did-extensions-resolution/#notfound-0)
9.  [7\. DID Document Metadata](https://www.w3.org/TR/did-extensions-resolution/#did-document-metadata)
    1.  [7.1 created](https://www.w3.org/TR/did-extensions-resolution/#created)
    2.  [7.2 updated](https://www.w3.org/TR/did-extensions-resolution/#updated)
    3.  [7.3 deactivated](https://www.w3.org/TR/did-extensions-resolution/#deactivated)
    4.  [7.4 nextUpdate](https://www.w3.org/TR/did-extensions-resolution/#nextupdate)
    5.  [7.5 versionId](https://www.w3.org/TR/did-extensions-resolution/#versionid)
    6.  [7.6 nextVersionId](https://www.w3.org/TR/did-extensions-resolution/#nextversionid)
    7.  [7.7 equivalentId](https://www.w3.org/TR/did-extensions-resolution/#equivalentid)
    8.  [7.8 canonicalId](https://www.w3.org/TR/did-extensions-resolution/#canonicalid)
10.  [8\. Parameters](https://www.w3.org/TR/did-extensions-resolution/#parameters)
    1.  [8.1 hl](https://www.w3.org/TR/did-extensions-resolution/#hl-param)
    2.  [8.2 service](https://www.w3.org/TR/did-extensions-resolution/#service-param)
    3.  [8.3 versionId](https://www.w3.org/TR/did-extensions-resolution/#versionId-param)
    4.  [8.4 versionTime](https://www.w3.org/TR/did-extensions-resolution/#versionTime-param)
    5.  [8.5 relativeRef](https://www.w3.org/TR/did-extensions-resolution/#relativeRef-param)
    6.  [8.6 initialState](https://www.w3.org/TR/did-extensions-resolution/#initialState-param)
    7.  [8.7 transformKeys](https://www.w3.org/TR/did-extensions-resolution/#transformKeys-param)
    8.  [8.8 signedIetfJsonPatch](https://www.w3.org/TR/did-extensions-resolution/#signedIetfJsonPatch-param)
    9.  [8.9 resource](https://www.w3.org/TR/did-extensions-resolution/#resource)
11.  [A. References](https://www.w3.org/TR/did-extensions-resolution/#references)
    1.  [A.1 Informative references](https://www.w3.org/TR/did-extensions-resolution/#informative-references)

_This section is non-normative._

This document serves as a collection of known DID Resolution and Dereferencing extensions.

The registration process is described in the [Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/).

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

This table provides a reference for media types and the associated specifications for producing and consuming those representations.

| Media Type | Specification |
| --- | --- |
| application/did+json | [DID Core](https://www.w3.org/TR/did-core#json) |
| application/did+ld+json | [DID Core](https://www.w3.org/TR/did-core#json-ld) |
| application/did+cbor | [The Plain CBOR Representation](https://www.w3.org/TR/did-cbor-representation/#application-did-cbor) |

These are entries in DID documents that are specific to the [JSON representation](https://w3c.github.io/did-core/#json).

(No entries yet)

These are entries in DID documents that are specific to the [JSON-LD representation](https://w3c.github.io/did-core/#json-ld).

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#production-0) |

The following values are acceptable values for the `@context` entry as a [JSON String](https://tools.ietf.org/html/rfc8259#section-7) or first item of a [JSON Array](https://tools.ietf.org/html/rfc8259#section-5), represented as a [JSON String](https://tools.ietf.org/html/rfc8259#section-7).

| `@context` Values | Specification Version |
| --- | --- |
| [https://www.w3.org/ns/did/v1](https://www.w3.org/ns/did/v1) | [DID Core 1.0 Working draft](https://w3c.github.io/did-core/) |

[Example 1](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-context-in-the-json-ld-representation)

: Example of @context in the JSON-LD representation

```
{
  <span>"@context"</span>: [
    <span>"https://www.w3.org/ns/did/v1"</span>,
    <span>"https://example.com/blockchain-identity/v1"</span>
  ],
  ...
}
```

These are entries in DID documents that are specific to the [CBOR representation](https://www.w3.org/TR/did-cbor-representation/).

(No entries yet)

These properties contain information pertaining to the DID resolution request.

| Normative Definition |  |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-options) |  |

These properties contain information pertaining to the DID resolution response.

| Normative Definition |  |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-metadata) |  |

[Example 3](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-contenttype-metadata-property)

: Example of contentType metadata property

```
<span>{</span>
  <span>"contentType"</span><span>:</span> <span>"application/did+ld+json"</span>
<span>}</span>
```

| Normative Definition |  |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-metadata) |  |

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-metadata) |

[Example 5](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-invaliddid-error-value)

: Example of invalidDid error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"invalidDid"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-metadata) |

[Example 6](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notfound-error-value)

: Example of notFound error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notFound"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-resolution-metadata) |

[Example 7](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-representationnotsupported-error-value)

: Example of representationNotSupported error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"representationNotSupported"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#methodnotsupported) |

[Example 8](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-methodnotsupported-error-value)

: Example of methodNotSupported error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"methodNotSupported"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#internalerror) |

[Example 9](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-internalerror-error-value)

: Example of internalError error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"internalError"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#invalidPublicKey) |

[Example 10](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-invalidpublickey-error-value)

: Example of invalidPublicKey error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"invalidPublicKey"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#invalidPublicKeyLengthr) |

[Example 11](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-invalidpublickeylength-error-value)

: Example of invalidPublicKeyLength error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"invalidPublicKeyLength"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#invalidPublicKeyType) |

[Example 12](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-invalidpublickeytype-error-value)

: Example of invalidPublicKeyType error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"invalidPublicKeyType"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Resolution](https://w3c.github.io/did-resolution/#unsupportedPublicKeyType) |

[Example 13](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-unsupportedpublickeytype-error-value)

: Example of unsupportedPublicKeyType error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"unsupportedPublicKeyType"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedVerificationMethodType](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-verification-method-type.md) |

[Example 14](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedverificationmethodtype-error-value)

: Example of notAllowedVerificationMethodType error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedVerificationMethodType"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedKeyType](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-key-type.md) |

[Example 15](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedkeytype-error-value)

: Example of notAllowedKeyType error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedKeyType"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedMethod](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-method.md) |

[Example 16](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedmethod-error-value)

: Example of notAllowedMethod error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedMethod"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedCertificate](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-certificate.md) |

[Example 17](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedcertificate-error-value)

: Example of notAllowedCertificate error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedCertificate"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedLocalDuplicateKey](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-local-duplicate-key.md) |

[Example 18](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedlocalduplicatekey-error-value)

: Example of notAllowedLocalDuplicateKey error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedLocalDuplicateKey"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedLocalDerivedKey](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-local-derived-key.md) |

[Example 19](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedlocalderivedkey-error-value)

: Example of notAllowedLocalDerivedKey error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedLocalDerivedKey"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Spec Extension: notAllowedGlobalDuplicateKey](https://github.com/decentralized-identity/did-spec-extensions/blob/main/error-codes/not-allowed-global-duplicate-key.md) |

[Example 20](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notallowedglobalduplicatekey-error-value)

: Example of notAllowedGlobalDuplicateKey error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notAllowedGlobalDuplicateKey"</span>
<span>}</span>
```

These properties contain information pertaining to the DID dereferencing response.

| Normative Definition |  |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-url-dereferencing-metadata) |  |

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-url-dereferencing-metadata) |

[Example 22](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-invaliddidurl-error-value)

: Example of invalidDidUrl error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"invalidDidUrl"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-url-dereferencing-metadata) |

[Example 23](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-notfound-error-value-0)

: Example of notFound error value

```
<span>{</span>
  <span>"error"</span><span>:</span> <span>"notFound"</span>
<span>}</span>
```

These properties contain information pertaining to the DID document itself, rather than the DID subject.

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 24](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-created-property)

: Example of created property

```
<span>{</span>
  <span>"created"</span><span>:</span> <span>"2019-03-23T06:35:22Z"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 25](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-updated-property)

: Example of updated property

```
<span>{</span>
  <span>"updated"</span><span>:</span> <span>"2023-08-10T13:40:06Z"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 26](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-deactivated-property)

: Example of deactivated property

```
<span>{</span>
  <span>"deactivated"</span><span>:</span> <span><span>true</span></span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 27](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-nextupdate-property)

: Example of nextUpdate property

```
<span>{</span>
  <span>"nextUpdate"</span><span>:</span> <span>"2023-08-10T13:40:06Z"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 28](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-versionid-property)

: Example of versionId property

```
<span>{</span>
  <span>"versionId"</span><span>:</span> <span>"bafyreifederejlobaec6kwpl2mc3tw7qk3j3ey4uytkbiw2qw7dzylud6i"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 29](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-nextversionid-property)

: Example of nextVersionId property

```
<span>{</span>
  <span>"nextVersionId"</span><span>:</span> <span>"bafyreifederejlobaec6kwpl2mc3tw7qk3j3ey4uytkbiw2qw7dzylud6i"</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 30](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-equivalentid-property)

: Example of equivalentId property

```
<span>{</span>
  <span>"equivalentId"</span><span>:</span> <span>[</span><span>"did:example:ABC"</span><span>,</span> <span>"did:example:Abc"</span><span>]</span>
<span>}</span>
```

| Normative Definition | JSON-LD |
| --- | --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-document-metadata-properties) | [DID Core](https://www.w3.org/ns/did/v1) |

[Example 31](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-canonicalid-property)

: Example of canonicalId property

```
<span>{</span>
  <span>"canonicalId"</span><span>:</span> <span>"did:example:ABC"</span>
<span>}</span>
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-parameters) |

[Example 32](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-hl-parameter)

: Example of hl parameter

```
did:example:123?hl=zQmWvQxTqbG2Z9HPJgG57jjwR154cKhbtJenbyYTWkjgF3e
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#generic-did-url-parameters) |

[Example 33](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-service-parameter)

: Example of service parameter

```
did:example:123?service=agent
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-parameters) |

[Example 34](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-versionid-parameter)

: Example of versionId parameter

```
did:example:123?versionId=4
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-parameters) |

[Example 35](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-versiontime-parameter)

: Example of versionTime parameter

```
did:example:123?versionTime=2016-10-17T02:41:00Z
```

| Normative Definition |
| --- |
| [DID Core](https://www.w3.org/TR/did-core/#did-parameters) |

[Example 36](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-relativeref-parameter)

: Example of relativeRef parameter

```
did:example:123?service=files&amp;relativeRef=%2Fmyresume%2Fdoc%3Fversion%3Dlatest%23intro
```

| Normative Definition |
| --- |
| [DID Spec Extensions by DIF](https://github.com/decentralized-identity/did-spec-extensions/blob/master/parameters/initial-state.md) |

[Example 37](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-initialstate-parameter)

: Example of initialState parameter

```
did:example:123?initialState=eyJkZWx0YV9oYXNoIjoiRWlDUlRKZ2Q0U0V2YUZDLW9fNUZjQnZJUkRtWF94Z3RLX3g...
```

| Normative Definition |
| --- |
| [DID Spec Extensions by DIF](https://github.com/decentralized-identity/did-spec-extensions/blob/master/parameters/transform-keys.md) |

[Example 38](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-transformkeys-parameter)

: Example of transformKeys parameter

```
did:example:123?transformKeys=jwk
```

| Normative Definition |
| --- |
| [DID Spec Extensions by DIF](https://github.com/decentralized-identity/did-spec-extensions/blob/master/parameters/signed-ietf-json-patch.md) |

[Example 39](https://www.w3.org/TR/did-extensions-resolution/#example-example-of-signedietfjsonpatch-parameter)

: Example of signedIetfJsonPatch parameter

```
did:example:123?signedIetfJsonPatch=eyJraWQiOiJkaWQ6ZXhhbXBsZTo0NTYjX1FxMFVMMkZxNjUxUTBGamQ2VH...
```

| Normative Definition |
| --- |
| [DID URL Resource Parameter Specification](https://wiki.trustoverip.org/display/HOME/DID+URL+Resource+Parameter+Specification) |

[Example 40](https://www.w3.org/TR/did-extensions-resolution/#example-a-did-url-with-a-resource-did-parameter)

: A DID URL with a 'resource' DID parameter

```
<span>did</span>:<span>foo</span>:21tDAKCERh95uGgKbJNHYp?resource=<span>true</span>
```

\[DID-EXTENSIONS\]

[Decentralized Identifier Extensions](https://www.w3.org/TR/did-extensions/). Manu Sporny. Decentralized Identifier Working Group. W3C Working Group Note. URL: [https://www.w3.org/TR/did-extensions/](https://www.w3.org/TR/did-extensions/)