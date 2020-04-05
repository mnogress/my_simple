---
layout: post
title: データを理解する（カテゴリカル・データ）
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

データ解析する大前提として用意された（通常はシステム部等のインフラチームから提供される）生データを解析に適したデータセットにします。　このことをデータクリーニングとかデータクレンジングといいます。　更に、その前段階として用意されたデータの中身を理解する必要があります。今回は、データの中で多くを占めるカテゴリカルデータを理解するためのPython （Pandas)のコーディングを説明します。
<!--more-->
データセットの中身を理解する具体的な方法について説明します。

* カテゴリカルデータの要素を知る
* 各要素の集計を知る
* NAN（欠損値）の有無を検査する

{% highlight py %}
// count to ten
for (var i = 1; i <= 10; i++) {
    console.log(i);
}

// count to twenty
var j = 0;
while (j < 20) {
    j++;
    console.log(j);
}
{% endhighlight %}

![Travel]({{ "/assets/img/pexels/travel.jpeg" | relative_url}})

Ut dolor diam, elementum et vestibulum eu, porttitor vel elit. Curabitur venenatis pulvinar tellus gravida ornare. Sed et erat faucibus nunc euismod ultricies ut id justo. Nullam cursus suscipit nisi, et ultrices justo sodales nec. Fusce venenatis facilisis lectus ac semper. Aliquam at massa ipsum. Quisque bibendum purus convallis nulla ultrices ultricies. Nullam aliquam, mi eu aliquam tincidunt, purus velit laoreet tortor, viverra pretium nisi quam vitae mi. Fusce vel volutpat elit. Nam sagittis nisi dui.

> Suspendisse lectus leo, consectetur in tempor sit amet, placerat quis neque

Etiam luctus porttitor lorem, sed suscipit est rutrum non. Curabitur lobortis nisl a enim congue semper. Aenean commodo ultrices imperdiet. Vestibulum ut justo vel sapien venenatis tincidunt.

Phasellus eget dolor sit amet ipsum dapibus condimentum vitae quis lectus. Aliquam ut massa in turpis dapibus convallis. Praesent elit lacus, vestibulum at malesuada et, ornare et est. Ut augue nunc, sodales ut euismod non, adipiscing vitae orci. Mauris ut placerat justo. Mauris in ultricies enim. Quisque nec est eleifend nulla ultrices egestas quis ut quam. Donec sollicitudin lectus a mauris pulvinar id aliquam urna cursus. Cras quis ligula sem, vel elementum mi. Phasellus non ullamcorper urna.
