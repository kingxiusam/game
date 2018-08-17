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
-export([generation_id/0]).


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




%%注册生成自增id的进程
generation_id()->
        register(generation,spawn(fun loop/0)).




