# Decentralized Identifier Extensions
## Known Extensions for the Decentralized Identifier Ecosystem
### W3C Group Note 29 April 2025

## Abstract

This document serves as a repository for all known global parameters, properties, and values used by the Decentralized Identifier ecosystem.

## Status of This Document

_This section describes the status of this document at the time of its publication. A list of current W3C publications and the latest revision of this technical report can be found in the [W3C standards and drafts index](https://www.w3.org/TR/) at https://www.w3.org/TR/._

This repository is under active development and implementers are advised against using the repository unless they are directly involved with the W3C DID Working Group.

Comments regarding this document are welcome. Please file issues directly on [GitHub](https://github.com/w3c/did-extensions/issues/), or send them to [public-did-wg@w3.org](mailto:public-did-wg@w3.org) ( [subscribe](mailto:public-did-wg-request@w3.org?subject=subscribe), [archives](https://lists.w3.org/Archives/Public/public-did-wg/)).

Portions of the work on this specification have been funded by the United States Department of Homeland Security's Science and Technology Directorate under contracts HSHQDC-16-R00012-H-SB2016-1-002, 70RSAT20T00000010, and HSHQDC-17-C-00019. The content of this specification does not necessarily reflect the position or the policy of the U.S. Government and no official endorsement should be inferred.

Work on this repository has also been supported by the Rebooting the Web of Trust community facilitated by Christopher Allen, Shannon Appelcline, Kiara Robles, Brian Weller, Betty Dhamers, Kaliya Young, Kim Hamilton Duffy, Manu Sporny, Drummond Reed, Joe Andrieu, and Heather Vescent, Dmitri Zagidulin, and Dan Burnett.

This document was published by the [Decentralized Identifier Working Group](https://www.w3.org/groups/wg/did) as a Group Note using the [Note track](https://www.w3.org/policies/process/20231103/#recs-and-notes).

This Group Note is endorsed by the [Decentralized Identifier Working Group](https://www.w3.org/groups/wg/did), but is not endorsed by W3C itself nor its Members.

This is a draft document and may be updated, replaced, or obsoleted by other documents at any time. It is inappropriate to cite this document as other than work in progress.

The [W3C Patent Policy](https://www.w3.org/policies/patent-policy/) does not carry any licensing requirements or commitments on this document.

This document is governed by the [03 November 2023 W3C Process Document](https://www.w3.org/policies/process/20231103/).

## Table of Contents

1.  [Abstract](https://w3c.github.io/did-extensions/#abstract)
2.  [Status of This Document](https://w3c.github.io/did-extensions/#sotd)
3.  [1. Introduction](https://w3c.github.io/did-extensions/#introduction)
    1.  [1.1 Conformance](https://w3c.github.io/did-extensions/#conformance)
4.  [2. The Registration Process](https://w3c.github.io/did-extensions/#the-registration-process)
5.  [3. Extensions](https://w3c.github.io/did-extensions/#extensions)
6.  [A. References](https://w3c.github.io/did-extensions/#references)
    1.  [A.1 Normative references](https://w3c.github.io/did-extensions/#normative-references)
    2.  [A.2 Informative references](https://w3c.github.io/did-extensions/#informative-references)

_This section is non-normative._

This document serves as a list of documents that contain known properties and values used by DID Methods \[[DID-CORE](https://w3c.github.io/did-extensions/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] and DID Resolution \[[DID-RESOLUTION](https://w3c.github.io/did-extensions/#bib-did-resolution "Decentralized Identifier Resolution (DID Resolution) v0.3")\] in the Decentralized Identifier ecosystem.

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key words _MAY_, _MUST_, _MUST NOT_, and _SHOULD_ in this document are to be interpreted as described in [BCP 14](https://www.rfc-editor.org/info/bcp14) \[[RFC2119](https://w3c.github.io/did-extensions/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] \[[RFC8174](https://w3c.github.io/did-extensions/#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")\] when, and only when, they appear in all capitals, as shown here.

Software implementers might find that the existing Decentralized Identifier Core specification \[[DID-CORE](https://w3c.github.io/did-extensions/#bib-did-core "Decentralized Identifiers (DIDs) v1.0")\] is not entirely capable of addressing their use case and might need to add a new parameters, properties, or values to this repository in order to achieve their use case in a globally interoperable fashion. In order to add a new parameter, property, or value to this repository, an implementer _MUST_ submit a modification request for this repository, as a pull request on the repository where this repository is hosted, where the modification request adheres to the following policies:

1.  Any addition to the DID Extensions _MUST_ specify a human readable description of the addition.
2.  Any name or value of a property or parameter _MUST_ be indicative of its function. Avoid generic terms such as "myProperty" or "foo".
3.  Any method name _SHOULD_ avoid generic terms such as "mymethod" or "registry".
4.  Any DID Method submission _MUST_ not impose any concerns about copyright, trademark, or intellectual property rights on the W3C, DID Method implementers, or users. To that end, the following apply:
    1.  DID Method submitters affirm to the best of their knowledge that their submission will not infringe upon or otherwise violate the rights of any third party.
    2.  If there are any known concerns about copyright, trademark, or intellectual property rights, the addition and use of a DID Method _MUST_ be authorized in writing by the holder of the intellectual property rights under an [F/RAND](https://en.wikipedia.org/wiki/Reasonable_and_non-discriminatory_licensing) license.
    3.  If a DID Method is subsequently alleged to violate any copyright, trademark, or intellectual property rights, those making the allegation _MUST_ provide documentation of their granted legal rights or an order from a court or arbitral tribunal, in each case of competent jurisdiction.
    4.  Should documentation of legally valid and enforceable copyright, trademark, or intellectual property rights be presented, then, at the discretion of the rights holder, the DID Method in question _MUST_ be removed.
5.  Any addition _MUST NOT_ create unreasonable legal, security, moral, or privacy issues that will result in direct harm to others. Examples of unacceptable additions include any containing racist language, technologies used to persecute minority populations, and unconsented pervasive tracking.
6.  Any addition to the DID Extensions _MUST_ link, via at least a URL, preferably a content-integrity protected one, to the defining specification so that implementers can implement the property.
7.  Any addition to the DID Extensions that is a property or value, _MUST_ specify a machine readable JSON-LD Context for the addition.
    -   The JSON-LD Context _MUST_ be included in full as part of the submission.
    -   A namespace URI _MUST_ be provided for the JSON-LD Context so that consumer implementations can consistently map a URI to the full context.
    -   The URI provided _MUST_ be persistent, and link all terms to their associated human readable descriptions.
    -   The URI provided _SHOULD_ resolve or link to the full context contents.
    -   JSON-LD Contexts _MUST_ be versioned and _MUST NOT_ be date stamped.
    -   JSON-LD Contexts _SHOULD_ use scoped terms and _MUST_ use the `@protected` feature to eliminate the possibility of term conflicts.
8.  Properties in the DID Extensions _MUST NOT_ be removed, only deprecated.

The Editors of the DID Specification Registries _MUST_ consider all of the policies above when reviewing additions to the repository and _MUST_ reject repository entries if they violate any of the policies in this section. Entities registering additions can challenge rejections first with the W3C DID Working Group and then, if they are not satisfied with the outcome, with the W3C Staff. W3C Staff need not be consulted on changes to the DID Specification Registries, but do have the final authority on repository contents. This is to ensure that W3C can adequately respond to time sensitive legal, privacy, security, moral, or other pressing concerns without putting an undue operational burden on W3C Staff.

Entries that are identified to cause interoperability problems _MAY_ be marked as such at the discretion of the maintainers of this repository, and if possible, after consultation with the entry maintainer.

Any submission to the registries that meet all the criteria listed above will be accepted for inclusion. These registries enumerate all known mechanisms that meet a minimum bar, without choosing between them.

The following documents list known extensions to the DID Ecosystem:

| Document | Description |
| --- | --- |
| [Property and Value Extensions](https://www.w3.org/TR/did-extensions-properties/) | Extensions to DID Document properties and values. |
| [Resolution Extensions](https://www.w3.org/TR/did-extensions-resolution/) | Extensions to DID Resolution parameters and results. |
| [DID Methods](https://www.w3.org/TR/did-extensions-methods/) | Ephemeral, distributed, and fully decentralized mechanisms for supporting Decentralized Identifiers across a variety of technology platforms. |

\[DID-CORE\]

[Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/). Manu Sporny; Amy Guy; Markus Sabadello; Drummond Reed. W3C. 19 July 2022. W3C Recommendation. URL: [https://www.w3.org/TR/did-core/](https://www.w3.org/TR/did-core/)

\[RFC2119\]

[Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/rfc/rfc2119). S. Bradner. IETF. March 1997. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc2119](https://www.rfc-editor.org/rfc/rfc2119)

\[RFC8174\]

[Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words](https://www.rfc-editor.org/rfc/rfc8174). B. Leiba. IETF. May 2017. Best Current Practice. URL: [https://www.rfc-editor.org/rfc/rfc8174](https://www.rfc-editor.org/rfc/rfc8174)

\[DID-RESOLUTION\]

[Decentralized Identifier Resolution (DID Resolution) v0.3](https://www.w3.org/TR/did-resolution/). Markus Sabadello; Dmitri Zagidulin. W3C. 29 May 2025. W3C Working Draft. URL: [https://www.w3.org/TR/did-resolution/](https://www.w3.org/TR/did-resolution/)