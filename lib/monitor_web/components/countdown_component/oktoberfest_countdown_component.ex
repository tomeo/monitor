defmodule OktoberfestCountdownComponent do
  use MonitorWeb, :live_component
  use HTTPoison.Base

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class={@class}>
      <div class="flex justify-between gap-1 h-full md:pl-8 md:pr-8">
        <div class="flex flex-col md:flex-row gap-2 items-center content-center">
          <div class="text-xs md:text-4xl">Zeit bis zum</div>
          <div class="text-4xl md:test-8xl">🍺</div>
          <div class="text-xs md:text-4xl">Oktoberfest</div>
        </div>
        <div class="grid grid-cols-4 gap-x-3 md:gap-x-10 gap-y-1 text-3xl md:text-6xl">
          <div id="oktoberfest_countdown_days" class="flex flex-col justify-end h-full"></div>
          <div id="oktoberfest_countdown_hours" class="flex flex-col justify-end h-full"></div>
          <div id="oktoberfest_countdown_minutes" class="flex flex-col justify-end h-full"></div>
          <div id="oktoberfest_countdown_seconds" class="flex flex-col justify-end h-full"></div>
          <div class="text-sm md:text-xl">Dôg</div>
          <div class="text-sm md:text-xl">Stund'n</div>
          <div class="text-sm md:text-xl">Minut'n</div>
          <div class="text-sm md:text-xl">Sekond'n</div>
        </div>
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
