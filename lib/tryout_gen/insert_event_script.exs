defmodule TryoutGen.InsertEventScript do
  use Ecto.Schema

  {:ok, pid} = TryoutGen.InsertEvent.start_link()

  for n <- 1..1000 do
  event =  %TryoutGen.Event{
    title: "event #{n}"
  }
  TryoutGen.InsertEvent.insert(pid, event.title)

  end

end
