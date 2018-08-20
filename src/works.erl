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
%%-export([generation_id/0]).
-export([mul_min/1]).


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



mul_min(L)->



    Size=length(L),


    L1=lists:sublist(L,0,Size/3),
    L2=lists:sublist(L,Size/3,Size/3),
    L3=lists:sublist(L,Size/3*2,Size-length(L2)-length(L1)),

    Pid1=spawn(works,fun loop_min/1),
    Pid2=spawn(works,fun loop_min/1),
    Pid3=spawn(works,fun loop_min/1),

%%    从当前进程(主进程)发送消息给子进程
    Pid1 ! {self(),L1},
    Pid2 ! {self(),L2},
    Pid3 ! {self(),L3},



    receive
        {Pid1,Min1}->Min1;

        {Pid2,Min2}->Min2;

        {Pid3,Min3}->Min3
    end.



loop_min(L)->

    receive
        {From,L}->
            Min=lists:min(L),
            From ! {self(),Min},
            loop_min(L)
    end.














