---
layout: single
title:  seaborn barplot の棒グラフに平均値のannotationをつける
header:
  overlay_image: images/header_A5.png
  overlay_filter: rgba(107, 74, 43, 0.20)
toc: true
toc_label: "目次"
toc_icon: "heart"
toc_sticky: True
excerpt_separator: <!--more-->
classes:
- landing
- dark-theme
#- wide
sidebar:
  nav: "docs"
tag: [seaborn, visualization, Python]
category: Python
date: 2022-06-11
last_modified_at : 2025-10-30 09:00:00
---


[seaborn](https://seaborn.pydata.org){:target="_blank"}は[matplotlib](https://matplotlib.org){:target="_blank"}をベースにしたデータビジュアライゼーションライブラリです。countplot はカテゴリカルデータを集計から度数分布図までを一気に行なってくれる大変便利なツールです。

<strong>barplot</strong> で棒グラフを作成し、各々のbarの値をannotationしたいと思います。Excelの代わりにseanborn でサクサク、グラフ化します。

<!--more-->
<style type="text/css">

table {
  display: block;
  margin-bottom: 1em;
  width: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif;
  font-size: 0.75em;
  border-collapse: collapse;
  overflow-x: auto;
}

table + table {
  margin-top: 1em;
}

thead {
  background-color: #e6e6fa;
  border-bottom: 2px solid #9b9b9d;
}

th {
  padding: 0.5em;
  font-weight: bold;
  text-align: start;
}

td {
  padding: 0.5em;
  border-bottom: 1px solid #9b9b9d;
}

tfoot {
  background-color: #afeeee;
  padding: 0.5em;
  border-top: 2px solid #9b9b9d;
  border-bottom: 2px solid #9b9b9d;
}

tr,
td,
th {
  vertical-align: middle;
}
_media screen and (max-width:1280px){
.p_table {width:100%;overflow:scroll;}
.p_table table {width:1153px;}
}
_media screen and (max-width:750px){
.resp_table {width:100% !important;}
.resp_table th ,.resp_table td{padding:10px !important;}
}
.rouge {
color: red;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.noir {
color: 1A818;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.bleu {
color: blue;
font-weight: normal;
font-family: inherit;
letter-spacing: inherit;
}
.petit {
font-size: 0.80em;
color: black;
font-family: inherit;
line-height: 1.1;
display: inline-block;
letter-spacing: inherit;
}

.custom-list-violet {
color: rgb(67, 31, 158);
font-size: 24px;
}

</style>
### サンプルデータセット

１．日本語化した棒グラフを作成するためにデータセットを用意します。<br>
２．Kagle のHRデータを編集して使っています。HRデータのうち、**Age**,	**EducationField**,	**TotalWorkingYears**　**MonthlyIncome** の列をそれぞれ、「年齢」、「専攻」、「勤続年数」、「月収」と書き換えました。<br>
３．**EducationField**で含まれるカテゴリカルデータを日本語するとろまでは同じです。<br>
４．二次元データを作るために、「専攻」のカテゴリカルデータを軸に**groupby**メソッドでデータを集約します。<br>
５．**groupby**メソッドを使うと**mean()**平均値 や**sum()**トータルで各カテゴリー値を集約できますが、平均値で各カテゴリの値を集約したいと思います。
{: .notice--warning}


### groupby での集約のイメージ

![groupby]({{ "/images/img/seaborn_pic4.png" | relative_url}}){:height="600px" width="600px"}


### reset_index()でx軸、y軸をColumnに配置する

seaborn の barplotを利用するためには、ｘ軸、y軸ともデータフレームのcolumn で指定する必要があります。　しかし、groupby で集約したカテゴリカルデータのcolumn
は、集約化されたデータフレームではラベルインデックスとして配置されています。　従って、reset_index()でカテゴリをcolumnに再配置させます。そのコードとデータフレームを図示しておきます。

{% highlight python linenos %}

#月収の列のみにする
df_gsum =  df_gsum.iloc[:, [2]]

#ラベルインデックスをreset_index()で列に配置する
df_gsum = df_gsum.reset_index()

{% endhighlight %}

![reset_index()]({{ "/images/img/seaborn_pic5.png" | relative_url}}){:height="600px" width="600px"}



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

数字表記の肝心な点として小数点何位まで表記するかだと思います。　平均値のため、小数点第二位まで表記するようにしています。　以下の<strong>format( '.2f')</strong>の部分がそれに相当します。 

<div class="box33">
    <span class="box-title">Point！</span>
  <ol>  
<li>format(p.get_height(), '.2f')</li>
<li>値pの小数点以下何位まで表記かを指定する　.2f = 小数点第二位</li>

 </ol>
</div>


### 度数分布図、任意のカテゴリー順

<span class="bleu">order = ['マーケティング', '理工学', '医薬、保健','人文科学','教育・人事','その他']</span>として
<span class="bleu">order = order</span>とすると、<span class="bleu">order</span>で指定した順に棒グラフが並びます。イメージは以下のとおりです。

![月収平均]({{ "/images/img/seaborn_pic6.png" | relative_url}}){:height="600px" width="600px"}


---


