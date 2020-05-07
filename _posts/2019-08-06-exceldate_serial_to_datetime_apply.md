---
layout: post
title: EXCELシリアル値をDatetime に変換する
feature-img: "assets/img/2019_07_01/check_patterm.png"   
tags: [pandas, data_handling]
excerpt_separator: <!--more-->
---

1900/1/1 を起点とするEXCELのDateシリアル値をPython Datetime に変換する関数です。
<!--more-->
オリジナルデータ[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} で使われていたEXCEL Dateシリアル値をpandasデータフレームで正しく表示させます。定番のデータハンドリングです。

---

### チートシート

やりたいこと | 注意点
---------- | -------------
EXCEL Dateシリアル値をDatetimeに変換する | df[&#39;d&#39;] = df[&#39;s&#39;].apply(関数名)　関数をapplyする


---


### 今回使うデータのポイント

1. df.shape => 17879 x 1
2. Serial_Date とある列が変換対象のEXCEL Dateシリアル値です
3. 関数２つでDate1,Date2の2列を追加します

オリジナルデータ[df]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"} のEXCEL シリアルDate値を抜き出して検証しました。

![df.shape]({{ "assets/img/2019_07_01/original_date_df.png" | relative_url}})



### サンプルコーディング


{% highlight python linenos %}
# 関数名 excel2datetimme, 引数はet, 列Date1を追加
def excel2datetime(et):
    if et < 60:
        days = pd.to_timedelta(et - 1, unit='days')
    else:
        days = pd.to_timedelta(et - 2, unit='days')
    return pd.to_datetime('1900/1/1') + days

df['Date1'] = df['Serial_Date'].apply(excel2datetime)

# ---------------------
# 関数名 excel2date, 引数はet2, 列Date2を追加
def excel2date(et2):
    from datetime import datetime, timedelta
    return(datetime(1899, 12, 30) + timedelta(days=et2))

df['Date2'] = df['Serial_Date'].apply(excel2date)

{% endhighlight %}

結果は以下のとおりです 今回使用したデータでは両者とも同じ結果を返しました。

#### 計算結果のデータフレーム
![result]({{ "assets/img/2019_07_01/result_date_df.png" | relative_url}})

---


#### おまけ

[strptimeの'%d/%m/%Y'の記法に関するメモ]({{ "portfolio/datetime-strptime.html" | relative_url}}){:target="_blank"}　も併せて参考にしてください！


定義した関数に直接直近のうるう年のシリアル値を入れて、確認してみました。大丈夫そうですね。　

![2020_leap_year]({{ "assets/img/2019_07_01/leap_year_2020.png" | relative_url}})


---

### ひとこと

> 前回のブログと同じように、変化のスピードが早い中データ解析に求められるのも、新鮮なデータでの解析です。リアルタイムにビッグデータを解析するのが当たり前な時代です。datetime handling 基礎です。
