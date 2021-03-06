%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%% 客户端消息显式
%%% @end
%%% Created : 21. 八月 2018 11:14
%%%-------------------------------------------------------------------
-module(chat_receive_client).
-author("Administrator").

%% API
-export([start/2]).



start(Ip,Port)->
    {ok,Socket}=gen_tcp:connect(Ip,Port,[binary,{packet,4}]),
    receive_msg(Socket).

receive_msg(Socket)->
    receive
        {tcp,Socket,Bin}->
            Msg=binary_to_term(Bin),
            io:format("~p~n",[Msg]),
            receive_msg(Socket)
    end.