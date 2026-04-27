---
layout: single
title: 異なる列間で値の一致、不一致を調べる
header:
  overlay_image: images/header_04_1280by336.png
  overlay_filter: rgba(44, 82, 207, 0.35)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  - wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
date: 2026-04-04
last_modified_at : 2026-04-04 11:00:00
excerpt: 
  データフレーム内の異なる列同士の値が一致しているか、不一致かを判定する関数の作り方と適用方法を紹介します。行単位で比較し、新しい列に結果を付与する実務でよく使う処理を、最小限のコードでシンプルにまとめた Reference 記事です。

---

<!--more-->
二つ以上のデータフレームを結合し、データをクリーニングする際、よく必要となるデータフレーム内の異なる列間で値の一致、不一致を調べる関数を紹介します。
一致のみならず、大小比較も等式を変更するだ、応用の範囲の広い関数例です。

---

### 問題の所在

実務では、同じ社員が提出したはずの報告データなのに、集計後に「列Aと列Bで値が違う」「本来同じはずの情報がズレている」といったケースがよく発生します。
たとえば、部署名の表記ゆれ、日付の入力ミス、マスタ更新漏れなど、原因はさまざまですが、人が入力したデータが複数の列にまたがると、どこかで不一致が生まれるのは珍しくありません。

こうした “同じはずなのに違う” 行を素早く見つけることは、データクレンジングや報告書の整合性チェックにおいて非常に重要です。

この記事では、Pandas を使って 行単位で複数列の一致・不一致を判定し、新しい列として付与するシンプルな関数の作り方 を紹介します。
最小限のコードで、実務で頻出する**「整合性チェック」**を効率化できます。

![what_is_problem]({{ "images/img/fig4.png" | relative_url}})<br>


### 関数を定義する

`if row['記録 列A'] == row['報告 列B']:`{:style="background: #eda0c4; font-size: 1.00em;"} の等式`==`{:style="background: #eda0c4; font-size: 1.00em;"}　で一致であれば、1を返し、不一致の場合は9を返すようにしています。

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
 
![fnction]({{ "images/img/fig6.png" | relative_url}})<br>


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

<div class="box33">
    <span class="box-title">ここがポイント！</span>
    <ol>
      <li><strong>df['結果'] = df.apply(func_row_check, axis=1)</strong>で、 <span class="rouge">axis=1</span>の指定すること</li>
      <li>デフォルトでは、<strong>axis=0</strong>のためKeyErroで例外となってしまい関数が上手く働きません。</li>
    </ol> 
</div>

---
