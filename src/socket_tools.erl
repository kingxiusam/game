%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 八月 2018 14:10
%%%-------------------------------------------------------------------
-module(socket_tools).
-author("Administrator").

%% API
-export([nano_get_url/0]).
-export([nano_get_url/1]).
-export([receive_data/2]).
-export([start_nano_server/0]).
-export([start_nano_client/1]).

nano_get_url()->
    nano_get_url("www.baidu.com").

nano_get_url(Host)->
%%    {packet,0}是指将数据原封不动的发送给应用程序
    {ok,Socket}=gen_tcp:connect(Host,80,[binary,{packet,0}]),
%%    send执行完成后会返回{tcp,Socket,Bin},Bin参数为二进制类型
    ok=gen_tcp:send(Socket,"GET / HTTP/1.0\r\n\r\n"),
%%    当接收到消息{tcp_closed,Socket}时说明web服务器已经停止向程序发送消息
    receive_data(Socket,[]).


receive_data(Socket,SoFar)->
    receive
        {tcp,Socket,Bin}->
                receive_data(Socket,[Bin|SoFar]);
        {tcp_closed,Socket}->list_to_binary(lists:reverse(SoFar))
    end.

start_nano_server()->
    {ok,Listen}=gen_tcp:listen(8080,[binary,{packet,4},{reuseaddr,true},{active,true}]),
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
            io:format("Client received value is ~p~n",[Val]),
            gen_tcp:close(Socket)
    end.

loop(Socket)->receive
                  {tcp,Socket,Bin}->
                      io:format("Server  received binary ~p~n",[Bin]),
                      Str=binary_to_term(Bin),
                      io:format("Server(unpack) ~p~n",[Str]),
                      Relay=Str,
                      gen_tcp:send(Socket,term_to_binary(Relay)),
                      loop(Socket);
                  {tcp_close,Socket}->
                      io:format("Server socket was closed")
              end.