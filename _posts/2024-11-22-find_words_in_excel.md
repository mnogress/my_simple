---
layout: single
title: Excelファイルの内容をKey Word検索する
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
date: 2024-11-22
last_modified_at : 2025-07-22 13:23:00
---


Excelファイルの内容をKey Word検索するPython Scriptをまとめました。 <!--more-->
フォルダ内のExcelファイルのタイトルではなく中身について検索するPython Script になります。

#### if "検索文字" in "検索対象文字列" を理解する 

検索には、**if "検索文字" in "検索対象文字列"**の構文を使っています。
以下の例で理解できます。検索対象文字列に対して**検索文字を含む部分検索**が可能です。

{% highlight python linenos %}
if 'リンゴ' in 'リンゴみかん':
    print('Matched')
else:
    print("No Matched")

>>> Matched
# 'リンゴみかん'の文字列には文字列'リンゴ'はある。
{% endhighlight %}


{% highlight python linenos %}
if 'リンゴみかん' in 'リンゴ':
    print('Matched')
else:
    print("No Matched")

>>> No Matched
# 'リンゴ'の文字列には文字列'リンゴみかん'はない。
{% endhighlight %}


{% highlight python linenos %}
if 'リンゴみかん' in 'リンゴみかんレモン':
    print('Matched')
else:
    print("No Matched")

>>> Matched
#  'リンゴみかんレモン'の文字列には文字列'リンゴみかん'はある。
{% endhighlight %}

