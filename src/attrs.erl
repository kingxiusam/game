%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 八月 2018 16:41
%%%-------------------------------------------------------------------
-module(attrs).
-author("Administrator").
-vsn(1.0).
-purpose("descript attr use").
-define(DWORD,32/unsigned-little-integer).
-define(WORD,16/unsigned-little-integer).
-define(LONG,32/unsigned-little-integer).
-define(BYTE,8/unsigned-little-integer).
-define(macral(X,Y),{a,X,Y}).

%% API
-export([fac/1]).
-export([f/1]).
fac(1)->1;
fac(N)->fac(N)*fac(N-1).

%?macral表达式会扩展相对应的宏
f(A)->?macral(A+10,b).
