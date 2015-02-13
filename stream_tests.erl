-module(stream_tests).
-include_lib("eunit/include/eunit.hrl").
-define(L2S(L), stream:l2s(L)).
-define(S2L(S), stream:s2l(S)).
append_test() ->
  ?assertEqual([1, 2, 3, 4], ?S2L(stream:append(?L2S([1, 2]), ?L2S([3, 4])))).
take_test() ->
  ?assertEqual([1, 2], ?S2L(stream:take(2, ?L2S([1, 2, 3, 4])))).
drop_test() ->
  ?assertEqual([3, 4], ?S2L(stream:drop(2, ?L2S([1, 2, 3, 4])))).
reverse_test() ->
  ?assertEqual([4, 3, 2, 1], ?S2L(stream:reverse(?L2S([1, 2, 3, 4])))).
sort_test() ->
  ?assertEqual([1, 1, 2, 2, 3, 3, 4, 4], ?S2L(stream:sort(?L2S([4, 1, 3, 2, 4, 1, 3, 2])))).
