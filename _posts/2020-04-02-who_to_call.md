---
layout: post
title: 列内のテキストで振り分ける
feature-img: "assets/img/2019_07_01/background-3045402_1920.png"   
tags: [data handling, pandas]
excerpt_separator: <!--more-->
---

EXCELに溜め込まれた訪問先の最初の担当者の様々な役職データを「経営層」、「管理職層」、「一般職（その他）」に
分類して、どの層にアポを取れてアプローチすれば、次のセルステージにつなげる確率が高いかを分析しました。

仮説「経営層から最初に攻めるトップダウンアプローチが有効である」とし、
立証「各層のセルステージ成功率に有意な差がある」

分析そのものは簡単でしたが、手間取ったのは、担当者の様々な役職データの分類作業です。

<!--more-->
会社には様々な役職名があります。　どんな役職名（肩書）を「経営層」とし、どんな役職名を「管理職層」とするか
意見の分かれるところだと思います。今回は、サンプルとして以下のような分類としました。

層別名 |　条件 
---------- | -------------
経営層  | 代表取締役、理事長、社長、取締役、理事、執行役員いずれかの役職名を持つ
管理職層 | 係長、課長、部長いずれかの役職名を持つ
一般職層 | 上記の役職を持たないすべて


そして「経営層」でも「管理職層」いずれでもないのを「その他」と三つの層に集約しました。
参照するデータは、ございません。　サンプルのデータでそのあらましを説明します。

---

### チートシート

やりたいこと | 方法
---------- | -------------
代表取締役,理事長,社長,取締役,理事,執行役員<br>のいずれかの文字列があれば Trueを返す。| 1. executive  = 代表取締役,理事長,社長,取締役,理事,執行役員<br>2. df[&#39;executive&#39;] =s.str.contains(executive, na=False)
Trueを1に変換する<br>Falseを0に変換する | 1. df[&#39;executive&#39;] = df[&#39;executive&#39;] * 1

---

### サンプルオペレーション

サンプルデータとして、最初の列にｅから始まる社員番号(4桁)と訪問先役職名を用意しました。訪問相手が複数の場合はそれぞれの役職名が入ることを想定します

{% highlight python linenos %}
#サンプルのデータです　社員番号と訪問先役職です
df = pd.DataFrame({'社員番号': ['e0001','e0002','e0003','e0004','e0005','e0006','e0007','e0008','e0009','e0010',
                          'e0011','e0012','e0013','e0014'],
                    '訪問先役職': ['課長','課長','部長, 代表取締役社長','代表取締役社長','取締役営業担当','営業部長',
                               '担当員','係長','執行役員','係長','課長, 常務取締役', '部長','理事長','理事']})

#作成したデータフレームを出力します
df
{% endhighlight %}

結果は以下のとおりになりました。

![df_start]({{ "assets/img/2019_07_01/2020-04-05 20.47.49.png" | relative_url}})<br>

{% highlight python linenos %}
# 訪問先役職の内訳をみます
df['訪問先役職'].value_counts()
{% endhighlight %}

{% highlight python %}
課長             2
係長             2
営業部長           1
担当員            1
代表取締役社長        1
部長, 代表取締役社長    1
理事長            1
取締役営業担当        1
理事             1
部長             1
課長, 常務取締役      1
執行役員           1
Name: 訪問先役職, dtype: int64
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}


{% highlight python linenos %}
#経営層(executive)，管理職(management)、その他(executive でもmanagementでない＝allでない)を語を登録し、それぞれ変数に代入します
executive  = '代表取締役|理事長|社長|取締役|理事|執行役員'
management = '係長|課長|部長'
all        = '係長|課長|部長|代表取締役|理事長|社長|取締役|理事|執行役員'

#調べる列を「変数s」に代入します
s = df['訪問先役職']

#列'executive'を新たに作り、変数executive の各語のいずれかが含まれていれば、'True'を返します。含まれない場合は'False'を返します
df['executive'] =s.str.contains(executive, na=False)
# True/FalseのBloole 値を 1/0に変換します（１をかけるだけです）
df['executive'] = df['executive'] * 1
#列'executive' の1/0のそれぞれの個数をプリントします
print(df['executive'].value_counts())

#列'management'を新たに作り、変数management の各語のいずれかが含まれていれば、'True'を返します。含まれない場合は'False'を返します
df['management'] =s.str.contains(management, na=False)
# True/FalseのBloole 値を 1/0に変換します（１をかけるだけです）
df['management'] = df['management'] * 1
#列'management' の1/0のそれぞれの個数をプリントします
print(df['management'].value_counts())

#列'other'を新たに作り、変数all の各語のいずれかが含まれていない時、'True'を返します。含まれれば'False'を返します
df['other'] =~s.str.contains(all, na=False)
# True/FalseのBloole 値を 1/0に変換します（１をかけるだけです）
df['other'] = df['other'] * 1
#列'other' の1/0のそれぞれの個数をプリントします
print(df['other'].value_counts())

# データフレーム'df'を表示します
df
{% endhighlight %}

{% highlight python %}
1    7
0    7
Name: executive, dtype: int64
1    8
0    6
Name: management, dtype: int64
0    13
1     1
Name: other, dtype: int64
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

![df_end]({{ "assets/img/2019_07_01/2020-04-05 20.51.49.png" | relative_url}})<br>



上記のことから、
1. 総数　14
2. 経営層　7
3. 管理職層 8
4. 一般職層 1
5. 経営層、管理職層の両者　1
であることがわかります。 






参照　[pandas.Series.str.contains](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.str.contains.html
){:target="_blank"}


---

### ひとこと

> 今回は、「経営層」、「管理職層」、「一般職層」の3つのカテゴリーに分類しましたが、大企業ではあれば、管理職にもいわゆる「課長」、「支店長」といった中間管理職、「執行役員」とか「本部長」といった事業責任者を分けて分析したいというニーズも当然でてきます。その場合は、従業員数が1000人を超える大企業に対して分類を細かく分けるというようなデータスライスと一緒に行うのが効果的です。しかし、社員数が1000人以上では、セールストップの訪問でも社長といった役員との訪問はほとんどなく、事業責任者が実質、経営層とするのが妥当である場合も少なく無いと思います。

