---
layout: post
title: Seaborn を使ってクロス集計の可視化を行う
feature-img: "assets/img/2020_08_15/geometric-shapes-7491454_1280.jpg"
tags: [Python, seaborn, cross table ]
excerpt_separator: <!--more-->
---

ビジュアライゼーションツールであるSeabornを使ってクロス集計の可視化を行う方法をまとめました。

----

### サンプルデータセットの紹介

データセットを利用しながら、説明をした方が分かりやすいと思いますので、今回も
[Sample Dataset](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}で紹介した、HRデータ（データセット3）の一部のカラムを利用して具体的に説明したいと思います。

<!--more-->


このデータセットは、Attrition に影響する従業員の属性について分析するためのものです。
「Attrition（アトリション）」は、組織や企業において従業員の離職や退職のことを指す言葉です。従業員の流出や離脱とも訳されます。
企業や組織は、Attritionの影響を最小限に抑えるために、離職率や離職原因の分析、従業員の定着策やキャリア開発プログラムの実施などの対策を取ることがあります。また、Attritionの率や傾向は、組織の人材計画や採用戦略にも影響を与える重要な指標となります。

今回は、Attrition 影響分析としてGender（性別）とDepartment(所属部門)で一見して差異があるかをどうかを可視化します。


### データセットは以下のとおりです。

表示結果`df.head()`は、以下のようになります。　

![data_frame]({{ "assets/img/2020_08_15/fig1020001.png" | relative_url}}){:height="75%" width="75%"}<br>

データセットの大きさは、1470 x 10　です。そのうち、

1. Attrition　が退職(Yes)と非退職(No) 
2. Gender は男性(Male)、女性(Female)の2値
3. Department は、3部門 (`Sales` `Research & Development` `Human Resources`)

### groupby メソッドでクロス集計する

今回はgroupby メソッドをクロス集計を行います。groupbyを使うとピンポイントに簡単に集計を行うことができます。

{% highlight python linenos %}

df.groupby(['Department','Attrition'])['Department'].count()

{% endhighlight %}

結果は、以下のとおりです。

![cross_table1]({{ "assets/img/2020_08_15/fig1020002.png" | relative_url}})<br>

結果を見てもお分かりのとおり、`Department` 単位の`Attrition`を`Deparment`をキー列に各々の数を集計します。
このままでも、集計結果は理解できますが、これを棒グラフにして各々の`Department`毎の差異を数字ではなく、棒の大きさで視覚に訴えます。

----
### Seaborn のcountplotを使って可視化する

各カラム毎のユニークな値の総数が分かりましたので、その中身について全部または一部を一覧表示し、特性を理解するのに役に立つスクリプトが以下になります。


{% highlight python linenos %}

import numpy as np
import pandas as pd
import seaborn as sns
# matplotlibのグラフをRetinaの高解像度で表示する
%config InlineBackend.figure_formats = {'png', 'retina'}
# Jupyter Notebookの中で作図した画像を表示させる
%matplotlib inline
# matplotlib をインポートする
import matplotlib.pyplot as plt
# 日本語タイトルのため、japanizeをインポートする
import japanize_matplotlib
plt.rcParams['font.family'] = 'IPAexGothic'

#show Attrition Frequency for Department
plt.figure(figsize=(9,7))
ax = sns.countplot(x = df['Department'], data=df, hue='Attrition',palette="winter")
plt.title('職種別退職状況（Attrition for Department）')
plt.xlabel('職種（Department）')
plt.legend(["退職（Attrition）", "非退職（Non Attrition）"])
plt.ylabel('度数（Frequency）')

plt.show()

{% endhighlight %}

結果は以下のとおりです。

![data_frame]({{ "assets/img/2020_08_15/fig1020003.png" | relative_url}})<br>

### seaborn.countplot の詳細

可視化の要となる`ax = sns.countplot( data=df, x = df['Department'], hue='Attrition',palette="winter")`{:style="background: #ff0044; color: white; font-size: 100%"}について説明したいと思います。詳しい説明は、
[seaborn countplot](https://seaborn.pydata.org/generated/seaborn.countplot.html){:target="_blank"}を参考にしてください。


変数２つでグルーピング（集約）することで、クロス集計を視覚化します。　
<dl>
<dt>data</dt>
<dd>データフレームを指定します。対象データセットです</dd>

<dt>x, hue</dt>
<dd>グルーピングする2変数を割り当てます。</dd>

<dt>palette="winter"</dt> 
<dd>棒グラフの色をパレットで指定しています。この例では"winter"パレットを指定しました。</dd>

</dl>

----


### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [サンプルデータセットの説明](https://www.so-wi.com/2019/06/01/reference_data.html){:target="_blank"}<br>
2) [df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}<br>
3) [クロス集計表とヒートマップでデータセットを理解する](https://www.so-wi.com/2020/12/22/cross_tab_heat_map.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}