---
layout: single
title: Markdown Table Reference
header:
  overlay_image: images/header_E.png
  #overlay_filter: rgba(107, 74, 43, 0.40)
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
date: 2024-08-22
last_modified_at : 2024-08-22 13:23:00
excerpt: >
  当サイトで使用している HTML テーブル（表）のカスタムスタイルをまとめたリファレンスです。見出し行、強調セル、背景色、行間調整など、記事作成でよく使う表の装飾方法を用途別に整理しています。読みやすく統一感のあるデザインを作るためのガイドとして活用できます。

---
 <!--more-->
#### はじめに
<p>
このページは、当サイトで使用している HTML テーブル（表）のカスタムスタイルをまとめたリファレンスです。
見出し行のデザイン、セルの強調、行間の調整、背景色の付け方など、記事作成時によく使う表の装飾方法を用途別に整理しています。
</p>

<p>
「どのクラスを使うとどんな見た目になるのか」をすぐ確認できるように、実際の表示例とともに掲載しています。
記事の読みやすさや視認性を高めるためのガイドとして活用してください。
</p>

<p>
特に、語学学習ページや技術解説ページでは表の使用頻度が高いため、統一感のあるデザインを保つことで、サイト全体の品質向上につながります。
必要に応じて、このリファレンスにスタイルを追加し、継続的に改善していくことを想定しています。
</p>


#### Base Table by Markdown and CSS

main.css のtableクラスを取り込み、それを利用して「**このページのみ有効**」とする装飾を
アレンジしたベーステーブルを作成する。　手順は以下のとおりです。


| Line# | 概要    |備考 | 
| :-----    | :-----   |:---- | 
| **1 to 38**    | main.css のtableクラスを取り込む  | \<style type="text/css">と</style>で囲みこのページ独自のCSSを作成する |
| **2 to 10**     | クラス名を"table"とする  |table {}で囲む|
| **7**     | font-sizeを変更  |font-size: 0.65em;と指定する|
| **27 to 31**   | tfootを追加し、backgroud-colorを別の色に変更  |background-color: #afeeee;と指定する|
| **49**   |  {: class="table"}を最後に付加する |これで設定したCSSが効くようになる　|
{: .notice}



{% highlight css linenos %}

<style type="text/css">
table {
  display: block;
  margin-bottom: 1em;
  width: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI", "Helvetica Neue", "Lucida Grande", Arial, sans-serif;
  font-size: 0.65em;
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
  border-bottom: 1px solid #9b9b9d;
}

tr,
td,
th {
  vertical-align: middle;
}
</style>

| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                     
| footer    |  ft_1-2   |  ft_1-3 |
{% raw %}{: class="table"}{% endraw %}
{% endhighlight %}

### Base Result

<style type="text/css">
</style>




| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                     
| footer    |  ft_1-2   |  ft_1-3 |
{: class="table"}


#### class(例:example) を設定して字の色と太字に変更する

{% highlight css linenos %}

<style type="text/css">
  table.example { color: cadetblue; font-weight: bold;}
</style>

| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                      < == table footer 開始
| footer    |  ft_1-2   |  ft_1-3 |
{% raw %}{: class="example"}{% endraw %}
{% endhighlight %}


#### Result 2


<style type="text/css">
  table.example { color: cadetblue; font-weight: bold;}
</style>

| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                     
| footer    |  ft_1-2   |  ft_1-3 |
{: class="example"}


#### styleを直接設定して字の大きさ変更する


{% highlight css linenos %}

| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                     
| footer    |  ft_1-2   |  ft_1-3 |
{% raw %}{: style="font-size:1.1em;"}{% endraw %}
{% endhighlight %}



#### Result 3


| 左寄せ(Left) | 真ん中(Cebter) | 右寄せ(Right) |
| :-----       | :----:         | -----:       |
| td_1-1    |  td_1-2   |  td_1-3 |
| td_2-1    |  td_2-2   |  td_2-3 |
|----
| td_3-1                      |  
| td_4-1   | td_4-21<br>td_4-22<br>  |  td_4-3 |  
|====                                     
| footer    |  ft_1-2   |  ft_1-3 |
{: style="font-size:1.1em;"}

<h4>まとめ</h4>
<p>
このページでは、当サイトで使用している HTML / Markdown のカスタムスタイルを一覧としてまとめました。
見出し、ボックス、強調表示、表、余白調整など、記事作成で頻繁に使う要素を用途別に確認できるよう整理しています。
</p>

<p>
スタイルを統一することで、記事全体の読みやすさや視認性が向上し、読者にとってストレスのない学習体験を提供できます。
特に語学学習ページや技術解説ページでは、情報量が多くなりがちなため、適切な装飾やレイアウトが大きな効果を発揮します。
</p>

<p>
今後も記事の内容に合わせてスタイルを追加・改善し、サイト全体のデザイン品質を継続的に高めていく予定です。
必要に応じて、このリファレンスを参照しながら、統一感のある記事作成に役立ててください。
</p>
