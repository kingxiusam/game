%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 八月 2018 14:53
%%%-------------------------------------------------------------------
-module(clock).
-author("Administrator").

%% API
-export([start/2]).
-export([stop/1]).
-export([trick/2]).

start(Time,Fun)->register(clock,spawn(fun()->trick(Time,Fun) end)).

%%停止进程
stop(Pid)->Pid ! stop.

%%计时函数
trick(Time,Fun)->receive
                     stop->void
                 after Time->Fun(),trick(Time,Fun)

                 end.


