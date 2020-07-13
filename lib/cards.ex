defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of string representing a deck of playing cards

  ## Example
  iex> deck = Cards.create_deck
  iex> length(deck) == 20
  true
  """
  @spec create_deck :: [String.t()]
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    for value <- values, suit <- suits, do: "#{value} of #{suit}"
  end



  @doc """
  Pass a deck that is a list of string, and shuffle function will return a random deck

  ## Example
  iex(4)> deck = Cards.create_deck
  iex(5)> deck != Cards.shuffle(deck)
  true
  """
  @spec shuffle(list(String.t())) :: [String.t()]
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card

  ## Examples
  iex> deck = Cards.create_deck
  iex> Cards.contains?(deck, "Ace of Spades")
  true
  """
  @spec contains?(list(), String.t()) :: boolean
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples
  iex> deck = Cards.create_deck
  iex> {hand, deck} = Cards.deal(deck, 1)
  iex> hand
  ["Ace of Spades"]
  """
  @spec deal(list(), pos_integer()) :: {[any()], [any()]}
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  it saves a deck into the binary file

  ## Example
  iex> deck = Cards.create_deck
  iex> Cards.save(deck, "filename") == :ok
  true
  """
  @spec save([String.t()], String.t()) :: {:ok, String.t()} | {:error, atom}
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  it loads a binary deck file

  ## Example
    iex(2)> deck = Cards.create_deck
    iex> filename = "file"
    iex(3)> Cards.save(deck, filename)
    :ok
    iex(4)> length(Cards.load(filename)) == 20
    true
  """
  @spec load(any) :: any
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exists"
    end
  end


  @doc """
  Returns a hand passing the number desired, and the rest of the deck

  ## Example
  iex> {hand, rest} = Cards.create_hand(5)
  iex> length(hand)
  5
  iex> length(rest)
  15
  """
  @spec create_hand(pos_integer) :: {[any], [any]}
  def create_hand(hand_size) do
    Cards.create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
