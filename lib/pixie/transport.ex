defmodule Pixie.Transport do
  import Pixie.Utils.String

  def get transport_name, client_id do
    id = "transport:#{client_id}"
    transport_name = transport_name
      |> String.split("-")
      |> Enum.join("_")
      |> camelize(true)

    module = Module.concat __MODULE__, transport_name
    Pixie.Supervisor.replace_worker module, id, []
  end

  def advice transport, advice do
    GenServer.call transport, {:advice, advice}
  end

  def await transport, messages do
    GenServer.call transport, {:await, messages}, Pixie.timeout * 2
  end

  def enqueue _transport, [] do
    :ok
  end

  def enqueue transport, messages do
    GenServer.cast transport, {:enqueue, messages}
  end

  def ensure_enqueue transport, messages do
    GenServer.call transport, {:ensure_enqueue, messages}
  end
end