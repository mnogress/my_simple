---
layout: single
title: カテゴリカルデータの個数、構成比率、トータル行を集計、整形する
header:
  overlay_image: images/header_F.png
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
date: 2026-01-21
last_modified_at : 2026-01-21 11:00:00
---

カテゴリカルデータの個数、構成比率、トータル行を集計、整形する方法をまとめました。

データフレームの特定の列（例：部門）ごとに、❶件数（何件あるか）、❷構成比（全体のうち何%か）を出して、
後で加工しやすい「表（データフレーム）」の形にまと、ついでに合計（Total）行も付けるためのスクリプトをまとめました。
<!--more-->


#### サンプルコードの紹介

カテゴリカルデータのそれぞれの個数を大きい順に表示し、その構成比率とトータル行を追加した内容を
データフレームとして提供するスクリプトになります。

{% highlight python linenos  %}

# 件数（count）と構成比（normalize=Trueで比率が出せる）
vc = df[col_name].value_counts(dropna=False)         # 件数
ratio = df[col_name].value_counts(dropna=False, normalize=True)  # 構成比

# データフレーム化して結合
tab = pd.DataFrame({
    '件数': vc,
    '構成比': ratio
})

# 合計行（Total）を追加
tab.loc['Total', '件数'] = tab['件数'].sum()
tab.loc['Total', '構成比'] = tab['構成比'].sum()

# 表示用フォーマット
format_dict = {'構成比': '{:.1%}', '件数': '{:n}'}
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




