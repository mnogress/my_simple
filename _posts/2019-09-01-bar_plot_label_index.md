---
layout: post
title: ラベルでインデックスして plt.bar で棒グラフ化する
feature-img: "assets/img/2019_07_01/background-3084012_1280.jpg"   
tags: [pandas, data_visualization]
excerpt_separator: <!--more-->
---

データフレームの可視化の際、データフレームそのまま操作するのではなく、ラベルでインデックスをしてpltをかける方法を説明します
<!--more-->
更に、プレゼン用にグラフにタイトルを付けたりして装飾する方法も紹介します。


---

### チートシート

やりたいこと | コーディング
---------- | -------------
ラベルでインデックスをつけ直す | df.index = df.pop(&#39;Col&#39;)
インデックスをｘ軸に棒グラフを作成する　| df.plot.bar()

---


### 今回使うデータのポイント

1. df.shape => 7 x 3 に集約してデータフレーム名 `df_month`
2. デフォルトの0から始まるインデックスから`Year of Month`列をインデックスにします
3. `PY_03` に一回目のトライ成功数
4. `PY_05` に二回目のトライ成功数
5. 各月の`PY_03`と`PY_05` の結果が７ヶ月分ある

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`オリジナルデータ`です。


![df.shape]({{ "assets/img/2019_07_01/bar_plot_original_group_by.png" | relative_url}})



### サンプルオペレーション

デフォルトの0から始まるインデックスをラベルインデックスに変更します。

{% highlight python linenos %}
# Year of Month でインデックスする
df_month.index = df_month.pop('Year of Month')
df_month.head()
{% endhighlight %}


結果は以下のとおりです。 `Year of Month` 列にがインデックスになりました。

![df.shape]({{ "assets/img/2019_07_01/bar_plot_original_group_by.png" | relative_url}})

### 棒グラフを作図します

`df_month.plot.bar()` とコーディングするだけで以下のような図が出来上がります。 
line# 3,4のコーディングでY軸にラベルを棒グラフのタイトルを追加してます。

{% highlight python linenos %}
# Year of Month でインデックスする
df_month.plot.bar()

plt.ylabel('Points')
plt.title('Points by 1st_try and 2nd_try')

{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/bar_plot_default_v1.png" | relative_url}})

これだけでも十分ですが、プレゼン用に同様な作図を通常のコーディングで行います。各月にあるそれぞれ２つのbar を横に並列と縦積みを紹介します。
まず、横に並列させます。

{% highlight python linenos %}
P3 = df_month['PY_03']
P5 = df_month['PY_05']
ind =  df_month.index.tolist()
left = np.arange(len(ind))
width = 0.35  
p3 = plt.bar(left, P3, width, color='lightblue')
p5 = plt.bar(left+width, P5, width, color='orange' )
plt.ylabel('Points')
plt.title('Points by 1st_tryl and 2nd_try')
plt.xticks(left, ind)
plt.legend((p3[0], p5[0]), ('1st_try', '2nd_try'))
plt.show()
{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/regular_bar_chart_para.png" | relative_url}})

まず、横に並列させました。　line by line で解説します。

>
1. PY_03 をdf_month のデータフレームから取り出し、変数P3 に代入します。P3はシリーズオブジェクトです
2. PY_05 をdf_month のデータフレームから取り出し、変数P5 に代入します。P5はシリーズオブジェクトです
3. 変数indにインデックス(=Year of Month)を代入します。ind ははシリーズオブジェクトです
4. 変数leftは、barの数だけの順序配列で、作図に必要です。そのため、np.arrange関数を用いて作りますが、barの数はind の長さより求めています
5. 幅を 0.35としています
6. 変数p3にライトブルーのbarの情報を代入します。7本のbar それぞれのbarの値はP3オブジェクトから取る、barの幅、色を指定しています
7. 変数p5にオレンジのbarの情報を代入します。7本のbarの横に置いて、その幅、それぞれのbarの値はP５オブジェクトから、幅、色の指定をしています
8. Y軸のラベル
9. グラフタイトル
10. 刻みとラベル
11. グラフ左上のlegend
12. おまじないの作図命令
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 0.85em"}



ほとんどコーディングは同じですが、line# 10 で 薄いブルーのP3 が下（bottom） に来ると指定します。
また、同じくline#10 のbar の数を最大とする配列変数`left`のみを指定して、bar幅の定数を足し込んでいません。


{% highlight python linenos %}
# Year of Month でインデックスする
P3 = df_month['PY_03']
P5 = df_month['PY_05']
ind =  df_month.index.tolist()

left = np.arange(len(ind))
width = 0.35  

p3 = plt.bar(left, P3, width, color='lightblue')
p5 = plt.bar(left, P5, width, color='orange', bottom=P3 ) #<- bar to stack

plt.ylabel('Points')
plt.title('Points by 1st_tryl and 2nd_try')
plt.xticks(left, ind)
plt.legend((p3[0], p5[0]), ('1st_try', '2nd_try'))
plt.show()

{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/regular_bar_to_stack.png" | relative_url}})

参照ドキュメント(英語）のURLも追記します。


参照　[matplotlib_documentation](https://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.bar){:target="_blank"}


---

### ひとこと

> データ分析での可視化は分析そのものと同じくらい重要な作業です。自らの理解であれば、デフォルトの方法で概観でも大丈夫ですが、クライアントや上司に対して提供するグラフは、タイトルはもちろん、ラベルであったり、色といった付属情報や装飾でグラフが見やすく、グラフ自体で説明できていることが求められます。　特に上に行けば行くほどきれいな行き届いたグラフをいつも見ている場合が多いので、可視化のスキルを求められます。　
