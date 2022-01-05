defmodule MapleTreeWeb.Components.ShoppingListDetailsTable do
  import Phoenix.LiveView.Helpers
  import MapleTreeWeb.Components.Icons

  use Phoenix.LiveComponent

  @minimum_rows 20

  def render(assigns) do
    assigns = assign(assigns, :minimum_rows, @minimum_rows)
    ~H"""
    <div class="bg-maple-textbook-bg relative mx-5 font-textbook text-black leading-7 flex">
      <div class="w-full flex">
        <.vertical_line />
        <div class="flex-grow select-none">
          <.header title={@shopping_list.name}/>
          <.item_indicator myself={@myself}/>

          <!-- print items -->
          <%= for item <- @shopping_list.items do %>
            <.item item={item} myself={@myself}/>
          <% end %>
          <.item item={hd @shopping_list.items} myself={@myself} is_expanded={true}/>

          <!-- print blank rows if needed-->
          <%= if iterator = max(0, @minimum_rows - length(@shopping_list.items)) do %>
            <%= for _ <- 0..iterator do %> <.blank_row /> <% end %>
          <% end %>

          <.footer />
        </div>
      </div>
    </div>
    """
  end

  defp item_indicator(assigns) do
    ~H"""
    <div class="flex items-center justify-around z-10 mr-9 pl-2 md:pl-5 uppercase font-bold" phx-click="say_hello" phx-target={@myself}>
      <span class="flex-grow">Item</span>
      <span>Quantity</span>
    </div>
    <hr class="border absolute w-full left-0 border-maple-textbook-horizontal-line" />
    """
  end

  defp item(assigns) do
    ~H"""
    <div class="flex items-center justify-around z-10 pl-2 md:pl-5 cursor-pointer" phx-click="click_collapse" phx-value-id={@item.id} phx-target={@myself}>
      <span class="flex-grow"><%= @item.name %></span>
      <span class=""><%= @item.quantity %></span>
      <div class="flex items-center w-20 justify-end z-20">
        <.interaction_icons class="h-5 w-5 cursor-pointer min-w-min" is_read={Map.get(assigns, :is_expanded, false)}/>
        <div>
          <.collapse_arrow id={#{@item.id}__collapse} class="h-5 w-5 mr-1 cursor-pointer" collapsed?={false}></.collapse_arrow>
        </div>
      </div>
    </div>
    <%= if Map.get(assigns, :is_expanded, false) do %>
      <div class="flex items-center text-sm px-2 md:px-5 lg:px-10">
        <span>com muito sal</span> 
      </div>
    <% end %>
    <hr class="border absolute w-full left-0 border-maple-textbook-horizontal-line" />
    """
  end

  defp header(assigns) do
    ~H"""
    <div class="flex items-center justify-center mt-2 mb-1">
      <h3 class="font-bold text-xl uppercase"> <%= @title%> </h3>
    </div>
    <hr class="border absolute w-full left-0 border-maple-textbook-horizontal-line" />
    """
  end

  defp blank_row(assigns) do
    ~H"""
    <div class="justify-around z-10 px-2 md:px-5">
      <span class="text-transparent">Item</span>
    </div>
    <hr class="border absolute w-full left-0 border-maple-textbook-horizontal-line" />
    """
  end

  defp footer(assigns) do
    ~H"""
    <div class="pt-5"></div>
    """
  end


  defp vertical_line(assigns) do
    ~H"""
    <div class="h-full w-1/12 hidden sm:block bg-maple-textbook-bg border-r border-maple-textbook-vertical-line"></div>
    """
  end

  defp interaction_icons(%{is_read: true} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" class={assigns[:class]} fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
    </svg>
    <svg xmlns="http://www.w3.org/2000/svg" class={assigns[:class]} viewBox="0 0 20 20" fill="currentColor">
      <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
    </svg>
    """
  end

  defp interaction_icons(assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" class={assigns[:class]} viewBox="0 0 20 20" fill="currentColor">
      <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
    </svg>
    <svg xmlns="http://www.w3.org/2000/svg" class={assigns[:class]} fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
    </svg>
    """
  end

  def handle_event(a, tem, socket) do
    IO.inspect a
    IO.inspect tem
    {:noreply, socket}
  end
end
