-module(stream).
-export([append/2, take/2, drop/2, reverse/1, sort/1, l2s/1, s2l/1]).
-export_type([cell/0, cons/0, stream/0]).
-define(SD(Thunk), susp:delay(Thunk)).
-define(SF(Susp), susp:force(Susp)).
-opaque cell() :: nil | cons().
-opaque cons() :: {term(), stream()}.
-type stream() :: {true, cell()} | {false, fun(() -> cell())}. % susp of cell.
-spec append(stream(), stream()) -> stream().
append(S, R) ->
  case ?SF(S) of
    nil    -> R;
    {H, T} -> ?SD(fun() -> {H, append(T, R)} end)
  end.
-spec take(non_neg_integer(), stream()) -> stream().
take(0, _) -> ?SD(nil);
take(N, S) ->
  case ?SF(S) of
    nil    -> S;
    {H, T} -> ?SD(fun() -> {H, take(N - 1, T)} end)
  end.
-spec drop(non_neg_integer(), stream()) -> stream().
drop(0, S) -> S;
drop(N, S) ->
  case ?SF(S) of
    nil    -> S;
    {_, T} -> drop(N - 1, T)
  end.
-spec reverse(stream()) -> stream().
reverse(S) -> reverse(S, ?SD(nil)).
-spec reverse(stream(), stream()) -> stream().
reverse(S, R) ->
  case ?SF(S) of
    nil    -> R;
    {H, T} -> reverse(T, ?SD({H, R}))
  end.
-spec sort(stream()) -> stream().
sort(S) -> foldl(fun insert/2, ?SD(nil), S).
-spec insert(term(), stream()) -> stream().
insert(I, S) ->
  case ?SF(S) of
    nil    -> ?SD({I, S});
    {H, T} -> insert(I, H, T)
  end.
-spec insert(term(), term(), stream()) -> stream().
insert(I, H, T) ->
  case I =< H of
    true  -> ?SD({I, ?SD({H, T})});
    false -> ?SD({H, insert(I, T)})
  end.
-spec foldl(fun((term(), term()) -> term()), term(), stream()) -> term().
foldl(F, A, S) ->
  case ?SF(S) of
    nil    -> A;
    {H, T} -> foldl(F, F(H, A), T)
  end.
-spec l2s(list()) -> stream().
l2s(L) ->
  case L of
    []    -> ?SD(nil);
    [H|T] -> ?SD({H, l2s(T)})
  end.
-spec s2l(stream()) -> list().
s2l(S) ->
  case ?SF(S) of
    nil    -> [];
    {H, T} -> [H|s2l(T)]
  end.
