defmodule FinnCar.Moose do
  @moduledoc """

  This is a GenServer process that implements a moose.


  API:
    setup_grid(100, 100) -- pass the size of our playing grid
    tick(number) - when i get a tick i update position and return position


  Implementation
    Moose picks a random position after setup_grid


  STATE
    position
    grid
    direction

  """
  use GenServer

   # Client

   def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def setup_grid(pid, [h, w]) do
    GenServer.call(pid, {:setup_grid, [h, w]})
  end

  def tick(pid, tick_number) do
    GenServer.call(pid, {:tick, tick_number})
  end


  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(nothing) do
    state = %{ position: [0, 0], grid: [0, 0] }
    {:ok, state}
  end

  @impl true
  def handle_call({:setup_grid, [h, w]}, _from, state) do
    state = %{state | grid: [h, w]}
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:tick, tick_number}, _from, state) do

    div = rem(tick_number, 5)

    state = cond do
      div == 0 -> move_right(state)
    end

    {:reply, :ok, state}
  end

  def move_right(state) do

    %{position: position, grid: grid} = state

    [r, c] = position
    c = c + 1

    [_grid_h, grid_w] = grid

    c = if c > grid_w do
      0
    else
      c
    end

    %{state | position: [r, c]}
  end


end
