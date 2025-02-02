defmodule DadJokeComponent do
  use MonitorWeb, :live_component
  use HTTPoison.Base

  def mount(socket) do
    case fetch_joke() do
      {:ok, joke} ->
        {:ok, socket |> assign(:joke, joke)}

      {:error, _reason} ->
        {:ok, socket |> assign(:joke, nil)}
    end
  end

  def handle_event("new_joke", _params, socket) do
    case fetch_joke() do
      {:ok, joke} ->
        {:noreply, socket |> assign(:joke, joke)}

      {:error, _reason} ->
        {:noreply, socket |> assign(:joke, nil)}
    end
  end

  def render(assigns) do
    ~H"""
    <div
      class={@class}
      phx-click="new_joke"
      phx-target={@myself}
      >
      <div class="flex gap-2 items-center">
        <div><%= @joke %></div>
      </div>
    </div>
    """
  end

  defp fetch_joke() do
    url = "https://icanhazdadjoke.com/"
    headers = [{"Accept", "application/json"}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, data} ->
            joke = data["joke"]
            {:ok, joke}

          {:error, error} ->
            IO.puts("Error parsing JSON: #{inspect(error)}")
            {:error, error}
        end

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        IO.puts("Request failed with status code: #{status_code}")
        {:error, :invalid_response}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Request failed with error: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
