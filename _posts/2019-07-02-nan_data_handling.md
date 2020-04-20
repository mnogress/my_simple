---
layout: post
title: 欠損値のハンドリング
hide_title: false                                 # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
# Sthumbnail: "assets/img/2019_06_30/code-1839406_1920.jpg"   # Add a thumbnail image on blog view
color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in post
bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データクリーニングの一連の作業の中で、重要な作業の一つである欠損値の取り扱い方について述べる。
<!--more-->
欠損値が含まれたままだと、エラーとなり分析はできない。

手順は、以下のとおりで、ここでは、3の **「NAN（欠損値）を適切に処置する」**について説明する。
1. **そもそもデータタイプがカテゴリカル・データかどうか**
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. **NAN（欠損値）を適切に処置する**

---
**チートシート**：

やりたいこと | コーディング
---------- | -------------
各列の欠損値の有無とその総数を調べる | df.isnull().sum()
特定の列のNanのある行を外す | df = df[df['列名'].isnull() == False]
データフレームのサイズ（行数、列数）を確認する  | df.shape

---

データフレーム（df) の各列の欠損値の有無とその総数を調べるには、`df.isnull().sum()`{:style="color: blue"}  と入力すると、欠損値の有無。無ければゼロを返す。ある場合はその個数を返す。　早速、用意したデータフレーム`df` で欠損値の状況を見る。
{% highlight python %}
# data frame の各列の欠損値の有無を確認する
df.isnull().sum() 
{% endhighlight %}

すると、以下のようにアウトプットされる。
この例では、データフレーム名は``df`` という名前で列の数は14列ある。
{% highlight py %}
PY_01       0
PY_02     830
PY_03       0
PY_04    5014
PY_05       0
PY_06    3977
PY_07       0
PY_08       2
PY_09       0
PY_10       0
PY_11       0
PY_12    7507
PY_13      14
Py_14      14
dtype: int64
{% endhighlight %}

上記のように　`PY_12` はすべて欠損値（NaN) である。　また、`PY_04` は5014個のNaN がある。`PY_06` でも5014個のNaN がある。
欠損値の処理としては
1. 欠損値のある行を落とす = 計算から除外する
2. 欠損値を0で埋める
3. 前の値で欠損値を代替する
種々の方法があるが、よく一般的な方法として紹介されている

「`df.dropna()`{:style="color: blue"} = 欠損値が一つでも含まれていたら、行を落とす」　をこのデータフレームで行ったりすると
空っぽになり、データ分析ができなくなってしまう。　仮に、この列`PY_12` ごと外してしまい、13列のデータフレームとして解析をするにしても、
5014行NaN がある`PY_04` 及び　3977行NaN がある`PY_06` の影響で殆ど残らない。

分析の実際においては、どうしても欠損値があると分析が難しくなるような場合を除き、そのままにしている。　ここでは、`PY_13` はこの列を使って
特徴量を計算するため、14個のNaN のある行を落とすこととする。

整数にするには、
```df = df[df['列名'].isnull() == False] ```{:style="color: blue"} でよい

行を落とすので、データフレームのサイズが変わることとなるので、行を落とす前と後のサイズを記録する。
データフレームのサイズの確認は ```df.shape``` でできる。

{% highlight python %}
# data frame の'PY_13' 列のNaN のある行を落とす。
# 前後のデータフレームのサイズを記録する。
print('before', df.shape)
df = df[df['PY_13'].isnull() == False]  
print('after', df.shape)
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
before (7507, 14)
after (7493, 14)
{% endhighlight %}

7505 マイナス　7493 イコール 14 ということで、14行落とした。

再度、NaNの数を確認する。

{% highlight python %}
df.isnull().sum() 
{% endhighlight %}


{% highlight python %}
PY_01       0
PY_02     830
PY_03       0
PY_04    5000
PY_05       0
PY_06    3967
PY_07       0
PY_08       2
PY_09       0
PY_10       0
PY_11       0
PY_12    7493
PY_13       0
Py_14       0
dtype: int64
{% endhighlight %}

結果は以下のとおり：
`PY_13` と`PY_14` にあった、NaN はどうやら同じ行に存在していたようだ。　`PY_14`のNaNもなくなった。
更に、`PY_06` のNaN の数も3977から3967と10個減っている。


## ひとこと
> 解析するデータの中身によるが、私の経験では連続データよりカテゴリカル・データの方が圧倒的に多い、性別、県番号、業種、評価等、枚挙にいとまがない。カテゴリカル・データのデータ解析は、説明変数として使う場合は、「ダミー変数化」する。　また、目的変数では分類問題のモデルで解析する。　これらもの使い方もこのサイトで説明していきたい。


