---
layout: post
title: df.value_counts() の結果をパワポ用にビジュアル化する
feature-img: "assets/img/2020_08_15/low-poly-1094512_1280.png"
tags: [Pandas, DataFrame, Python]
excerpt_separator: <!--more-->
---

`df['列名'].value_counts()`はデータセットの理解のはじめの一歩として必ず使うcodeの一つです。　今回は、この結果を報告用にビジュアル化してそのまま、パワポに画像貼り付けするためのHint＆Tipsをブログにしてみました。

<!--more-->

### サンプルデータセット

サンプルデータセットは以下のようなデータフレームです。　サンプルとして135行x 1列でその列名には、「問2 フリーワードで検索できるシステムは必要だと思いますか。」という質問項目がそのまま列名となっている列が一つだけとその値がラベル名で与えられています。
ラベル名は
>
1. 必要である
2. どちらかといえば、必要である
3. どちらかといえば、不要である
4. 不要である

の４種類です。　問2 のアンケートの結果のデータフレームでアンケートの問いが列名となって要素として各々のラベル名で入っているとします。

![merge_left]({{ "assets/img/2020_08_15/df_pic001.png" | relative_url}})<br>



### 各々のラベルの要素数を調べる

各々のラベルの要素の数を調べるには、以下のCodeで一発で分かります。

{% highlight python linenos %}
df.value_counts()
{% endhighlight %}

結果は以下のようになりました。　アンケートの単純集計であれば、問２の質問の内容と各々のラベルの数で十分な場合があります。

{% highlight python %}
問2 フリーワードで検索できるシステムは必要だと思いますか
必要である                             80
どちらかといえば、必要である                    44
不要である                              8
どちらかといえば、不要である                     3
dtype: int64
{% endhighlight %}

### 報告用に整形する方に手間取る

このJupyter Notbookの出力結果をそのまま画面ショットを撮るなどして報告用としてもいいですが、すると度数がズレていたりして、たった一発のコマンド結果なのに、それをEXCELやパワポの表に整形する方に手間がかかったりすることがままあります。

この場合も以下のが画面ショットの結果です。

![merge_left]({{ "assets/img/2020_08_15/df_pic11.png" | relative_url}})<br>


### 報告用にデータフレームをPandas の機能で整形する

そこで以下のようなCode でデータフレームを整形してみましょう。　このCodeの目的はデータフレームを表のようにしてパワーポイントで画像を貼り付け使えるようにすることです。

{% highlight python linenos %}
col_name = '問2 フリーワードで検索できるシステムは必要だと思いますか。'

df[col_name].value_counts()
tab = df[col_name].value_counts()
tab = pd.DataFrame(tab)
tab = tab.rename_axis(col_name)
tab.rename(columns={col_name: '度数'}, inplace = True)

display(tab)

{% endhighlight %}


![merge_left]({{ "assets/img/2020_08_15/df_pic31.png" | relative_url}})<br>


### 円グラフにします。

{% highlight python linenos %}
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt 
from pylab import rcParams
import japanize_matplotlib
sns.set(font='IPAGothic')
plt.rcParams['font.family']='IPAexGothic'
%matplotlib inline
rcParams['figure.figsize'] = 9,6

sizes = tab['度数']
labels = tab.index.tolist()
fix1, ax1 = plt.subplots()
colors = sns.color_palette('pastel')[0:5]
ax1.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=0, colors=colors)
ax1.set_title(col_name, pad=8, fontsize=14, color='blue')
plt.show()

{% endhighlight %}

ここまで、Jupyter Notebook でしておけば、報告用のパワポの作業が断然省力化できます。

![index_join]({{ "assets/img/2020_08_15/df_pic422.png" | relative_url}})<br>


### おまけ　構成比率を追加しました

おまけとして、データフレームにも度数に加えて構成比を追加してみました。　
`format_dict = { '構成比': '{:.1%}'}`{:style="background: #cbe8f5"} で％表示にしています。　これも報告用に整形する際のマストアイテムですね。

{% highlight python linenos %}
df[col_name].value_counts()
tab = df[col_name].value_counts()
tab = pd.DataFrame(tab)
tab = tab.rename_axis(col_name)
tab['構成比'] = (tab[col_name] / tab[col_name].sum() )
tab.rename(columns={col_name: '度数'}, inplace = True)

format_dict = { '構成比': '{:.1%}'}
display(tab.style.format(format_dict))

{% endhighlight %}

![index_join]({{ "assets/img/2020_08_15/df_pic51.png" | relative_url}})<br>


### 参照ページ一覧
このブログと一緒にこのサイト内の以下のページも併せてご覧ください。
>
1) [value_counts()の結果を plt.subplots()で円グラフ化する](https://www.so-wi.com/2019/09/06/pie_chart_to_draw.html){:target="_blank"}<br>
2) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
3) [クロス集計表とヒートマップでデータセットを理解する](https://www.so-wi.com/2020/12/22/cross_tab_heat_map.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}



