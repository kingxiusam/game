%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 八月 2018 20:11
%%%-------------------------------------------------------------------
-module(query_comprehensive).
-author("Administrator").
-include_lib("stdlib/include/qlc.hrl").

-record(shop,{item,quality,cost}).

%% API
-export([start_comprehensive/1, database_start/0, example_table/0, reset_table/0]).


database_start()->
    mnesia:start().

start_comprehensive(select_shop)->
%%    将编译的结果交给do函数
    do(qlc:q([X||X<-mnesia:table(shop)])).



do(Q) ->
    F=fun()-> qlc:e(Q) end,
    {atomic,Value}=mnesia:transaction(F),
    Value
    .






example_table()->
    [


        {shop,apple,20,1.4},
        {shop,pear,30,9.4},
        {shop,banana,40,1.2},
        {shop,potato,70,1.8},
        {cost,apple,1.9},
        {cost,pear,2.7},
        {cost,banana,2.7},
        {cost,potato,2.7}



    ].



reset_table()->
    mnesia:create_table(shop),
    mnesia:create_table(cost),
    F=fun()->lists:foreach(fun mnesia:write/1,example_table())end,
    mnesia:transaction(F)
    .