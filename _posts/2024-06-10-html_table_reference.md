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
  #- wide
sidebar:
  nav: "docs"
category: Reference
date: 2024-08-22
last_modified_at : 2024-08-22 13:23:00
---


Markdown Table の作成と装飾についてまとめました。 <!--more-->
マークダウンは簡単にテーブルを作成できますが、セルがマージできないなど
制限もあります。<br>css での装飾、リスト表示、footer の追加方法についてまとました。

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
  border-top: 2px solid #9b9b9d;
  border-bottom: 2px solid #9b9b9d;
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
