---
layout: post
title: Label Encoderで目的変数を作成する
feature-img: "assets/img/2019_07_01/label_encoded_bg.png"   
tags: [pandas, logistic regression]
excerpt_separator: <!--more-->
---

二項ロジスティック回帰分析も目的変数は 1または0の配列です。
<!--more-->
Label Encoder で作成します。　Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} のデータセットでオペレーションしました。　このデータセットで社員の退職要因を分析する二項ロジスティック回帰分析をシリーズでブログしたいと思います。

---

### チートシート

やりたいこと | 注意点
---------- | -------------
二項カテゴリカル・データを0/1の配列にする | Label Encoder を使う

---


### 今回使うデータのポイント

1. 1,470名の社員の退職状況(attrition)に関する人事データ (Kaggleより)
2. df.shape => 1470 x 35 
3. 目的変数用のデータフレームを作成します

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`HRデータ`です。

![df.shape]({{ "assets/img/2019_07_01/labe_encoder_log_res.png" | relative_url}})



### サンプルオペレーション


{% highlight python linenos %}
# Attrition に対してLabel Encodeし、最初の５行の結果をみる
from sklearn.preprocessing import LabelEncoder as LE
label_encoder = LE()
attrition_flag = df['Attrition']
attrition_encoded = label_encoder.fit_transform(attrition_flag)
attrition_encoded[0:5]
{% endhighlight %}


結果は以下のとおりです。 Attrition = Yes を１に、No を0にしています。

{% highlight python %}
array([1, 0, 1, 0, 0])
{% endhighlight %}

戻り値の配列を`target_df`という名前のデータフレームにします。

{% highlight python linenos %}
# 1 = yes / 0 = no
target_df = pd.DataFrame(attrition_encoded, columns=['attrition_yes'])
target_df.head()
{% endhighlight %}


#### 計算結果のデータフレーム
![result]({{ "assets/img/2019_07_01/label_encoded_df.png" | relative_url}})

---


#### 目的変数を可視化してみました

{% highlight python linenos %}

rcParams['figure.figsize'] = 6,4
sb.countplot(x='attrition_yes', data=target_df, palette='hls')
{% endhighlight %}


![count_bar]({{ "assets/img/2019_07_01/label_encode_bar.png" | relative_url}})

{% highlight python linenos  %}
df_pie =target_df.groupby(by='attrition_yes').size()

labels = ['Yes', 'No']
plot = df_pie.plot.pie(y='attrition_yes', labels=labels, autopct='%.1f%%')
{% endhighlight %}

![count_pie]({{ "assets/img/2019_07_01/label_encode_pie.png" | relative_url}})

---

### ひとこと

> 分類問題の基本である二項ロジスティック回帰分析のためのデータセット準備には、Label Encoderが必須アイテムです。また、作成した目的変数の可視化も合わせて行い、どんな割合で分類されているか確認しておきましょう。
