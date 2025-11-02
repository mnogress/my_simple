---
layout: single
title: df_overview スクリプト
header:
  overlay_image: images/header_H.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: True
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
category: Reference
tag: ["Pandas", "Function"]
date: 2024-07-04
last_modified_at : 2024-08-19 15:23:00
---

データフレームの概要理解する  "df_overview" スクリプト<!--more-->を紹介します。


>
**参照したWebページ**<br> 
[「データセットを理解するためのスクリプト4選」](https://www.so-wi.com/2023/05/31/four_command_script_to_understand_dataset){:target="_blank"}<br>
**so-wi.com**  -  *May, 2023*
>{: style="font-size: 0.9em;"} 


#### スクリプトの内容

{% highlight python linenos  %}

# 必要なモジュールをインポート
import numpy as np
import pandas as pd

# DataFrame 要約　列番号、列名、ユニーク変数数、データタイプ、NaN の個数
pd.options.display.max_rows = 220
## Check for unique values of categorical variables
df_overview = pd.DataFrame([[i, len(df[i].unique()), df[i].dtypes, df[i].isnull().sum()] for i in df.columns], 
                          columns=['Feature', 'Unique Values', 'dtypes', 'NaN'])
df_overview

{% endhighlight %}


#### 結果

![image]({{ "/images/2024-07150340.png" | relative_url}}){:height="500px" width="500px"}<br>




#### データフレームのインデックス番号、インデックス名を指定してその行を削除する

{% highlight python linenos  %}

# データフレームの2行目にもタイトルの残骸があり、その行は無効なの
# 行を指定して削除する
# index[0] はデータフレームとしては最初の行だが、無効なため削除する

df = df.drop(df.index[[0]])

{% endhighlight %}
