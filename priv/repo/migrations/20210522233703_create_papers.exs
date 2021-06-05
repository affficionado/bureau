defmodule Bureau.Repo.Migrations.CreatePapers do
  use Ecto.Migration

  def change do
    create table("papers") do
      add :arxiv_id, :string
      add :status, :string
      add :title, :string
      add :date, :date
      add :toc, :string
      add :body, :string
      add :links, :string
      add :styles, :string
      add :scripts, :string

      timestamps()
    end

    create unique_index(:papers, [:arxiv_id])
  end
end
