%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 八月 2018 20:24
%%%-------------------------------------------------------------------
-module(chat_acceptor).
-author("Administrator").

%% API
-export([start/1]).




start([Port])->
    gen_server:start({local,?MODULE},?MODULE,[Port],[]).
