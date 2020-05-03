---
layout: post
title: 文字列を日付に変換する
feature-img: "assets/img/portfolio/ttt.png"
img: "assets/img/portfolio/drop_cols_create_new_df.png"
date: 2019-07-13
tags: [pandas, python]
---

文字列を日付に直すあるいはその逆の作業は、結構頻繁にあると感じています。特に、連携先がEXCELだと厄介な作業となります。そんな時、必ずお世話になる `strptime`と`strftime` についてまとめます。

#### 使用例

基本は、YYYY-MM-DD のフォーマットです。これであれば、特に問題はありません。　しかし、EXCELからの入力で、以下のように DD/MM/YYYY とか、MM/DD/YY　で受け取る場合には注意が必要です。　特に、まれに見かけるMM/DD/YYは、1/1/68 を「1月1日1968年」と通常考えるかもしれませんが、以下のコーディングでは 「1月1日2068年」となります。


コーディング | 結果
---------- | -------------
datetime.datetime.strptime('21/12/2008', '%d/%m/%Y').strftime('%Y-%m-%d') | '2008-12-21'
datetime.datetime.strptime('12/21/2008', '%m/%d/%Y').strftime('%Y-%m-%d') | '2008-12-21'
datetime.datetime.strptime('12/21/08', '%m/%d/%y').strftime('%Y-%m-%d')| '2008-12-21'
datetime.datetime.strptime('1/1/68', '%m/%d/%y').strftime('%Y-%m-%d') | ```'2068-01-01'```{:style='background: #ffebf6'}

### ひとこと

> 日付のYYYYのところを二桁というのは、2000年以降ありえない表記ですが、未だに二桁のを見かけます。別記事で紹介したリオオリンピック選手の生年月日も年部分が二桁でした。したがって、1968年以前生まれ(1/1/68)については、1968年ではなく、2068年としてしまうため、別操作が必要となります。　