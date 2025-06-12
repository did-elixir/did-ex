# DID Core Specification Test Suite and Implementation Report

## Abstract

This document describes the did core test suite, and summarizes the latest test results.

## Status of This Document

This document is merely a W3C\-internal document. It has no official standing of any kind and does not represent consensus of the W3C Membership.

This document is under active development and implementers are advised against using the document unless they are directly involved with the W3C DID Working Group.

## Table of Contents

1.  [Abstract](https://w3c.github.io/did-test-suite/#abstract)
2.  [Status of This Document](https://w3c.github.io/did-test-suite/#sotd)
3.  [1. Conformance](https://w3c.github.io/did-test-suite/#conformance)
4.  [2. Introduction](https://w3c.github.io/did-test-suite/#introduction)
5.  [3. Terminology](https://w3c.github.io/did-test-suite/#terminology)
    1.  [3.1 Suite](https://w3c.github.io/did-test-suite/#suite)
    2.  [3.2 Statement](https://w3c.github.io/did-test-suite/#statement)
    3.  [3.3 Suite Configuration](https://w3c.github.io/did-test-suite/#suite-configuration)
    4.  [3.4 Raw Test Suite Run Result](https://w3c.github.io/did-test-suite/#raw-test-suite-run-result)
    5.  [3.5 Implementation Report](https://w3c.github.io/did-test-suite/#implementation-report-0)
6.  [4. Implementation Report](https://w3c.github.io/did-test-suite/#implementation-report)
    1.  [4.1 Executive Summary](https://w3c.github.io/did-test-suite/#executive-summary)
    2.  [4.2 Summary by Specification Statements](https://w3c.github.io/did-test-suite/#spec-statement-summary)
    3.  [4.3 Summary by Method Implementation](https://w3c.github.io/did-test-suite/#implementation-summary)
    4.  [4.4 Report by Test Suites](https://w3c.github.io/did-test-suite/#report-by-test-suites)
        1.  [4.4.1 did-core-properties](https://w3c.github.io/did-test-suite/#report-by-test-suites-did-core-properties)
        2.  [4.4.2 did-identifier](https://w3c.github.io/did-test-suite/#report-by-test-suites-did-identifier)
        3.  [4.4.3 did-production](https://w3c.github.io/did-test-suite/#report-by-test-suites-did-production)
        4.  [4.4.4 did-resolution](https://w3c.github.io/did-test-suite/#report-by-test-suites-did-resolution)
        5.  [4.4.5 did-url-dereferencing](https://w3c.github.io/did-test-suite/#report-by-test-suites-did-url-dereferencing)
    5.  [4.5 Report by Methods](https://w3c.github.io/did-test-suite/#report-by-methods)
        1.  [4.5.1 did:3](https://w3c.github.io/did-test-suite/#M1)
        2.  [4.5.2 did:ace](https://w3c.github.io/did-test-suite/#M2)
        3.  [4.5.3 did:algo](https://w3c.github.io/did-test-suite/#M3)
        4.  [4.5.4 did:art](https://w3c.github.io/did-test-suite/#M4)
        5.  [4.5.5 did:bba](https://w3c.github.io/did-test-suite/#M5)
        6.  [4.5.6 did:bid](https://w3c.github.io/did-test-suite/#M6)
        7.  [4.5.7 did:btcr](https://w3c.github.io/did-test-suite/#M7)
        8.  [4.5.8 did:ccp](https://w3c.github.io/did-test-suite/#M8)
        9.  [4.5.9 did:cheqd](https://w3c.github.io/did-test-suite/#M9)
        10.  [4.5.10 did:ebsi](https://w3c.github.io/did-test-suite/#M10)
        11.  [4.5.11 did:elem](https://w3c.github.io/did-test-suite/#M11)
        12.  [4.5.12 did:emtrust](https://w3c.github.io/did-test-suite/#M12)
        13.  [4.5.13 did:ethr](https://w3c.github.io/did-test-suite/#M13)
        14.  [4.5.14 did:evan](https://w3c.github.io/did-test-suite/#M14)
        15.  [4.5.15 did:example](https://w3c.github.io/did-test-suite/#M15)
        16.  [4.5.16 did:gatc](https://w3c.github.io/did-test-suite/#M16)
        17.  [4.5.17 did:github](https://w3c.github.io/did-test-suite/#M17)
        18.  [4.5.18 did:hcr](https://w3c.github.io/did-test-suite/#M18)
        19.  [4.5.19 did:icon](https://w3c.github.io/did-test-suite/#M19)
        20.  [4.5.20 did:io](https://w3c.github.io/did-test-suite/#M20)
        21.  [4.5.21 did:ion](https://w3c.github.io/did-test-suite/#M21)
        22.  [4.5.22 did:is](https://w3c.github.io/did-test-suite/#M22)
        23.  [4.5.23 did:jnctn](https://w3c.github.io/did-test-suite/#M23)
        24.  [4.5.24 did:jolo](https://w3c.github.io/did-test-suite/#M24)
        25.  [4.5.25 did:key](https://w3c.github.io/did-test-suite/#M25)
        26.  [4.5.26 did:kilt](https://w3c.github.io/did-test-suite/#M26)
        27.  [4.5.27 did:knox](https://w3c.github.io/did-test-suite/#M27)
        28.  [4.5.28 did:lit](https://w3c.github.io/did-test-suite/#M28)
        29.  [4.5.29 did:monid](https://w3c.github.io/did-test-suite/#M29)
        30.  [4.5.30 did:mpg](https://w3c.github.io/did-test-suite/#M30)
        31.  [4.5.31 did:nacl](https://w3c.github.io/did-test-suite/#M31)
        32.  [4.5.32 did:nft](https://w3c.github.io/did-test-suite/#M32)
        33.  [4.5.33 did:onion](https://w3c.github.io/did-test-suite/#M33)
        34.  [4.5.34 did:ont](https://w3c.github.io/did-test-suite/#M34)
        35.  [4.5.35 did:orb](https://w3c.github.io/did-test-suite/#M35)
        36.  [4.5.36 did:photon](https://w3c.github.io/did-test-suite/#M36)
        37.  [4.5.37 did:pkh](https://w3c.github.io/did-test-suite/#M37)
        38.  [4.5.38 did:polygon](https://w3c.github.io/did-test-suite/#M38)
        39.  [4.5.39 did:schema](https://w3c.github.io/did-test-suite/#M39)
        40.  [4.5.40 did:sol](https://w3c.github.io/did-test-suite/#M40)
        41.  [4.5.41 did:sov](https://w3c.github.io/did-test-suite/#M41)
        42.  [4.5.42 did:ssb](https://w3c.github.io/did-test-suite/#M42)
        43.  [4.5.43 did:stack](https://w3c.github.io/did-test-suite/#M43)
        44.  [4.5.44 did:trust](https://w3c.github.io/did-test-suite/#M44)
        45.  [4.5.45 did:tz](https://w3c.github.io/did-test-suite/#M45)
        46.  [4.5.46 did:unisot](https://w3c.github.io/did-test-suite/#M46)
        47.  [4.5.47 did:v1](https://w3c.github.io/did-test-suite/#M47)
        48.  [4.5.48 did:vaa](https://w3c.github.io/did-test-suite/#M48)
        49.  [4.5.49 did:web](https://w3c.github.io/did-test-suite/#M49)
        50.  [4.5.50 did:webkey](https://w3c.github.io/did-test-suite/#M50)
        51.  [4.5.51 did:work](https://w3c.github.io/did-test-suite/#M51)
7.  [A. References](https://w3c.github.io/did-test-suite/#references)
    1.  [A.1 Normative references](https://w3c.github.io/did-test-suite/#normative-references)

As well as sections marked as non-normative, all authoring guidelines, diagrams, examples, and notes in this specification are non-normative. Everything else in this specification is normative.

The key words _MAY_, _MUST_, _MUST NOT_, _OPTIONAL_, _REQUIRED_, and _SHOULD_ in this document are to be interpreted as described in [BCP 14](https://www.rfc-editor.org/info/bcp14) \[[RFC2119](https://w3c.github.io/did-test-suite/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] \[[RFC8174](https://w3c.github.io/did-test-suite/#bib-rfc8174 "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words")\] when, and only when, they appear in all capitals, as shown here.

The DID Core Specification strives to make no untestable normative statements with \[[RFC2119](https://w3c.github.io/did-test-suite/#bib-rfc2119 "Key words for use in RFCs to Indicate Requirement Levels")\] Language.

This document attempts to demonstrate that all such language has been tested, and is supported by at least 2 independent implementations.

A test suite is a collection of tests and a json suite configuration file.

[Example 1](https://w3c.github.io/did-test-suite/#example-example-json-suite-configuration)

: Example json suite configuration

```
<span>{</span>
  <span>"name"</span><span>:</span> <span>"test-suite-a"</span><span>,</span>
  <span>"a"</span><span>:</span> <span>1</span><span>,</span>
  <span>"b"</span><span>:</span> <span>2</span>
<span>}</span>
```

[Example 2](https://w3c.github.io/did-test-suite/#example-example-javascript-test-file)

: Example javascript test file

```
<span>let</span> { suiteConfig } = <span>global</span>;

<span>if</span> (!suiteConfig) {
  suiteConfig = <span>require</span>(<span>"./defaultSuiteConfig.json"</span>);
}

<span>describe</span>(<span>"test-suite-a"</span>, <span>() =&gt;</span> {
  <span>it</span>(<span>"suite config should have correct name"</span>, <span>async</span> () =&gt; {
    <span>expect</span>(suiteConfig.<span>name</span>).<span>toBe</span>(<span>"test-suite-a"</span>);
  });

  <span>it</span>(<span>"a should be 1"</span>, <span>async</span> () =&gt; {
    <span>expect</span>(suiteConfig.<span>a</span>).<span>toBe</span>(<span>1</span>);
  });

  <span>it</span>(<span>"b should be 2"</span>, <span>async</span> () =&gt; {
    <span>expect</span>(suiteConfig.<span>b</span>).<span>toBe</span>(<span>2</span>);
  });
});
```

Test Suites _MUST_ have unique descriptive names.

Note

For the purposes of the DID Core WG, the suite name is assumed to be "did-spec". However, we may choose to add additional test suites, with different names in the future.

Test suites _MAY_ be split into positive and negative cases.

A suite is considered passing when all associated tests are passing.

Normative statements are mapped to one or more tests.

[Example 3](https://w3c.github.io/did-test-suite/#example-example-normative-statement)

: Example normative statement

```
The DID method name MUST be an ASCII lowercase string.
```

[Example 4](https://w3c.github.io/did-test-suite/#example-example-test-of-statement)

: Example test of statement

```
<span>it</span>(<span>'The DID method name MUST be an ASCII lowercase string.'</span>, <span>() =&gt;</span> {
  <span>const</span> method = did.<span>split</span>(<span>':'</span>)[<span>1</span>];
  <span>expect</span>(utils.<span>isAsciiString</span>(method)).<span>toBe</span>(<span>true</span>);
  <span>expect</span>(method.<span>toLowerCase</span>()).<span>toBe</span>(method);
});
```

Tests _SHOULD_ match normative statements in the DID Core.

Tests _SHOULD_ reuse utility functions like `isAsciiString`, or `decodeBase64UrlToString`.

In order to run a test suite, a configuration file must be provided for the test file to be run against.

Multiple suites can be run at once.

For the latest version of this file, please see [latest did spec suite configuration](https://github.com/w3c/did-test-suite/blob/master/packages/did-core-test-server/suites/did-spec/default.json)

[Example 5](https://w3c.github.io/did-test-suite/#did-spec-suite-configuration)

: The current did-spec configuration file

```
  <span>{</span>
  <span>"name"</span><span>:</span> <span>"did-core-suites"</span><span>,</span>
  <span>"suites"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"suite_name"</span><span>:</span> <span>"did-core-properties"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"suite_name"</span><span>:</span> <span>"did-identifier"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"suite_name"</span><span>:</span> <span>"did-production"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"suite_name"</span><span>:</span> <span>"did-resolution"</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"suite_name"</span><span>:</span> <span>"did-url-dereferencing"</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```

Test results are produced by [jest](https://jestjs.io/), with a post processing filter.

Both console and JSON output are provided. The member `suitesReportTerminal` contains encoded captures from standard out and error, and can be safely ignored.

Following is an example of a raw test suite run result. Latest output is in [3.4 Raw Test Suite Run Result](https://w3c.github.io/did-test-suite/#raw-test-suite-run-result)

[Example 6](https://w3c.github.io/did-test-suite/#example-example-test-results)

: Example test results

```
<span>{</span>
  <span>"suitesReportTerminal"</span><span>:</span> <span>"G1s5OTlEG1tLG1swbRtbN20bWzFtG1szMm0gUEFTUyAbWzM5bRtbMjJtG1syN20bWzBtIBtbMm1zdWl0ZXMvdGVzdC1zdWl0ZS1hLxtbMjJtG1sxbXRlc3Qtc3VpdGUtYS5zcGVjLmpzG1syMm0KICB0ZXN0LXN1aXRlLWEKICAgIBtbMzJt4pyTG1szOW0gG1sybXN1aXRlIGNvbmZpZyBzaG91bGQgaGF2ZSBjb3JyZWN0IG5hbWUgKDEgbXMpG1syMm0KICAgIBtbMzJt4pyTG1szOW0gG1sybWEgc2hvdWxkIGJlIDEbWzIybQogICAgG1szMm3inJMbWzM5bSAbWzJtYiBzaG91bGQgYmUgMhtbMjJtCgobWzk5OUQbW0sbWzFtVGVzdCBTdWl0ZXM6IBtbMjJtG1sxbRtbMzJtMSBwYXNzZWQbWzM5bRtbMjJtLCAxIHRvdGFsChtbMW1UZXN0czogICAgICAgG1syMm0bWzFtG1szMm0zIHBhc3NlZBtbMzltG1syMm0sIDMgdG90YWwKG1sxbVNuYXBzaG90czogICAbWzIybTAgdG90YWwKG1sxbVRpbWU6G1syMm0gICAgICAgIDAuODk5IHMsIGVzdGltYXRlZCAxIHMKG1sybVJhbiBhbGwgdGVzdCBzdWl0ZXMbWzIybRtbMm0uG1syMm0KG1s5OTlEG1tLG1s5OTlEG1tLG1swbRtbN20bWzFtG1szMm0gUEFTUyAbWzM5bRtbMjJtG1syN20bWzBtIBtbMm1zdWl0ZXMvdGVzdC1zdWl0ZS1iLxtbMjJtG1sxbXRlc3Qtc3VpdGUtYi5zcGVjLmpzG1syMm0KICB0ZXN0LXN1aXRlLWIKICAgIBtbMzJt4pyTG1szOW0gG1sybXN1aXRlIGNvbmZpZyBzaG91bGQgaGF2ZSBjb3JyZWN0IG5hbWUbWzIybQogICAgG1szMm3inJMbWzM5bSAbWzJteCBzaG91bGQgYmUgMyAoMSBtcykbWzIybQogICAgG1szMm3inJMbWzM5bSAbWzJteSBzaG91bGQgYmUgNBtbMjJtCgobWzk5OUQbW0sbWzFtVGVzdCBTdWl0ZXM6IBtbMjJtG1sxbRtbMzJtMSBwYXNzZWQbWzM5bRtbMjJtLCAxIHRvdGFsChtbMW1UZXN0czogICAgICAgG1syMm0bWzFtG1szMm0zIHBhc3NlZBtbMzltG1syMm0sIDMgdG90YWwKG1sxbVNuYXBzaG90czogICAbWzIybTAgdG90YWwKG1sxbVRpbWU6G1syMm0gICAgICAgIDAuMTQzIHMsIGVzdGltYXRlZCAxIHMKG1sybVJhbiBhbGwgdGVzdCBzdWl0ZXMbWzIybRtbMm0uG1syMm0KG1swbRtbN20bWzFtG1szMm0gUEFTUyAbWzM5bRtbMjJtG1syN20bWzBtIBtbMm1zdWl0ZXMvaXNzdWVyLWFwaS8bWzIybRtbMW1pc3N1ZXItYXBpLnNwZWMuanMbWzIybQogIGlzc3Vlci1hcGkKICAgIBtbMzJt4pyTG1szOW0gG1sybXN1aXRlIGNvbmZpZyBzaG91bGQgaGF2ZSBjb3JyZWN0IG5hbWUbWzIybQogICAgG1szMm3inJMbWzM5bSAbWzJtZW5kcG9pbnQgbXVzdCBjb250YWluIC9pc3N1ZS9jcmVkZW50aWFscxtbMjJtCiAgICAbWzMybeKckxtbMzltIBtbMm12ZXJpZmljYXRpb25NZXRob2RzIG11c3QgYmUgZ3JlYXRlciB0aGFuIDEgKDEgbXMpG1syMm0KICAgIBtbMzJt4pyTG1szOW0gG1sybWNyZWRlbnRpYWxzIG11c3QgYmUgYXQgbGVhc3QgMRtbMjJtCiAgICAbWzMybeKckxtbMzltIBtbMm1jYW4gaXNzdWUgYWxsIGNyZWRlbnRpYWxzIGZyb20gYWxsIHZlcmlmaWNhdGlvbk1ldGhvZHMgKDY0NCBtcykbWzIybQoKG1s5OTlEG1tLG1sxbVRlc3QgU3VpdGVzOiAbWzIybRtbMW0bWzMybTEgcGFzc2VkG1szOW0bWzIybSwgMSB0b3RhbAobWzFtVGVzdHM6ICAgICAgIBtbMjJtG1sxbRtbMzJtNSBwYXNzZWQbWzM5bRtbMjJtLCA1IHRvdGFsChtbMW1TbmFwc2hvdHM6ICAgG1syMm0wIHRvdGFsChtbMW1UaW1lOhtbMjJtICAgICAgICAwLjk3OCBzLCBlc3RpbWF0ZWQgNCBzChtbMm1SYW4gYWxsIHRlc3Qgc3VpdGVzG1syMm0bWzJtLhtbMjJtCg=="</span><span>,</span>
  <span>"suitesReportJson"</span><span>:</span> <span>[</span>
    <span>{</span>
      <span>"suite"</span><span>:</span> <span>"test-suite-a"</span><span>,</span>
      <span>"testResults"</span><span>:</span> <span>[</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-a"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"suite config should have correct name"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span><span>,</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-a"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"a should be 1"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span><span>,</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-a"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"b should be 2"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span>
      <span>]</span>
    <span>}</span><span>,</span>
    <span>{</span>
      <span>"suite"</span><span>:</span> <span>"test-suite-b"</span><span>,</span>
      <span>"testResults"</span><span>:</span> <span>[</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-b"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"suite config should have correct name"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span><span>,</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-b"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"x should be 3"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span><span>,</span>
        <span>{</span>
          <span>"ancestors"</span><span>:</span> <span>[</span><span>"test-suite-b"</span><span>]</span><span>,</span>
          <span>"title"</span><span>:</span> <span>"y should be 4"</span><span>,</span>
          <span>"status"</span><span>:</span> <span>"passed"</span>
        <span>}</span>
      <span>]</span>
    <span>}</span>
  <span>]</span>
<span>}</span>
```
