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
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).
-export([loop/0]).
-export([mul_min/2]).
-export([loop_min/0]).
-author("Administrator").



%% API
-export([]).


mul_min(L,State)->



    Size=length(L),
%%    输入列表的元素个数需为3的倍数
    L1=lists:sublist(L,1,Size div 3),
    L2=lists:sublist(L,(Size div 3)+1,Size div 3),
    L3=lists:sublist(L,(Size div 3)*2+1,Size-length(L2)-length(L1)),


    %%使用该函数通过gen_server启动多个进程
    Pid1=gen_server:start_link(?MODULE,[],[]),
    Pid2=gen_server:start_link(?MODULE,[],[]),
    Pid3=gen_server:start_link(?MODULE,[],[]),

    io:format("pid : ~p~n",[Pid1]),
    io:format("pid : ~p~n",[Pid2]),
    io:format("pid : ~p~n",[Pid3]),


    gen_server:call(),

    receive
    %%        主进程接收子进程的返回值

        {Pid1,Min1} when State==1 ->put(min,Min1)
            ,mul_min(L,2)
    ;

        {Pid2,Min2} when State==2 ->
            Temp2 = get(min),

            if
                Temp2 > Min2 -> put(min,Min2);
                true->get(min)
            end
            ,mul_min(L,3)
    ;

        {Pid3,Min3} when State==3 ->Min3,
            Temp3 = get(min),
            if
                Temp3 > Min3 -> put(min,Min3);
                true->get(min)
            end,
            io:format("the min of list is :~p~n",[get(min)])
%%            递归出口
            ,mul_min(L,0)
    end.


%%the callback interface
init([]) ->

    {ok,ets:new(?MODULE,[])}.


handle_cast(_From,State)->
    {noreply,State}.

handle_info(_Info,State)->
    {noreply,State}.

terminate(_From,State)->
    {ok,State}.

code_change(_OldVer,State,_Ext)->
    {ok,State}.




%%计算所给列表的最小值 -callback
handle_call({loop},_From,Tab)->

    Reply= case  true of
               true -> io:format("hello")
           end,
    {reply,Reply,Tab}.




loop()->
    receive
        {From,L}->
        Min=lists:min(L),
        From ! {self(),Min},
        loop()
    end.


loop_min()->gen_server:call(?MODULE,{loop}).


