---
layout: post
title: ロジスティック回帰分析＿相関係数
feature-img: "assets/img/2019_07_01/logo_huusenn.png"   
tags: [logistic regression, machine learning]
excerpt_separator: <!--more-->
---

[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/logistic_regression_basic_2.html" | relative_url}}){:target="_blank"} では、各社員の退職の予想を二項ロジスティック回帰モデルにダミー変数を加えて的中率(hit rate)をアップする手順を解説しました。
<!--more-->
今回は、説明変数を退職率への影響の大小という観点で検討のため、「相関係数(coeffiect)」の扱いについて説明します。

データ分析屋としては的中率の最大化に進みたいところですが、クライアントの人事や現場は、むしろ何が退職率に影響しているのか、影響度の度合いについての検討を望んでいることが多いと感じます。　

使うデータは、Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} のデータセットでオペレーションしました。

---

### チートシート

やりたいこと | 方法
---------- | -------------
各説明変数の相関係数(θ)の変数`coef`を得る |　coef = LogReg.coef_
データフレームを転地する　| df_coef = df_coef.T

`'LogReg : LogReg.fit(X_train, y_train)で学習(fit)済オブジェクト`{:style="background-color: #ffe3e2; font-size: 0.7em"}


---


### 今回使うデータのポイント

1. 退職状況(attrition)に関する人事データ[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/regression_basic_1.html" | relative_url}}){:target="_blank"} で得たロジスティック回帰分析モデルの各説明変数の係数と説明変数の統計量を調べます
2. 相関係数の正負、絶対値より予想に対する影響度を考えます

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`HRデータ`です。


### サンプルオペレーション

以前の記事で紹介した[データフレーム同士の左結合]({{ "2019/07/14/concat_rese_duplicaes.html" | relative_url}}){:target="_blank"}および[列名の変更]({{ "portfolio/column_rename.html" | relative_url}}){:target="_blank"}を使って、データハンドリングをします。

変数`LogReg`は二項ロジスティックアルゴリズム`liblinear`で定義され、トレーニングデータで学習(fit)済です。相関係数は、`coef_`アトリビュートから得ることができます。


{% highlight python linenos %}
# 「ロジスティック回帰分析＿その1」でfit済み
# LogReg = LogisticRegression(solver='liblinear')
# LogReg.fit(X_train, y_train)
print(LogReg.coef_)
{% endhighlight %}

{% highlight python %}
[[ 3.64089914e-02  2.55992323e-02 -2.47726126e-01 -4.10522161e-01
  -2.64106383e-01 -1.31124028e-04  9.08532467e-02  4.53165931e-01
  -3.39360350e-02 -4.91441426e-01 -9.35272936e-02 -6.12707786e-02]]
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

各説明変数の統計量は`y_test.describe()`で得ることができます。　ここでは、`LogReg.coef_`で得たcoefと統計量をそれぞれデータフレームにして結合します。結合に当たり、各々のデータフレームを転地（行と列を入れ替え）て 12 x 9 のデータフレームにしています。
また、最初に表示する数値を小数点以下2位までにして、大小関係を分かりやすくさせています。

{% highlight python linenos %}
# 各説明変数の相関係数(coef)を取得する
pd.options.display.float_format = '{:.1f}'.format
coef = LogReg.coef_
df_coef = pd.DataFrame(coef)
labels = df_test.columns
df_coef.columns = labels
df_coef = df_coef.T
df_coef = df_coef.rename(columns = { 0 : 'estimate'})
# 検証用（答え）のデータフレームの各説明変数の統計量を取得する
df_describe = df_test.describe()
df_describe = df_describe.T
df_coef_sum = pd.concat([df_coef, df_describe], axis =1)
df_coef_sum
{% endhighlight %}

結果は、以下のとおりです。

![df.shape]({{ "assets/img/2019_07_01/coef_statistics.png" | relative_url}})

line by line で説明します。

>
1. #### 各説明変数の相関係数(coef)を取得する
2. 係数の正負、絶対値を分かりやすくするため、表示を小数点以下1位までにします
3. 変数coefに相関係数を代入します
4. df_coef としてコンストラクタでデータフレーム化します
5. df_testの列名を変数lablesに格納します
6. df_coefの列名をlabelsの内容に入れ替えます
7. データフレームの行と列を入れ替え 1x12 を12x1 にします。インデックスがそれまでの列名に置き換わります
8. df_coef の新しい列名を estimateとします。それまでは、インデックス番号0でした
9. #### 検証用（答え）のデータフレームの各説明変数の統計量を取得する
10. 検証用のデータフレーム(df_test)の統計量をdf_describeに格納します
11. データフレームの行と列を入れ替えそ、 8x12を12x8にします
12. df_coefと df_describeを左結合し、新しいデータフレーム df_coef_sum とします
13. 表示させます
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 0.85em"}



### 係数の影響度の考察

相関係数の絶対値が0.3を目安に正の相関＝数値が大きいと１（退職）になる確率が大いと考えます。マイナスの場合はその反対に在職する確率が高いと考えると以下のようになります。

1. 退職するに影響すると考えられる説明変数
    1. Peformance Rating 業績評価　0.5 (ただし、Ratingは3,4しかない)
    2. NumCompaniesWorked(転職回数)　0.1(やや影響あり)
2. 在職するに影響すると考えられる説明変数
    1. StockOptionLevel	ストックオプション　-0.5
    2. JobInvolvement 職務環境　-0.4
    3. JobSatisfaction 職務満足度 -0.3
    4. EnvironmentSatisfaction 環境満足度　-0.2
    5. TrainingTimesLastYear 直近の教育機会　-0.1(やや影響あり)
    6. WorkLifeBalance ワークライフバランス　-0.1(やや影響あり)
3. ほとんど影響が見られない説明変数
    1. DistanceFromHome	通勤距離　０
    2. Education 教育分野　0
    3. MonthlyIncome 月収　-0
    4. RelationshipSatisfaction 対人関係満足度　-0


### 多重共線性でドロップした説明変数を忘れないこと

多重回帰もそうですが、ロジスティック回帰分析では説明変数間は独立（相関が無い）ことが求められています。そのため、以下の説明変数は
モデル作成時にドロップさせました。　

1. Age
2. JobLevel
3. PercentSalaryHike
4. TotalWorkingYears
5. YearsAtCompany
6. YearsInCurrentRole
7. YearsSinceLastPromotion
8. YearsWithCurrManager

3のPercentSalaryHike（賃金上昇率）がPeformanceRating（業績評価）と相関でドロップしましたが、それ以外はMonthlyIncome（月収）との相関関係があったので、ドロップしました。年功序列の傾向の強いデータですが、MonthlyIncomeの係数は`-0`となり、回帰分析の結果からはほとんど退職には影響していないということです。

なんとなく疑問が生じる部分かと思います。そういうときは、ドロップした説明変数と入れ替えるなりして、影響を見極める必要があります。


参照　[sklearn.linear_model.LogisticRegression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html#sklearn-linear-model-logisticregression
){:target="_blank"}


---

### ひとこと

> 多重共線性を考慮するため、いくつかの説明変数をドロップして回帰分析をしました。折角集めた説明変数が使われないことになり、ここは異論があるところだと思います。また、ここでは触れていませんが、相関係数 coefficient はその信頼性を担保するため、計算結果の確率、いわゆるp値が5%から1%以下が求められ、15%以上の確率で計算されるとなると、偶然性が排除されないので、ここでも折角収集した説明変数を使えなくなってしまいます。ここにそもそもデータ解析をする目的は、モデルの性能評価だけではなく、予測値からどうアクションして目標に達成するかというビジネス的な議論の方向性が見えてきます。　次回以降、この点も含めてブログで綴りたいと思います。
