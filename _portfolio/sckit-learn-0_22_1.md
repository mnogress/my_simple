---
layout: post
title: scikit-learn_0.22.1へのアップデート
feature-img: "assets/img/2019_07_01/sckit-learn-22_1.png"
img: "assets/img/2019_07_01/sckit-learn-22_1.png"
date: Feburary, 16 2020
tags: [anaconda, scikit-learn]
---

### ことの始まり

Random Forest Classifer のFeature Importances ではなく、permutation_importance で分析するため、"from sklearn.inspection import permutation_importance" としたところ、scikit-learn のバージョが低く
`ModuleNotFoundError: No module named 'sklearn.inspection'`{:style="background: #e8f00a"}で
怒られました。　それで、[scikit-learn_0.22.1](https://scikit-learn.org/stable/whats_new/v0.22.html#version-0-22-1){:target="_blank"}にanaconda on Mac Catalina の環境でアップデートをしようとして半日以上、ハマリマしたので、メモします。

#### ModuleNotFoundError の際のエラーメッセージ

[Permutation_feature_importance](https://scikit-learn.org/stable/modules/permutation_importance.html
){:target="_blank"}より、permutation_importanceのモジュールを読み込もうとしたところ、以下のようなエラーメッセージを出力されました。

{% highlight python linenos %}
from sklearn.inspection import permutation_importance

ModuleNotFoundError                       Traceback (most recent call last)
<ipython-input-3-9559cd919643> in <module>

---> 21 from sklearn.inspection import permutation_importance

ModuleNotFoundError: No module named 'sklearn.inspection'
{% endhighlight %}

#### scikit-learn 0.23.1 へのアップグレード

1. Anaconda NavigatorのUI上でscikit-learnをアップグレードしようとapply しますが、以前古いバージョンのまま
2. ターミナルよりコマンドを投入することに

#### ERROR conda.core.link:_execute(700): An error occurred while uninstalling package

`conda update conda` をターミナルから投入すると、以下のような残念な結果になりました。ちなみに、MacOSは 10.14.4 Catalina です。
ネットを調べたところ、どうやらpermission error と推定

{% highlight python linenos %}

Proceed ([y]/n)? y

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
ERROR conda.core.link:_execute(700): An error occurred while uninstalling package 'defaults/osx-64::colorama-0.4.1-py37_0'.
Rolling back transaction: done

[Errno 13] Permission denied: '/Users/so-wi/anaconda3/lib/python3.7/site-packages/colorama/__init__.py' -> '/Users/so-wi/anaconda3/lib/python3.7/site-packages/colorama/__init__.py.c~'
{% endhighlight %}


#### sudo conda update conda で解決

よく考えてみれば、簡単な対応でした。　わからないまま、ネットの記事たよりでコマンドを投入するともっとドツボにハマっていたと思います。

`ERROR conda.core.link:_execute(700)`{:style="background: #e8f00a"} の[解決策として参考にした記事](https://superuser.com/questions/1520209/permession-denied-error-while-installing-pyldavis-in-conda-env-errorno-13){:target="_blank"}には以下のような記述がありました。コマンドの投入は自己責任というのを痛感します。

>You should try to run the terminal (cmd) as administrator. If you are using MacOS or Linux, you can try: sudo conda install -c conda-forge pyldavis,but if you work in windows, run cmd as administrator and run the following command:` conda install -c conda-forge pyldavis
{:style="background-color: #f5c6cp; border-left: #f5c6c9; font-size: 0.85em"}

#### コマンド投入のログ

{% highlight python linenos %}
sudo conda update conda
Password:
Collecting package metadata (repodata.json): done
Solving environment: \ 
Warning: 2 possible package resolutions (only showing differing packages):
  - defaults/noarch::path.py-12.0.2-py_0, defaults/osx-64::path-13.2.0-py37_0
  - defaults/noarch::path.py-12.4.0-0, defaults/osx-64::path-13.1.0-py37done

 -## Package Plan ##

  environment location: /Users/so-wi/anaconda3

  added / updated specs:
    - conda
省略
he following packages will be UPDATED:

  _anaconda_depends                          2019.10-py37_0 --> 2020.02-py37_0
  anaconda-project   pkgs/main/osx-64::anaconda-project-0.~ --> pkgs/main/noarch::anaconda-project-0.8.4-py_0
  asn1crypto                                  0.24.0-py37_0 --> 1.3.0-py37_0
  astroid                                      2.2.5-py37_0 --> 2.4.0-py37_0
  astropy                              3.1.2-py37h1de35cc_0 --> 4.0.1.post1-py37h01d97ff_1
  atomicwrites       pkgs/main/osx-64::atomicwrites-1.3.0-~ --> pkgs/main/noarch::atomicwrites-1.4.0-py_0
  attrs               pkgs/main/osx-64::attrs-19.1.0-py37_1 --> pkgs/main/noarch::attrs-19.3.0-py_0
省略
Proceed ([y]/n)? y
Preparing transaction: done
Verifying transaction: done
Executing transaction: done

conda list scikit-learn
-# packages in environment at /Users/so-wi/anaconda3:
-## Name                    Version                   Build  Channel
scikit-learn              0.22.1           py37hebd9d1a_0  


{% endhighlight %}





