---
layout: post
title: seaborn barplot の棒グラフに平均値のannotationをつける
feature-img: "assets/img/2020_08_15/background-7279441_1280.jpg"
tags: [seaborn, visualization, Python]
excerpt_separator: <!--more-->
---

[seaborn](https://seaborn.pydata.org){:target="_blank"}は[matplotlib](https://matplotlib.org){:target="_blank"}をベースにしたデータビジュアライゼーションライブラリです。countplot はカテゴリカルデータを集計から度数分布図までを一気に行なってくれる大変便利なツールです。

前回は[seaborn countplot の棒グラフに度数のannotationをつける](https://www.so-wi.com/2022/06/10/seaborn_countplot_annotation.html){:target="_blank"}で`countplot`で度数を`annotation`する方法を紹介しました。　今回は、`barplot` で棒グラフを作成し、各々の`bar`の値を`annotation`したいと思います。Excelの代わりにseanborn でサクサク、グラフ化の参考の第二弾になります。

<!--more-->

### サンプルデータセット

日本語化した棒グラフを作成するためにデータセットを用意します。[seaborn countplot の棒グラフに度数のannotationをつける](https://www.so-wi.com/2022/06/10/seaborn_countplot_annotation.html){:target="_blank"}と同様に
[サンプルデータセット](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}で紹介しているデータセット3 のHRデータを編集して使っています。HRデータのうち、`Age`,	`EducationField`,	`TotalWorkingYears`　`MonthlyIncome` の列をそれぞれ、「年齢」、「専攻」、「勤続年数」、「月収」と書き換えました。　さらに、`EducationField`で含まれるカテゴリカルデータを日本語するとろまでは同じです。

今回は二次元データを作るために、「専攻」のカテゴリカルデータを軸に`groupby`メソッドでデータを集約します。`groupby`メソッドを使うと`mean()`平均値 や`sum()`トータルで各カテゴリー値を集約できます。今回は、平均値で各カテゴリの値を集約したいと思います。

### groupby での集約のイメージ

![groupby_image]({{ "assets/img/2020_08_15/seaborn_pic4.png" | relative_url}})<br>


### reset_index()でx軸、y軸をColumnに配置する

`seaborn` の `barplot`を利用するためには、ｘ軸、y軸ともデータフレームのcolumn で指定する必要があります。　しかし、`groupby` で集約したカテゴリカルデータの`column`
は、集約化されたデータフレームではラベルインデックスとして配置されています。　従って、`reset_index()`でカテゴリを`column`に再配置させます。そのコードとデータフレームを図示しておきます。

{% highlight python linenos %}

#月収の列のみにする
df_gsum =  df_gsum.iloc[:, [2]]

#ラベルインデックスをreset_index()で列に配置する
df_gsum = df_gsum.reset_index()

{% endhighlight %}

![reset_index()]({{ "assets/img/2020_08_15/seaborn_pic5.png" | relative_url}})<br>



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

#日本語タイトルのため、japanizeをインポートする
import japanize_matplotlib
plt.rcParams['font.family'] = 'IPAexGothic'

order = ['マーケティング', '理工学', '医薬、保健','人文科学','教育・人事','その他']
title = '専攻分野別平均月収'
y_name = '月収'
x_name = '専攻'
y_label = '平均月収(US$)'

ax = plt.subplots(figsize =(9,9))
ax = sns.barplot(x = x_name, y = y_name,
                   data = df_gsum, 
                   palette='pastel',
                  order = order)

plt.title(title, fontsize=18, fontweight='bold' )
plt.xticks(rotation=90)
plt.xlabel(x_name, fontsize = 14, fontweight='bold')
plt.ylabel(y_label, fontsize = 14, fontweight='bold')

for p in ax.patches:
    ax.annotate(format(p.get_height(), '.2f'), 
                   (p.get_x() + p.get_width() / 2., 
                    p.get_height()), 
                    ha = 'center', 
                    va = 'center', 
                    xytext = (0, 9), 
                    textcoords = 'offset points',
                    fontsize = 14,
                    color = 'blue')

{% endhighlight %}

### 小数点何位までの表示とするかの指定

数字表記の肝心な点として小数点何位まで表記するかだと思います。　平均値のため、小数点第二位まで表記するようにしています。　以下の`format( '2f')`{:style="background: #cbe8f5"}の部分がそれに相当します。 
<dl>
    <dt>format(p.get_height(), '.2f')</dt>
    <dd>値pの小数点以下何位まで表記かを指定する　.2f = 小数点第二位</dd>
</dl>

### 度数分布図、任意のカテゴリー順

`order = ['マーケティング', '理工学', '医薬、保健','人文科学','教育・人事','その他']`{:style="background: #cbe8f5"}として
`order = order`{:style="background: #cbe8f5"}とすると、`order`で指定した順に棒グラフが並びます。イメージは以下のとおりです。

![月収平均]({{ "assets/img/2020_08_15/seaborn_pic6.png" | relative_url}})<br>




### 参照ページ一覧
本ブログは、以下のネットの記事等を参考に作成しました。　
>
1) [seaborn countplot の棒グラフに度数のannotationをつける](https://www.so-wi.com/2022/06/10/seaborn_countplot_annotation.html){:target="_blank"}<br>
2) [seaborn](https://seaborn.pydata.org){:target="_blank"}<br>
3) [matplotlib](https://matplotlib.org){:target="_blank"}<br>
4) [EXCELの達人からPythonの達人へ：住民基本台帳年齢階級別人口から都道府県別人口を作成する](https://www.so-wi.com/2021/07/08/japan_population_by_prefecture.html){:target="_blank"}<br>
5) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}


