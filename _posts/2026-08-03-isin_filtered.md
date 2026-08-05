---
layout: single
title: isin() メソッドでビッグデータを操作する
header:
  overlay_image: images/header_X12_1280by336.png
  overlay_filter: rgba(107, 74, 43, 0.40)
toc: True
toc_label: "目次"
toc_icon: "heart" 
toc_sticky: True
excerpt_separator: <!--more-->
classes:
  - landing
  - dark-theme
  - wide
sidebar:
  nav: "docs"
category: Reference
tag: ["Pandas", "Function"]
date: 2026-08-04
last_modified_at : 2026-08-04 10:23:00
excerpt: >

 このセクションでは、大量のデータ（ビッグデータ）を効率的にフィルタリングする手法やベストプラクティスについて解説しています。

---
<!--more-->

主な内容は以下の通りです：

- パフォーマンスの最適化: 膨大なレコードを処理する際、メモリ使用量を抑えつつ高速にフィルタリングを行うための条件設定やアルゴリズムの考え方。
- 効率的なクエリ・条件指定: 不要なスキャンを防ぎ、必要なデータだけを正確に抽出するためのフィルタリング構文やパラメータの指定方法。
- 実用的なコード例: 実際のシステムやデータベース連携において、どのようにフィルタリング処理を実装すべきかのサンプルコードの提示。

### 🧩 ビッグデータをフィルタリング

df_a は数万件以上の行数と100を超える列を持つ大規模なデータフレームであり、その中から特定の name に一致するデータのみを抽出したい場合がある。
このとき、抽出対象となる name の一覧が df_b の name 列に格納されている場合、Pandas の <span class="bleu">isin() メソッド</span>を利用することで効率的に絞り込みを行うことができる。

### 🌱 isin()メソッドとは

isin() は、指定した値の集合に各要素が含まれているかを判定し、真偽値（True / False）を返すメソッドである。

>`df_a['name']` の値が `df_b['name']` に含まれている行のみを残す場合：<br>
>→　`df_a['name'].isin(df_b['name'])` を条件として使用する。

### 🔍 一致するものを残す

{% highlight python linenos  %}

df_a_filtered_isn = df_a[df_a['name'].isin(df_b['name'])]

{% endhighlight %}


この処理により、df_b に登録されている約100件の name と一致する行だけが df_a から抽出される。df_a の行数や列数が多い場合でも、isin() はベクトル化された処理として実行されるため、Python の for ループで1件ずつ比較する方法よりも高速かつ簡潔に実装できる。

### 🔍 逆方向にフィルタリングする（一致しないものを残す）

df_b の name 列に登録されている値を除外条件とし、df_a の name 列が df_b に存在**しない**レコードのみを抽出する。
実装には Pandas の isin() メソッドと**否定演算子** <span class="bleu">「~」</span> を使用する。


{% highlight python linenos  %}

df_a_filtered_notin = df_a[~df_a['name'].isin(df_b['name'])]

{% endhighlight %}

### 📋 元データ　df_a

```
No	name	score
1	A	    80
2	B	    90
3	C	    75
4	D	    88
5	E	    92
```

### 📋 元データ　df_b

```
name
A
D
E
```

### ① isin() による判定


{% highlight python linenos  %}

df_a['name'].isin(df_b['name'])

{% endhighlight %}

>❶　df_a['name'] の各値について、「df_b['name'] に存在するか？」を確認します。<br>
>❷　df_a['name'] df_b に存在するか

```
A	False
B	True
C	False
D	True
E	True
```

結果は以下のような Boolean 型の Series になります。

```
0    False
1     True
2    False
3     True
4     True
dtype: bool
```

### ② True の行だけを抽出


{% highlight python linenos  %}
df_a[
    df_a['name'].isin(df_b['name'])
]
{% endhighlight %}

実際には次のようなイメージです。

```
          条件
行1 A  → False ✕
行2 B  → True  ○
行3 C  → False ✕
行4 D  → True  ○
行5 E  → True  ○
```

### ③ 抽出結果

{% highlight python linenos  %}
df_a_filtered
{% endhighlight %}

```
No	name	score
2	B	    90
4	D	    88
5	E	    92
```

### 🚀 SQL と比較する

{% highlight python linenos  %}
df_a_filtered = df_a[~df_a['name'].isin(df_b['name'])]
{% endhighlight %}

これは SQL の次の条件とほぼ同じ意味です。

{% highlight sql linenos  %}
WHERE name NOT IN (...)
{% endhighlight %}

### 🧠 フィルタされた数だけを知りたい

- len() を使う（シンプル）ですが、shape を使うのが、おすすめです。<br>
- df.shape は (行数, 列数) のタプルを返します。例えば `df.shape`が (100, 5) なら、100行5列です。<br>
- 実務では `df.shape[0]` を使うことが多いです。列数も同時に確認したい場合は、以下のとおりです。<br>

{% highlight python linenos  %}
print(f"行数: {df.shape[0]}")
print(f"列数: {df.shape[1]}")
{% endhighlight %}

`len()` を使いたいのであれば

{% highlight python linenos  %}
print(len(df))       
print(len(df.index)) 
{% endhighlight %}

※このブログの流れであれば、`df`は、`df_a_filtered_isn`もしくは、`df_a_filtered_notin`で読み返してください。
{: .notice--danger}

<style>
</style>