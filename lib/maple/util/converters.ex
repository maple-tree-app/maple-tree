defmodule MapleTree.Util.Converters do
  def string_to_boolean(str) do
    case str do
      "true" -> true
      "false" -> false
      _ -> raise ArgumentError, message: "string is not a boolean"
    end
  end
end
