---
layout: post
title: EXCELデータを機械学習用にデータをクリーニングする
feature-img: "assets/img/2019_07_01/argyle-909253_1280.jpg"   
tags: [data_handling, pandas]
excerpt_separator: <!--more-->
---

隣の部門(課)で共有して集計しているEXCELデータをオリジナルデータとして機械学習用のデータセットにする作業で
行ったデータクリーニングの実際をメモします。　一日半かけてクリーニング作業で山場は越えたところです。
来週の確認のミーティングまので間にしたためました。

エンドユーザ部門で共有するEXCELデータのクオリティはKaggle のデータセットとは大違いに、エラー入力、重複入力の
デパート状態でした。
<!--more-->

参照するデータは、ございません。クラウドで利用可能なCRMを使えば、こんなにデータクリーニング作業にかかることは無いと思います。

---

### チートシート

やりたいこと | 方法
---------- | -------------
エクセルファイルの複数シート<br>(&#39;３月&#39;, &#39;4月&#39;)をdf1, df2に読み込む | 1) xlsx = pd.ExcelFile(&#39;file.xlsx&#39;)<br>2) df1 = pd.read_excel(xlsx, &#39;３月&#39;, index_col=None, `header=4`{:style="background-color: #ffe3e2; font-size: 1.0em"})<br>3) df1 = pd.read_excel(xlsx, &#39;４月&#39;, index_col=None, `header=4`{:style="background-color: #ffe3e2; font-size: 1.0em"})
数値データ以外をNaNとする<br>特定の列のNaNの数を確認する | 1) df[&#39;日付&#39;] = pd.to_numeric(df[&#39;日付&#39;],errors = &#39;coerce&#39; )<br>2) df[&#39;日付&#39;].isnull().sum()
重複行の最初の行を残し、他を削除する | 1) df = df.drop_duplicates([&#39;会社ID&#39;], keep=&#39;first&#39; )

`header=4 :EXCELの5行目にヘッダーがある`{:style="background-color: #ffe3e2; font-size: 0.9em"}

---


### 今回使うデータのポイント

１） 入力ソースはEXCEL ファイルで、各月にシートは別れています。<br>
２） CRM 同様に企業IDごとに活動をEXCELで集計し主にステージングを状況をPivotやグラフでまとめています<br>
３） 従って、企業IDの重複は無い(あるべきではない）のに、それが1%弱あります。40,000のデータで重複は200～300程度あります<br>
４） 各営業のテリトリー内の企業へのCall(訪問) の記録が重要は営業情報です。しかし、Call Date(訪問日)の入力間違いが少なからずあります <br>
５） 入力間違いはいろいろで、YYYY/MM/DD のところをHやRで始まるもの、「令和」と漢字入力されているもの、'YYYY/MM/DD予定'となっているもの、ありえない日にち 1930/12/22やなぜか2018./10/13 と'点'が入ってるのまで発見 


### サンプルオペレーション

前提: 日付データはEXCEL上でシリアルデータに変更します。

１） EXCELファイルの各シートをdf1, df2..とそれぞれデータフレームとして読み込みます<br>
２） それぞれのデータフレームを連結して１つのデータフレームにします<br>
３） pd.to_numericでEXCELのDateシリアルでない文字列のデータをNaNにし、その行を削除します<br>
４） 分析期間でスライスします<br>
５） 企業IDで重複排除します。その際、最新のエントリーを残します。 

### EXCEL シート名９月、10月をそれぞれ、df1, df2 のデータフレームとして読み込みます

{% highlight python linenos %}
xlsx = pd.ExcelFile('file.xlsx')
df1 = pd.read_excel(xlsx, '９月', index_col=None, header=4)
df2 = pd.read_excel(xlsx, '１０月', index_col=None, header=4)
print ('９月', df1.shape)
print ('１０月', df2.shape)
{% endhighlight %}

df1, df2のサイズを確認します。

{% highlight python %}
９月 (14235, 81)
１０月 (3344, 49)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

### シートごとそれぞれをデータフレームとして読み込んだものを連結します

df1とdf2を連結します。 既存のインデックスは無視して新しくインデックスを振り直します。<br>
詳しくは[「Ignoring_indexes_on_the_concatenation_axis」](https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html#ignoring-indexes-on-the-concatenation-axis
){:target="_blank"}のサンプルを参照してください。

{% highlight python linenos %}
df12 = pd.concat([df1, df2], ignore_index=True, sort=False)
df12.shape
{% endhighlight %}

{% highlight python %}
(17579, 96)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

日付の列のNaN（欠損値）を削除します。　[欠損値のハンドリング]({{ "2019/07/02/nan_data_handling.html" | relative_url}}){:target="_blank"}の記事で紹介している`欠損値(NaN)の取り扱い方法`を参考にしてください。

{% highlight python linenos %}
print('before', df.shape)
df = df[df['日付'].isnull() == False]
print('after', df.shape)
{% endhighlight %}


{% highlight python %}
before (17579, 96)
after (17570, 96)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

9個のNaNを持つ行が削除されました。

### 文字列などEXCEL シリアル値でないデータをNaNにします

日付データには、HやRで始まるもの、「令和」と漢字入力されているもの、'YYYY/MM/DD予定'となっているものが多くあります。それらを一括してNaNにするため、`pd.to_numeric`{:style="background-color: #ffe3e2; font-size: 0.9em"}の`errors = 'coerce'`{:style="background-color: #ffe3e2; font-size: 0.9em"}を指定することで、うまく変換できない場合はNaNを戻り値にします。　
参照：[pandas.to_numeric](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.to_numeric.html#pandas-to-numeric){:target="_blank"}

{% highlight python linenos %}
df['日付'] = pd.to_numeric(df['日付'],errors = 'coerce' )
df['日付'].isnull().sum()
{% endhighlight %}

1520 もありました。

{% highlight python %}
1520
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

戻り値NaNとなっていますので、それを削除します。いつもの方法ですね。[欠損値のハンドリング]({{ "2019/07/02/nan_data_handling.html" | relative_url}}){:target="_blank"}の記事で紹介している`欠損値(NaN)の取り扱い方法`を参考にしてください。

{% highlight python linenos %}
print('before', df.shape)
df = df[df['日付'].isnull() == False]
print('after', df.shape)
{% endhighlight %}

{% highlight python %}
before (17570, 96)
after (16050, 96)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


この時点で、16050行、96列が計算対象になりました。

### 対象期間でデータをスライスします

このデータには、日付部分が無効なデータ以外に、1930/12/14 であるとか、2031/4/1という明らかに日付入力エラーのデータも存在しています。そこで、計算対象期間(2019/1/1 〜 2019/6/30)でスライスします。日付列はEXCELシリアル値で入っていますので、2018/12/31(期初の一日前)のシリアル値43465と2019/7/1(期末の翌日)43647でスライスします。

{% highlight python linenos %}
print('before', df.shape)
df = df[(df['日付'] > 43465.0) & (df['日付'] < 43647.0) ]
print('after', df.shape)
{% endhighlight %}

{% highlight python %}
before (16050, 96)
after (16044, 96)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


### 企業IDが重複しているデータを最新のデータを残して削除します

CRMと同様、企業ID一つに対してその状況アップデートしていますので、同じ企業IDを持つ行の重複は無いはずですが、実際には重複があります。最新のデータを残して、重複処理をします。そのためには：<br>
１） 日付で若い順にデータセットをソートします<br>
２） `df.drop_duplicates([ keep='first' )`{:style="background-color: #ffe3e2; font-size: 0.9em"}で最初のデータを残すとします。

{% highlight python linenos %}
df = df.sort_values(by = '日付', ascending=True)
print('before', df.shape)
df = df.drop_duplicates(['企業ID'], keep='first' )
print('after', df.shape)
{% endhighlight %}

{% highlight python %}
before (16044, 96)
after (16022, 96)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}



---

### ひとこと

> データクリーニングの実際をブログしました。元データの日付値をEXCELのシリアル値として読み込んで処理をしましたが、文字列で読み込んでクリーニングする方法もあるかと思います。EXCELの場合、1900//1/1を1としてシリアル値が付番されています。一方、PythonなどのUNIXTIMEは1970/1/1 00:00:00 からの経過秒数で表しています。シリアル値は期間等の計算には向いており、両者の特徴を理解して日付をハンドリングすることはとても重要なスキルとなります。

