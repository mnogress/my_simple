---
layout: post
title: RFCのGrid Search CVについて
feature-img: "assets/img/2019_07_01/grid-811032_1920.jpg"   
tags: [random forest classifier, Grid Search]
excerpt_separator: <!--more-->
---

トレーニングデータセットをバリデーション用に細分化してそれぞれでaccuracyのバラツキを見るクロスバリデーション(CV: cross-validation)の方法を応用して、トレーニングデータセットを細分化します。パラメータセットで定取りうるパラメータを定義し、すべての組み合わせ計算し、その中で最もいいパラメータセットを決定します。このような総当りで計算して最適なパラメータセットを決定する方法をGridSerachCVといいます。
<!--more-->

[RFCのCross-validationについて]({{"2019/10/30/rfc_cross_validation.html" | relative_url}}){:target="_blank"}のRFC(ランダムフォーレスト分類器)の問題でクロスバリデーションを紹介しましたが、クロスバリデーションをモデルのパラメータ最適化に応用します。

今回使うデータも、RFCのクロスバリデーション、ロジスティック回帰分析のブログで利用したKaggle からダウンロードした[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} です。

---

### チートシート

やりたいこと | 方法
---------- | -------------
クロスバリデーションでスコアの<br>平均、標準偏差(scores)を確認する | 1. from sklearn.model_selection import GridSearchCV <br>2. rf = RFC()<br>3. cv = GridSearchCV(rf, parameters, cv=5)<br>cv.fit(X_train, y_train.values.ravel(),)

---


### 今回使うデータのポイント

1. 退職状況(attrition)に関する人事データ[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/regression_basic_1.html" | relative_url}}){:target="_blank"} で選択した12個の説明変数でRandom Forest Classifer（RFC)で機械学習するところまでは同じです。
2. テストデータを更に5等分(cv=5 といた場合）して、バリデーション用データとトレーニング用を1:4の組み合わせを５通り作ります
3. 5通り各々の組み合わせでaccuracy スコアを計算して、トレーニングデータでの学習における的中率の平均と標準偏差を計算します
4. ベストの組み合わせとなるパラメータをトレーニング結果とします

![cross_validation]({{ "assets/img/2019_07_01/grid_search_workflow_2.png" | relative_url}})<br>

出典：　[GridSerachCV_User_Guide](https://scikit-learn.org/stable/modules/grid_search.html#grid-search){:target="_blank"}


### サンプルオペレーション

1. 計算結果をプリントする関数`print_results`を定義し計算結果をJupyter Notebook上にプリントさせます。
2. RFCで使うパラメータセットを定義します。今回は`n_estimators;: [5, 50, 100]`{:style="color: blue"} と`max_depth: [2, 10, 20, None]`{:style="color: blue"} を総当りの組み合わせで性能比較をします。


{% highlight python linenos %}
# print_results という関数を定義します
def print_results(results):
# best_params_ にGridSerachCVのベストスコアとするパラメータです
    print('BEST PARAMS: {}\n'.format(results.best_params_))
# 平均と標準偏差をresults.cv_results_から取り出して、それぞれmean とstdsに代入します
    means = results.cv_results_['mean_test_score']
    stds = results.cv_results_['std_test_score']
# それぞれをプリントします。
    for mean, std, params in zip(means, stds, results.cv_results_['params']):
        print('{} (+/-{}) for {}'.format(round(mean, 3), round(std * 2, 3), params))
{% endhighlight %}

パラメータセットを定義します。すべての組み合わせを計算して、そのscore の平均、標準偏差を

{% highlight python linenos %}
# RFC (Random Forest Classifier)をrfとします
rf = RFC()
# 総当りで計算するパラメータセットを定義します
parameters = {
    'n_estimators': [5, 50, 100],
    'max_depth': [2, 10, 20, None]
}
# GridSearchCV
cv = GridSearchCV(rf, parameters, cv=5)
cv.fit(X_train, y_train.values.ravel(),)

print_results(cv)
{% endhighlight %}

以下のとおり、`max_depth:20,　n_estimators: 50`{:style="color: blue"} の組み合わせが平均0.854, 標準偏差0.015 で最も成績がいいという結果になりました。

{% highlight python %}
BEST PARAMS: {'max_depth': 20, 'n_estimators': 50}

0.844 (+/-0.009) for {'max_depth': 2, 'n_estimators': 5}
0.842 (+/-0.005) for {'max_depth': 2, 'n_estimators': 50}
0.844 (+/-0.0) for {'max_depth': 2, 'n_estimators': 100}
0.824 (+/-0.038) for {'max_depth': 10, 'n_estimators': 5}
0.848 (+/-0.029) for {'max_depth': 10, 'n_estimators': 50}
0.849 (+/-0.005) for {'max_depth': 10, 'n_estimators': 100}
0.833 (+/-0.04) for {'max_depth': 20, 'n_estimators': 5}
0.854 (+/-0.015) for {'max_depth': 20, 'n_estimators': 50}
0.853 (+/-0.016) for {'max_depth': 20, 'n_estimators': 100}
0.826 (+/-0.024) for {'max_depth': None, 'n_estimators': 5}
0.844 (+/-0.015) for {'max_depth': None, 'n_estimators': 50}
0.852 (+/-0.016) for {'max_depth': None, 'n_estimators': 100}
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

参照　[GridSerachCV_User_Guide](https://scikit-learn.org/stable/modules/grid_search.html#grid-search){:target="_blank"}<br>
参照　[Cross-validation:_evaluating_estimator_performance](https://scikit-learn.org/stable/modules/cross_validation.html#cross-validation-evaluating-estimator-performance
){:target="_blank"}<br>
参照　[Parameter estimation using grid search with cross-validation](https://scikit-learn.org/stable/auto_examples/model_selection/plot_grid_search_digits.html#parameter-estimation-using-grid-search-with-cross-validation)
{:target="_blank"}

---

### ひとこと

> トレーニングデータでモデルのパラメータ最適化して、検証データで性能評価をする機械学習では、トレーニングデータによってどうしてもその性能にバラツキが出てしまいます。トレーニングを繰り返し、技術に磨きをかけて、よりいい記録をだすアスリートと同様に、クロスバリデーションとパラメータ最適化で性能を高めるのが、GridSerachCVの考え方です。
