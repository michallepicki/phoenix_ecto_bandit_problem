defmodule HelloWeb.ThingJSON do
  alias Hello.Some.Thing

  @doc """
  Renders a list of things.
  """
  def index(%{things: things}) do
    %{data: for(thing <- things, do: data(thing))}
  end

  @doc """
  Renders a single thing.
  """
  def show(%{thing: thing}) do
    %{data: data(thing)}
  end

  defp data(%Thing{} = thing) do
    %{
      id: thing.id,
      name: thing.name
    }
  end
end
