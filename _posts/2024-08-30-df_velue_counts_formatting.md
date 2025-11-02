---
layout: single
title: カテゴリカルデータの個数、構成比率、トータル行を集計、整形する
header:
  overlay_image: images/header_A5.png
  overlay_filter: rgba(44, 82, 207, 0.35)
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
date: 2024-09-01
last_modified_at : 2024-09-01 11:00:00
---

カテゴリカルデータの個数、構成比率、トータル行を集計、整形する<!--more-->方法をまとめました。


#### サンプルコードの紹介

カテゴリカルデータのそれぞれの個数を大きい順に表示し、その構成比率とトータル行を追加した内容を
データフレームとして提供するスクリプトになります。

{% highlight python linenos  %}

col_name = '部門' # 集計したい列名
tab = df[col_name].value_counts()
tab = pd.DataFrame(tab)
tab = tab.rename_axis(col_name)
tab['構成比']=(tab['count'] / tab['count'].sum())
tab.rename(columns={col_name: '会社数', 'count': '件数'}, inplace = True)

# Total 行を追加する関数
def append_sum_row_label(df):
    df.loc['Total'] = df.sum(numeric_only=True)
    return df

tab = append_sum_row_label(tab)
format_dict = {'構成比': '{:.1%}', '件数' : '{:n}'}
display(tab.style.format(format_dict))

{% endhighlight %}

#### サンプルデータフレーム

以下のとおり、サンプルデータフレームの集計結果をデータフレームとして得ることができます。

{% highlight python linenos  %}

# 演習用のデータフレームを作成します。
df = pd.DataFrame({ 'ID': ['01285679', '01340788', '02123782', '10541976', '12297411', 
                             '13299899', '48144450', '55339981'],
                   '出身地': ["東京都","山口県",'大阪府','千葉県','東京都',
                          '埼玉県','千葉県','千葉県'],
                  '部門':   ["首都圏営業部","関西支部","本部総務",
                               "研究開発","東北支部","北海道支部",
                               "首都圏営業部","研究開発"]},
                    index=[0, 1, 2, 3, 4, 5, 6,7])
# オリジナルのデータフレームを表示

{% endhighlight %}

{% capture notice-1 %}
**サンプルデータフレームを表示**:

`>> display(df)`{:style="background: #f5e964; font-size: 120%"} 

![image]({{ "/images/fig_1.png" | relative_url}}){:height="300px" width="300px"}<br>

--> 部門別に集計します。
{% endcapture %}
<div class="notice"><span style="font-size:1.15em;">{{ notice-1 | markdownify }}</span></div>


#### スクリプトの結果

{% capture notice-1 %}
**'部門'で集計結果を表示**:

`>> format_dict = {'構成比': '{:.1%}', '件数' : '{:n}'}`{:style="background: #f5e964; font-size: 120%"} <br>`>> display(tab.style.format(format_dict))`{:style="background: #f5e964; font-size: 120%"} 

![image]({{ "/images/fig_2.png" | relative_url}}){:height="300px" width="300px"}<br>

{% endcapture %}
<div class="notice"><span style="font-size:1.15em;">{{ notice-1 | markdownify }}</span></div>




