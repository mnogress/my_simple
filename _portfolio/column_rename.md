---
layout: post
title: 列名の変更　rename メソッド
feature-img: "assets/img/portfolio/submarine.png"
img: "assets/img/portfolio/column_name_chg.png"
date: 2017-09-03
tags: [pandas]
---

データフレームの列名の変更は、結構な頻度で行います。　`merge`{:style="color: blue"}  とかで共通の列名で名寄せをして2つのデータフレームを一つにする場合や新規に追加した列に対して結合先のデータフレームの列名のネーミングルールに変更したい場合などは、　`rename`{:style="color: blue"}  メソッドでピンポイントに変更できます。　

### チートシート

やりたいこと　| コーディング
---------- | -------------
　列名を変更する| df = df.rename(columns = {&#39;旧列名&#39; : &#39;新列名&#39;})


---

### 複数の列を変更する場合

{% highlight python linenos %}
# 列名を変更する
df = df.rename(columns = {
    'KT_A1': 'PY_01',
    'KT_B1': 'PY_02', 
    'KT_C1': 'PY_03', 
    'KT_D1': 'PY_04', 
    'KT_E1': 'PY_05', 
    'KT_F1': 'PY_06', 
    'KT_G1': 'PY_07', 
    'KT_H1': 'PY_08',
    'KT_I1': 'PY_09', 
    'KT_J1': 'PY_10', 
    'KT_K1': 'PY_11', 
    'KT_L1': 'PY_12', 
    'KT_M1': 'PY_13', 
    'KT_N1': 'Py_14'
})
{% endhighlight %}

### おまけ

上記のような規則性のあるネーミングで変換は、jupyter notebook に直接手打ちというよりも、VS Code 等のテキストエディタで用意される方も少なくないと思います。
複数の行を縦に編集のための「縦カーソル(VS Code)」は

>Mac     [`CONTROL`] + [`SHIFT`] <br>
>Windows [`CONTROL`] + [`ALT`]  

キーの位置が微妙に違うため、いつもわからなくなるのでそれも注記しました。

