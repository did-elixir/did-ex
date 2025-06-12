# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- `mix test` - Run all tests
- `mix test test/did_test.exs` - Run specific test file
- `mix deps.get` - Install dependencies
- `mix compile` - Compile the project
- `mix docs` - Generate documentation

## Project Goals

DID.ex is an implementation of the W3C DID Core 1.0 specification as a standalone Hex package that provides a foundational framework for DID method implementations. It aims to pass as many tests as possible from the official W3C test suites while including at least one simple reference method implementation. Method implementations requiring heavy dependencies should be implemented as separate packages to keep the core lightweight and focused.

The library emphasizes standards compliance, interoperability and extensibility.

## Relevant Specifications

Key specifications are documented in `kb/`:
- **DID Core 1.0** (`kb/did-1.0-spec.md`) - Core DID specification
- **DID Resolution 0.3** (`kb/did-resolution-0.3.md`) - DID resolution protocol
- **DID Implementation Guide 1.0** (`kb/did-implementation-guide-1.0.md`) - Implementation guidance
- **DID Extensions** (`kb/did-extensions.md`) - Extension specifications
- **DID Document Property Extensions** (`kb/did-document-property-extensions.md`) - Property extensions
- **DID Resolution Extensions** (`kb/did-resolution-extensions.md`) - Resolution extensions

## Project Architecture

This is an Elixir library for working with DID (Decentralized Identifiers) documents, built on top of the RDF.ex ecosystem using Grax schemas for RDF-to-struct mapping.

### Core Components

- **DID.Document** (`lib/did/document.ex`) - Main DID document schema using Grax, defines the structure of a DID document with properties like `verification_method`, `authentication`, `service`, etc.
- **DID.VerificationMethod** (`lib/did/verification_method.ex`) - Schema for cryptographic verification methods with properties like `controller`, `type`, `public_key_jwk`, `public_key_multibase`
- **DID.Service** (`lib/did/service.ex`) - Schema for service endpoints in DID documents
- **DID.NS** (`lib/did/ns.ex`) - RDF vocabulary namespaces for DID Core and Security vocabularies loaded from TTL files in `priv/vocabs/`
- **DID.JsonLdHelper** (`lib/did/json_ld_helper.ex`) - Helper for converting RDF graphs to JSON-LD format, uses external `jsonld` CLI tool via Exile

### Key Dependencies

- **Grax** - RDF-to-struct mapping library for schema definitions
- **RDF.ex** - Core RDF functionality and data structures  
- **JSON-LD.ex** - JSON-LD processing and serialization

### Development Setup Notes

- The project uses a custom `rdf_ex_dep/2` function in `mix.exs` that allows switching between local, GitHub, and Hex versions of RDF.ex packages via the `RDF_EX_PACKAGES_SRC` environment variable
- Vocabulary files are stored in `priv/vocabs/` as TTL files and loaded via `defvocab` macros
- The main `DID` module acts as a namespace proxy to `DID.NS.DID` using `act_as_namespace`

### Testing

- Tests use ExUnit with doctests enabled
- Prefer `==` comparisons with expected on right side
- Pattern matching only when exact comparison is impractical

## Development Guidelines

- All code, including documentation, is written in English
- Keep TODO comments unless resolved
- Minimal, focused documentation (document "why" not "what")
- Use hyphens for documentation lists
- Commits: Capital letter, verb start, <80 chars
- CHANGELOG entries follow "Keep a CHANGELOG" conventions