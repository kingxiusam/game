%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 八月 2018 13:37
%%%-------------------------------------------------------------------
-module(lib_misc).
-author("Administrator").
%% API
-export([game/0]).
-export([total/1]).
-export([sum/1]).
-export([for/3]).
-export([map/2]).
-export([qsort/1]).
-export([pythag/1]).
-export([perms/1]).
-export([max/2]).
-export([filter/2]).
-export([odds_and_evens/1]).
-export([odds_and_evens_acc/1]).
-export([match/1]).
-export([some_funx/1]).



game()->
    io:fwrite("this is app print\n").

total([{What,N}|T])->shop:cost(What)*N+total(T);
total([])->0.
%%同名不同目的的函数
%%用于计算列表L所有元素的综合
sum(L)->sum(L,0).
%%辅助函数
sum([],N)->N;
sum([H|T],M)->sum(T,H+M).

%%自定义for循环实现
for(Max,Max,F)->[F(Max)];
for(I,Max,F)->[F(I)|for(I+1,Max,F)].

%%自定义map实现,对列表进行操作
map(_,[])->[];
map(F,[H|T])->[F(H)|map(F,T)].

%%快速排序算法
qsort([])->[];
qsort([Pivot|T])->qsort([X||X<-T,X=<Pivot])
        ++[Pivot]++
        qsort([X||X<-T,X>Pivot]).
%%生成毕达格拉斯三元组
pythag(N)->[{A,B,C}||
%%            使用生成器和过滤器
                A<-lists:seq(1,N),
                B<-lists:seq(1,N),
                C<-lists:seq(1,N),
                A+B+C=<N,
                A*A+B*B=:=C*C
            ].
%%变位词
perms([])->[[]];
perms(L)->[[H|T]||H<-L,T<-perms(L--[H])].

%%断言的使用
max(X,Y) when is_integer(X),X>Y -> X;
max(X,Y)->Y.


%%case表达式
%%使用case表达式定义过滤器
filter(P,[H|T])->
    case P(H) of
        true->[H|filter(P,T)];
        false->filter(P,T)
    end;
filter(P,[])->[].

odds_and_evens(L)->
    Odds=[X||X<-L,X rem 2 =:=0],
    Evens=[X||X<-L,X rem 2 =:=1],
%%    构造器{[偶数列表],[奇数列表]}
    {Odds,Evens}.


        %%优化
%%初始化分解列表
odds_and_evens_acc(L)->odds_and_evens_acc(L,[],[]).
%%具体的分解逻辑
odds_and_evens_acc([H|T],Odds,Evens)->
    case H rem 2 of
%%        [H|Odds] [H|Evens]元素满足条件时加入到列表头部
        0->odds_and_evens_acc(T,[H|Odds],Evens);
        1->odds_and_evens_acc(T,Odds,[H|Evens])
    end;
%%当列表为空的时候,返回传入参数的构造值
odds_and_evens_acc([],Odds,Evens)->{Odds,Evens}.

%%if表达语句

match(N)->
    if
        N==1->io:fwrite("this is one\n") ;
        N/=1->io:fwrite("this is other\n")
    end.


%%下划线变量的使用
some_funx(X)->
    {P,_Q}=some_funx(X),
%%    io:format("_Q=~p~n",_Q),
    P.