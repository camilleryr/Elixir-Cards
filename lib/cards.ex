defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Retruns a collection of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits,
        value <- values do
      "#{value} of #{suit}"
    end
  end


  @doc """
  Takes in a deck of cards and returns a new deck in a random order
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Takes a collection of cards and a single card and checks the collection for the exsistence of the single

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Five of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  
  @doc """
  Returns a list of cards as dictated by the `hand_size` and a collection of the remaining cards in the deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  
  @doc """
  Takes in a collection of cards and a file name and saves the collection to the file sysytem
  """
  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  @doc """
  Takes in a file name and loads the collection of cards from the file, or returns an error
  """
  def load(file_name) do
    File.read(file_name)
    |> parse_load
  end

  @doc """
  Private function for reading file from the file system if File.read returns :ok
  """
  defp parse_load({:ok, binary}) do
    :erlang.binary_to_term(binary)
  end

  @doc """
  Private function for reading file from the file system if File.read returns :error
  """
  defp parse_load({:error, _reason}) do
    "That file does not exist"
  end

  @doc """
  Takes an integer value that dictates the numbe of cards you wish to receive - creates a new deck, shuffles the deck into a random order,
  and returns a tuple {hand, remaining_deck}
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
