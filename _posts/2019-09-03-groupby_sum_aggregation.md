---
layout: post
title: 最初の7桁の文字単位にデータフレームを集約する
feature-img: "assets/img/2019_07_01/blue_kasumi.png"   
tags: [pandas, data_handling]
excerpt_separator: <!--more-->
---

日付データ`YYYY-MM-DD`の最初の7桁`YYYY-MM`でデータセットを`groupby`で集約します。　集約の演算は合計としています。
<!--more-->
[ラベルでインデックスしてplt.barで棒グラフ化する]({{ "2019/09/01/bar_plot_label_index.html" | relative_url}}){:target="_blank"}の記事で紹介したデータフレーム`df_month`を作成しながら、データ集約を説明します。


---

### チートシート

やりたいこと | コーディング
---------- | -------------
n桁の文字でsum()集約する<br> さらに列名変更と再インデクスする | df.groupby(df[&#39;Date&#39;].str[:n]).sum()<br>.reset_index().rename(columns={&#39;Date&#39; :  &#39;New_Date&#39;})
Dateオブジェクトを文字列オブジェクトに変える　| df[&#39;Date&#39;]=df[&#39;Date&#39;].astype(str)


---


### 今回使うデータのポイント

1. df.shape => 2919x 3
2. `Date` 列に`YYYY-MM-DD` の日付情報がある
3. `PY_03` は一回目のトライ成功=1 まはた不成功=0
4. `PY_05` に二回目のトライ成功=1 まはた不成功=0
2. 最初の７桁`YYYY-MM`が同じもの同士で集約して他の列の`PY_03`, `PY_05`の列のそれぞれの値の合計を計算する

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介しているオリジナルデータです。

[ラベルでインデックスしてplt.barで棒グラフ化する]({{ "2019/09/01/bar_plot_label_index.html" | relative_url}}){:target="_blank"}のデータフレーム`df_month`を作成します。

元のデータセットの`df.head()`と`df.shape` は以下のとおりです。

![df.shape]({{ "assets/img/2019_07_01/date_groupby_original.png" | relative_url}})

### アトリビュートエラーに注意

データセットの読み込む際のデータの型やDate列を計算によっては、データの型が`datetime64[ns]`のままの場合があります。　そのまま、`groupby`の操作をしようとすると、以下のようなエラーに遭遇します。　その場合は、データの方を`string`にすれば解決します。

`AttributeError: Can only use .str accessor with string values, which use np.object_ dtype in pandas`{:style="background-color: #ffe3e2; font-size: 0.9em"}

### サンプルオペレーション

デフォルトの0から始まるインデックスをラベルインデックスに変更します。

{% highlight python linenos %}
# データの型を確認する
df.dtypes
{% endhighlight %}

問題なさそうです。　Dateの行が`datetime64[ns]`だと、df[&#39;Date&#39;]=df[&#39;Date&#39;].astype(str)が必要です。

{% highlight python %}
Date     object
PY_03     int64
PY_05     int64
dtype: object
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

groupbyでsum集約します。ついでに、集約した列名も`Year of Month`とし、更に再インデックス化します。
また、その結果はdf_monthというデータフレームに代入し、そのデータフレームの行数、列数をとります（df.shapeします）

{% highlight python linenos %}
# 先頭7桁の文字単位にデータフレームをsum()集約、列名も変更し再インデクス化する
df_month=df.groupby(df['Date'].str[:7]).sum().reset_index().rename(columns={'Date': 'Year of Month'})
df_month.shape
{% endhighlight %}

以下のとおり、7行に集約されました。

{% highlight python %}
(7, 3)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

７行なので、データフレームすべてを表示しましょう。

![df.shape]({{ "assets/img/2019_07_01/result_df_month.png" | relative_url}})

可視化の記事[ラベルでインデックスしてplt.barで棒グラフ化する]({{ "2019/09/01/bar_plot_label_index.html" | relative_url}}){:target="_blank"}も一緒に御覧ください。


---

### ひとこと

> `groupby` はデータの集約化ではなくてはならないメソッドです。列の一部を共通項として集約もよく行う集約方法になります。集約する列が文字列とし扱う場合は、アトリビュートエラーに注意しましょう。　　
