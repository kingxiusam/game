%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 八月 2018 13:37
%%%-------------------------------------------------------------------
-module(pp).
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