---
layout: post
title: seaborn barplot で棒グラフを隣接させＹ軸、annotationをパーセント表示する
feature-img: "assets/img/2020_08_15/background-ga81e858fe_1280.jpg"
tags: [seaborn, visualization, Python]
excerpt_separator: <!--more-->
---

[seaborn](https://seaborn.pydata.org){:target="_blank"}は[matplotlib](https://matplotlib.org){:target="_blank"}をベースにしたデータビジュアライゼーションライブラリです。barplot は、データの大小が、棒の高低で表されるので、データの大小を比較するのに適しています。

前回は基本[seaborn barplot の棒グラフに平均値のannotationをつける](https://www.so-wi.com/2022/06/11/seaborn_brplot_annotation.html){:target="_blank"}で各々の`bar（棒）`の値を`annotation`の方法について解説しました。　今回は、比較対象の各々 `bar`を隣接させ、より大小比較を際立たせるグラフの作成を紹介します。また、Y軸をパーセント(%)表示にする方法もご紹介します。Excelの代わりにseanborn でサクサク、グラフ化の参考の第三弾になります。

<!--more-->

### サンプルデータセット

今回は、以下のようなマルチインデックスのデータセットを使ってグラフを作成したいと思います。4つの支部のそれぞれ令和3年度と4年度における達成率がデータとしてあります。支部名と年度名がラベルインデックスとして配置されて、各々の達成率がColumn で提供されています。

![dataset_image]({{ "assets/img/2020_08_15/seaborn_pic7.png" | relative_url}}){:height="48%" width="48%"}<br>


### reset_index()でx軸、y軸をColumnに配置する

`seaborn` の `barplot`を利用するためには、ｘ軸、y軸ともデータフレームのcolumn で指定するところは同じです。　しかし、`groupby` で集約したカテゴリカルデータの`column`
は、集約化されたデータフレームではラベルインデックスとして配置されています。　従って、`reset_index()`で二つのインデックスを両方とも`column`に再配置させます。結果のデータフレームを図示しておきます。

![dataset_image]({{ "assets/img/2020_08_15/seaborn_pic8.png" | relative_url}})<br>



### Python コードの紹介

{% highlight python linenos %}

import numpy as np
import pandas as pd
import seaborn as sns
#matplotlibのグラフをRetinaの高解像度で表示する
%config InlineBackend.figure_formats = {'png', 'retina'}
#Jupyter Notebookの中で作図した画像を表示させる
%matplotlib inline
#matplotlib をインポートする
import matplotlib.pyplot as plt

#X軸の並びを指定する
order = ['首都圏支部','愛知支部', '大阪支部', '福岡支部']

title = '主要支部達成率　前年度 vs 本年度 4～5月'
x_label = '支部名'
y_label = '率(%)'

ax = plt.subplots(figsize =(9,9))

ax = sns.barplot(x="支部名",
           y="達成率",
           hue="年度",
           data=df,
           order = order)

#グラフのタイトル等の属性情報を指定する
plt.title(title, fontsize=18, fontweight='bold' )
plt.xticks(rotation=0)
plt.xlabel(x_label, fontsize = 14, fontweight='bold')
plt.ylabel(y_label, fontsize = 14, fontweight='bold')

#y軸を%表示にする
import matplotlib.ticker as mtick
ax.yaxis.set_major_formatter(mtick.PercentFormatter(xmax=1, decimals=None, symbol='%', is_latex=False))

#各barにannotation(xx%)を追加する 
for p in ax.patches:
    ax.annotate(format(p.get_height(), '.2%'), 
                   (p.get_x() + p.get_width() / 2., 
                    p.get_height()), 
                    ha = 'center', 
                    va = 'center', 
                    xytext = (0, 9), 
                    textcoords = 'offset points',
                    fontsize = 12,
                    color = 'blue')

{% endhighlight %}

### 小数点何位までの表示とするかの指定

割合の表記で重要な点は`0.xxx` で操作はするけども、表記の際は`xx.x%` のようにパーセント表示にします。　以下の`format( '.2%')`{:style="background: #cbe8f5"}の部分がそれに相当します。 
<dl>
    <dt>format(p.get_height(), '.2%')</dt>
    <dd>値pをパーセント表示して小数点以下何位まで表記かを指定する　.2f = パーセント表示で小数点第二位</dd>
</dl>

### Y軸も%表示にする

Annotation の数値を%表示にしたのですから、Y軸も%表示にした方が丁寧なグラフになることは言うまでもありません。これは、以下のTwo Line で実現できます。 このまま、コピペで使えます。　

{% highlight python linenos %}

import matplotlib.ticker as mtick
ax.yaxis.set_major_formatter(mtick.PercentFormatter(xmax=1, decimals=None, symbol='%', is_latex=False))

{% endhighlight %}


### 度数分布図、任意のカテゴリー順

`order = ['首都圏支部','愛知支部', '大阪支部', '福岡支部']`{:style="background: #cbe8f5"}として
`order = order`{:style="background: #cbe8f5"}とすると、`order`で指定した順に棒グラフが並ぶことは前回説明しました。イメージは以下のとおりです。

![隣接棒グラフ]({{ "assets/img/2020_08_15/seaborn_pic9.png" | relative_url}})<br>


---


### 参照ページ一覧
本ブログは、以下のネットの記事等を参考に作成しました。　
>
1) [seaborn countplot の棒グラフに度数のannotationをつける](https://www.so-wi.com/2022/06/10/seaborn_countplot_annotation.html){:target="_blank"}<br>
2) [seaborn barplot の棒グラフに平均値のannotationをつける](https://www.so-wi.com/2022/06/11/seaborn_brplot_annotation.html){:target="_blank"}<br>
3) [seaborn](https://seaborn.pydata.org){:target="_blank"}<br>
4) [matplotlib](https://matplotlib.org){:target="_blank"}<br>
5) [EXCELの達人からPythonの達人へ：住民基本台帳年齢階級別人口から都道府県別人口を作成する](https://www.so-wi.com/2021/07/08/japan_population_by_prefecture.html){:target="_blank"}<br>
6) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}


