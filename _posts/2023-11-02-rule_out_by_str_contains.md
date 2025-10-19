---
layout: post
title: str.contain否定演算子"~"による「指定の文字列を含まない行」を抽出する
feature-img: "assets/img/2020_08_15/presents-1913987_1280.jpg"
tags: [Python, pandas, dataframe ]
excerpt_separator: <!--more-->
---

Pandas の`str.contais`を利用して指定の値を含まない行の抽出方法をまとめました。
データフレームの中身をクリーニング等で抽出作業は必須スキルです。
今回は、
`str.contains("除きたい文字列")`{:style="background: #64f5eb; font-size: 105%"} と
否定演算子`~`{:style="background: #f5e964; font-size: 105%"} を使って`~df`{:style="background: #64f5eb; font-size: 105%"} 
として<strong>`指定の文字列を含まない行の抽出方法`</strong>をまとめました。

<!--more-->

----

### 行いたいことを図示します。

以下の事をPandas のデータフレーム上で行いたいと思います。

![what_is_problem]({{ "assets/img/2020_08_15/fig_1107_01.png" | relative_url}})<br>

### str.contains と 否定演算子を使う

`str.contains("除きたい文字列")`{:style="background: #64f5eb; font-size: 105%"} と
否定演算子`~`{:style="background: #f5e964; font-size: 105%"} を使えば、簡単に抽出できます。
また、<strong>print('before/after:', df.shape)</strong>を前後に挟むことで
`データフレームの前後のサイズを把握します。`{:style="color: blue; font-size: 105%"}

{% highlight python linenos %}

print('before:', df.shape)
df = df[~df['メールアドレス'].str.contains('@example.org')]
print('after:', df.shape)

{% endhighlight %}

前後に配置した<strong>`df.shape`</strong> でデータフレームのサイズのBefore/After を記録して抽出サイズ（削除された行数）を把握します。

{% highlight linenos %}
{% raw %}

>> before: (8, 3)
>> after: (6, 3)

{%  endraw %}
{% endhighlight %} 

抽出後のデータフレームは以下のとおりです。

![what_is_output]({{ "assets/img/2020_08_15/fig_1107_02.png" | relative_url}})<br>


### 練習データで指定する「値を含む」場合を示します

このブログで利用した練習用データフレームの作成から抽出までのコードは以下のとおりです。　今回は、「指定値を含む」ケースです。

{% highlight python linenos %}

# 演習用のデータフレームを作成します。
df = pd.DataFrame({ '顧客番号': ['01285679', '01340788', '02123782', '10541976', '12297411', 
                             '13299899', '30144450', '47339981'],
                   '都道府県名': ["北海道","北海道",'青森県','群馬県','千葉県','東京都','和歌山県','沖縄県'],
                  'メールアドレス':   ["nabe@example.net","hiro@example.net","aatsu@example.net",
                               "hi106@example.org","im_to@example.co.jp","ka713@example.org",
                               "sato@example.com","oka_h@example.net"]},
                    index=[0, 1, 2, 3, 4, 5, 6,7])
# オリジナルのデータフレームを表示

df = df[df['メールアドレス'].str.contains('@example.org')]

display(df)


{% endhighlight %}

![what_is_output]({{ "assets/img/2020_08_15/fig_1107_03.png" | relative_url}})<br>

## まとめ

<div class="box28">
    <span class="box-title">Point</span>
    <p style="font-size: 130%; color: blue;">df = df[df['メールアドレス'].str.contains('@example.org')]　<strong>含む</strong>で抽出<br>
    df = df[~df['メールアドレス'].str.contains('@example.org')]　<strong>含まない</strong>で抽出</p>
</div>

<style>
.box28 {
    position: relative;
    margin: 2em 0;
    padding: 25px 10px 7px;
    border: solid 5px #FFC107;
}
.box28 .box-title {
    position: absolute;
    display: inline-block;
    top: -2px;
    left: -2px;
    padding: 0 9px;
    height: 25px;
    line-height: 25px;
    font-size: 17px;
    background: #FFC107;
    color: #ffffff;
    font-weight: bold;
}
.box28 p {
    margin: 0; 
    padding: 0;
}
</style>

---

### 参照ページ一覧
このブログを作成するにあたり、以下のページを参考にしています。併せてご覧ください。
>
1) [カラムデータの特定語句の有無を判定しカテゴリ化する](https://www.so-wi.com/2020/04/02/who_to_call){:target="_blank"}<br>
2) [データフレーム内の列間の値を比較する](https://www.so-wi.com/2023/02/17/function_to_compare_between_rows){:target="_blank"}<br>
3) [データセットを理解するためのスクリプト4選](https://www.so-wi.com/2023/05/31/four_command_script_to_understand_dataset){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}