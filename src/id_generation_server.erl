%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 八月 2018 18:54
%%%-------------------------------------------------------------------
-module(id_generation_server).
-author("Administrator").
-behavior(gen_server).

%%唯一id
-record(ids,{idtype, ids}
).

%%ids表装状态
-record(state, {}).

-export([init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).
%% API
-export([start_multi_process/0]).
-export([get_newId/1]).
-export([start_link/0]).
-export([stop/0]).




%%同时开启多个进程
start_multi_process()->
    spawn(id_generation_server,get_newId,[client]),
    spawn(id_generation_server,get_newId,[client]),
    spawn(id_generation_server,get_newId,[client]).





%%注册生成自增id的进程
start_link()->
    gen_server:start({local,?MODULE},?MODULE,[],[]).

stop()->
    gen_server:call(?MODULE,stop).

get_newId(IdType)->
    mnesia:force_load_table(ids),
    Id=gen_server:call(?MODULE,{get_newId,IdType}),
    io:format("get the generation id is:~p~n",[Id]).


%%the callback interface
init([]) ->
    mnesia:start(),
    io:format("start the mnesia db"),
    mnesia:create_schema([node()]),
    case mnesia:create_table(ids,[{type,ordered_set},
        {attributes,record_info(fields,ids)},
        {disc_copies,[]}
    ]) of
        {atomic,ok}->
            {atomic,ok};
        {error,Reason}->
            io:format("create table error:~p~n",[Reason])
    end,
    {ok,#state{}}.









handle_cast(_From,State)->
    {noreply,State}.

handle_info(_Info,State)->
    {noreply,State}.

terminate(_From,State)->
    {ok,State}.

code_change(_OldVer,State,_Ext)->
    {ok,State}.



%%generate new Id for given type
handle_call({get_newId,IdType},_From,State)->
    F=fun()->
        Result=mnesia:read(ids,IdType,write),
        case Result of
            [S]->
                Id=S#ids.ids,
                NewColumn=S#ids{ids=Id+1},
                mnesia:write(ids,NewColumn,write),
                Id;
            []->
                NewColumn=#ids{idtype=IdType,ids=2},
                mnesia:write(ids,NewColumn,write),
                1
        end
      end,
    case mnesia:transaction(F)of
        {atomic,Id}->
            {atomic,Id};
        {aborted,Reason}->
            io:format("run transaction error ~1000.p ~n",[Reason]),
            Id=0;
        _Els->
            Id=1000
    end,
    {reply,Id,State};

handle_call(stop,_From,State)->
    {stop,normal,stopped,State}.
