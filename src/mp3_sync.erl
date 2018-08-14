%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 八月 2018 14:56
%%%-------------------------------------------------------------------
-module(mp3_sync).
-author("Administrator").

%% API
-export([get_word/2]).
-export([unpack_header/1]).


%%从输入数据Bin中的N开始获取32位用于分析
get_word(N,Bin)->{_,<<C:4/binary,_/binary>>}=split_binary(Bin,N),
            C.

%%对头进行解包
unpack_header(X)->
    try
       decode_header(X)
    catch
        _:_ -> error
    end.

%%对输入数据进行解码
decode_header(<<2#11111111111:11,B:2,C:2,_D:1,E:4,F:2,G:1,Bits:9>>)->
    Vsn= case B of
             1 ->{2,5};
             2 ->2;
             3 ->3;
             0 ->exit(badVsn)
         end,
    Layout= case C of
                1 ->exit(badLayout);
                2 ->1;
                3 ->2;
                0 ->3
            end,
    BitRate=bitrate(Vsn,Layout,E)*1000,
    SampleRate=samplerate(Vsn,F),
    Padding=G,
    FrameLength=framelength(Layout,BitRate,SampleRate,Padding),
    if
        FrameLength < 21 -> exit(frameSize);
        true ->
            {ok,FrameLength,{Layout,BitRate,SampleRate,Vsn,Bits}}
    end;
decode_header(_)->exit(badHeader).

