defmodule TryoutGen.InsertEvent do
  use GenServer
  require Logger

  # Client APIs

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def insert(pid, event) do
    GenServer.cast(pid, event)
  end

  # Server callbacks

  @flush_interval_ms 5_000
  @max_buffer_size 20

  def init(buffer) do
    timer = Process.send_after(self(), :tick, @flush_interval_ms)

    {:ok, %{buffer: buffer, timer: timer}}
  end

  def handle_cast( event, %{buffer: buffer, timer: timer} = state) do

    new_buffer = [event | buffer]

    if length(new_buffer) >= @max_buffer_size do
      Logger.info("Buffer full")
      Process.cancel_timer(timer)
      do_flush(new_buffer)

      new_timer = Process.send_after(self(), :tick, @flush_interval_ms)

     {:noreply, %{buffer: [], timer: new_timer}}
    else
      {:noreply, %{state | buffer: new_buffer}}
      end
  end

  def handle_info(:tick, %{buffer: buffer} ) do
    do_flush(buffer)
    timer = Process.send_after(self(), :tick, @flush_interval_ms)

    {:noreply, %{buffer: [], timer: timer}}
  end

  def do_flush(buffer) do
    case buffer do
      [] ->
        nil

      events ->
        TryoutGen.Repo.insert_all(TryoutGen.Event, Enum.map(events, fn event -> %{title: event} end))
    end
  end
end
