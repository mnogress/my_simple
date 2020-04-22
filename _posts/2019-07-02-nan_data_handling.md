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
1. そもそもデータタイプがカテゴリカル・データかどうか
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
特定の列のNaNのある行を外す | df = df[df['列名'].isnull() == False]
データフレームのサイズ（行数、列数）を確認する  | df.shape

---

データフレーム（df) の各列の欠損値の有無とその総数を調べるには、`df.isnull().sum()`{:style="color: blue"}  と入力すると、欠損値の有無。無ければゼロを返す。ある場合はその個数を返す。　早速、用意したデータフレーム[df]({{ "2019/06/01/reference_data.html" | relative_url}}) で欠損値の状況を見る。_posts/2019-06-01-reference_data.md
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

---

上記のように　`PY_12` はすべて欠損値（NaN) である。　また、`PY_04` は5014個のNaN がある。`PY_06` でも5014個のNaN がある。
欠損値の処理としては
1. 欠損値のある行を落とす => NaNを計算から除外し、データフレームを再構成する
2. 欠損値を0で埋める
3. 前の値で欠損値を代替する

一般的な方法として上記のような方法を紹介されている。しかし、実際の処理はどうだろう。　方法１は以下のような問題がある。

「`df.dropna()`{:style="color: blue"} = 欠損値が一つでも含まれていたら、行を落とす」　をこのデータフレームで行ったりすると
空っぽになり、データ分析ができなくなってしまう。　仮に、この列`PY_12` ごと外してしまい、13列のデータフレームとして解析をするにしても、
5014行NaN がある`PY_04` 及び　3977行NaN がある`PY_06` の影響で殆ど残らない。

方法2は、データタイプが`int`や`float`であれば、使えないこともなりが、データタイプがカテゴリカル・データでは意味をなさず、使えない（カテゴリカル・データの種類として0 があり、それとNaN を同じと前提できるのであれば、使える場合もある）。

方法3は、データの内容を変えることとなるので、解析には適していない。

---

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

#### 結果：
`PY_13` と`PY_14` にあった、NaN はどうやら同じ行に存在していたようだ。　`PY_14`のNaNもなくなった。
更に、`PY_06` のNaN の数も3977から3967と10個減っている。


## ひとこと
> 欠損値は必ず存在する。　解析に重要な列での欠損値のある行は、基本は削除する。　しかし、行の削除はデータの総数が変わるので、欠損値をどのように処理したかは、解析を開始する前にデータ提供部門とミーティングを開催するなどして了解を得るのが賢明だ。


