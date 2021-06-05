defmodule Bureau.Paper do
  use Ecto.Schema
  import Ecto.Changeset

  schema "papers" do
    field :arxiv_id, :string
    field :status, :string
    field :title, :string
    field :date, :date
    field :toc, :string
    field :body, :string
    field :links, :string
    field :styles, :string
    field :scripts, :string

    timestamps()
  end

  @doc false
  def changeset(paper, attrs) do
    paper
    |> cast(attrs, [:arxiv_id, :status, :title, :date, :toc, :body, :links, :styles, :scripts])
    |> validate_required([:arxiv_id, :status, :title])
    |> unique_constraint(:arxiv_id)
  end
end
