---
layout: post
title: 先頭のゼロが抜け落ちた番号をzfillを使って修復する
feature-img: "assets/img/2019_07_01/tropical-greens-3809617_1280.jpg"   
tags: [data cleaning, pandas]
excerpt_separator: <!--more-->
---

顧客番号の先頭2桁が都道府県番号のように0（ゼロ）から始まる番号のゼロが抜け落ちたリストのデータクリーニングをした際に利用したmap とzfill メソッドの使い方をブログにまとめました。基本的な内容ですが、日常的に使う場面が多いと思います。演習用にデータフレームから用意しましたのでご参考になれば幸いです。

<!--more-->

#### 問題の所在

![zero_dropped]({{ "assets/img/2019_07_01/filling_00.png" | relative_url}})<br>


データフレームのとおり、２番目の北海道と宮城県の顧客番号数値（整数）で入力されてしまい、最初のゼロがありません。従って、文字数も７つとなってしまっています。　何も考えずに、エクセルで新規シートを作成し、手打ちで`01340788`{:style="color: red"}と入力すると、勝手に最初のゼロが取れて`1340788`{:style="color: blue"}となってしまいます。

>列の値に文字列と数値が混在してしまい、ゼロから始まる番号の0が抜け落ちでしまうデータの修復の手順を説明します
>
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}



#### チートシート

| やりたいこと                                                 | How To                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 顧客番号の列の値を文字列にする<br><br>`length`{:style="color: blue"}という列を追加して顧客番号の値の長さを求める | `df['顧客番号']=df['顧客番号'].astype(str)`{:style="background: #ffebf6"}<br><br>`df['length']=list(map(len, df['顧客番号']))`{:style="background: #ffebf6"}<br><br>`*値の長さを求めるには文字列のデータ型である必要あり`{:style="color: orange"} |
| 顧客番号の列の値を変数sに代入する<br><br>顧客番号の値の長さを「８」で統一する。<br>「７」しかないフィールドは先頭にゼロを追加する | `s = df['顧客番号']`{:style="background: #ffebf6"}<br/><br/>`df['顧客番号'] = pd.DataFrame(s.str.zfill(8))`{:style="background: #ffebf6"} |


#### コーディングサンプル

演習用のデータフレームを用意します。以下のコーディングをコピーしてJupyter Notebook で実行してみてください。

##### 演習用のデータフレームを用意する

{% highlight python linenos %}
# 必要なモジュールをインポートします
import numpy as np
import pandas as pd
# 演習用のデータフレームを作成します。
# ２番目の北海道と宮城県の顧客番号はint型でその他はstr型でデータフレームを作成
df = pd.DataFrame({'都道府県番号': [1,1,2,3,4,13,30,47],
                   '都道府県名': ['北海道', '北海道', '青森県','岩手県', '宮城県', '東京都', '和歌山県', '沖縄県'],
                  '顧客番号': ['01285679', 1340788, '02123782', '03541976', 4297411, '13299899', '30144450', '47339981']},
                    index=[0, 1, 2, 3, 4, 5, 6,7])
# データフレームを表示します
df
{% endhighlight %}

以下のように表示されると思います。２番目の北海道と宮城県の顧客番号数値（整数）のため最初のゼロが無い状況をシミュレーションしています。

![filling_01]({{ "assets/img/2019_07_01/filling_01.png" | relative_url}})<br>

##### 顧客番号の文字列の長さを求める

{% highlight python linenos %}
# 顧客番号の列をstr型にして、文字列の長さ(文字数）を
# 求められるようにする
df['顧客番号']=df['顧客番号'].astype(str)
# lengthという新しい列を追加して顧客番号の長さを求める
df['length']=list(map(len, df['顧客番号']))
df
{% endhighlight %}

以下のように表示されると思います。lengthという新しい列を追加され顧客番号の長さが示されています。

![filling_02]({{ "assets/img/2019_07_01/filling_02.png" | relative_url}})<br>

##### 顧客番号の長さを均一にする

{% highlight python linenos %}
# 顧客番号を変数sに代入する
s = df['顧客番号']
# 顧客番号の値の長さを「８」で統一する。
# 「７」しかないフィールドは先頭にゼロを追加する
df['顧客番号'] = pd.DataFrame(s.str.zfill(8))
df
{% endhighlight %}

以下のように表示されると思います。`赤枠で示しているとおり`{:style="color: red"} 
顧客番号の長さが「８」に統一され、７つしかない行の顧客番号のところには左詰で0が埋められています。

![filling_03]({{ "assets/img/2019_07_01/filling_03.png" | relative_url}})<br>

