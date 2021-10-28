defmodule MapleTreeWeb.Components.Modal do

  import Phoenix.LiveView.Helpers
  alias Phoenix.LiveView.JS

  def modal(assigns) do
    ~H"""
    <div
      class="min-w-screen h-screen animated fadeIn faster fixed left-0 top-0 flex justify-center items-center inset-0 z-50 outline-none focus:outline-none bg-no-repeat bg-center bg-cover"
      id={@id}
      phx-remove={hide_modal(@id)}
    >
      <div class="absolute bg-black opacity-40 inset-0 z-0"></div>
      <div 
        id={"content"<>@id}
        phx-click-away={hide_modal(@id)}
        class="w-full max-w-lg p-5 relative mx-auto my-auto rounded-xl shadow-lg  bg-maple-light-surface dark:bg-maple-dark-surface"
      >
        <!--content-->
        <div>
          <%= if header = Map.get(assigns, :header) do render_slot(header) end %>
          <%= render_slot(@inner_block) %>
          <%= if footer = Map.get(assigns, :footer) do render_slot(footer) end %>
          <div class="p-3  mt-2 text-center space-x-4 md:block">
            <%= if buttons = Map.get(assigns, :buttons) do render_slot(buttons) end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp hide_modal(id, js \\ %JS{}) do
    js
      |> JS.hide(transition: "fade-out", to: "##{id}")
      |> JS.hide(transition: "fade-out-down", to: "#content-#{id}")
  end

end
