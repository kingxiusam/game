%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 八月 2018 11:01
%%%-------------------------------------------------------------------
-module(try_code).
-author("Administrator").

%% API
-export([generator_exception/1]).
-export([try_caught/0]).
-export([caught_try/0]).
-export([sqrt/1]).
-export([show_exception_stack/0]).
-export([test_record/0]).


-record(r_player_hero, {
    battle_heros = []          % 上阵武将
    ,hero_equips = []          % 武将装备
    ,hero_bag = []  % 武将背包
    ,open_pos = 1              % 开放的位置
    ,open_embattle_pos=1       % 布阵位置
    ,hero_lifestar = []        % 武将命星
    ,hero_talisman = []         % 武将法宝
    ,deity_beast = [] %% 神兽
}).


%%异常处理
generator_exception(1)->a;
generator_exception(2)->throw(a);
generator_exception(3)->exit(a);
generator_exception(4)->{"error",a};
generator_exception(5)->erlang:error(a).

try_caught()->[catcher(I)||I<-[1,2,3,4,5]].

%%使用try catch语句
catcher(N)->try generator_exception(N) of
%%                无异常发生情况返回
                Val->{N,noraml,Val}
            catch
                throw:X->{N,caught,thow,X};
                exit:X->{N,caught,exit,X};
                error:X->{N,caught,error,X}
            after
                io:fwrite("success\n")
            end.

%%使用catch语句
caught_try()->[{I,catch(generator_exception(I))}||I<-[1,2,3,4,5,6]].


%%包装math:sqrt函数
sqrt(Number) when Number<0 ->
    erlang:error({squareNegativeRootAgument,Number});
sqrt(Number)-> math:sqrt(Number).


%%跟踪异常栈

show_exception_stack()->try generator_exception(5)
                       catch
                            error:X  -> {X,erlang:get_stacktrace()}
                    end.





test_record()->
    Data=#r_player_hero{

        battle_heros = [1]          % 上阵武将
        ,hero_equips = [2,3]          % 武将装备
        ,hero_bag = [3]  % 武将背包
        ,open_pos = 1              % 开放的位置
        ,open_embattle_pos=1       % 布阵位置
        ,hero_lifestar = [1]        % 武将命星
        ,hero_talisman = [1]         % 武将法宝
        ,deity_beast = [4] %% 神兽
    },
    tuple_to_list(Data).