%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 八月 2018 20:23
%%%-------------------------------------------------------------------
-module(chat_room).
-author("Administrator").

%% API
-export([start_link/0]).


start_link()->
    gen_server:start_link({local,?MODULE},?MODULE,[],[]).
