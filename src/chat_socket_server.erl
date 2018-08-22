%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 八月 2018 13:59
%%%-------------------------------------------------------------------
-module(chat_socket_server).
-author("Administrator").

%% API
-export([send_data/2, start_nano_client/1, start_nano_server/0]).




start_nano_server()->
    {ok,Listen}=gen_tcp:listen(8080,[binary,{packet,4}]),
%%    函数返回Socket
    {ok,Socket}=gen_tcp:accept(Listen),
%%    accept返回后立即关闭监听套接字
    gen_tcp:close(Listen),
    loop(Socket).



start_nano_client(Str)->
    {ok,Socket}=gen_tcp:connect("localhost",8080,[binary,{packet,4}]),
    ok=gen_tcp:send(Socket,term_to_binary(Str)),

    receive
        {tcp,Socket,Bin}->
            io:format("Client received binary data ~p~n",[Bin]),
            Val=binary_to_term(Bin),
            io:format("Client received value is ~p~n",[Val])
    end.

loop(Socket)->receive
                  {tcp,Socket,Bin}->
                      io:format("Server  received binary ~p~n",[Bin]),
                      Str=binary_to_term(Bin),
                      io:format("Server was unpack ~p~n",[Str]),
                      gen_tcp:send("~p~n",[Str]),
                      loop(Socket);
                  {tcp_close,Socket}->
                      io:format("Server socket was closed")
              end.





send_data(Sockets,Data)->
    SendData=fun(Socket)->
        gen_tcp:send(Socket,Data)
             end,
    lists:foreach(SendData,Sockets).
