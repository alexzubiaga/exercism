defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> extract_number()
    |> (fn {areacode, exchangecode, subscribernumber} -> areacode <> exchangecode <> subscribernumber end).()
  end

  @invalidnumber "0000000000"

  defp extract_number(raw) do
    ~r/[\W]/
    |> Regex.replace(raw, "")
    |> no_letters()
    |> match_length()
    |> parse_number()
    
  end

  defp no_letters(raw) do
    if ~r/[a-zA-Z]/ |> Regex.match?(raw) do
      @invalidnumber
    else
      raw
    end
  end

  defp match_length(<<raw::bytes-size(10)>>), do: raw
  defp match_length("1" <> <<raw::bytes-size(10)>>), do: raw
  defp match_length(_), do: @invalidnumber

  defp parse_number("2" <> <<_::bytes-size(2)>> <> <<ecprefix::bytes-size(1)>> <> <<_::bytes-size(2)>> <> <<_::bytes-size(4)>>) when ecprefix in ["1", "0"] do
    parse_number(@invalidnumber)
  end

  defp parse_number("2" <> <<areacode::bytes-size(2)>> <> <<exchangecode::bytes-size(3)>> <> <<subscribernumber::bytes-size(4)>>) do
    {"2" <> areacode, exchangecode, subscribernumber}
  end

  defp parse_number("1" <> <<rest::bytes-size(10)>>) do
    parse_number(rest)
  end

  defp parse_number(_) do
    {"000", "000", "0000"}
  end



  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    {areacode, _ ,_} = extract_number(raw)
    areacode
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    {areacode, exchangecode, subscribernumber} = extract_number(raw)
    "(#{areacode}) #{exchangecode}-#{subscribernumber}"
  end
end
