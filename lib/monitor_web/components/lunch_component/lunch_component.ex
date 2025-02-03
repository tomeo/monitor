defmodule LunchComponent do
  use MonitorWeb, :live_component
  require Logger

  def update(assigns, socket) do
    case fetch_lunch_data() do
      {:ok, lunch_places} ->
        {:ok, assign(socket, lunch_places: lunch_places, class: assigns.class)}

      {:error, reason} ->
        Logger.error("Failed to fetch lunch data: #{reason}")
        {:ok, assign(socket, lunch_places: [], class: assigns.class)}
    end
  end

  defp fetch_lunch_data do
    url = "https://lunch-api-lively-forest-2534.fly.dev/helsingborg/ramlosa"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, data} -> {:ok, data}
          {:error, _} -> {:error, :invalid_json}
        end

      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, "HTTP status #{status}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def render(assigns) do
    ~H"""
    <div class={@class}>
      <h2 class="text-base font-semibold mb-2 flex gap-4 items-center">
        <div class="text-4xl md:test-6xl">🥗</div>
        <div>Lunch Ramlösa</div>
      </h2>
      <%= for place <- @lunch_places do %>
        <div class="mb-2 p-4 bg-white rounded-lg shadow">
          <h3 class="text-sm font-semibold"><%= place["name"] %></h3>
          <ul class="mt-2 space-y-2">
            <%= for dish <- place["dishes"] do %>
              <li class="p-2 border border-gray-200 rounded-md shadow-sm">
                <p class="text-xs font-medium"><%= dish["dish"] %></p>
                <p class="text-xs text-gray-600">Pris: <%= dish["price"] %> kr</p>
              </li>
            <% end %>
          </ul>
        </div>
      <% end %>
    </div>
    """
  end
end
