%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 八月 2018 19:33
%%%-------------------------------------------------------------------
-module(kvs).
-author("Administrator").

%% API
-export([loop/0]).
-export([start/0]).
-export([store/2]).
-export([lookup/1]).

%%启动服务器,创建并注册服务名为kvs
-spec start()->true.

start()->register(kvs,spawn(fun()->loop()end)).

%%将Val和Key关联起来
-spec store(Key,Val)->true when
    Key::term(),
    Val::term().

store(Key,Val)->rpc({store,Key,Val}).

-spec lookup(Key)->Val|undefined when
    Key::term(),
    Val::term().

lookup(Key)->rpc({lookup,Key}).


%%远程服务调用
rpc(Q)->
    kvs ! {self(),Q},
    receive
        {kvs,Reply}->Reply
    end.


loop()->
    receive
            {From,{store,Key,Val}}->
                put(Key,{ok,Val}),
                From ! {kvs,true},
                loop();
            {From,{lookup,Key}}->
                From ! {kvs,get(Key)},
                loop()
     end.