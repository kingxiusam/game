%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 八月 2018 21:10
%%%-------------------------------------------------------------------
-module(area_server).
-author("Administrator").

%% API
-export([loop/0]).
-export([rpc/2]).
-export([start/0]).
-export([area/2]).



loop()->
    receive
        {From,{rectangle,Height,Width}}->
            %%          From  向客户机发送相关信息
            From ! {self(),Height*Width*5},
            io:format("Area is rectangle ~p~n",[Height*Width*5]),
            loop();
        {From,{cricle,R}}->
            From ! {self(),3.1415*R*R},
            io:format("Area is cricle ~p~n",3.1415*R*R),
            loop();
        {From,Other}->
            From ! {self(),error,Other},
            io:format("Area is other ~p~n",[Other]),
            loop()

%%    超时处理
    after 2000->
                io:format("请求处理超时")
    end.

rpc(PID,Request)->
    PID ! {self(),Request},
    receive
        {PID,Response}->Response
    end.


%%计算面积客户机
area(Pid,What)->rpc(Pid,What).

%%启动处理进程客户机
start()->spawn(fun loop/0).
