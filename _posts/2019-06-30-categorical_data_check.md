---
layout: post
title: カテゴリカル変数の確認
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
# bootstrap: true                                   # Add bootstrap to the page
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データクリーニングの一連の作業のうち、データ型を確認する手順を説明します。カテゴリカルデータを処理するための最初の一歩です。
<!--more-->

---

### チートシート

やりたいこと | コーディング
---------- | -------------
データの型を調べる | df.dtypes
整数型にする  | df[&#39;列名&#39;]=df[&#39;列名&#39;].astype(int)
カテゴリカル型にする  | df[&#39;列名&#39;]=pd.Categorical(df[&#39;列名&#39;])

---

カテゴリーデータとは、名前やラベルに基づいて保存し、識別することができる情報の形式を指します。 数値で測定するのではなく、カテゴリーに分類することができる定性的なデータの一種です。

このデータ型は、性別や都道府県などを示すカテゴリー変数で構成されています。 カテゴリカルな測定値は数値で与えられるのではなく、自然言語による記述で与えられます。数字がそれを表すこともあるが、その数字は数学的には何の意味もありません。 カテゴリカルデータの例としては以下のようなものがあります：

- 生年月日
- 電話番号
- 好きな色
- 洋服のサイズ

この例では、生年月日や電話番号が数字で構成されています。 数値が含まれていても、カテゴリーデータとして扱われます。 提供されたデータがカテゴリー的か数値的かを判断する方法として平均値を計算することが簡単な方法です。

>
平均値を把握できれば（平均値に意味があれば）、数値データとみなされます。 
平均値を把握できない（平均値に何も意味がない）場合は、カテゴリーデータとみなされます。
>

---

次に、分析データが **「カテゴリカル変数として定義されてるか」**について考えてみましょう。
以下の手順で確認します。

>
1. そもそもデータタイプがカテゴリカル変数かどうか
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. NAN（欠損値）の有無を調べる
>


オリジナルデータセット[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} の各列のデータの型を調べるには、`df.dtypes`{:style="color: blue"}  と入力するだけです。

{% highlight python linenos %}
# data frame の各列のデータ型を見る
df.dtypes  
{% endhighlight %}

以下がアウトプットです。

データフレーム名は[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}という名前で14列ありました。

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
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

`PY_07` の内容は、数字ですがその実態は都道府県番号です。
しかし、データを読み込むにあたり、`float64` と認識されており、例えば東京の番号`13` 
に対して`13.0` と小数点付きの数字で扱われてしまいます。

従って、まず整数にして小数点を取り払い、その後カテゴリカルデータに変更する2段階のステップを踏む必要があります。　

`float64` から整数 `int64` に変更してそれから、カテゴリカルデータのデータ型に変更します。
整数にするには、
```df['列名']=df['列名'].astype(int)```{:style="color: blue"} とします。



{% highlight python linenos %}
# data frame の'PY_07' 列の型を整数にする
df['PY_07']=df['PY_07'].astype(int) 
# 確認

df['PY_07'].dtypes
{% endhighlight %}

結果は以下のとおり整数型になりました：
{% highlight python %}
dtype('int64')
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

次に、カテゴリカルのデータ型に変換します。Categoricalメソッドを使います。
具体的には：```df['列名']=pd.Categorical(df['列名'])```{:style="color: blue"} です。

整数型や浮動小数点型にする時と構文が異なります

{% highlight python linenos %}
# data frame の'PY_07' 列の型をカテゴリカルデータ型にする
df['PY_07']=pd.Categorical(df['PY_07'])

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
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


### ひとこと
> カテゴリカル変数の場合、データの型が正しく読み込まれているかの確認作業は必須です。　カテゴリカル変数といっても、データの中身が整数で種類を表したりすると、今回の例のように整数型は浮動小数点型として認識している事が多々あります。注意が必要ですね。


