%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 八月 2018 19:44
%%%-------------------------------------------------------------------
-module(ets_show).
-author("Administrator").

%% API
-export([start/0]).
-export([show_ets/1]).


start()->
    lists:foreach(fun show_ets/1,[set,ordered_set,bag,duplicate_bag]).


show_ets(Mode)->
    TableId=ets:new(test,[Mode]),

    ets:insert(TableId,{a,1}),
    ets:insert(TableId,{a,2}),
    ets:insert(TableId,{b,2}),
    ets:insert(TableId,{c,3}),

    List=ets:tab2list(TableId),
    io:format("~-13w => ~p~n",[Mode,List]),
    ets:delete(TableId).


