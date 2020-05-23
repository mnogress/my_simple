---
layout: post
title: ロジスティック回帰分析＿その2
feature-img: "assets/img/2019_07_01/mizutama_logo.png"   
tags: [logistic regression, machine learning]
excerpt_separator: <!--more-->
---

満足度や業績評価、月収等のすでに数値化された順序尺度の回帰分析に性別等のカテゴリカルデータを説明変数に加えて的中率(hit ratio)の影響を調べます。モデルに修正を加えて的中率(hit ratio)をアップする手順を解説します。

<!--more-->
[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/logistic_regression_basic_1.html" | relative_url}}){:target="_blank"} では、各社員の退職の予想を二項ロジスティック回帰分析し、86%の的中率(hit ratio)でした。

使うデータは、Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} ダウンロードできます。

---

### チートシート

やりたいこと | 方法
---------- | -------------
カテゴリカル・データを説明変数に加える |　df_cat = pd.get_dummies(cat, prefix=&#39;cat&#39;)<br> df_test1 = pd.concat([df_test, df_cat], axis = 1)

`'cat' : カテゴリカル・データ変数の列名`{:style="background-color: #ffe3e2; font-size: 0.7em"}

---


### 今回使うデータのポイント

1. 1,470名の社員の退職状況(attrition)に関する人事データ[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/regression_basic_1.html" | relative_url}}){:target="_blank"} と同じデータ
2. JooRole（職務）,Gender（性別）, BusinessTravel (出張の有無)のカテゴリカル・データを別々に追加して的中率(hit ratio)で評価します 

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`HRデータ`です。

![df.shape]({{ "assets/img/2019_07_01/labe_encoder_log_res.png" | relative_url}})



### サンプルオペレーション

それぞれのカテゴリカル・データに対して、以前の記事で紹介した[One_Hop_Encoding]({{ "2019/07/12/one_hop_encode.html" | relative_url}}){:target="_blank"} もしくは、[Lavel_Encoder]({{ "2019/08/23/label_encoder_for_target.html" | relative_url}}){:target="_blank"} でダミー変数化したデータフレームを作成します。　それをテストデータのデータフレームに左結合させます。　左結合についても[データフレーム同士の左結合]({{ "2019/07/14/concat_rese_duplicaes.html" | relative_url}}){:target="_blank"}に方法を説明していますので、必要に応じて参照しください。

まず、JobRole（職務）からダミー変数化します。


{% highlight python linenos %}
# カテゴリカル・データのJobRoleをダミー変数化する
JobRole = df['JobRole'] # series 
df_JobRole = pd.get_dummies(JobRole, prefix='jr')

#サイズをみる
print('df_JobRole', df_JobRole.shape)
{% endhighlight %}

{% highlight python %}
(1470, 9)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

ダミー変数化した`df_JobRole`データフレームの先頭５行を確認する

![df_head]({{ "assets/img/2019_07_01/job_role_head.png" | relative_url}})

`df_test`に`df_JobRole`を左結合してこのテストデータを`df_test1`とし、二項ロジスティック回帰分析をします。

{% highlight python linenos %}
df_test1 = pd.concat([df_test, df_JobRole], axis = 1)X_train, X_test, y_train, y_test = train_test_split(df_test1,
                                                   target_df['attrition_yes'], test_size=0.2,
                                                   random_state=200)

LogReg = LogisticRegression(solver='liblinear')
LogReg.fit(X_train, y_train)
y_pred = LogReg.predict(X_test)
accuracy_score(y_test, y_pred)
{% endhighlight %}

モデルの性能評価をします。　残念ながら、0.1ポイントダウンで`JobRol`eは`Attrition`に関係なさそうです。

{% highlight python %}
0.8571428571428571
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

同様に、df_test2 には`Gender`を追加したデータフレームでの二項ロジスティック分析を、df_test3では`Business_Travel`で同様の分析をしました。
それぞれのカテゴリカル・データの影響度を図るため、一度にすべてを投入するのではなく、個々に投入してその影響度を確認します。

また、テストデータのトレーニング用と検証用に分割する際も以下のことに気をつけて、できるだけ他の要因を排除して、カテゴリカル・データ投入の影響をみるようにします。
1. 分割比を変えない（今回は8:2)
2. ランダムサンプリングのSeed値を変えない（同じ乱数を発生させる）

### 検証結果

カテゴリカル・データ　| 的中率(hit ratio)
---------- | -------------
何も投入しない　| 0.8605442176870748
JobRole(職務)　| 0.8571428571428571
Gender(性別)　| 0.8605442176870748
Business Travel (出張)　| 0.8639455782312925



出張は職務より、性別より社員の退職を予想制度を若干上げる結果となりました。　
モデルを確定するにあたり、Business Travel の影響を考慮する必要がありそうです。　ここまで検討をすると、現在投入したそれぞれの説明変数の予想精度に対する寄与度を見たくなると思います。
次回からはその辺の検討方法について解説します。


参照　[sklearn.linear_model.LogisticRegression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html#sklearn-linear-model-logisticregression
){:target="_blank"}


---

### ひとこと

> 二項ロジスティック回帰分析のモデルの生成について説明しました。現在、的中率86.4% です。90%を超えたいと思う一方、分析の本旨は何かを今一度、考えてみましょう。精度の高いモデルの構築はデータ分析屋としては追求したいですが、クライアントは数ある説明変数のうち、どれを管理すれば退職率が低下できるのかといった、管理面に関心があることが多いです。なんのためのデータ分析なのか、一呼吸入れて考えることも大事ですね。
