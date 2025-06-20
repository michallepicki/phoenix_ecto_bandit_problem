defmodule Hello.SomeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Some` context.
  """

  @doc """
  Generate a thing.
  """
  def thing_fixture(attrs \\ %{}) do
    {:ok, thing} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Hello.Some.create_thing()

    thing
  end
end
