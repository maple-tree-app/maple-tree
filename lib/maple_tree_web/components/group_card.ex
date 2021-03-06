defmodule MapleTreeWeb.Components.GroupCard do
  import Phoenix.LiveView.Helpers

  def group_card(assigns) do
    ~H"""
      <div class="group_card">
        <div class="h-full w-3 flex-shrink-0" style={"background-color: "<>@group.color}></div>
        <div class="flex flex-grow items-center py-6 mx-2 h-full">
        <%= #<img src="https://pbs.twimg.com/media/EXMrwZuUcAAnv5p.png:small" alt="lable" class="group_card__image"> %>
          <.live_component module={MapleTreeWeb.Components.Thumbnail}
            id={@group.id<>"__thumbnail"}
            class="group_card__image"
            name={@group.name}
            color={@group.color}
            image={@group.image_url} />
          <div class="flex flex-col flex-grow justify-center items-start mx-2 h-full">
            <h3 class="text-xl font-bold"> <%= @group.name %> </h3>
            <%= if @group.description do %>
              <p class="group_card__description faded"> <%= @group.description %> </p>
            <% end %>
          </div>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 faded flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </div>
      </div>
    """  
  end 
end
