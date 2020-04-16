---
layout: post
title: データを理解する（カテゴリカル・データ）
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データクリーニングの一連の作業のうち、データの中身を理解する手順を説明する。カテゴリカルデータを理解するためのPython
<!--more-->
での具体的な方法について説明する。

手順は、以下のとおり
1. そもそもデータタイプがカテゴリカル・データかどうか
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. NAN（欠損値）の有無を調べる

データフレーム（df) の各列のデータの型を調べるには、`df.dtypes` と入力すればいい。
{% highlight python %}
# data frame の各列のデータ型を見る
df.dtypes  
{% endhighlight %}

すると、以下のようにアウトプットされる。
この例では、データフレーム名は``df`` という名前で列の数は６３列ある。
{% highlight py %}
R1A1      object
R1B1     float64
R1B1a    float64
R1C1     float64
R1C1a    float64
R1D1      object
R1E1     float64
R1F1     float64
R1G1     float64
 <省略>
R1H1      object
R1I1     float64
R1J1     float64
R1K1     float64
R1L1     float64
R1M1     float64
R1N1     float64
Length: 63, dtype: object
dtype: object
{% endhighlight %}

上記のように　`R1E1` はカテゴリカル・データであるが、実際は都道府県番号が入っているがデータを読み込むにあたり、
`fload64` と認識されている。そこで、カテゴリカルデータをに変更する。　都道府県番号なので、
まず、`float65` から整数 `int64` に変更してそれから、カテゴリカルデータに変更する。

整数にするには、
```df['列名']=df['列名'].astype(int)```でよい



{% highlight python %}
# data frame の'R1E1' 列の型を整数にする
df['R1E1']=df['R1E1'].astype(int) 

# 確認する
df['R1E1'].dtypes
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
dtype('int64')
{% endhighlight %}

整数の型になった、この列をカテゴリカルのデータ型に変換する。Categoricalメソッドを使う。
具体的には：```df['列名']=pd.Categorical(df.列名)```　である。

{% highlight python %}
# data frame の'R1E1' 列の型をカテゴリカルデータ型にする
df['R1E1']=pd.Categorical(df.R1E1)

# 確認する
df['R1E1'].dtypes
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
CategoricalDtype(categories=[ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
                  16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                  31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
                  46, 47],
                 ordered=False)
{% endhighlight %}


## ひとこと
> 解析するデータの中身によるが、私の経験では連続データより圧倒的に多い、性別、県番号、業種、評価等、枚挙にいとまがない。これらカテゴリカル・データはデータ解析では、説明変数では「ダミー変数化」する。　また、目的変数では分類問題のモデルで解析する。


