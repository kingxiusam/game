%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 八月 2018 11:56
%%%-------------------------------------------------------------------
-module(m_timer).
-author("Administrator").


%% API
-export([do_timer/2]).
-export([cancel/1]).
-export([timer/2]).

do_timer(T,Fun)->spawn(fun()->timer(T,Fun) end).


cancel(Pid)->Pid ! cancel.

timer(T,Fun)->
    receive
%%超时之前取消计时器
        cancel->
            io:format("program is cancel\n")
        after T->
            Fun()
    end.