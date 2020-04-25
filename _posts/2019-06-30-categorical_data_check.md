---
layout: post
title: カテゴリカル・データの確認
hide_title: false                                 # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
# Sthumbnail: "assets/img/2019_06_30/code-1839406_1920.jpg"   # Add a thumbnail image on blog view
color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in post
bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データクリーニングの一連の作業のうち、データ型を確認する手順を説明します。
<!--more-->
カテゴリカルデータを処理するための最初の一歩です。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
データの型を調べる | df.dtypes
整数型にする  | df['列名']=df['列名'].astype(int)
カテゴリカル型にする  | df['列名']=pd.Categorical(df.列名)

---

ここでは、１の **「そもそもデータタイプがカテゴリカル・データかどうか」**について説明します。
1. **そもそもデータタイプがカテゴリカル・データかどうか**
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. NAN（欠損値）の有無を調べる


データフレーム[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} の各列のデータの型を調べるには、`df.dtypes`{:style="color: blue"}  と入します。
{% highlight python %}
# data frame の各列のデータ型を見る
df.dtypes  
{% endhighlight %}

アウトプットです。

データフレーム名は[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}という名前で14列ですね。
{% highlight py %}
PY_01     object
PY_02    float64
PY_03      int64
PY_04    float64
PY_05      int64
PY_06     object
PY_07    float64
PY_08    float64
PY_09      int64
PY_10     object
PY_11      int64
PY_12    float64
PY_13    float64
Py_14    float64
dtype: object
{% endhighlight %}

`PY_07` はカテゴリカル・データなので、実際は都道府県番号が入っています。
しかし、データを読み込むにあたり、`float64` と認識されています。カテゴリカルデータの方に変更します。　

都道府県番号なので、まず、`float64` から整数 `int64` に変更してそれから、カテゴリカルデータに変更します。

整数にするには、
```df['列名']=df['列名'].astype(int)```{:style="color: blue"} とします。



{% highlight python %}
# data frame の'PY_07' 列の型を整数にする
df['PY_07']=df['PY_07'].astype(int) 
# 確認

df['PY_07'].dtypes
{% endhighlight %}

結果は以下のとおりです：
{% highlight python %}
dtype('int64')
{% endhighlight %}

次に、カテゴリカルのデータ型に変換する。Categoricalメソッドを使います。
具体的には：```df['列名']=pd.Categorical(df.列名)```{:style="color: blue"} です。

整数型や浮動小数点型にする時と構文が異なります

{% highlight python %}
# data frame の'PY_07' 列の型をカテゴリカルデータ型にする
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


### ひとこと
> カテゴリカル・データの場合、データの型が正しく読み込まれているかの確認作業は必須です。　カテゴリカル・データといっても、データの中身が整数で種類を表したりすると、今回の例のように整数型は浮動小数点型として認識している事が多々あります。注意が必要ですね。


