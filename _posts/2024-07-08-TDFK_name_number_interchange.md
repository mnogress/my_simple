---
layout: single
title: 都道府県名と都道府県番号の相互変換
header:
  overlay_image: images/header_3.png
  overlay_filter: rgba(107, 74, 43, 0.20)
toc: True
toc_label: "目次"
toc_icon: "club" 
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
date: 2024-07-25
last_modified_at : 2024-07-25 15:00:00
---

都道府県名から都道府県番号に変換及びその反対変換<!--more-->を[**jp_pref.prefectureモジュール**](https://pypi.org/project/jp-pref/){:target="_blank"}の
*name2code, code2name*をPandas データフレームに対して利用する関数とその適用方法を紹介します。

#### モジュールをインポートと関数定義

{% highlight python linenos  %}

# 必要なモジュールをインポート
from jp_pref.prefecture import name2code, code2name
from jp_pref.prefecture import df as df_pref

# 関数の定義１　都道府県番号から都道府県名を得る関数の定義
def get_prefecture_name(prefecture_number):
    try:
        return df_pref[df_pref["都道府県番号"] == prefecture_number]["都道府県名"].values[0]
    except IndexError:
        return None  # 該当する都道府県名がない場合は None を返す

# 関数の定義２　都道府県名から都道府県番号を得る関数の定義
def get_prefecture_number(prefecture_name):
    try:
        return df_pref[df_pref["都道府県名"] == prefecture_name]["都道府県番号"].values[0]
    except IndexError:
        return None  # 該当する都道府県名がない場合は None を返す
{% endhighlight %}


<dl><strong>定義した関数</strong>
<dt>get_prefecture_name(prefecture_number)</dt> 
<dd>都道府県番号　==> 都道府県名</dd>
<dt>get_prefecture_number(prefecture_name)</dt>
<dd>都道府県名　==> 都道府県番号</dd>
</dl>
{: .notice--info}

#### df_pref を関数参照用に操作する

df_pref が定義した上記の関数が参照するデータフレームですが、そのままでは使えません。
都道府県番号をインデックスから列名'都道府県番号'に変更するなどの操作が必要です。
詳細は、以下のコードのとおりです。

{% highlight python linenos  %}

# df_pref データフレームを関数に合わせて
# インデックスから列にリセットし、列名を変更する

df_pref = df_pref.reset_index()
df_pref.rename(columns={'code': '都道府県番号',
                       'name': '都道府県名',
                       'short_name': '都道府県'}, inplace = True)

{% endhighlight %}


#### 関数のPandas Pandas データフレームへの適用

{% highlight python linenos  %}

# データフレーム内の"都道府県番号"という列の値から
# "TDFK_name"という新しい列を作成し、対応する都道府県名を代入する
# 該当する都道府県名が無い　例：48 の場合は　None を返す

df['TDFK_name'] = df['都道府県番号'].apply(get_prefecture_name)


# データフレーム内の"都道府県名"という列の値から
# "TDFK_number"という新しい列を作成し、対応する都道府県番号を代入する
# 該当する都道府県番号が無い　例：東大阪 の場合は　None を返す

df['TDFK_number'] = df['都道府県名'].apply(get_prefecture_name)

{% endhighlight %}
