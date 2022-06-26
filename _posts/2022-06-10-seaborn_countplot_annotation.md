---
layout: post
title: seaborn countplot の棒グラフに度数のAnnotationをつける
feature-img: "assets/img/2020_08_15/flowers-7217498_1280.jpg"
tags: [seaborn, visualization, Python]
excerpt_separator: <!--more-->
---

[seaborn](https://seaborn.pydata.org){:target="_blank"}は[matplotlib](https://matplotlib.org){:target="_blank"}をベースにしたデータビジュアライゼーションライブラリです。countplot はカテゴリカルデータを集計から度数分布図までを一気に行なってくれる大変便利なツールです。　　　

今までも本サイトでも何度か、データビジュアライゼーションのサンプルとしてcode を紹介してきましたが、今回はannotation のつけ方について解説します。Excelの代わりにseanborn でサクサク、グラフ化の参考にしてください。

<!--more-->

### サンプルデータセット

日本語化した度数分布表を作成するため、
[サンプルデータセット](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}で紹介しているデータセット3 のHRデータを編集して使っています。HRデータのうち、`Age`,	`EducationField`,	`TotalWorkingYears`の列をそれぞれ、年齢、専攻、勤続年数と書き換えました。　さらに、`EducationField`で含まれるカテゴリカルデータを日本語にしています。

![sample_dataframe]({{ "assets/img/2020_08_15/seaborn_pic1.png" | relative_url}})<br>

{% highlight python linenos %}
df['専攻'].value_counts()

>>人文科学          606
>>医薬、保健        464
>>マーケティング    159
>>理工学            132
>>その他            82
>>教育・人事        27
>>Name: 専攻, dtype: int64

{% endhighlight %}


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

#タイトル名等の変数の定義
title = '専攻分野'
col_name = '専攻'
y_label = '人数'

#figsizeを9inch by 9inch とする
plt.subplots(figsize =(9,9))
#seaborn countplotを設定し、変数axとしてAnnotationを上書できるようにする
ax = sns.countplot(x = col_name, 
                   data = df, 
                   palette='pastel',
                   order = df[col_name].value_counts().index)

#グラフタイトル、軸名を設定する
plt.title(title, fontsize=18, fontweight='bold' )
plt.xticks(rotation=90)
plt.xlabel(col_name, fontsize = 14, fontweight='bold')
plt.ylabel(y_label, fontsize = 14, fontweight='bold')

#Annotation を設定する
for rect in ax.patches:
    ax.text (rect.get_x() + rect.get_width() / 2,
             rect.get_height() + 2,
             rect.get_height(),horizontalalignment='center', 
             fontsize = 14)

{% endhighlight %}



### 度数分布図、大きい順

`order = df[col_name].value_counts().index`{:style="background: #cbe8f5"}の指定があるため、度数の多い順に並べて棒グラフが完成します。　イメージは以下のとおりです。

![度数分布図]({{ "assets/img/2020_08_15/seaborn_pic2.png" | relative_url}})<br>

### 度数分布図、任意のカテゴリー順

`order = ['マーケティング', '理工学', '医薬、保健','人文科学','教育・人事','その他']`{:style="background: #cbe8f5"}として
`order = order`{:style="background: #cbe8f5"}とすると、`order`で指定した順に棒グラフが並びます。イメージは以下のとおりです。

![度数分布図]({{ "assets/img/2020_08_15/seaborn_pic3.png" | relative_url}})<br>


{% highlight python linenos %}
order = ['マーケティング', '理工学', '医薬、保健','人文科学','教育・人事','その他']
title = '専攻分野'
col_name = '専攻'
y_label = '人数'

plt.subplots(figsize =(9,9))
ax = sns.countplot(x = col_name, 
                   data = df, 
                   palette='pastel',
                   order = order)

plt.title(title, fontsize=18, fontweight='bold' )
plt.xticks(rotation=90)
plt.xlabel(col_name, fontsize = 14, fontweight='bold')
plt.ylabel(y_label, fontsize = 14, fontweight='bold')

for rect in ax.patches:
    ax.text (rect.get_x() + rect.get_width() / 2,
             rect.get_height() + 2,
             rect.get_height(),horizontalalignment='center', 
             fontsize = 14)
{% endhighlight %}



### 参照ページ一覧
本ブログは、以下のネットの記事等を参考に作成しました。　
>
1) [seaborn](https://seaborn.pydata.org){:target="_blank"}<br>
2) [matplotlib](https://matplotlib.org){:target="_blank"}<br>
3) [EXCELの達人からPythonの達人へ：住民基本台帳年齢階級別人口から都道府県別人口を作成する](https://www.so-wi.com/2021/07/08/japan_population_by_prefecture.html){:target="_blank"}<br>
4) [matplotlib](https://matplotlib.org){:target="_blank"}<br>
5) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}


