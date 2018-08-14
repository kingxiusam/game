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


loop()->
    receive
        {rectangle,Height,Width}->loop();
        {cricle,R}->loop();
        Other->loop()
    end.