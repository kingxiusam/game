%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%% 用来启动一个client发消息的进程
%%% @end
%%% Created : 21. 八月 2018 11:08
%%%-------------------------------------------------------------------
-module(chat_send_client).
-author("Administrator").

%% API
-export([start/2]).
-export([talk/1]).

start(IP, Port) ->
    {ok, Socket} = gen_tcp:connect(IP, Port, [binary, {packet, 4}]),
    talk(Socket).



talk(Socket)->
    Msg=io:get_line("input the message："),
    ok=gen_tcp:send(Socket,term_to_binary(Msg)),
    talk(Socket).