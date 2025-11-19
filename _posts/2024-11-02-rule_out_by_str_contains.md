---
layout: single
title: str.contain否定演算子"~"による「指定の文字列を含まない行」を抽出する
header:
  overlay_image: images/header_X12_1280by336.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: true
toc_label: "目次"
toc_icon: "heart"
toc_sticky: True
excerpt_separator: <!--more-->
classes:
- landing
- dark-theme
# wide
sidebar:
  nav: "docs"
tag: [Python, pandas, dataframe]
category: python
date: 2024-11-02
last_modified_at : 2025-10-28 09:00:00
---
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
</style>

Pandas の<strong>str.contais</strong>を利用して指定の値を含まない行の抽出方法をまとめました。
データフレームの中身をクリーニング等で抽出作業は必須スキルです。
今回は、
<strong>str.contains("除きたい文字列")</strong>と否定演算子 <strong> ~ </strong> を使って<strong> ~df </strong>
として<strong>指定の文字列を含まない行の抽出方法</strong>をまとめました。

<!--more-->

----

### 行いたいことを図示します。

以下の事をPandas のデータフレーム上で行いたいと思います。

![what_is_problem]({{ "/images/img/fig_1107_01.png" | relative_url}}){:height="600px" width="600px"}<br>


### str.contains と 否定演算子を使う

<strong>str.contains("除きたい文字列")</strong> と
否定演算子<strong> ~ </strong>を使えば、簡単に抽出できます。
また、<strong>print('before/after:', df.shape)</strong>を前後に挟むことで、データフレームの前後のサイズを把握します。

{% highlight python linenos %}

print('before:', df.shape)
df = df[~df['メールアドレス'].str.contains('@example.org')]
print('after:', df.shape)

{% endhighlight %}

前後に配置した<strong>df.shape</strong> でデータフレームのサイズのBefore/After を記録して抽出サイズ（削除された行数）を把握します。

{% highlight linenos %}
{% raw %}

>> before: (8, 3)
>> after: (6, 3)

{%  endraw %}
{% endhighlight %} 

抽出後のデータフレームは以下のとおりです。

![what_is_output]({{ "/images/img/fig_1107_02.png" | relative_url}}){:height="300px" width="300px"}<br>


### 練習データで指定する「値を含む」場合を示します

このブログで利用した練習用データフレームの作成から抽出までのコードは以下のとおりです。　今回は、「指定値を含む」ケースです。

{% highlight python linenos %}

# 演習用のデータフレームを作成します。
df = pd.DataFrame({ '顧客番号': ['01285679', '01340788', '02123782', '10541976', '12297411', 
                             '13299899', '30144450', '47339981'],
                   '都道府県名': ["北海道","北海道",'青森県','群馬県','千葉県','東京都','和歌山県','沖縄県'],
                  'メールアドレス':   ["nabe@example.net","hiro@example.net","aatsu@example.net",
                               "hi106@example.org","im_to@example.co.jp","ka713@example.org",
                               "sato@example.com","oka_h@example.net"]},
                    index=[0, 1, 2, 3, 4, 5, 6,7])
# オリジナルのデータフレームを表示

df = df[df['メールアドレス'].str.contains('@example.org')]

display(df)


{% endhighlight %}

![what_is_output]({{ "/images/img/fig_1107_03.png" | relative_url}}){:height="300px" width="300px"}<br>


### まとめ

<div class="box44">
    <span class="box-title">Point</span>
    <ol style="font-size: 100%; color: noir;">
    <li>df = df[df['メールアドレス'].str.contains('@example.org')]　<strong>含む</strong>で抽出</li>
    <li>df = df[~df['メールアドレス'].str.contains('@example.org')]　<strong>含まない</strong>で抽出</li>
    </ol>
</div>

---
