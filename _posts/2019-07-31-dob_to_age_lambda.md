---
layout: post
title: 生年月日(MM/DD/YY)から年齢を計算する
feature-img: "assets/img/2019_07_01/alice_pattern.png"   
tags: [pandas, data_handling]
excerpt_separator: <!--more-->
---

生年月日(MM/DD/YY)から年齢を計算をします。文字列`MM/DD/YY`で年が二桁しかありません。
<!--more-->
[Kaggle]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"}でみつけた2016年リオデジャネイロオリンピックの選手リストを使って、Pandas で計算します。

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}にデータセットの概要があります。参考にしてください。

---

### チートシート

やりたいこと | Coding
---------- | -------------
文字列の生年月日をDatetimeオブジェクトにする | df[&#39;dob&#39;] = pd.to_datetime(df[&#39;dob&#39;])


---


### Kaggle データで作成する

[リオデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} を使って、生年月日を計算しました。　生年月日がMM/DD/YYと年が二桁であること。　データに欠損値があるので、必ず、その行を落とすなどして下準備が必要です。
Kaggle で RIO, Olympic と検索すると出てくると思います・


### 今回使うデータのポイント

1. df.shape => 11538 x 11
2. dob とある列が生年月日です
3. 2016/07/01 時点の年齢としました

![df.shape]({{ "assets/img/2019_07_01/dob_to_age_lambda.png" | relative_url}})

### サンプルコーディング


{% highlight python linenos %}
# 下準備として文字列からオブジェクトにしておく
df["DoB"] = pd.to_datetime(df["dob"], format="%m/%d/%y")

# 年齢を計算する

def getAge(DoB):
    today    = int(pd.to_datetime('2016-07-01').strftime('%Y%m%d'))
    DoB = int(DoB.strftime('%Y%m%d'))
    return int((today - DoB) / 10000)

df['age'] = df['DoB'].apply(lambda x: getAge(x))
df.head()

# もしくは以下でも同じこと

now = pd.to_datetime('2016/07/01')
df['age']=(now.year - df['DoB'].dt.year) - ((now.month - df['DoB'].dt.month) < 0)

{% endhighlight %}

結果は以下のとおりです YYYY-MM-DD の形式の`DoB` 列を作成しその列に対してlambda関数で生年月日を計算しました。

#### 計算結果のデータフレーム
![result]({{ "/assets/img/2019_07_01/dob_to_age_result.png" | relative_url}})

---


#### おまけ

よろしかったら、[strptimeについての記事]({{ "portfolio/datetime-strptime.html" | relative_url}}){:target="_blank"}　も参考にしてください！

密度関数のグラフ化もして分布の状況をみてみました。

![密度関数]({{ "assets/img/2019_07_01/density_func_distribution.png" | relative_url}})


---

### ひとこと

> データ解析に日付データは欠かせません。`MM/DD/YY` 年数部分は二桁が依然主流です。<br>
>`df["DoB"] = pd.to_datetime(df["dob"], format="%m/%d/%y")`はよく使うコードです。
