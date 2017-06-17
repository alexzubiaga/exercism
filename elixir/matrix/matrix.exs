defmodule Matrix do
  defstruct width: 0, data: []

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    data =
      input
      |> String.split(~r/[ \n]/)
      |> Stream.map(&Integer.parse/1)
      |> Enum.map(fn {i, ""} -> i end)

    height =
      input
      |> String.split(~r/\n/)
      |> Enum.count()

    width =
      data
      |> Enum.count()
      |> div(height)

    %Matrix{width: width, data: data}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{width: width, data: data}) do
    data
    |> Enum.map(&Integer.to_string/1)
    |> Enum.chunk(width)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{width: width, data: data}) do
    data
    |> Enum.chunk(width)
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{width: width, data: data}, index) do
    data
    |> Enum.slice(index * width, width)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{width: width, data: data}) do
    data
    |> Stream.with_index(1)
    |> Enum.group_by(
      fn {idx, _} -> rem(idx - 1, width) end,
      fn {_, item} -> item end)
    |> Enum.map(fn {_, col} -> col end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{width: width, data: data}, index) do
    data
    |> Stream.drop(index)
    |> Enum.take_every(width)
  end
end
