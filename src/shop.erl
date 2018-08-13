%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 八月 2018 14:59
%%%-------------------------------------------------------------------
-module(shop).
-author("Administrator").
-import(lists,[map/2,sum/1]).
%% API
-export([cost/1]).
-export([total/1]).

cost(oranges)->5;
cost(newspaper)->6;
cost(pears)->7;
cost(apples)->8;
cost(milk)->9.

%%total(L)->sum(map(fun({What,N})->cost(What)*N end,L)).
total(L)->lists:sum([shop:cost(A)*B||{A,B}<-L]).

