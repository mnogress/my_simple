---
layout: post
title: value_counts()の結果を plt.subplots()で円グラフ化する
feature-img: "assets/img/2019_07_01/logo_pink_square.png"   
tags: [pandas, data_visualization]
excerpt_separator: <!--more-->
---

value_counts()の結果を円グラフにする方法を説明します。　分析にはほとんど使わない円グラフですが、プレゼン資料では大活躍です。
<!--more-->
更に、一つのパイ切れを引っ張り出して強調する方法も説明します。　


---

### チートシート

やりたいこと | コーディング
---------- | -------------
value_counts()の結果を円グラフの<br>ソースデータにする | pie = df[&#39;Col&#39;].value_counts()<br>df_pie = pd.DataFrame(pie)
インデックスラベルをシリーズオブジェクトで受ける　| labels =  df_JobRole.index.tolist()

`'Col' : 任意の列名`{:style="background-color: #ffe3e2; font-size: 0.7em"}
`labels: ラベル名のシリーズオブジェクト `{:style="background-color: #ffe3e2; font-size: 0.7em"}

---


### 今回のデータについて

1. df['JobRole'].value_counts()　した結果をデータフレームにします
2. df.shape => 9 x 1 に集約しています。　データフレーム名 `df_JobRole`
3. インデックスは各`JobRole`名になります。

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`HRデータ`です。
1470行 x 35列のサイズがあります。


![df_JobRole]({{ "assets/img/2019_07_01/hr_data_oroginal.png" | relative_url}})



### サンプルオペレーション

デフォルトの0から始まるインデックスをラベルインデックスに変更します。

{% highlight python linenos %}
# JobRole の各要素数を`value_counts()`で取る
df['JobRole'].value_counts()
{% endhighlight %}


結果は以下のとおりです。 
{% highlight python %}
Sales Executive              326
Research Scientist           292
Laboratory Technician        259
Manufacturing Director       145
Healthcare Representative    131
Manager                      102
Sales Representative          83
Research Director             80
Human Resources               52
Name: JobRole, dtype: int64
{% endhighlight %}


円グラフ用のデータフレームを作成します。　インデックスをJobRole名にします。

{% highlight python linenos %}
# JobRole の各要素数を`value_counts()`で取る
JobRole = df['JobRole'].value_counts()
df_JobRole = pd.DataFrame(JobRole)
df_JobRole
{% endhighlight %}

結果は、以下のとおりです。

![df.shape]({{ "assets/img/2019_07_01/value_count_pie_df.png" | relative_url}})


### 円グラフを作図します


{% highlight python linenos %}
# Year of Month でインデックスする
sizes = df_JobRole['JobRole']
labels =  df_JobRole.index.tolist()
fig1, ax1 = plt.subplots()
ax1.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=0)
ax1.axis('equal')
plt.show()
{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/df_jobrole_pie_1.png" | relative_url}})

これだけでも十分ですが、プレゼン用に`Labratory Technician` だけ少し引っ張り出して強調させて見ましょう。

{% highlight python linenos %}
sizes = df_JobRole['JobRole']
labels =  df_JobRole.index.tolist()
explode = (0,0,0.1,0,0,0,0,0,0)
fig1, ax1 = plt.subplots()
ax1.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=0, explode=explode, shadow=True)
ax1.axis('equal')
plt.show()
{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/df_jobrole_pie_2.png" | relative_url}})

line by line で解説します。

>
1. JobRole をdf_JobRole のデータフレームから取り出し、変数sizes に代入します。sizesはシリーズオブジェクトです
3. 変数labesにインデックス(JobRole名)を代入します。lablesもシリーズオブジェクトです
4. 変数explodeに各pie ピースのうち、explode(引っ張ってくる)pieピースに0.1を与える配列を定義します。
5. plt.subplot()に入れる変数を定義します
6. 円グラフの本体axiにpieの大きさ、ラベル、pieの中に記入する％のフォーマット等を設定します 
7. ax1の均等スケーリング equal を指定します
7. おまじないの作図命令
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 0.85em"}


ついでに、棒グラフは以下のとおりです。　仲間内にはこのグラフで十分かと思います。 これは、[ラベルでインデックスして plt.bar で棒グラフ化する]({{ "2019/09/01/bar_plot_label_index.html" | relative_url}}){:target="_blank"}の記事で紹介している方法です。

{% highlight python linenos %}
df_JobRole.plot.bar()
{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/jobrole_bar.png" | relative_url}})

### 参照ページ一覧

以下のページ（本サイト内及び外部サイト）も参照してください。

>
1) [df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}<br>
2) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
3) [クロス集計表とヒートマップでデータセットを理解する](https://www.so-wi.com/2020/12/22/cross_tab_heat_map.html){:target="_blank"}<br>
4) [matplotlib_documentation](https://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.pie){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}

### ひとこと

> データの集約化から可視化へのワークフローを確立することをおすすめします。データ解析自体より意外と時間と手間のかかるまとめのプレゼン資料作成がぐんと楽になります。

