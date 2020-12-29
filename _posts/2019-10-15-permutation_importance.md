---
layout: post
title: RFCのPermutation Feature Importanceについて
feature-img: "assets/img/2019_07_01/wood_floor.png"   
tags: [random forest classifier, interpretability]
excerpt_separator: <!--more-->
---

モデルの評価基準は、予測精度(accuracy)に偏りがちですが、モデルによって事象の発生を解釈(interpret)し、事象をコントロールする可能性(interpretability)があります。ランダムフォーレストなど決定木系のアルゴリズムでは係数(feature imporatances)に変数の選択肢の数(cardinality)でバイアスされ解釈には使えないと言われています。
<!--more-->
[scikit-learn-0-22のpermutation_feature_importance](https://scikit-learn.org/stable/modules/permutation_importance.html
){:target="_blank"} でどの説明変数が重要かということを計算してくれるようになりました。実際に使って見たいと思います。アルゴリズムはrandom forest classifierです。

Permutation_Feature_Importanceは説明変数の一つをランダムにシャッフルし、予測結果をオリジナルのそれと比較します。　シャッフルした説明変数が重要だとすると、シャッフルしない場合と比較して予測精度が落ちるハズだという仮説に基づくアルゴリズムです。　また、説明変数のシャッフルも一度ではなく、複数回行いその平均と標準偏差がPermutation_Feature_Importanceの結果になります。

Kaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} で検討しました。

>
利用したデータセットは
[kaggle_hr_data](https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset){:target="_blank"}からダウンロードできます。
[サンプルデータセットについて]({{ "2019/06/01/reference_data.html" | relative_url}}){:target="_blank"}の記事でデータセットの概要を紹介しています。併せて参考にしてください。
{:style="background-color: #ffe3e2; border-left: #ffe3e2; font-size: 0.9em"}

---

### チートシート

やりたいこと | 方法
---------- | -------------
permutation_importanceを得る | permutation_importance(rc, X_train, y_train_array, <br>n_repeats=10,random_state=0)
変数の選択肢の数(cardinality)を取得する　| df.apply(pd.Series.nunique)

`permutation_importance :順列重要度`{:style="background-color: #ffe3e2; font-size: 0.7em"}


---


### 今回使うデータのポイント

１） 退職状況(attrition)に関する人事データ[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/regression_basic_1.html" | relative_url}}){:target="_blank"} で選択した12個の説明変数でRandom Forest Classifer（RFC)で機械学習しFeature Imporances とCardinalityが一致する関係を調べます。<br>
２） [permutation_importance](https://scikit-learn.org/stable/modules/permutation_importance.html
){:target="_blank"}を計算して、1で調べたFeature Imporances とCardinalityと比較する<br>

----

### サンプルオペレーション

１）　12の説明変数それぞれのcardinarily を算出します。　チートシートにあるように`df.apply(pd.Series.nunique)`{:style="background: #cbe8f5"} でとれます。それをデータフレーム化しておきます。<br>

２）RFCで機械学習し、説明変数のCardinalityの大きさ順にFeature Importances になることを確認します。　RFC で定番のCross Validation Predict といったモデルの性能の最大化は今回はしません。<br>

３）Permutation_Importancesの計算をしてその結果と比較します。　

### Feature_ImporatancesとCardinalityの一致を確認します

{% highlight python linenos %}
# cardinality の計算をし、データフレーム化します
df_cardinal = df_test.apply(pd.Series.nunique)
df_cardinal = pd.DataFrame(df_cardinal)
df_cardinal = df_cardinal.rename(columns={0 : 'cardinality'})
df_cardinal
{% endhighlight %}

![df.shape]({{ "assets/img/2019_07_01/df_cardinal_view.png" | relative_url}})

{% highlight python linenos %}
# 「ロジスティック回帰分_その１」と同じ説明変数をRFCでfitする
# rc = RFC(solver='liblinear')
# rc.fit(X_train, y_train)
from sklearn.ensemble import RandomForestClassifier as RFC
from sklearn.inspection import permutation_importance
from sklearn import metrics
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import precision_score, recall_score
X_train, X_test, y_train, y_test = train_test_split(df_test,
                                                   target_df['attrition_yes'], test_size=0.4,
                                                   random_state=200)
rc = RFC(n_estimators=200, random_state=0)
y_train_array = np.ravel(y_train)
rc.fit(X_train, y_train_array)
{% endhighlight %}

RFC のパラメータがアウトプットされます。

{% highlight python %}
RandomForestClassifier(bootstrap=True, ccp_alpha=0.0, class_weight=None,
                       criterion='gini', max_depth=None, max_features='auto',
                       max_leaf_nodes=None, max_samples=None,
                       min_impurity_decrease=0.0, min_impurity_split=None,
                       min_samples_leaf=1, min_samples_split=2,
                       min_weight_fraction_leaf=0.0, n_estimators=200,
                       n_jobs=None, oob_score=False, random_state=0, verbose=0,
                       warm_start=False)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

基本的なRFCの性能評価をします。classification_reportを出力させます

{% highlight python linenos %}
y_pred = rc.predict(X_test)
print(metrics.classification_report(y_test, y_pred))
{% endhighlight %}


{% highlight python %}
             precision    recall  f1-score   support
           0       0.84      0.98      0.90       242
           1       0.56      0.10      0.16        52
    accuracy                           0.83       294
   macro avg       0.70      0.54      0.53       294
weighted avg       0.79      0.83      0.77       294
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

Feature Imporances とCardinalityを併せたデータフレームを作成します。

{% highlight python linenos %}
feature_names = X_train.columns
df_features = pd.DataFrame(feature_names)
df_features = pd.concat([df_features, df_importances], axis=1)
df_features.columns = ['features', 'feature_importance']
df_features.set_index('features', inplace = True)
df_features2 = df_features.sort_values(by='feature_importance',ascending=False )
df_features_cardinal = pd.concat([df_features2, df_cardinal], axis =1)
df_features_cardinal
{% endhighlight %}

結果は、以下のとおりです。確かに、Cardinalityの大きい順にFeature Imporancesが並んでいますね。これでは、Feature ImporatancesはInterpretability
が得られないことは自明です。

![df.shape]({{ "assets/img/2019_07_01/df_features_caridinality.png" | relative_url}})

### Permutation_Feature_ImportancesとCardinalityの関係を確認します

Permutation_Feature_ImportanceとCardinalityの関係を確認します。Permutation_Feature_Importanceの平均値を代表値とします。

{% highlight python linenos %}
result = permutation_importance(rc, X_train, y_train_array, n_repeats=10,
                                random_state=0)
result = result.importances_mean
df_resut = pd.DataFrame(result)
df_permutation = pd.DataFrame(feature_names)
df_permutation = pd.concat([df_permutation, df_result], axis=1)
df_permutation.columns = ['features_name', 'permutation_importance']
df_permutation.set_index('features_name', inplace=True)
df_permutation_sort = df_permutation.sort_values(by='permutation_importance' ,ascending=False )
df_permutation_sort = pd.concat([df_permutation_sort, df_cardinal], axis =1 )
df_permutation_sort
{% endhighlight %}

結果は、以下のとおりです。確かに、Cardinalityの大きい順ではなくなりました。では、これでモデルを解釈できるでしょうか。　[ロジスティック回帰分析_相関係数]({{ "2019/09/30/logistic_regression_coef_study.html" | relative_url}}){:target="_blank"}で求めた説明変数の順列とも異なる結果となりました。

![df.shape]({{ "assets/img/2019_07_01/permutation_imp.png" | relative_url}})

ロジスティック回帰分析とランダムフォーレストではアルゴリズムが違いますので、アルゴリズムの差が結果にも影響しています。　また、サンプルのデータ自体もバイアスが無いとは言い切れません。どちらが正しいという優劣をつける議論ではないと思います。


### 相関係数と順列重要度の比較

ロジスティック回帰分析や重回帰分析で得られる相関係数とランダムフォーレストで得られる順列重要度の特徴について以下の表にまとめました。

　|相関係数 　| 順列重要度
説明変数　| 説明変数間に相関がある場合は、<br>多重共線性よりどちらか一方をドロップする必要がある　|　すべての変数間の重要度が比較可能 
統計処理| 各係数のp値を持つため、<br> ｐ値>0.1の係数はドロップする必要がある　| 各重要度が統計的に算出されるため、<br>平均値をその説明変数の重要度とするなど「決め」が必要　
変数間のばらつき|正負の相関が算出されるため、<br>各変数が効く向き(極性)がわかりやすい 　| 　モデルへの寄与度であり、極性はわからない



参照　[sklearn.linear_model.LogisticRegression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html#sklearn-linear-model-logisticregression
){:target="_blank"}


参照　[sklearn.ensemble.RandomForestClassifier](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html?highlight=random%20forest#sklearn-ensemble-randomforestclassifier){:target="_blank"}

---

### ひとこと

> ランダムフォーレストはアンサンブル学習の代表的なアルゴリズムです。予測精度も高く、機械学習のアルゴリズムとしてよく使われる事が多いと思います。しかし、中で多数決で予測結果を求めるなどしているため、どのようにして予測結果が導かれたかよくわかりません。伝統的な統計手法を使った回帰分析では各説明変数の影響が「正負の極性」でわかるなど、未だに使われることが多いと思います。ちなみに、Pythonで統計情報を得ようとすると、scikit-learn ではなくstatsmodelsをインポートする必要があります。統計情報が当たり前のRから始めた私にはちょと違和感のあるscikit-learnです。
