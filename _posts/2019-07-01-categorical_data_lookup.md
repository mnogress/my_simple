---
layout: post
title: カテゴリカル・データの要約
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

前回の続きとして、カテゴリカル・データの中身を要約し、理解を深める手順を説明する。データの理解は、分析の大前提である。
<!--more-->
ここの要約では、要素の総数はもちろん、集約したり、グラフで分布のイメージを持つ。

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
'列' のカテゴリ変数の値をカウントする（重複は除く） | df['列名'.value_counts()]
要約された統計量をみる  | df['列名'].describe()
ヒストグラムを作図する  | sb.countplot(x='列名', data=df, palette='hls')

---

カテゴリカル・データでは、`df.dtypes`{:style="color: blue"}  と入力すれば、どんなデータが入っているかはわかる。
この例では、データフレーム名は`df` で、列名`PY_07` に都道府県番号が入っている。

{% highlight python %}
df['PY_07'].dtypes
{% endhighlight %}

結果は以下のとおりで、この列を使えば、４７都道府県ごとに分類できる。
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
df['PY_07'].value_counts()
{% endhighlight %}

結果は以下のとおり：

{% highlight python %}
13    1114
27     691
23     508
14     406
1      388
28     364
12     267
11     228
20     223
22     208
40     205
4      163
21     151
15     136
34     130

<省略>

24      60
29      59
35      58
45      55
18      54
25      53
42      50
39      41
36      38
5       33
41      15
32      10
Name: PY_07, dtype: int64

{% endhighlight %}

リストを見ても中身を十分理解できないので、分布のイメージを`describe`{:style="color: blue"}  メソッドで定量的に掴む。　以下のように打つ。

```df['列名'].describe()```


{% highlight python %}
# カテゴリカル・データの列にある中身を定量的に見る
df['PY_07'].describe()
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
count     7507
unique      47
top         13
freq      1114
Name: PY_07, dtype: int64
{% endhighlight %}

これで、総度数（count)は、7507,　種類の総数 (unique)は、47種類。　 最も多い種類 (top)は、「13（東京都」 で、最頻値 (freq) 1114個であることがわかる。

次に、棒グラフで見てみる。

{% highlight python %}
# 度数分布図をseaboan 書く
import seaborn as sb
sb.set_style('whitegrid')
sb.countplot(x='PY_07', data=df, palette='hls')
{% endhighlight %}

結果は以下のとおり：
![BarChart]({{ "assets/img/2019_07_01/dl_04_18.png" | relative_url}})



## ひとこと
> 解析するデータの中身によるが、私の経験では連続データよりカテゴリカル・データの方が圧倒的に多い、性別、県番号、業種、評価等、枚挙にいとまがない。カテゴリカル・データのデータ解析は、説明変数として使う場合は、「ダミー変数化」する。　また、目的変数では分類問題のモデルで解析する。　これらもの使い方もこのサイトで説明していきたい。


