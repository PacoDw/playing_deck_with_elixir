defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

  test "contains? checks if the deck contains a specific string" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of Spades")
  end

  test "deal must to divide the deck in two values: 1 and 19" do
    deck = Cards.create_deck()
    {hand, deck} = Cards.deal(deck, 1)
    assert length(hand) == 1 && length(deck) == 19
  end

  test "save generates a file saving a deck" do
    deck = Cards.create_deck()
    assert Cards.save(deck, "archivo")
  end

  test "load reads a saved file that contains a deck" do
    filename = "archivo"
    deck = Cards.create_deck()
    Cards.save(deck, filename)
    assert !List.improper?(Cards.load("archivo"))
  end

  test "create_hand creates a hand with a specific number is passed" do
    {hand, rest} = Cards.create_hand(5)
    assert length(hand) == 5 && length(rest) == 15
  end

end
