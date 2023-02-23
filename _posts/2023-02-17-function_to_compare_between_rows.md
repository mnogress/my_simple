---
layout: post
title: データフレーム内の列間の値を比較する
feature-img: "assets/img/2020_08_15/flowers-g500bc7407_640.jpg"
tags: [Python, 関数, データフレーム操作 ]
excerpt_separator: <!--more-->
---

二つ以上のデータフレームを結合し、データをクリーニングする際、よく必要となるデータフレーム内の異なる列間で値の一致、不一致を調べる関数を紹介します。

<!--more-->
一致のみならず、大小比較も等式を変更するだ、応用の範囲の広い関数例です。

---

### 問題の所在

以下のようなケースを想定しています。

![what_is_problem]({{ "assets/img/2020_08_15/fig4.png" | relative_url}})<br>


### 関数を定義する

`if row['記録 列A'] == row['報告 列B']:` の等式`==`　で一致であれば、1を返し、不一致の場合は9を返すようにしています。

{% highlight python linenos %}

def func_row_check(row):
    """
    列間を比較する

    引数:
        row['col1']: 比較したい列名 col1
        row['col2']: 比較したいもう一つの列名 col2

    Returns:
        1 : 一致
        9 : 不一致
    """
    if row['記録 列A'] == row['報告 列B']:
        return 1
    else:
        return 9

{% endhighlight %}

上図はコメントを入れた関数になっています。実際に必要なコードはLine #1,13,14,15,16 だけで十分です。簡単ですね。 

### 関数を適用する

関数を適用した結果は、列名「結果」という新しい列に内容を追加します。

{% highlight python %}

df['結果'] = df.apply(func_row_check, axis=1)

{% endhighlight %}


### データフレームで内容を確認
 
![fnction]({{ "assets/img/2020_08_15/fig6.png" | relative_url}})<br>


---

### サンプルコード（練習用データ付き）

サンプルコードでは、データフレームの作成から、関数の定義と適用、結果の確認までを紹介していますので、お手元の
Python 環境(Jupyrt Notebook 等)でお確かめくださいませ。


{% highlight python linenos %}

# 必要なモジュールをインポートします
import numpy as np
import pandas as pd
# 演習用のデータフレームを作成します。
df = pd.DataFrame({ '社員番号': ['01285679', '01340788', '02123782', '03541976', '04297411', '13299899', '30144450', '47339981'],
                   '記録 列A':   [4,3,2,1,4,2,3,8],
                   '報告 列B': [4,3,2,2,4,0,3,8]},
                    index=[0, 1, 2, 3, 4, 5, 6,7])
# オリジナルのデータフレームを表示
display(df)
# 関数を定義
def func_row_check(row):
    """
    列間を比較する

    引数:
        row['col1']: 比較したい列名 col1
        row['col2']: 比較したいもう一つの列名 col2

    Returns:
        1 : 一致
        9 : 不一致
    """
    if row['記録 列A'] == row['報告 列B']:
        return 1
    else:
        return 9
# 関数を適用
df['結果'] = df.apply(func_row_check, axis=1)
# 結果のデータフレームを表示
display(df)

{% endhighlight %}


>
`[ここがポイント！]`{:style="color: blue; font-size: 1.3em; background-color: #ffe3e2"} 
`df['結果'] = df.apply(func_row_check, axis=1)` で `axis=1`{:style="background: #ff0044; color: white"} の指定をしないと
デフォルトでは、`axis=0`のため`KeyErro`で例外となってしまい関数が上手く働きません。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 1.0em"}

---


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [先頭のゼロが抜け落ちた番号をzfillを使って修復する](https://www.so-wi.com/2021/02/27/filling_zeros_right.html){:target="_blank"}<br>
2) [任意の列の計算結果を新しい列に格納 lambda](https://www.so-wi.com/portfolio/lambda-if-new){:target="_blank"}<br>
3) [df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}