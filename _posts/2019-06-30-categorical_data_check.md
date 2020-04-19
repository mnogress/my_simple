---
layout: post
title: カテゴリカル・データの確認
hide_title: true                                  # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
thumbnail: "assets/img/thumbnail/sample-th.png"   # Add a thumbnail image on blog view
color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in post
bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データクリーニングの一連の作業のうち、データの中身を理解する手順を説明する。カテゴリカルデータを理解するためのPython
<!--more-->
での具体的な方法について説明する。

手順は、以下のとおりで、ここでは、１の **「そもそもデータタイプがカテゴリカル・データかどうか」**について説明する。
1. **そもそもデータタイプがカテゴリカル・データかどうか**
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. NAN（欠損値）の有無を調べる

---
**チートシート**は、以下のとおり：

やりたいこと | コーディング
---------- | -------------
データの型を調べる | df.dtypes
整数型にする  | df['列名']=df['列名'].astype(int)
カテゴリカル型にする  | df['列名']=pd.Categorical(df.列名)

---

データフレーム（df) の各列のデータの型を調べるには、`df.dtypes`{:style="color: blue"}  と入力すればいい。
{% highlight python %}
# data frame の各列のデータ型を見る
df.dtypes  
{% endhighlight %}

すると、以下のようにアウトプットされる。
この例では、データフレーム名は``df`` という名前で列の数は14列ある。
{% highlight py %}
PY_01     object
PY_02    float64
PY_03      int64
PY_04    float64
PY_05      int64
PY_06     object
PY_07      int64
PY_08    float64
PY_09      int64
PY_10     object
PY_11      int64
PY_12    float64
PY_13    float64
Py_14    float64
dtype: object
{% endhighlight %}

上記のように　`PY_07` はカテゴリカル・データであるが、実際は都道府県番号が入っている。
しかし、データを読み込むにあたり、`fload64` と認識されている。そこで、カテゴリカルデータをに変更する。　都道府県番号なので、
まず、`float64` から整数 `int64` に変更してそれから、カテゴリカルデータに変更する。

整数にするには、
```df['列名']=df['列名'].astype(int)```{:style="color: blue"} でよい



{% highlight python %}
# data frame の'PY_07' 列の型を整数にする
df['PY_07']=df['PY_07'].astype(int) 

# 確認する
df['PY_07'].dtypes
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
dtype('int64')
{% endhighlight %}

整数の型になった、この列をカテゴリカルのデータ型に変換する。Categoricalメソッドを使う。
具体的には：```df['列名']=pd.Categorical(df.列名)```{:style="color: blue"} である。

{% highlight python %}
# data frame の'Sc7Tdfk' 列の型をカテゴリカルデータ型にする
df['PY_07']=pd.Categorical(df.PY_07)

# 確認する
df['PY_07'].dtypes
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
> 解析するデータの中身によるが、私の経験では連続データよりカテゴリカル・データの方が圧倒的に多い、性別、県番号、業種、評価等、枚挙にいとまがない。カテゴリカル・データのデータ解析は、説明変数として使う場合は、「ダミー変数化」する。　また、目的変数では分類問題のモデルで解析する。　これらもの使い方もこのサイトで説明していきたい。


