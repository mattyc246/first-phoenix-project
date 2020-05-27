defmodule RumblWeb.VideoView do
  use RumblWeb, :view

  def category_select_options(categories) do
    for category <- categories, do: {category.name, category.id}
  end

  def player_id(video) do
    ~r{^.*(?:youtu\.be/|\w+/|v=)(?<id>[^#&?]*)}
    |> Regex.named_captures(video.url)
    |> get_in(["id"])
  end
end
