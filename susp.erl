-module(susp).
-export([delay/1, force/1, memoize/1]).
-export_type([susp/0]).
-type susp() :: {boolean(), term()}.
-spec delay(term()) -> susp().
delay(Thunk) ->
  case is_function(Thunk) of
    false -> {true,  Thunk};
    true  -> {false, fun() -> Thunk() end}
  end.
-spec force(susp()) -> term().
force(Susp) ->
  case Susp of
    {true,  Thunk} -> Thunk;
    {false, Thunk} -> Thunk() % not memoized.
  end.
-spec memoize(susp()) -> susp().
memoize(Susp) ->
  case Susp of
    {true,  Thunk} -> {true, Thunk};
    {false, Thunk} -> {true, Thunk()} % memoized.
  end.
