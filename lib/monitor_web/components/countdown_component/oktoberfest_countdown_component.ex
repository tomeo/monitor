defmodule OktoberfestCountdownComponent do
  use MonitorWeb, :live_component
  use HTTPoison.Base

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class={@class}>
      <p class="text-xl">Zeit bis zum Oktoberfest:</p>
      <div class="grid grid-cols-4 gap-1 text-6xl">
        <div id="oktoberfest_countdown_days"></div>
        <div id="oktoberfest_countdown_hours"></div>
        <div id="oktoberfest_countdown_minutes"></div>
        <div id="oktoberfest_countdown_seconds"></div>
        <div class="text-xl">Dôg</div>
        <div class="text-xl">Stund'n</div>
        <div class="text-xl">Minut'n</div>
        <div class="text-xl">Sekond'n</div>
      </div>

      <script>
        var countDownDate = new Date("Sep 25, 2025 12:45:00").getTime();
        var x = setInterval(function() {
          var now = new Date().getTime();
          var distance = countDownDate - now;
          var days = Math.floor(distance / (1000 * 60 * 60 * 24));
          var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
          var seconds = Math.floor((distance % (1000 * 60)) / 1000);
          document.getElementById("oktoberfest_countdown_days").innerHTML = days;
          document.getElementById("oktoberfest_countdown_hours").innerHTML = hours;
          document.getElementById("oktoberfest_countdown_minutes").innerHTML = minutes;
          document.getElementById("oktoberfest_countdown_seconds").innerHTML = seconds;

          if (distance < 0) {
            clearInterval(x);
            document.getElementById("oktoberfest_countdown").innerHTML = "0";
          }
        }, 1000);
      </script>
    </div>
    """
  end
end
