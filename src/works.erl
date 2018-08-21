%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 八月 2018 14:57
%%%-------------------------------------------------------------------
-module(works).
-author("Administrator").

%% API
-export([avg/1]).
-export([min/1]).
-export([num/1]).
-export([sum/1]).
-export([insect/2]).
-export([concat/2]).
-export([loop_min/0]).
-export([mul_min/2]).


sum(L)          -> sum(L, 0).
sum([H|T], Sum) -> sum(T, Sum + H);
sum([], Sum)    -> Sum.

num([])          ->0;
num([_H|T])      ->1+num(T).

avg([])         ->0;
avg(L)          ->
                sum(L)/num(L).

min([H|T])                   -> min(T, H).
min([H|T], Min) when H < Min -> min(T, H);
min([_|T], Min)              -> min(T, Min);
min([],    Min)              -> Min.




insect(L1,L2) -> [X||X<-L1,Y<-L2,X=:=Y].


concat(String1,String2)->
    List=[String1|String2],
    binary_to_list(list_to_binary(List)).



mul_min(L,State)->

    Size=length(L),
%%    输入列表的元素个数需为3的倍数
    L1=lists:sublist(L,1,Size div 3),
    L2=lists:sublist(L,(Size div 3)+1,Size div 3),
    L3=lists:sublist(L,(Size div 3)*2+1,Size-length(L2)-length(L1)),

    Pid1=spawn(fun()->loop_min()end),
    Pid2=spawn(fun()->loop_min()end),
    Pid3=spawn(fun()->loop_min()end),
%%    从当前进程(主进程)发送消息给子进程
    Pid1 ! {self(),L1},
    Pid2 ! {self(),L2},
    Pid3 ! {self(),L3},

    receive
    %%        主进程接收子进程的返回值

        {Pid1,Min1} when State==1 ->put(min,Min1)
        ,mul_min(L,2)
    ;

        {Pid2,Min2} when State==2 ->
            Temp2 = get(min),

            if
                Temp2 > Min2 -> put(min,Min2);
                    true->get(min)
            end
        ,mul_min(L,3)
    ;

        {Pid3,Min3} when State==3 ->Min3,
            Temp3 = get(min),
            if
            Temp3 > Min3 -> put(min,Min3);
                true->get(min)
            end,
            io:format("the min of list is :~p~n",[get(min)])
%%            递归出口
        ,mul_min(L,0)
    end.



loop_min()->


    receive
        {From,L}->
            Min=lists:min(L),
            From ! {self(),Min},
            loop_min()
    end.














