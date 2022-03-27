---
layout: post
title: 多重回答の結果をPandas で集計する
feature-img: "assets/img/2020_08_15/abstract-1867656_1280.jpg"
tags: [Pandas, Google Forms, Python]
excerpt_separator: <!--more-->
---

フォーム入力の方法の一つのチェックボックス入力形式は、通常、ユーザが複数の回答を選択できるように用意されています。　その結果は多重回答といいます。多重解答の集計は、ラジオボタンで択一選択する場合と異なり、ちょっとしたコツが必要です。今回は、Google フォームに入力された多重回答をサンプルにして集計方法についてブログにまとめてみました。

<!--more-->

### チェックボックス（Google フォーム）

ユーザが複数回答を選択して回答できるアンケートフォームとは以下のようなフォームの事です。　今回は、Google フォームを例に取り説明します。

![google_form1]({{ "assets/img/2020_08_15/google_pic1.png" | relative_url}})<br>

### セミコロンで区切られた多重回答

Google フォームでは複数の回答は選択された各々の設問のまま、セミコロンで区切られた多重回答としてまとめられ、全体のアンケートは、csv形式でダウンロードが可能です。

サンプルとして問6でユーザの保有する資格について尋ねたアンケートで135人の回答について、csv 経由でPandas データフレームで取り込んだ結果を示します。
ちなみに、[df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}で紹介した方法でデータフレームの見栄えを良くしてます。

![google_form2]({{ "assets/img/2020_08_15/google_pic2.png" | relative_url}})<br>

多重回答の組み合わせ毎に別々の回答してカウントするため、`value_counts()` では正しくカウントできません。　以下のようになってしまいます。この結果も
[df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}で紹介した方法でデータフレームの見栄えを良くしてます。

![google_form2]({{ "assets/img/2020_08_15/google_pic3.png" | relative_url}})<br>

### Pandas で集計する

正しく集計するためには、以下のCode のように、セミコロンで多重回答をリスト化して再集計する必要があります。

{% highlight python linenos %}

# 回答人数をans_tot という変数に代入する
ans_tot = len(df)
# 質問を　変数 q に代入する
q = '問6 あなたが保有する資格（複数チェック可）'

# 新しい列['new_col']に区切り文字';' で各行の回答を分割したlist形式で格納する
df['new_col'] = df[q].str.split(';')
# NaNの行があればそれを削除する
df = df[df['new_col'].isnull() == False]
# 変数ans で列['new_col']の内容を一つのリストに格納する
ans = sum(df['new_col'], [])
# list > array > data frame に形式を変換し名前をans_list とする
ans_array = np.array(ans)
ans_df = pd.DataFrame(ans_array)
ans_list = ans_df.value_counts()
ans_list = pd.DataFrame(ans_list, columns=['回答数'])
ans_list = ans_list.rename_axis(q)
ans_list = ans_list.reset_index()
# 回答数が一種類のみ＝その他の自由記述回答したチェックリスト以外の回答とする　値としてNaNを入れる
ans_list['col']= ans_list['回答数'].apply(lambda x: x if x != 1 else np.nan)
# 変数 sum_nan に回答数が一種類のみの総数を代入する
sum_nan = ans_list['col'].isnull().sum()
# その他の回答としてまとめる
ans_list = ans_list[ans_list['col'].isnull() == False] 
ans_list = ans_list.drop(columns=['col'])
colname = ans_list.columns
# newlist とというdata frame にして
newlist = [('その他', sum_nan)]
newlist = pd.DataFrame(newlist, columns = colname)
# and_list の最後に その他としてappend する
ans_list = ans_list.append(newlist, ignore_index = True)
# 列名が質問の内容、各々の回答が要素の列をインデックス(label indexにする
ans_list = ans_list.set_index(q)
ans_list['%'] = (ans_list['回答数'] / ans_tot )
# ans_list_q6 というデータフレーム名にする
ans_list_q6 = ans_list
# % 列を小数点表示から%表示に変更する
ans_list_q6.style.format(format_dict)
{% endhighlight %}

結果は以下のようになりました。　ここまで集約ができれば、あとは円グラフも簡単にできますね。

![google_form1]({{ "assets/img/2020_08_15/google_pic4.png" | relative_url}})<br>



### 参照ページ一覧
このブログと一緒にこのサイト内の以下のページも併せてご覧ください。
>
1) [df.value_counts() の結果をパワポ用にビジュアル化する](https://www.so-wi.com/2022/03/11/df_value_counts_visualization.html){:target="_blank"}<br>
2) [value_counts()の結果を plt.subplots()で円グラフ化する](https://www.so-wi.com/2019/09/06/pie_chart_to_draw.html){:target="_blank"}<br>
3) [日本語対応した matplotlib 2軸グラフ](https://www.so-wi.com/2021/02/02/japanize_matplotlib_two_axis.html){:target="_blank"}<br>
4) [クロス集計表とヒートマップでデータセットを理解する](https://www.so-wi.com/2020/12/22/cross_tab_heat_map.html){:target="_blank"}<br>
{:style="border-color: #5f564d; border-top-color: #5f564d; font-size: 1.0em; background-color: #f5f5dc;"}



