---
layout: post
title: ロジスティック回帰分析＿その１
feature-img: "assets/img/2019_07_01/marble_floor.png"   
tags: [logistic regression, machine learning]
excerpt_separator: <!--more-->
---

[「Label_Encoderで目的変数を作成する」]({{ "2019/08/23/label_encoder_for_target.html" | relative_url}}){:target="_blank"} で作成した目的変数に対して二項ロジスティック回帰分析で機械学習をします。　テストデータの的中率を向上する手順を紹介します。
<!--more-->
今回は、そのベースとなるモデル作成と最初の計算結果までご紹介します。

使うデータは、Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} のデータセットでオペレーションしました。

---

### チートシート

やりたいこと | コーディング
---------- | -------------
説明変数同士の相関関係をチェックする | import seaborn as sns<br>sns.heatmap(df.corr(), annot=True, cmap=&#39;Blues&#39;)

ロジスティック回帰のモデルにおいて、説明変数同士の相関係数が概ね0.3upあれば、どちらか一方を除外します。　
いわゆる多重共線性を回避する必要があります。

---


### 今回使うデータのポイント

1. 1,470名の社員の退職状況(attrition)に関する人事データ (Kaggleより)
2. df.shape => 1470 x 35 
3. 列を取捨選択し、説明変数用のデータフレームを作成します

[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事で紹介している`HRデータ`です。

![df.shape]({{ "assets/img/2019_07_01/labe_encoder_log_res.png" | relative_url}})



### サンプルオペレーション

相互の相関関係をチェックします。　順序尺度となる変数が19ある今回のデータセットでは、組み合わせは自身を除いても以下のとおり 
19 x 18 / 2 = 171 とおりとなります。 これを確認する方法としてヒートマップを作成し相関関係のある変数を整理します。


{% highlight python linenos %}
# dfに対して相関関係のヒートマップを作成する
import seaborn as sns
%matplotlib inline
rcParams['figure.figsize'] = 18,12
sns.heatmap(df.corr(), annot=True, cmap='Blues')
{% endhighlight %}

![heatmap]({{ "assets/img/2019_07_01/heatmap_hr_df_original.png" | relative_url}})



相互に相関のある列のうちいずれかを除外します。　ルールはありません。しいて言えば、
1. 説明変数として説明力がある　Monthly Income とMaonthly Rateなら前者の方が包含していると考えます
2. 計算結果の的中率が向上する方。
3. 2.に関しては後出しの感はいなめませが、試行錯誤して行います。実際、PeformanceRating とPerformanceSalaryHike　順序尺度してのバラエティは後者でした

{% highlight python linenos %}
#　ヒートマップから相互相関の変数の片方をドロップする
to_drop = [
    'Age',
    'JobLevel',
    'PercentSalaryHike',
    'TotalWorkingYears', 
    'YearsAtCompany', 
    'YearsInCurrentRole', 
    'YearsSinceLastPromotion', 
    'YearsWithCurrManager'  
]
df.drop(to_drop, inplace=True, axis=1)

sns.heatmap(df.corr(), annot=True, cmap='Blues')
{% endhighlight %}

結果は以下のとおりです。

![heatmap]({{ "assets/img/2019_07_01/heatmap_hr_df_after.png" | relative_url}})

---


### 機械学習用のデータセットの作成

更に、社員番号、性別、既婚・非婚等のカテゴリカル・データと目的変数となる'Attrition'を除外して機械学習用のデータセット`df_test`を作成します。

{% highlight python linenos %}
# 機械学習用データセットを作成する
df_test = df[['DistanceFromHome', 
              'Education',
              'EnvironmentSatisfaction', 
              'JobInvolvement',
              'JobSatisfaction',
              'MonthlyIncome',
              'NumCompaniesWorked',  
              'PerformanceRating', 
              'RelationshipSatisfaction', 
              'StockOptionLevel', 
              'TrainingTimesLastYear',
              'WorkLifeBalance' ]]

df.shape
{% endhighlight %}

{% highlight python %}
(1470, 25)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

データセットをトレーニング用とテスト用に8:2で分割します。　目的変数は、`target_df`です。
[Label Encoderで目的変数を作成する]({{ "2019/08/23/label_encoder_for_target.html" | relative_url}}){:target="_blank"}の記事で紹介している`目的変数のデータセット`です。

{% highlight python linenos %}
X_train, X_test, y_train, y_test = train_test_split(df_test,
                                                   target_df['attrition_yes'], test_size=0.2,
                                                   random_state=200)
{% endhighlight %}

### ロジスティック回帰分析をする

全データのうちの80%のトレーニングデータで機械学習を行います。　次に。残りの20%のデータで構成されるテスト用でモデルの性能評価をします。
まず、最初のモデルの機械学習と性能評価を行います。

{% highlight python linenos %}
# モジュールを読み込む
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_predict
from sklearn import metrics
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import precision_score, recall_score

LogReg = LogisticRegression(solver='liblinear')
LogReg.fit(X_train, y_train)
{% endhighlight %}

{% highlight python %}
LogisticRegression(C=1.0, class_weight=None, 
          dual=False, fit_intercept=True,
          intercept_scaling=1, max_iter=100, multi_class='warn',
          n_jobs=None, penalty='l2', random_state=None, solver='liblinear',
          tol=0.0001, verbose=0, warm_start=False)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.70em"}

### 結果レポート

#### クラシフィケーションレポート

{% highlight python linenos %}
# 分配問題としてのクラシフィケーションレポートを出す

`y_pred`がロジスティック回帰分析での予想値です。　`y_test`が正解です。

y_pred = LogReg.predict(X_test)
print(classification_report(y_test, y_pred))
{% endhighlight %}

{% highlight python %}
                precision    recall  f1-score   support
           0       0.87      0.99      0.92       253
           1       0.50      0.07      0.13        41
   micro avg       0.86      0.86      0.86       294
   macro avg       0.68      0.53      0.53       294
weighted avg       0.82      0.86      0.81       294
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.80em"}

HTMLのテーブルに転記しました。 今回は、二項ロジスティックですので、0 と1 のクラスに対する `precision`, `recall`, `f1-score`, `support` を提供しています。

　|  precision  |  recall  | f1-score |  support
---------- | ------------- | ------------- | ------------- | -------------
0     |   0.87    |   0.99     |  0.92      |  253
1    |   0.50    |  0.07     | 0.13        |41
micro avg     |  0.86   |   0.86   |   0.86    |   294
macro avg     |   0.68   |    0.53   |    0.53    |    294
weighted avg    |    0.82    |   0.86  |     0.81   |     294

予測値と正解値の組み合わせは以下のように4通りあります。`precision`, `recall`, `f1-score`はこの組み合わせごとの出現回数で計算されます。

![df.shape]({{ "assets/img/2019_07_01/tp_fp_table.JPG" | relative_url}})　<br>

* precision　：　TP /　(TP + FP) 適合率と訳され、実際の分類値において正解が占める割合
* recall :  TP / (TP + TN) 再現率と言われ、予想した分類値において正解が占める割合
* f1-score : 2 x (precision x recall) / (precision + recall)  precision とrecall で計算され f1 と呼ばれます。　
* support : テストデータ(二項)の結果です

f1 は直感的にはわかりにくいですが、これを論文では性能評価の指標とすること多いです。
加重平均の方法でmicro とmacro があります。micro が次節で述べる「的中率 `acuuracy`」 と同意です。　

予想値に対して、このように多面的にいろいろな指標が用意されていますが、
`直感的にわかりやすい的中率、もしくは論文等でよく使われる f1 を正しく理解して注釈を入れて誤解を生まない程度で使い分けることが肝要`{:style="background: #cbe8f5"} かと思います。

モデルの性能を議論する純粋な数理系のディスカッションでも無い限り、f1 を指標として使う必要はないと個人的には考えます。的中率を使うので事が足りると思います。
理由は以下のとおりです

1. 的中率はわかりやすく、多くの関係者がモデルの性能について正しく、同じ理解を持てる
2. f1 の説明は難しく、正しく理解されず、的中率や正答率と誤解の元となる
3. precision　や、recall はそれぞれ正答率の一部分を示しており、マトリックスでの説明になり、どれがどうかわからなくなる。'


参照：　[Accuracy,_Precision,_Recall_&_F1_Score:_Interpretation_of_Performance_Measures](https://blog.exsilio.com/all/accuracy-precision-recall-f1-score-interpretation-of-performance-measures/){:target="_blank"}



### 性能評価のための的中率

的中率を計算します。これを、性能評価基準としていろいろなケースで検討します。クライアントや部門の上司とディスカッションによるモデルの性能評価とそれから読み取るアクションのディスカッションでは、的中率がわかりやすく議論も活発になります。　 

`y_train`が正解。`y_pred`が予測値で、`accuracy_score`メソッドで得ることができます。また、これは前述のクラシフィケーションレポートのmicro avgの欄でも示されています。

{% highlight python linenos %}
accuracy_score(y_test, y_pred)
{% endhighlight %}

{% highlight python %}
0.8605442176870748
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

まだ始まりの段階の計算結果に過ぎません。

参照　[sklearn.linear_model.LogisticRegression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html#sklearn-linear-model-logisticregression
){:target="_blank"}


---

### ひとこと

> 分類問題の基本である二項ロジスティック回帰分析を行いました。的中率86.05% です。もともと、退職しないに83%と偏っており、全部を退職しないとしても、83%の的中率になりますので、それほどの結果出ないと考えるかたも少なくないと思います。これをボトムとして現存のデータで向上させるところが分析の冥利です。　その解説は次回以降にアップします。
