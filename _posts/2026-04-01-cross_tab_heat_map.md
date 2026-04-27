---
layout: single
title: クロス集計表とヒートマップでデータセットを理解する
header:
  overlay_image: images/header_048_1280by336.png
  overlay_filter: rgba(44, 82, 207, 0.35)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  - wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
date: 2026-04-01
last_modified_at : 2026-04-01 11:00:00
excerpt: 
  50列以上ある複雑なデータセットから「どの変数同士に関係がありそうか」を
  見つけるための実践的なサーチ方法をまとめたリファレンスです。
  Pandas のクロス集計表と Seaborn のヒートマップを使い、
  度数分布の確認、クロス集計、正規化、可視化までを通して
  データの構造を素早く理解し“発見の糸口”をつかむ手順を解説します。


---

#### 🎯 はじめに
<!--more-->
<p>
実務のデータ分析では、50列以上ある複雑なデータセットの中から
「どの変数同士に関係がありそうか？」を素早く見つけることが重要です。
しかし、いきなり相関係数や機械学習に進むと、前処理や前提条件に左右され、
本質的な“気づき”を得にくいことがあります。
</p>

<p>
このページでは、Pandas の <strong>クロス集計表（crosstab）</strong> と
Seaborn の <strong>ヒートマップ</strong> を使って、
大量のカテゴリ・数値データの中から「関係のありそうな組み合わせ」を
効率よく探索するための実践的アプローチをまとめています。
年齢 × 収入のような一例にとどまらず、
データセット全体の構造を理解し、分析の糸口をつかむための
 <span class="bleu2">“発見のためのサーチ方法” </span>を体系的に学べます。
</p>


#### ① クロス集計表とヒートマップ

- クロス集計表とは、２つのカテゴリーに属するデータを各々のカテゴリーで分類して、それぞれのカテゴリーに交わるセルにその度数（サンプル数、頻度）を集計した表のことです。

- クロス集計表では度数は数字で表していますが、その数字の大小を色の濃淡で視覚的に表現するヒートマップの形にすると今まで見えていなかったものが見えたりします。

- クロス集計表のサンプルとして、今回使う[Kaggle_HR_attrition](https://www.kaggle.com/search?q=hr+attrition){:target="_blank"}のうち、男女(Gender)の列と仕事満足度(JobSatisfaction)の列の２軸でクロス集計してみました。

![countplot]({{ "images/img/cross_tab_sample1.png" | relative_url}})<br>


Pandasを使えば、簡単にクロス集計表やヒートマップを作成、描画が可能です。ここでは<span class="bleu2">Kaggle のHRデータの年齢とMonthly Salary のデータ</span>でクロス集計表とヒートマップの作成をご紹介したいと思います。




#### ② 度数分布グラフを作成する

クロス集計する二つのカテゴリーとして"Age"と"MonthlyIncome"で集計したいと思います。集計にあたり、"Age" と"MonthlyIncome" 各々の度数分布を棒グラフで確認します。



seabornを使えば、簡単にきれいな度数分布グラフを作成することができます。 カラーパレット`palette='hls'`{:style="background: #cbe8f5; font-size: 1.00em;"} で各棒(bar)に色をつけてメリハリをつけてみました。


{% highlight python linenos %}
# カレントディレクトリからKaggleデータ data.csv を読み込みます
df = pd.read_csv('/data.csv', delimiter =",", header=0)
# 年齢別の度数分布を作成します
sns.countplot(x='Age', data=df, palette='hls')
{% endhighlight %}

![countplot]({{ "images/img/countplot_age.png" | relative_url}})<br>


”MonthlyIncome”は１ドル単位までデータとしてあります。これでは、度数分布としては細か過ぎますので、roundメソッド`.round(-3)`{:style="background: #cbe8f5; font-size: 1.00em;"} として1,000ドル単位のレンジにして、新しい列名"MonthlyRate"を作成します。

{% highlight python linenos %}
# 1,000ドル単位に下3桁で切り捨てて、それを列名'MonthlyRateに格納します
df['MonthlyRate'] = df['MonthlyIncome'].round(-3)
# MonthlyRateの度数分布を作成します
sns.countplot(x='MonthlyRate', data=df, palette='hls')
{% endhighlight %}

![countplot]({{ "images/img/monthly_rate_hr.png" | relative_url}})<br>


#### ③ クロス集計表を作成する

集計する２つの列の値が整数やカテゴリカルデータであれば、クロス集計表はとても簡単に作成できます。
18歳から60歳までのそれぞれの年齢ごとの、月額給与が1,000ドル以上から20,000ドル以上までのクロス集計表を作成します。
この集計表の表のサイズは、43 x 20 になります。
Pandas では、以下のように指定します。

{% highlight python linenos %}
ct = pd.crosstab(df['Age'], df['MonthlyRate'])
ct
{% endhighlight %}

結果は、以下のようになります。

![cross_tab_2]({{ "images/img/cross_table_hr_age_monthlurate.png" | relative_url}})<br>

#### ④ ヒートマップで大小を可視化する

それぞれのセルの大小関係を可視化するため、ヒートマップで色の濃淡で大小関係を見るとことにします。ヒートマップは今回のように表のサイズが大きい場合に特に有効な方法といえます。

{% highlight python linenos %}
# figsizeを変更するモジュール rcParsmsを読み込みます
from pylab import rcParams
# figsize を24 x 13インチにします
rcParams['figure.figsize'] = 24,13
# クロス集計表のデータフレーム ct のヒートマップを作成します。
# 色だけでなく、度数も表示するため、annot = True を指定します
sns.heatmap(ct, annot=True, cmap='BuGn')
# カレントディレクトリにヒートマップ図をimg_hr.pngとして保存します
plt.savefig("img_hr.png")
{% endhighlight %}

![heatmap_2]({{ "images/img/heatmap_age_monthlyrate_1.png" | relative_url}})<br>

#### ⑤ 列ごとまたは行ごとに正規化して比率で比較する

`normalize = 'columns'`{:style="background: #cbe8f5; font-size: 1.00em;"} とすると、列ごとに0～1までに正規化(normalize)します。また、小数点以下2桁でパーセント表示したい場合は、`ct2.style.format("{:.2%}")`{:style="background: #cbe8f5; font-size: 1.00em;"} とします。　ここでは、婚姻状況(MaritalStatus)と退職状況(Attrition)で見てみたいと思います。　まずは、列ごとに正規化します。

{% highlight python linenos %}
ct = pd.crosstab(df['MaritalStatus'], df['Attrition'], normalize = 'columns')
ct.style.format("{:.2%}")
{% endhighlight %}

![norm_1]({{ "images/img/column_norm.png" | relative_url}})<br>


行単位で正規化したい場合は、`normalize = 'index'`{:style="background: #cbe8f5; font-size: 1.00em;"}とすればいいだけです。

```python
ct = pd.crosstab(df['MaritalStatus'], df['Attrition'], normalize = 'index')
ct.style.format("{:.2%}")
```
![norm_2]({{ "images/img/index_norm.png" | relative_url}})<br>