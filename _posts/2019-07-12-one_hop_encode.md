---
layout: post
title: カテゴリカル・データのダミー変数化
feature-img: "assets/img/2019_06_30/website-1624028_1280.jpg"   
tags: [Python, data_handling]
excerpt_separator: <!--more-->
---

カテゴリカル・データをデータ解析の説明変数とするためダミー変数にします。
<!--more-->
Pandas では一発でダミー変数にできます。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
ダミー変数化したい列をシリーズデータとして取り出す | dummy = df['ダミー変数したい列'] 
カテゴリカル・データをダミー変数化する | dymmy = pd.get_dummies(dummy, prefix='td')

---

### 概念図

左結合の概念図は以下のとおりです。
ちなみに、作成する新データフレーム`tdfk`は図中のコマンドを打つ前にSeries（配列）にして取り出す必要があります。その名前も`tdfk`としています。

![merge_left]({{ "/assets/img/2019_07_01/one_hop_encode.png" | relative_url}})

### ポイント

1. df内のカテゴリカル・データの列（タテ）を横に展開する
2. 都道府県番号のように47種類ある場合は、47列生成される
3. データフレームの行数（Length）は不変
4. `pd.cancat`で結合する
5. 変更元の列は不要なので削除することを忘れないようにする


### one hop encoding の実際

本サイトでおなじみのデータフレーム[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} の都道府県番号が入っている`PY_07`をダミー変数化します。


{% highlight python %}
# Series データとして取り出した後、ダミー変数化したデータフレムにする
tdfk = df['PY_07'] # series 
tdfk = pd.get_dummies(tdfk, prefix='td')

# 元となるdfと新しく作成されたtdfk のサイズを見ます
print('df', df.shape)
print('tdfk', tdfk.shape)
{% endhighlight %}

結果は以下のとおりです。
{% highlight python %}
(7845, 11)
(7485, 47)
{% endhighlight %}


共通の列は`PY_09` です。サイズは、dfが7507行 でdf2が22596行あります。
更に、NaNの様子を確認します。

{% highlight python %}
# dfの前後のサイズをプリントしておきます
print('before', df.shape)
df = pd.concat([df, tdfk], axis = 1)
df = df.drop(columns=['PY_07'])
print('after', df.shape)
{% endhighlight %}

{% highlight python %}
before (7485, 11)
after (7485, 57)
{% endhighlight %}


df にdf2 を左結合します。 

{% highlight python %}
# 列名を出力します
df.columns
{% endhighlight %}

{% highlight python %}
Index(['PY_02', 'PY_03', 'PY_05', 'PY_06', 'PY_09', 'PY_11', 'PY_12', 'PY_13',
       'PY_14', 'PY_20', 'td_1', 'td_2', 'td_3', 'td_4', 'td_5', 'td_6',
       'td_7', 'td_8', 'td_9', 'td_10', 'td_11', 'td_12', 'td_13', 'td_14',
       'td_15', 'td_16', 'td_17', 'td_18', 'td_19', 'td_20', 'td_21', 'td_22',
       'td_23', 'td_24', 'td_25', 'td_26', 'td_27', 'td_28', 'td_29', 'td_30',
       'td_31', 'td_32', 'td_33', 'td_34', 'td_35', 'td_36', 'td_37', 'td_38',
       'td_39', 'td_40', 'td_41', 'td_42', 'td_43', 'td_44', 'td_45', 'td_46',
       'td_47'],
      dtype='object')
{% endhighlight %}



---

### ひとこと

> カテゴリカル・データをデータ解析の説明変数としてする場合には、ダミー変数化する必要があります。one hop encoding はカテゴリカル・データのダミー変数にするための手間を格段と減らしてくれます。　是非、使い慣れてください。
