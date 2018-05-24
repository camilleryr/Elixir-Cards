defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck returns 20 cards" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 20
  end

  test "create_hand returns the correct number of cards in the hand" do
    {hand, deck} = Cards.create_hand(5)
    assert length(hand) == 5
    assert length(deck) == 15
  end

  test "shuffle randomizes deck" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end

end
