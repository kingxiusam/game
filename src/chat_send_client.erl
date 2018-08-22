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
-export([start/3]).
-export([talk/2]).


start(IP, Port,ClientId) ->
    {ok, Socket} = gen_tcp:connect(IP, Port, [binary, {packet, 4}]),
    talk(Socket,ClientId).



talk(Socket,ClientId)->
    Id=integer_to_list(ClientId),
    io:format("[client "++Id++" input process]"),
    Msg=io:get_line("input："),
    ok=gen_tcp:send(Socket,term_to_binary("[client"++Id++"]:"++Msg)),
    talk(Socket,ClientId)
.