---
layout: post
title: Pandas 列内のデータをN分割して、それぞれをセミコロンで連結した新しい列を作成する
feature-img: "assets/img/2020_08_15/background-6360864_640.png"   
tags: [pandas, concat]
excerpt_separator: <!--more-->
---

データセットに格納されたある列のデータを抜き出す作業で、ひとつずつではなく複数の塊にまとめることとなり、
しかも`セミコロン ";" で連結したい`{:style="background: #64f5eb; font-size: 100%"}というリクエストに対応しましたので、Blogにまとめました。

<!--more-->

コードはかなりベーシックな内容ですが、データフレーム操作の基本から応用までの良いサンプルだと思います。

### 変換イメージ
データフレームの変換イメージを以下のとおり図示します。

![countplot]({{ "assets/img/2020_08_15/fig_splited_01.png" | relative_url}}){:height="85%" width="85%"}<br>

### サンプルコード

サンプルコードを以下に示します。データフレームの対象列を一旦リスト化して、N個ずつの塊に分割し、それを再びデータフレームに結合します。
その結果をCSVファイルに書き出し、それを再びデータフレームで読み込むなど、中間ファイルの一連の処理が行われます。もっと効率的に
実行できる方法も考えられますが、ここで使用されているテクニックは別の場面でも有用である可能性がありますので、参考にしてください。

{% highlight python linenos %}
# 必要なモジュールをインポートする
import numpy as np
import pandas as pd
import codecs

# アウトプットファイル 'output.csv'を初期化する
with open("output.csv", "w") as f:
    pass

# 対象となる列をリスト化する
np_array = df['random_words'].values
np_list = np_array.tolist()

# リスト化した対象列を 3(N=3)分割する 任意可能 
N = 3 
splited_df = [np_list[i:i+N] for i in range(0, len(df), N)]
# 操作しやすいようにデータフレームにしておく
df = pd.DataFrame(splited_df)

# データフレーム転置(4x3->3x4)してオリジナルデータを縦向きに書き出すようにする
df = df.T

# 転置した結果、4列になるのでそれぞれにカラム名をつける
collist = ['col1', 'col2', 'col3', 'col4']
df.columns = collist

# col1 to 4 のそれぞれのデータを";"で連結してPrint to file('output.csv') で書き出す
for i in collist:
    k = ";".join(df[i])
    print(k, "," , file=codecs.open('output.csv', 'a', 'utf-8'))

# 書き出された'output.csv'をデータフレーム(df)で読み込む
import codecs
with codecs.open("output.csv", mode ="r", encoding ="utf-8", errors="ignore") as file:
    df = pd.read_csv(file, delimiter =",", header=None)

# 余分な2番目のカラムを削除する
df = df.drop(columns=[1])

# カラム名'";" で連結したrandom_words'としてnotebook上に書き出し
df.columns = ['";" で連結したrandom_words']
display(df)

{% endhighlight %}

### 最終結果のデータフレーム

![countplot]({{ "assets/img/2020_08_15/fig_splited_02.png" | relative_url}}){:height="60%" width="60%"}<br>