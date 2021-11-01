defmodule MapleTreeWeb.Components.GenericCard do
  import Phoenix.LiveView.Helpers
  

  @spec generic_card(%{
    id: String.t(),
    name: String.t(),
    image_url: String.t(),
    color: String.t(),
    description: String.t(),
    render_arrow: Bool.t()
  }) :: Phoenix.LiveView.Rendered.t()
  def generic_card(assigns) do
    ~H"""
      <div class="group_card">
        <div class="h-full w-3 flex-shrink-0" style={"background-color: "<>@color}></div>
        <div class="flex flex-grow items-center py-6 mx-2 h-full">
        <%= #<img src="https://pbs.twimg.com/media/EXMrwZuUcAAnv5p.png:small" alt="lable" class="group_card__image"> %>
          <.live_component module={MapleTreeWeb.Components.Thumbnail} id={@id<>"__thumbnail"} name={@name} color={@color} image={Map.get(assigns, :image_url)} />
          <div class="flex flex-col flex-grow justify-center items-start mx-2 h-full">
            <h3 class="text-xl font-bold"> <%= @name %> </h3>
            <%= if description = Map.get(assigns, :description) do %>
              <p class="group_card__description faded"> <%= description %> </p>
            <% end %>
          </div>
          <%= if Map.get(assigns, :render_arrow, false) do %>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 faded flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          <% end %>
        </div>
      </div>
    """  
  end 
end
