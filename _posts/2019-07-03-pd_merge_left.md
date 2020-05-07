---
layout: post
title: データセットの結合
feature-img: "assets/img/2019_06_30/website-1624028_1280.jpg"   
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

2つのデータセットを共通の列で結合します。
<!--more-->
EXCELのVlookupのように共通列をキーにマッチする行へ結合し、要素を引き込みます。　
ここでは、「左結合」と呼ばれる結合元のデータセットのキー列で要素を引き込む方法を解説します。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
&#39;キー列&#39;でdfにdf2を左結合する | pd.merge(df, df2, how=&#39;left&#39;, on =&#39;キー列名&#39;)


---

### 概念図

左結合の概念図は以下のとおりです。

![merge_left]({{ "/assets/img/2019_07_01/pd_merge_left.png" | relative_url}})

### ポイント

1. df の左にdf2 が結合する
2. df のキー列は不変
3. df のキー列にない要素の行は結合されない　例では、df2のd行
4. df2 のキー列にない要素の行はNaNになる　例では、dfのc行


### データフレームdf とdf2 を結合する

本サイトでおなじみのオリジナルデータ[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} で操作します。これに、df2 というデータフレーム別途用意して左結合します。　各々のデータフレームのサイズは、以下のとおりです。

{% highlight python linenos %}
# df, df2 それぞれのサイズをプリントします
print('df', df.shape)
print('df2', df2.shape)
{% endhighlight %}

結果は以下のとおりです。
{% highlight python %}
df (7507, 10)
df2 (22596, 2)
{% endhighlight %}

いずれも`PY_09`という列が存在します。
共通の列`PY_09` の各々のサイズは、dfが7507行 でdf2が22596行あります。
更に、NaNの様子を確認します。

{% highlight python linenos %}
# df, df2 それぞれのNaNの数をプリントしておきます
print('df:','\n', df.isnull().sum())
print('\n')
print('df2:', '\n',df2.isnull().sum())
{% endhighlight %}

{% highlight python %}
df: 
 PY_02     830
PY_03       0
PY_05       0
PY_06    3977
PY_07       0
PY_09       0
PY_11       0
PY_12    7507
PY_13      14
PY_14      14
dtype: int64

df2: 
 PY_09     0
PY_20    44
dtype: int64
{% endhighlight %}


`PY_09` 列にいずれもNaN がありません。　では、df にdf2 を左結合します。 

{% highlight python linenos %}
# merge 前と後のデータフレームの構成を確認
print('before', df.shape)
df=pd.merge(df,df2, how='left', on = 'PY_09')
print('after', df.shape)
{% endhighlight %}

{% highlight python %}
before (7507, 10)
after (7507, 11)
{% endhighlight %}

結合の結果、df に追加された`PY_20` のNaNの数を確認します。

{% highlight python linenos %}
#　NaN 特にPY_20の数を確認
df.isnull().sum()
{% endhighlight %}



{% highlight python %}
PY_02     830
PY_03       0
PY_05       0
PY_06    3977
PY_07       0
PY_09       0
PY_11       0
PY_12    7507
PY_13      14
PY_14      14
PY_20      22
dtype: int64
{% endhighlight %}


---

### ひとこと

> 左結合をEXCEL のVlookup のように使うことが私は多いです。　解析に必要なデータフレームを作り上げるために特徴量を別のデータセットから引っ張ってこないと行けないことは日常茶飯事です。一度データをもらったら、解析がスタートとはいきません。こういった作業の必要性と協力もしくは理解を取り付けるため、解析を進める初期段階で関係者とよく話し合っておいたほうがいいと思います。


