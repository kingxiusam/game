%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 八月 2018 16:33
%%%-------------------------------------------------------------------
-module(id_generation_code).
-behavior(gen_server).
-author("Administrator").
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).
%% API
-export([start_multi_process/0]).
-export([getId/1]).
-export([start_link/0]).
-export([stop/0]).
%% API

%%唯一id
-record(state,
    {id}
).

%%同时开启多个进程
start_multi_process()->
    spawn(id_generation_code,getId,[idClient]),
    spawn(id_generation_code,getId,[idClient]),
    spawn(id_generation_code,getId,[idClient]).





%%注册生成自增id的进程
start_link()->
    gen_server:start({local,?MODULE},?MODULE,[],[]).

stop()->
    gen_server:call(?MODULE,stop).

getId(idClient)->
    Id=gen_server:call(?MODULE,{getId,idClient}),
    io:format("get the generation id is:~p~n",[Id#state.id]).


%%the callback interface
init([]) ->
    io:format("init the id  ~p",[#state{id=0}]),
    {ok,#state{id=0}}.


handle_cast(_From,State)->
    {noreply,State}.

handle_info(_Info,State)->
    {noreply,State}.

terminate(_From,State)->
    {ok,State}.

code_change(_OldVer,State,_Ext)->
    {ok,State}.



%%generate new Id
handle_call({getId,idClient},_From,State)->


    Id=State#state.id,
%%    修改state日志的id值
    NewId=State#state{id = Id+1},
%%    返回生成的id值并通传递给State参数
    {reply,NewId,NewId}
;

handle_call(stop,_From,State)->
    {stop,normal,stopped,State}
.
