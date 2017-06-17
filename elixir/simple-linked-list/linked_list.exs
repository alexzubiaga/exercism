defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new :: t
  def new do
    {:list, 0, :empty_list}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({:list, n, tail}, elem) do
    {:list, n + 1, {elem, tail}}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({:list, n, _}) do
    n
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({:list, 0, _}), do: true
  def empty?({:list, _, _}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({:list, 0, _}), do: {:error, :empty_list}
  def peek({:list, _, {elem, _}}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({:list, 0, _}), do: {:error, :empty_list}
  def tail({:list, n, {_, tail}}), do: {:ok, {:list, n - 1, tail}}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({:list, 0, _}), do: {:error, :empty_list}
  def pop({:list, n, {x, xs}}), do: {:ok, x, {:list, n - 1, xs}}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({:list, _, list}), do: rec_to_list(list, [])

  defp rec_to_list(:empty_list, list), do: Enum.reverse list
  defp rec_to_list({x, xs}, list), do: rec_to_list(xs, [x | list])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse({:list, n, list}), do: {:list, n, rec_reverse(list, :empty_list)}

  defp rec_reverse(:empty_list, list), do: list
  defp rec_reverse({x, xs}, list), do: rec_reverse(xs, {x, list})
end
