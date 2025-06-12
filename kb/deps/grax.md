# Grax Knowledge Base - Complete Guide

## Overview

Grax is a lightweight graph data mapper for Elixir that maps RDF (Resource Description Framework) graph data from RDF.ex data structures to schema-conform Elixir structs. It provides a bridge between the semantic web's RDF data model and Elixir's functional programming paradigms.

### Key Features
- Maps RDF graphs to Elixir structs and vice versa
- Schema-based mapping with type validation
- Support for both data properties (literals) and link properties (relationships)
- Preloading strategies for nested data
- Custom mapping functions
- Schema inheritance and polymorphism
- Built on top of RDF.ex

### Current Limitations
- Only works with in-memory RDF.ex graphs
- No direct SPARQL query capabilities
- No triple store integration (must use RDF.ex serializers or SPARQL.Client)
- Limited to basic depth preloading strategy

## Installation

Add Grax to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:grax, "~> 0.5"}
  ]
end
```

## Core Concepts

### Grax Schema
A Grax schema is an Elixir struct that defines how RDF data maps to Elixir values. It's similar to Ecto schemas but for graph data instead of relational data.

### Basic Structure
Every Grax schema struct contains:
- `__id__`: The RDF.IRI or RDF.BlankNode identifying the resource
- `__additional_statements__`: Map containing RDF statements not covered by the schema
- User-defined properties and links

### Property Types
1. **Data Properties**: Map to simple Elixir values (strings, integers, etc.)
2. **Link Properties**: Map to other Grax schema structs (relationships)
3. **Custom Fields**: Elixir-only fields not mapped to RDF

## Basic Schema Definition

```elixir
defmodule User do
  use Grax.Schema

  alias NS.{SchemaOrg, FOAF}

  schema SchemaOrg.Person do
    # Data properties
    property :name, SchemaOrg.name, type: :string, required: true
    property :emails, SchemaOrg.email, type: list_of(:string), required: true
    property :age, FOAF.age, type: :integer
    
    # Link properties
    link :friends, FOAF.friend, type: list_of(User)
    link :posts, -SchemaOrg.author, type: list_of(Post)
    
    # Custom fields
    field :password
  end
end
```

### Schema Declaration Syntax
```elixir
# Basic schema
schema do
  # properties...
end

# With class declaration
schema SchemaOrg.Person do
  # properties...
end

# With inheritance
schema inherit: ParentSchema do
  # properties...
end

# With class and inheritance
schema SchemaOrg.Customer < User do
  # properties...
end
```

## Data Properties

### Supported Datatypes

| Grax Type | RDF.ex Datatype | Elixir Type |
|-----------|-----------------|-------------|
| `:string` | `RDF.XSD.String` | String |
| `:integer` | `RDF.XSD.Integer` | Integer |
| `:boolean` | `RDF.XSD.Boolean` | Boolean |
| `:float` | `RDF.XSD.Float` | Float |
| `:double` | `RDF.XSD.Double` | Float |
| `:decimal` | `RDF.XSD.Decimal` | Decimal |
| `:date` | `RDF.XSD.Date` | Date |
| `:date_time` | `RDF.XSD.DateTime` | DateTime |
| `:time` | `RDF.XSD.Time` | Time |
| `:any_uri` | `RDF.XSD.AnyURI` | URI |
| `:json` | `rdf:JSON` | Any JSON-serializable value |
| `:iri` | - | RDF.IRI (keeps IRIs as-is) |
| `:any` | - | Any datatype (default) |
| `:numeric` | - | Any numeric datatype |

### Property Definition Syntax

```elixir
# Full syntax
property :name, SchemaOrg.name, type: :string, required: true, default: nil

# Concise syntax
property name: SchemaOrg.name, type: :string, required: true

# With list types
property emails: SchemaOrg.email, type: list_of(:string)
property phones: SchemaOrg.telephone, type: ordered_list_of(:string)

# With cardinalities
property tags: EX.tag, type: list_of(:string, card: {:min, 1})
property categories: EX.category, type: list_of(:string, card: 1..5)
property exact_items: EX.item, type: list_of(:string, card: 3)
```

### Special Datatypes

#### JSON Type
```elixir
property config: EX.configuration, type: :json

# Maps to:
%Example{
  config: %{
    "server" => "example.com",
    "port" => 8080,
    "features" => ["a", "b", "c"],
    "debug" => true,
    "timeout" => :null  # JSON null as direct value
  }
}
```

#### Ordered Lists
```elixir
property steps: EX.step, type: ordered_list_of(:string)
# Creates RDF lists that preserve order and duplicates
```

## Link Properties

### Basic Link Definition
```elixir
# Single link
link :author, SchemaOrg.author, type: User

# Multiple links
link :friends, FOAF.friend, type: list_of(User)

# Concise syntax
link author: SchemaOrg.author, type: User
```

### Inverse Properties
```elixir
# Use minus sign for inverse properties
link posts: -SchemaOrg.author, type: list_of(Post)
# This finds posts where the current user is the author
```

### Union Links
```elixir
link content: SchemaOrg.mainEntity, type: list_of(%{
  SchemaOrg.BlogPosting => Post,
  SchemaOrg.Comment => Comment,
  nil => GenericContent  # fallback for untyped resources
})
```

### Link Options
```elixir
link :address, SchemaOrg.address, 
     type: Address,
     depth: 2,                           # preloading depth
     on_missing_description: :use_rdf_node,  # or :create_empty
     on_rdf_type_mismatch: :force,       # :ignore, :error
     polymorphic: true                   # allow inherited schemas
```

## Preloading

### Depth Preloading
```elixir
# Default depth: 1 (load immediate properties and links, but not nested links)
link :posts, -SchemaOrg.author, type: list_of(Post)

# Specific depth from root
link :posts, -SchemaOrg.author, type: list_of(Post), depth: 2

# Additive depth (relative to current level)
link :country, SchemaOrg.addressCountry, type: Country, depth: +1

# Schema-wide depth
defmodule Address do
  use Grax.Schema, depth: +1
  # All links in this schema use additive depth +1
end
```

### Preloading Behavior
- **Depth 0**: Only data properties, links contain RDF nodes
- **Depth 1**: Data properties + immediate linked resources (data properties only)
- **Depth 2+**: Recursive preloading to specified depth
- **Additive depths**: Override parent depth constraints

## API Reference

### Loading from RDF

```elixir
# Load with explicit schema
{:ok, user} = Grax.load(graph, EX.User1, User)
{:ok, user} = User.load(graph, EX.User1)

# Auto-detect schema from rdf:type
{:ok, user} = Grax.load(graph, EX.User1)

# Bang variants (no validation by default)
user = Grax.load!(graph, EX.User1, User)
user = User.load!(graph, EX.User1)

# With options
{:ok, user} = User.load(graph, EX.User1, depth: 2, validate: true)
```

### Building from Scratch

```elixir
# Empty struct
{:ok, user} = User.build(EX.User1)
user = User.build!(EX.User1)

# With initial values
user = User.build!(EX.User1, 
  name: "John", 
  emails: ["john@example.com"],
  age: 30
)

# Using Grax module
{:ok, user} = Grax.build(User, EX.User1, name: "John")
```

### Updating Structs

```elixir
# Set single property
{:ok, user} = Grax.put(user, :age, 42)
user = Grax.put!(user, :age, 42)

# Set multiple properties
user = Grax.put!(user, name: "Jane", age: 25)

# Schema-aware updates (converts single values to lists where needed)
user = Grax.put!(user, :emails, "new@example.com")  # Becomes ["new@example.com"]

# Set nested structs
user = Grax.put!(user, :posts, Post.build!(EX.Post1, title: "Hello"))

# Set with maps (requires __id__ or auto-generated ID)
user = Grax.put!(user, :posts, %{__id__: EX.Post1, title: "Hello"})

# Set with RDF nodes (for lazy loading)
user = Grax.put!(user, :posts, EX.Post1)
```

### Validation

```elixir
# Validate struct against schema
case Grax.validate(user) do
  {:ok, user} -> # valid
  {:error, %Grax.ValidationError{errors: errors}} -> # invalid
end

# Validation checks:
# - Required properties present
# - Type constraints
# - Cardinality constraints
```

### Preloading

```elixir
# Check if preloaded
Grax.preloaded?(user, :posts)  # specific property
Grax.preloaded?(user)          # all properties

# Manual preloading
{:ok, user} = Grax.preload(user, graph, depth: 2)
```

### Mapping to RDF

```elixir
# Convert to RDF graph
{:ok, graph} = Grax.to_rdf(user)

# With graph options (passed to RDF.Graph.new/2)
{:ok, graph} = Grax.to_rdf(user, name: EX.MyGraph, prefixes: [ex: EX])
```

### Additional Statements

```elixir
# Access additional statements
description = Grax.additional_statements(user)

# Add additional statements
user = Grax.add_additional_statements(user, %{RDFS.comment() => "A comment"})

# Set additional statements (replaces existing)
user = Grax.put_additional_statements(user, statements)

# Delete specific statements
user = Grax.delete_additional_statements(user, %{RDFS.comment() => "Old comment"})

# Delete all statements for predicates
user = Grax.delete_additional_predicates(user, [RDFS.comment()])

# Clear all additional statements
user = Grax.clear_additional_statements(user)
```

### Schema Conversion

```elixir
# Convert between schemas (via RDF roundtrip)
{:ok, customer} = Customer.from(user)
```

## Advanced Features

### Schema Inheritance

```elixir
defmodule User do
  use Grax.Schema
  
  schema SchemaOrg.Person do
    property name: SchemaOrg.name, type: :string, required: true
    property emails: SchemaOrg.email, type: list_of(:string)
  end
end

defmodule Customer do
  use Grax.Schema
  
  # Inherit all properties from User
  schema EX.Customer < User do
    property since: EX.customerSince, type: :date
    link subscription: EX.subscription, type: Subscription
  end
end

# Multiple inheritance
schema EX.PremiumCustomer < [Customer, PremiumUser] do
  # properties...
end
```

### Custom Mappings

#### Property Mapping Functions
```elixir
defmodule User do
  use Grax.Schema
  
  schema SchemaOrg.Person do
    property customer_type: RDF.type,
             from_rdf: :customer_type_from_rdf,
             to_rdf: :customer_type_to_rdf
  end
  
  # from_rdf(values, description, graph) -> {:ok, mapped_value} | {:error, reason}
  def customer_type_from_rdf(types, _description, _graph) do
    if EX.PremiumUser in types do
      {:ok, :premium_user}
    else
      {:ok, :regular_user}
    end
  end
  
  # to_rdf(value, struct) -> {:ok, rdf_values} | {:ok, rdf_values, additional_statements} | {:error, reason}
  def customer_type_to_rdf(:premium_user, _user), do: {:ok, EX.PremiumUser}
  def customer_type_to_rdf(:regular_user, _user), do: {:ok, EX.RegularUser}
  def customer_type_to_rdf(_, _), do: {:ok, nil}
end

# External mapping functions
property customer_type: RDF.type,
         from_rdf: {MyMappings, :customer_type_from_rdf},
         to_rdf: {MyMappings, :customer_type_to_rdf}
```

#### Callbacks
```elixir
defmodule User do
  use Grax.Schema
  
  schema SchemaOrg.Person do
    property name: SchemaOrg.name, type: :string
    field :computed_field
  end
  
  # on_load(struct, graph_or_description, opts) -> {:ok, updated_struct} | {:error, reason}
  def on_load(user, graph, _opts) do
    computed_value = compute_something(user, graph)
    {:ok, %{user | computed_field: computed_value}}
  end
  
  # on_to_rdf(struct, graph, opts) -> {:ok, updated_graph} | {:error, reason}
  def on_to_rdf(user, graph, _opts) do
    additional_statements = generate_additional_statements(user)
    {:ok, RDF.Graph.add(graph, additional_statements)}
  end
end
```

### Cardinalities

```elixir
# Required single value
property name: SchemaOrg.name, type: :string, required: true

# Required list (at least one value)
property emails: SchemaOrg.email, type: list_of(:string), required: true
# Equivalent to:
property emails: SchemaOrg.email, type: list_of(:string, card: {:min, 1})

# Exact cardinality
property tags: EX.tag, type: list_of(:string, card: 3)

# Range cardinality
property categories: EX.category, type: list_of(:string, card: 1..5)

# Minimum cardinality
property items: EX.item, type: list_of(:string, card: {:min, 2})
```

## Best Practices

### Namespace Management
```elixir
# Define vocabulary namespaces
defmodule NS do
  use RDF.Vocabulary.Namespace
  
  defvocab EX, base_iri: "http://example.com/", terms: [:User, :Post, :name]
  defvocab SchemaOrg, base_iri: "https://schema.org/", file: "schema_org.ttl"
end

# Use aliases in schemas
defmodule User do
  use Grax.Schema
  
  alias NS.{SchemaOrg, FOAF, EX}
  
  schema SchemaOrg.Person do
    property name: SchemaOrg.name, type: :string
  end
end
```

### Error Handling
```elixir
# Always handle load errors
case User.load(graph, EX.User1) do
  {:ok, user} -> 
    # Process user
  {:error, %Grax.ValidationError{errors: errors}} ->
    # Handle validation errors
  {:error, reason} ->
    # Handle other errors
end

# Use bang variants only when errors are unexpected
user = User.load!(graph, EX.User1)  # May raise
```

### Preloading Strategy
```elixir
# Be explicit about preloading needs
link posts: -SchemaOrg.author, 
     type: list_of(Post), 
     depth: 2  # If you need nested data

# Use additive depths for consistent nested loading
defmodule Address do
  use Grax.Schema, depth: +1
  
  schema SchemaOrg.PostalAddress do
    link country: SchemaOrg.addressCountry, type: Country
  end
end
```

### Validation Strategy
```elixir
# Load without validation for form processing
user = User.load!(graph, EX.User1, validate: false)

# Validate before saving
case Grax.validate(user) do
  {:ok, valid_user} -> save_to_store(valid_user)
  {:error, errors} -> show_form_errors(errors)
end
```

## Troubleshooting

### Common Issues

1. **Validation Errors**: Check required properties and type constraints
2. **Preloading Issues**: Verify depth settings and circular references
3. **Missing Data**: Check if RDF contains expected properties
4. **Type Mismatches**: Ensure RDF datatypes match schema expectations

### Debugging Tips

```elixir
# Inspect additional statements for unmapped data
IO.inspect(user.__additional_statements__)

# Check what's in the graph
IO.inspect(RDF.Graph.subjects(graph))
IO.inspect(RDF.Graph.description(graph, EX.User1))

# Validate schemas step by step
{:ok, user} = User.load(graph, EX.User1, validate: false)
case Grax.validate(user) do
  {:error, %Grax.ValidationError{errors: errors}} ->
    IO.inspect(errors, label: "Validation errors")
end
```

