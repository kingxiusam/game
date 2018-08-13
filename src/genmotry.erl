%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 八月 2018 14:24
%%%-------------------------------------------------------------------
-module(genmotry).
-author("Administrator").

%% API
-export([area/1]).
%%求解矩形面积
area({rectangle,Height,Width})->Height*Width;
%%求解圆形面积
area({cricle,R})->3.1415*R*R.