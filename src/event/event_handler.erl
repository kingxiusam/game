%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 八月 2018 14:28
%%%-------------------------------------------------------------------
-module(event_handler).
-author("Administrator").

%% API
-export([no_operate/1]).
-export([event/2]).
-export([add_handler/2]).
-export([my_handler/1]).


make(Name)->register(Name,spawn(fun()->my_handler(fun no_operate/1)end)).


%%"啥也不干"事件处理
no_operate(_)->void.

%%事件处理
event(RegProgressName,Detail)->RegProgressName ! {event,Detail}.

%%添加事件处理器
add_handler(RegProgressName,Fun)->RegProgressName ! {add,Fun}.

%%自定义处理程序
my_handler(Fun)->receive
                    {add,Function}->
                        my_handler(Function);
                    {event,Any}->
%%                        判断是否会出现异常
                        catch(Fun(Any)),
                        my_handler(Fun)
                end.