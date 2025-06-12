defmodule DIDTest do
  use ExUnit.Case
  doctest DID

  alias DID.TestNamespaces.EX

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
end
