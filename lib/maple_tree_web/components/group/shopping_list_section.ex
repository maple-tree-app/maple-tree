
defmodule MapleTreeWeb.Components.Group.ShoppingListSection do
  import Phoenix.LiveView.Helpers
  import MapleTreeWeb.Components.Icons
  import MapleTreeWeb.Components.GenericCard
  import MapleTreeWeb.Gettext

  alias Phoenix.LiveView.JS
  alias MapleTreeWeb.Router.Helpers, as: Routes
  

  def shopping_list_section(assigns) do
    ~H"""
    <div class="mt-12">
      <div class="maple-header items-end mb-4">
        <div class="flex flex-row items-center cursor-pointer" phx-click="click_section" phx-value-section="shopping_lists">
          <.collapse_arrow id="shopp_list_collapse_icon" class="h-6 w-6 mr-2" collapsed?={Map.get(@section_open_control, "shopping_lists", false)}></.collapse_arrow>
          <h1 class="text-2xl select-none"><%= dgettext "default", "shopping lists" %></h1> 
        </div>
        <%= live_patch  to: Routes.new_shopping_list_path(@socket, :new, @group.id), class: "maple-header__side-button", style: MapleTreeWeb.Helpers.UI.get_custom_button_style_string(@group.color) do %>
          <%= dgettext "groups", "new shopping list" %>
        <% end %>
      </div>
      <hr/>
      <%= if Map.get @section_open_control, "shopping_lists", false do %>
        <!-- Shopping list preview goes here -->
        <div id="shopping_list_inner" class="mt-6 flex-col items-start fade-in" phx-remove={JS.hide(%JS{},transition: "fade-out", to: "#shopping_list_inner")}>
          <%= for shopping_list <- @shopping_lists do %>
            <div
              class="mb-5"
              phx-click="go_to_shopping_list"
              phx-value-id={shopping_list.id}
            >
            <.generic_card
              id={shopping_list.id}
              name={shopping_list.name}
              image_url={shopping_list.image_url}
              description={shopping_list.description}
              color={@group.color}
              render_color_bar={false}
            />
          </div>
          <% end %>
        </div>
      <% end %>
    </div>
    
    """
  end
end
