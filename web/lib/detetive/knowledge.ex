defmodule Detetive.Knowledge do
  @moduledoc """
  The Knowledge context.
  """

  import Ecto.Query, warn: false
  alias Detetive.Repo

  alias Detetive.Knowledge.Politician

  @doc """
  Returns the list of politicians.

  ## Examples

      iex> list_politicians()
      [%Politician{}, ...]

  """
  def list_politicians do
    Repo.all(Politician)
  end

  @doc """
  Gets a single politician.

  Raises `Ecto.NoResultsError` if the Politician does not exist.

  ## Examples

      iex> get_politician!(123)
      %Politician{}

      iex> get_politician!(456)
      ** (Ecto.NoResultsError)

  """
  def get_politician!(id), do: Repo.get!(Politician, id)

  @doc """
  Creates a politician.

  ## Examples

      iex> create_politician(%{field: value})
      {:ok, %Politician{}}

      iex> create_politician(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_politician(attrs \\ %{}) do
    %Politician{}
    |> Politician.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a politician.

  ## Examples

      iex> update_politician(politician, %{field: new_value})
      {:ok, %Politician{}}

      iex> update_politician(politician, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_politician(%Politician{} = politician, attrs) do
    politician
    |> Politician.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a politician.

  ## Examples

      iex> delete_politician(politician)
      {:ok, %Politician{}}

      iex> delete_politician(politician)
      {:error, %Ecto.Changeset{}}

  """
  def delete_politician(%Politician{} = politician) do
    Repo.delete(politician)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking politician changes.

  ## Examples

      iex> change_politician(politician)
      %Ecto.Changeset{data: %Politician{}}

  """
  def change_politician(%Politician{} = politician, attrs \\ %{}) do
    Politician.changeset(politician, attrs)
  end
end
