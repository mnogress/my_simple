---
layout: single
title: 【Pandas】日付の新しい方を残す重複排除
header:
  overlay_image: images/header_F.png
  overlay_filter: rgba(44, 82, 207, 0.25)
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
date: 2025-10-20
last_modified_at : 2025-10-20 15:23:00
excerpt: >
  日付の新しい（または古い）方を残して重複排除するための実務的な手順を、datetime の確認からソート、drop_duplicates まで3ステップでまとめた How To 記事です。最初に並び替えておくことが成功のポイントで、日常の集計で頻出する処理を Python で確実に再現できるように解説しています。

---

日付の新しい方を残す重複排除やり方をまとめました。重複排除するルールとして、❶新しいものを残す。❷古い方を残す。といった一工夫が必要な場合があります。そのステップをまとめました。<!--more--> 概要は以下のとおりです。
<div class="box33">
    <span class="box-title">概要</span>
    <ol>
      <li><strong>keep='first'</strong> でデータフレームを上から下へ重複チェックするとして、最初のものを残す</li>
      <li>新しいものが最初にチェックされるよう降順に並べ替える</li>
    </ol> 
</div>

<style>
</style>


#### Step 1：datetime オブジェクトの確認

日付の列でソートするには、その列がdatetime オブジェクトでなければなりません。まず、ソートする列のデータ型を確認します。

{% highlight python linenos  %}
# データ型を確認する

df['date'].dtypes

>> dtype('<M8[ns]')  --> OK
>> dtype('O')  --------> NG  datetime 型式にする必要ある
>> dtype('int64')  ----> NG  datetime 型式にする必要ある
>> dtype('float64') ---> NG  datetime 型式にする必要ある
{% endhighlight %}

NGの場合には、datetime オブジェクトにします。

{% highlight python linenos  %}
# データ型をdatetime にする

df['date']=pd.to_datetime(df['date'])

{% endhighlight %}


#### Step 2：新しい順に並び替える

{% highlight python linenos  %}
# ascending = False -> 値の大きい順、日付けの新しい順　

df = df.sort_values(["date"], ascending = False)

{% endhighlight %}

列名**date**で新しい順に並び替えておく。

##### *ascending = False* >> 降順 >> 新しいものから古いもの

<div class="box33">
<span class="box-title">Point!</span>
<dl><strong>ascending の意味：上昇</strong>
<dt>ascending = True</dt> 
<dd>昇順　古いものから新しいものへ　小さいものから大きいものへ</dd>
<dt>ascending = False</dt>
<dd>降順　新しいものから古いものへ　大きいものから小さいものへ</dd>
</dl>
</div>


#### Step 3：列A（例：社員番号）の重複排除の基準として新しいものを残す

{% highlight python linenos  %}

# 新しいものが最初にソートされているので、keep='first'とする
# inplace=True で上書きする
# 前後にdf.shapeで要素数をプリントし排除された数を把握する

print(df.shape)
df.drop_duplicates(subset='社員番号', keep='first', inplace=True)
print(df.shape)

{% endhighlight %}
