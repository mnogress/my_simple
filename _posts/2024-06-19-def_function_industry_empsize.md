---
layout: single
title: 産業大分類番号と分類名変換
header:
  overlay_image: images/header_K.png
  overlay_filter: rgba(107, 74, 43, 0.22)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  #- wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
---

振り分け関数とPandasへの適用サンプル<!--more-->

#### 産業中分類番号から産業大分類番号に振り分ける関数

{% highlight python linenos  %}

def func_ind_furiwake(x):
    if  x <= 2:
        return 1
    elif x >= 3 and x <=4 :
        return 2
    elif x >= 5 and x <=5 :
        return 3
    elif x >= 6 and x <=8 :
        return 4
    elif x >= 6 and x <=8 :
        return 4
    elif x >= 9 and x <=32 :
        return 5
    elif x >= 33 and x <=36 :
        return 6
    elif x >= 37 and x <=41 :
        return 7
    elif x >= 42 and x <=49 :
        return 8
    elif x >= 50 and x <=61 :
        return 9
    elif x >= 62 and x <=67 :
        return 10
    elif x >= 68 and x <=70 :
        return 11
    elif x >= 71 and x <=74 :
        return 12
    elif x >= 75 and x <=77 :
        return 13
    elif x >= 78 and x <=80 :
        return 14
    elif x >= 81 and x <=82 :
        return 15
    elif x >= 83 and x <=85 :
        return 16
    elif x >= 86 and x <=87 :
        return 17
    elif x >= 88 and x <=96 :
        return 18
    elif x >= 97 and x <=98 :
        return 19
    elif x >= 99 and x <=99 :
        return 20

{% endhighlight %}

#### 関数の適用

{% highlight python linenos  %}


df['産業大分類コード']=df['産業中分類コード'].apply(func_ind_furiwake)

{% endhighlight %}

#### 産業大分類番号から産業大分類名を割り当てる関数


{% highlight python linenos  %}

def func_ind_name_furiwake(x):
    if  x == 1 :
        return '農業_林業'
    elif x == 2 :
        return '漁業'
    elif x == 3 :
        return '砿業_採石業_砂利採取業'
    elif x == 4 :
        return '建設業'
    elif x == 5 :
        return '製造業'
    elif x == 6 :
        return '電気・ガス・熱供給・水道業'
    elif x == 7 :
        return '情報通信業'
    elif x == 8 :
        return '運輸業_郵便業'
    elif x == 9 :
        return '卸売業・小売業'
    elif x == 10 :
        return '金融業・保険業'
    elif x == 11 :
        return '不動産業_物品賃貸業'
    elif x == 12 :
        return '学術研究_専門・技術サービス業'
    elif x == 13 :
        return '宿泊業_飲食サービス業'
    elif x == 14 :
        return '生活関連サービス業_娯楽業'
    elif x == 15 :
        return '教育_学習支援業'
    elif x == 16 :
        return '医療_福祉'
    elif x == 17 :
        return '複合サービス事業'
    elif x == 18 :
        return 'サービス業（他に分類されないもの）'
    elif x == 19 :
        return '官公庁'
    elif x == 20 :
        return '分類不能の産業'

{% endhighlight %}

#### 関数の適用

{% highlight python linenos  %}
df['産業大分類名']=df['産業大分類コード'].apply(func_ind_name_furiwake)
{% endhighlight %}
