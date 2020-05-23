---
layout: post
title: 欠損値のハンドリング
hide_title: false                                 # Hide the title when displaying the post, but shown in lists of posts
feature-img: "assets/img/2019_06_30/code-1839406_1920.jpg"              # Add a feature-image to the post
# color: rgb(80,140,22)                             # Add the specified color as feature image, and change link colors in 
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---


データセット内の「計算する列」に欠損値が含まれていると、Python は処理エラーとなり分析できません。欠損値を削除したり、代替するなどして、Pythonを正常に稼働するようにデータセットの中身を整え（クリーニング）ます。
<!--more-->
今回もオリジナルデータを使用します。
[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}にデータセットの概要があります。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
各列の欠損値の有無とその総数を調べる | df.isnull().sum()
特定の列のNaNのある行を外す | df = df[df[&#39;列名&#39;].isnull() == False]
データフレームのサイズ（行数、列数）を確認する  | df.shape


---

データの理解の流れは、以下のとおりです。

1. データタイプがカテゴリカル変数かどうか確認する
2. カテゴリカルデータの要素を概観する
 - 総数
 - 種類
 - 種類ごとの数（集計）
3. **欠損値（NaN）を処理する**

今回は、3の **「欠損値（NaN）を処理する」**です。　データセットは`オリジナルデータ｀を使います。

---

### 欠損値の処理

データフレーム[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} の各列の欠損値の有無とその総数を調べるには、`df.isnull().sum()`{:style="color: blue"}  と入力します。すると、欠損値の有無。無ければゼロを返します。欠損値があれば、その個数を返します。データフレーム[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} 全体の欠損値の状況を見ます。

{% highlight python linenos %}
# data frame の各列の欠損値の有無を確認する
df.isnull().sum() 
{% endhighlight %}

データフレーム名[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} の14列のうち、7列で欠損値を有します。
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
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


`PY_12` はすべて欠損値（NaN) です。また、`PY_04` は5014個の欠損値があります。`PY_06` は5014個のNaNが存在します。

---

### 一般的な欠損値の処理方法


欠損値の処理として以下が紹介されています。

1. 欠損値のある行を落とす => NaNを計算から除外し、データフレームを再構成する
2. 欠損値を0で埋める
3. 前の値で欠損値を代替する

しかし、実際の処理はどうでしょう。　方法１は以下のような問題があります。

「`df.dropna()`{:style="color: blue"} = 欠損値が一つでも含まれていたら、行を落とす」　方法をこのデータフレームに適用すると、`PY_12`列により、すべての行が落とされ、空っぽになります。　これでは、データ分析ができませんね。　仮に、この列`PY_12` は削除し、残り13列のデータフレームとして解析をするにしても、
5014行もの欠損値がある`PY_04` 及び　3977行で欠損値がある`PY_06` の影響で殆ど残らないと思います。データフレーム全体で欠損値がある行をすべて落とすということは、折角収集して作り上げたデータフレームの一部しか使えない場合があります。

方法2「欠損値=> 0 に置き換える」はどうでしょう。

データの型が`int`や`float`であれば、使えないこともありませんが、データタイプがカテゴリカル変数で「0」は、意味をなさず、使えません。（カテゴリカル変数の種類として0 があり、それとNaN を同じと前提できるのであれば、使える場合は除きます）。

方法3は、データの内容を一定の前提のもと、変更してしまうこととなりますので、多くの場合、解析には適していません。

---

### 特定の行の欠損値にのみ着目して削除する

欠損値が14個ある、`PY_13` は欠損値の行を落として、データフレームを再構成します。他の欠損値はそのまま残します。

特定の行の欠損値にのみ着目して、欠損値を削除するには、

```df = df[df['列名'].isnull() == False] ```{:style="color: blue"} と入力します。

行を落とした結果、全体のデータフレームのサイズが変わってしまいます。　そこで、行を落とす前と後のサイズを記録しておきます。
データフレームのサイズの確認は ```df.shape``` で（行数、列数）を返します。

{% highlight python linenos %}
# data frame の'PY_13' 列のNaN のある行を落とす。
# 前後のデータフレームのサイズを記録する。
print('before', df.shape)
df = df[df['PY_13'].isnull() == False]  
print('after', df.shape)
{% endhighlight %}

結果：
{% highlight python %}
before (7507, 14)
after (7493, 14)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

7505 マイナス　7493 イコール 14 ということで、14行落としました。

再度、NaNの数を確認します。

{% highlight python linenos %}
# NaNを確認
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
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


`PY_13` と`PY_14` にあった、NaN はどうやら同じ行に存在していたようです。　`PY_14`の欠損値もなくなりました。
更に、`PY_06` の欠損値の数も3977から3967と10個減りました。


### ひとこと
> 欠損値は必ず存在します。特に、データ操作が少ない、生データであればあるほど、欠損値が存在しています。<br>解析に重要な列の欠損値のみ削除します。しかし、行の削除はデータの総数が変わり、データセットを再構成したことになります。<br>"0"等の別の値を代入した場合も含め、欠損値をどのように処理したかは、解析を開始する前にデータ提供部門とミーティングを開催するなどして了解を得ることが賢明です。


