---
layout: post
title: データを理解する　〜カテゴリカル・データの確認〜
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

前回の続きとして、データの中身を理解する手順を説明する。今回は、カテゴリカルデータの各要素を概観する。
<!--more-->
要素の総数はもちろん、集約したり、グラフで分布のイメージを持つ。

2の **「カテゴリカルデータの要素を概観する」**について説明する。
1. そもそもデータタイプがカテゴリカル・データかどうか
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

カテゴリカル・データでは、`df.dtypes`{:style="color: blue"}  と入力すれば、どんなデータが入っているかはわかる。
この例では、データフレーム名は`df` で、列名`Sc7Tdfk` に都道府県番号が入っている。

{% highlight python %}
df['Sc7Tdfk'].dtypes
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
CategoricalDtype(categories=[ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
                  16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                  31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
                  46, 47],
                 ordered=False)
{% endhighlight %}

各都道府県番号ごとの要素の数（度数）を見るには、`df['列名'].value_counts()`{:style="color: blue"}でわかる。
このデータを使って、調べてみることにする。

{% highlight python %}
df['R1E1'].value_counts()
{% endhighlight %}

結果は以下のとおり：

{% highlight python %}
13    4005
27    2562
23    1867
1     1418
14    1339
28    1317

<省略>

18     264
32     249
29     231
31     225
30     219
16     204
19     199
24     190
5      188
Name: R1E1, dtype: int64
{% endhighlight %}


整数にするには、
```df['列名']=df['列名'].astype(int)```{:style="color: blue"} でよい



{% highlight python %}
# data frame の'Sc7Tdfk' 列の型を整数にする
df['Sc7Tdfk']=df['Sc7Tdfk'].astype(int) 

# 確認する
df['Sc7Tdfk'].dtypes
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
dtype('int64')
{% endhighlight %}

整数の型になった、この列をカテゴリカルのデータ型に変換する。Categoricalメソッドを使う。
具体的には：```df['列名']=pd.Categorical(df.列名)```{:style="color: blue"} である。

{% highlight python %}
# data frame の'Sc7Tdfk' 列の型をカテゴリカルデータ型にする
df['Sc7Tdfk']=pd.Categorical(df.Sc7Tdfk)

# 確認する
df['Sc7Tdfk'].dtypes
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


