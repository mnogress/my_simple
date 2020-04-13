---
layout: post
title: データを理解する（カテゴリカル・データ）
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データ解析する大前提として用意された（通常はシステム部等のインフラチームから提供される）生データを解析に適したデータセットにします。　このことをデータクリーニングとかデータクレンジングといいます。　更に、その前段階として用意されたデータの中身を理解する必要があります。今回は、データの中で多くを占めるカテゴリカルデータを理解するためのPython （Pandas)のコーディングを説明します。
<!--more-->
データセットの中身を理解する具体的な方法について説明します。

1. データタイプがカテゴリカル・データかどうか
2. カテゴリカルデータの要素
    - 総数
    - 種類
    - 種類ごとの数（集計）
3. NAN（欠損値）の有無

データフレーム（df) の各列のデータの型を調べるには、`df.dtypes` と入力すればいい。
{% highlight python %}
# data frame の各列のデータ型を見る
df.dtypes  
{% endhighlight %}

すると、以下のようにアウトプットされる
{% highlight py %}
R1BH      float64
R1C1a       int64
R1E1     category
R1J1     category
R1K1      float64
R1L1      float64
R1M1      float64
R1N1      float64
R1O1      float64
R1P1      float64
R1Q1       object
R1T1     category
R1AB      float64
R1AG      float64
R1AH      float64
R1V1      float64
R1W1      float64
R1BHa       int64
dtype: object
{% endhighlight %}

上記のように　`R1E1` はカテゴリカル・データであるが、実際は都道府県番号が入っている。　その中身を見てみる

{% highlight python %}
# data frame の'R1E1' 列のデータ型を見る
df['R1E1'].dtypes  
{% endhighlight %}

結果は以下のとおり：
{% highlight python %}
CategoricalDtype(categories=[ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
                  16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                  31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
                  46, 47],
                 ordered=False)

{% endhighlight %}

![Travel]({{ "/assets/img/pexels/travel.jpeg" | relative_url}})

Ut dolor diam, elementum et vestibulum eu, porttitor vel elit. Curabitur venenatis pulvinar tellus gravida ornare. Sed et erat faucibus nunc euismod ultricies ut id justo. Nullam cursus suscipit nisi, et ultrices justo sodales nec. Fusce venenatis facilisis lectus ac semper. Aliquam at massa ipsum. Quisque bibendum purus convallis nulla ultrices ultricies. Nullam aliquam, mi eu aliquam tincidunt, purus velit laoreet tortor, viverra pretium nisi quam vitae mi. Fusce vel volutpat elit. Nam sagittis nisi dui.

> Suspendisse lectus leo, consectetur in tempor sit amet, placerat quis neque

Etiam luctus porttitor lorem, sed suscipit est rutrum non. Curabitur lobortis nisl a enim congue semper. Aenean commodo ultrices imperdiet. Vestibulum ut justo vel sapien venenatis tincidunt.

Phasellus eget dolor sit amet ipsum dapibus condimentum vitae quis lectus. Aliquam ut massa in turpis dapibus convallis. Praesent elit lacus, vestibulum at malesuada et, ornare et est. Ut augue nunc, sodales ut euismod non, adipiscing vitae orci. Mauris ut placerat justo. Mauris in ultricies enim. Quisque nec est eleifend nulla ultrices egestas quis ut quam. Donec sollicitudin lectus a mauris pulvinar id aliquam urna cursus. Cras quis ligula sem, vel elementum mi. Phasellus non ullamcorper urna.
