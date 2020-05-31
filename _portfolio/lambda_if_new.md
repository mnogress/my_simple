---
layout: post
title: 任意の列の計算結果を新しい列に格納 lambda
feature-img: "assets/img/2019_07_01/lambda_if_new_columns.png"
img: "assets/img/2019_07_01/lambda_if_new_columns.png"
date: 2019-05-26
tags: [pandas, lambda]
---

任意の列の値をif条件で判定し、判定結果の正しい(1),正しくない(0)を新しい列に格納したい時にはlambda（無名関数）を使うと簡単に実現できます。

---
### チートシート

やりたいこと　| コーディング
---------- | -------------
Price列をif条件(350Up?)で判定し<br>結果(0/1)を新しい列&#39;350Up&#39;に格納する| df[&#39;350up&#39;] = df[&#39;Price&#39;].apply(lambda x :1 if x >350 else 0)


---

### サンプルオペレーション

{% highlight python linenos %}
# サンプルデータフレームを作成
cars = {'Brand': ['Nissan Leaf','Toyota Prius','Honda Legend','Mazda  MPV'],
        'Price': [400,320,770,350]
        }

df = pd.DataFrame(cars, columns = ['Brand', 'Price'])
df
{% endhighlight %}

以下の簡単なデータフレームに対して、Price が350Upかどうかの条件で判定します

![df.head()]({{ "assets/img/2019_07_01/result_before.png" | relative_url}})

{% highlight python linenos %}
df['350up'] = df['Price'].apply(lambda x :1 if x >350 else 0)
df
{% endhighlight %}

結果は以下のとおり

![df.head()]({{ "assets/img/2019_07_01/result_df.png" | relative_url}})