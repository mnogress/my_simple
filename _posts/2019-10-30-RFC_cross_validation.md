---
layout: post
title: RFCのCross-validationについて
feature-img: "assets/img/2019_07_01/background-1503842_1280.png"   
tags: [random forest classifier, cross validation]
excerpt_separator: <!--more-->
---

トレーニングデータでは完璧のスコアで学習をしたモデルで正解データで検証すると良くないスコアとなることを過学習(overfitting)と言います。通常トレーニングデータセットを更にバリデーション用に細分化してそれぞれでaccuracyのバラツキを見ることをクロスバリデーション(CV: cross-validation)といいます。簡単に計算できます。
<!--more-->

[RFCのPermutation_Feature_Importanceについて]({{"2019/10/15/permutation_importance.html" | relative_url}}){:target="_blank"}のRFC(ランダムフォーレスト分類器)の問題で、クロスバリデーションを行います。

大元のデータは、ロジスティック回帰分析のブログで利用したKaggle より[HRデータ]({{ "https://www.kaggle.com" | relative_url}}){:target="_blank"} です。kaggleよりダウンロードして、確かめてみてください。

---

### チートシート

やりたいこと | 方法
---------- | -------------
クロスバリデーションでスコアの<br>平均、標準偏差(scores)を確認する | 1. from sklearn.ensemble import RandomForestClassifier as RFC<br>2. rf = RFC()<br>3. scores = cross_val_score(rf, x, y, cv=5)

---


### 今回使うデータのポイント


１） 退職状況(attrition)に関する人事データ[「ロジスティック回帰分析＿その1」]({{ "2019/09/15/logistic_regression_basic_1.html" | relative_url}}){:target="_blank"} で選択した12個の説明変数でRandom Forest Classifer（RFC)で機械学習するところまでは同じです。<br>
２） テストデータを更に5等分して、バリデーション用データとトレーニング用を1:4の組み合わせを５通り作ります<br>
３） 5通り各々の組み合わせでaccuracy スコアを計算して、トレーニングデータでの学習における的中率の平均と標準偏差をみます

![cross_validation]({{ "assets/img/2019_07_01/cross_validation.png" | relative_url}})<br>


### サンプルオペレーション

１） データセットをトレーニング用(X_train, y_train)と検証用(X_test, y_test)にまず分けます。<br>
２） トレーニング用データセットを更に５等分(cv=5)にしてクロスバリデーションし、それぞれのaccuracy scoreを出します


{% highlight python linenos %}
from sklearn.ensemble import RandomForestClassifier as RFC
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(df_test,
                                                   target_df['attrition_yes'], test_size=0.5,
                                                   random_state=200)
scores = cross_val_score(rf, X_train, y_train.values.ravel(), cv=5)
scores
{% endhighlight %}

accuracy score が５つ出てきます

{% highlight python %}
array([0.85034014, 0.81632653, 0.83673469, 0.83673469, 0.85034014])
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

平均を標準偏差をプリントします。 各々のクロスバリデーションのスコアが戻り値です。`scores`{:style="background: #ffebf6"}に配列の形式で格納されていますので、平均と標準偏差を計算してプリントします。

{% highlight python linenos %}
print('Accuracy : %0.2f (+/- %0.2f)' % (scores.mean(), scores.std() *2))
{% endhighlight %}

{% highlight python %}
Accuracy : 0.84 (+/- 0.02)
{% endhighlight %}{:style="background-color: #faf5d2; font-size: 0.82em"}

### クロスバリデーションはトレーニングデータに適用する

クロスバリデーションの目的は、トレーニングデータでの学習でどの程度のモデルの性能にバラツキがあるかを知るために行います。今回の場合、下が81.6%,
上が85.0%でした。平均は84%です。　的中率が85%としたトレーニング結果のモデルで、正解データで検証すると的中率が81%の場合もありうるということです。トレーニングデータによって、学習したモデルの的中率もこの程度のバラツキが生じうることがわかります。

### パラメータの最適化はGridSearchで行う

トレーニングデータでのクロスバリデーションで的中率のバラツキの程度を把握できました。　ベストのパラメータはグリッドサーチテクニックと呼ばれるパラメータの総当り(Exhasutive)で決定します。　それは、次回のブログで説明いたします。



参照　[Cross-validation:_evaluating_estimator_performance](https://scikit-learn.org/stable/modules/cross_validation.html#cross-validation-evaluating-estimator-performance
){:target="_blank"}


参照　[Parameter estimation using grid search with cross-validation](https://scikit-learn.org/stable/auto_examples/model_selection/plot_grid_search_digits.html#parameter-estimation-using-grid-search-with-cross-validation)
{:target="_blank"}

---

### ひとこと

> ランダムフォーレストはアンサンブル学習の代表的なアルゴリズムです。クロスバリデーションはトレーニングデータで生成されるモデルのパラメータのバラツキを可視化してくれます。次回説明するグリッドサーチのようにモデルの性能を上げるための様々な方策が提供されています。グリッドサーチにしてもトレーニングデータでモデルを最適化します。　クロスバリデーションによって、同じ最適化でも結果に差が出ることを把握しておくことは、分析結果の議論でとても大切な準備だと思います。
