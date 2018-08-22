%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 八月 2018 19:44
%%%-------------------------------------------------------------------
-module(mul_min_gen_server).
-behavior(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([mul_min/1]).
-export([loop_min/2]).
-export([start_link/0]).
-export([show/0]).
-author("Administrator").



%% API
-export([]).


%%开启主进程
start_link()->
    gen_server:start({local,?MODULE},?MODULE,[],[])

.

mul_min(L)->

    Size=length(L),
%%    输入列表的元素个数需为3的倍数
    L1=lists:sublist(L,1,Size div 3),
    L2=lists:sublist(L,(Size div 3)+1,Size div 3),
    L3=lists:sublist(L,(Size div 3)*2+1,Size-length(L2)-length(L1)),


    %%使用该函数通过gen_server启动多个进程
%%    Pid1=gen_server:start_link(?MODULE,[L1],[]),
%%    Pid2=gen_server:start_link(?MODULE,[L2],[]),
%%    Pid3=gen_server:start_link(?MODULE,[L3],[]),
    Pid1=spawn(mul_min_gen_server,loop_min,[L1,1]),
    Pid2=spawn(mul_min_gen_server,loop_min,[L2,2]),
    Pid3=spawn(mul_min_gen_server,loop_min,[L3,3]),

    io:format("pid : ~p~n",[Pid1]),
    io:format("pid : ~p~n",[Pid2]),
    io:format("pid : ~p~n",[Pid3])

.

%%发起计算最小值服务器的远程调用
loop_min(L,Index)->

    Min=
        gen_server:call(?MODULE,{loop_min,L,Index})
    ,
    io:format("the min: ~p~n",[Min])

.

%%the callback interface
init([]) ->
    io:format("start the master process ~n"),
    {ok,ets:new(min_table,[public,named_table,ordered_set])}.


handle_cast(_From,State)->
    {noreply,State}.

handle_info(_Info,State)->
    {noreply,State}.

terminate(_From,State)->
    {ok,State}.

code_change(_OldVer,State,_Ext)->
    {ok,State}.




%%计算所给列表的最小值 -callback
handle_call({loop_min,L,Index},_From,State)->

    Min=lists:min(L),
    ets:insert(min_table,{Index,Min}),
    {reply,Min,State}.


show()->

    List=ets:tab2list(min_table),
    [{_,Min1},{_,Min2},{_,Min3}] = List,
    Result=lists:min([Min1,Min2,Min3]),
    io:format("the min of list is : ~p~n",[Result]).