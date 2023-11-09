---
layout: post
title: 日付順にソートする
feature-img: "assets/img/2019_07_01/sort_by_date.png"
img: "assets/img/2019_07_01/sort_by_date.png"
date: 2019-09-12
tags: [pandas, data_handling]
---

日付データをソートして、インデックスもその順番に付け替えます。　EXCELではよくやる作業をpandas で行います。

#### 使用例

YYYY-MM-DD のフォーマットです。


やりたいこと | コーディング
---------- | -------------
古い順に並べ替える　|　df.sort_values(by = &#39;Date&#39;, ascending=True)
インデックスを付け替える　|　df.reset_index(drop=True)
データフレームにそのまま書き込む　|　df.reset_index(drop=True, inplace=True)



### ポイント

1. Dateとという列で日付順にする
2. ascending = True で古い順にする
3. 並び替えてもインデックスはそのままなので、付け替える
4. drop=True で付け替える前のインデックスを削除する
5. inplace=Trueで、データフレームに上書きする

　
![input_and_output]({{ "/assets/img/2019_07_01/sort_results.png" | relative_url}})
