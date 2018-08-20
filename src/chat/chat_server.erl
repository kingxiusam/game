%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 八月 2018 20:23
%%%-------------------------------------------------------------------
-module(chat_server).
-author("Administrator").

%% API
-export([start/1]).



start(ClientPort)->
    chat_room:start_link(),
    chat_acceptor:start(ClientPort).

