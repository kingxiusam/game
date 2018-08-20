%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 八月 2018 17:28
%%%-------------------------------------------------------------------
-module(mul_min_server).
-author("Administrator").
-behavior(gen_server).
-export([start/0]).
-export([stop/0]).
%% API
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


start()->gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop()->gen_server:call(?MODULE,stop).




init([])->{ok,true}.

handle_call(_Request, _From, Status) ->
    {reply,ok,Status}.

handle_cast(_Arg0, Status) ->
    {noreply,Status}.

handle_info(_Info, Status) ->
    {noreply,Status}.

terminate(_Arg0, Status) ->
    {ok,Status}.

code_change(_OldVsn, Status, _Extra) ->
    {ok,Status}.