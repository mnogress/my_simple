---
layout: post
title: 複数の行を連結して重複行を削除する
feature-img: "assets/img/2019_07_01/background-2025316_1280.png"   
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

年別や地域別で複数のデータセットにまたがったデータを一つに解析用に連結します。
<!--more-->
更に、連結した際のお作法として重複した行があれば削除します。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
複数のデータフレームの行を連結する | df = pd.concat([df1, df2]) 
新しくインデックスをつけ直し、元のインデックスは削除する | df.reset_index(drop=True)
重複した行を削除する| df = df.drop_diplicates()

---

### 概念図

今回のデータ操作の流れは以下のとおりです。　

![concat_dup]({{ "/assets/img/2019_07_01/df_concat_rest_duplicates.png" | relative_url}})

### ポイント

1. df1 にdf2の行を追加する
2. 列名の行は追加されない
3. インデックスはそのままなので、重複するため振り直す
4. `df.reset_index(drop=True)` と指定しないと元のインデックスが列として残る
5. 念の為、重複した行があれば削除する


### Kaggle データ

今回は、いつものデータフレームではなく、Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} をダウンロードしてオペレーションしました。　欠損値のチェックやデータセットの理解のための一連の作業は実施済です。

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}にデータセットの概要があります。参考にしてください。


{% highlight python linenos %}
# データを分割して作成したdf1 とdf2 を連結する
print('before df1', df1.shape) 
print('before df2', df2.shape) 
df=pd.concat([df1,df2])
print('after df', df.shape) 

{% endhighlight %}

結果は以下のとおりです。
{% highlight python %}
before df1 (10, 35)
before df2 (30, 35)
after df (40, 35)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


2つのデータフレームとも同じ行数です。次に、ダミー変数のデータフレームのtdfkをdf に連結します。
今回の連結には pd,concat メソッドでdf にtdfk を追加する感じで連結します。
また、都道府県番号が入った'PY_07'は必要ないので、ドロップしてます。

{% highlight python linenos %}
# インデックスを振り直します
df =df.reset_index(drop=True)
{% endhighlight %}

{% highlight python linenos %}
# 重複した行を除外します
print('before', df.shape) 
df = df.drop_duplicates()
print('after', df.shape) 
{% endhighlight %}

df のサイズを確認します。ちなみに、`df=df.drop_duplicates()` と同じdf に代入しているため、行数が変化します。　
`df.drop_duplicates(inplace=True)` と`inplace=True`{:style="background: #ffebf6"}を指定するとdfに代入する必要はありません。

{% highlight python %}
before (40, 35)
after (32, 35)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

### Kaggle データで行ってみる

Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} で2つのデータフレームを作成して上記の一連の操作を行いました。

データフレームのビフォア、アフターは以下のようになりました。
薄いオレンジがインデクスです。　薄黄色が重複のある行です。　それが除外され、赤い部分に置き換わっています。


![output_comparison]({{ "/assets/img/2019_07_01/output_comparison.png" | relative_url}})


---

### ひとこと

> マシンラーニング等で解析する場合は、一つの大きなデータセットをトレーニングとテストに分けていきます。　人が解析や管理するには、データセットを細分化した方が都合がいいかもしれません。　そのため、解析にあたりこのような単純ではあるが、気の抜けない「結合作業」は必ず存在します。
