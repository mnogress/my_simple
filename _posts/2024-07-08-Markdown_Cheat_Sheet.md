---
layout: single
title: Markdown Cheat Sheet
header:
  overlay_image: images/header_U.png
  overlay_filter: rgba(58, 129, 242, 0.20)
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
tag: ["HTML", "Markdown", "css"]
date: 2024-07-27
last_modified_at : 2024-07-27 15:23:00
---

HTML/Markdown のStyle sheet reference になります。 <!--more--> 前提は[*Karmdown*](https://kramdown.gettalong.org/){:target="_blank"}で、
[*Jekyll Minimal Mistakes*](https://github.com/mmistakes/minimal-mistakes){:target="_blank"} がテーマです。

### 文字に色をつける


{% highlight python linenos %}

これは、<span style="color:green"> *green*</span> 色。<br>
これは、<span style="color:#FF44AB"> **カスタム** </span>色(16進コード)。

{% endhighlight %}

これは、<span style="color:green"> *green*</span> 色。<br>
これは、<span style="color:#FF33AB"> **カスタム** </span>色(16進コード)。


---

### 強制的に文字を左右中央に配置する

{% highlight python linenos %}

中央
{: style="text-align: center; color: blue; font-weight: bold;"} 
Right[^1]
{: style="text-align: right; color: red; font-style: italic;"} 
左寄せ
{: style="text-align: left; color: green; font-size:1.10em;"} 

[^1]: イタリックは主に英語で使用する

{% endhighlight %}

中央
{: style="text-align: center; color: blue; font-weight: bold;"} 
Right[^1]
{: style="text-align: right; color: red; font-style: italic;"} 
左寄せ
{: style="text-align: left; color: green; font-size:1.10em;"} 

[^1]: イタリックは主に英語で使用する

---

### Notice Box

{% highlight python linenos %}

**Notice:** 重要なNoticeです。
{: .notice--danger}
{% endhighlight %}

**Notice:** 重要なNoticeです。
{: .notice--danger}

---

### Color Variation

**Notice:** {: .notice}
{: .notice}

**Primay Notice:** {: .notice--primary}
{: .notice--primary}

**Info Notice:** {: .notice--info}
{: .notice--info}

**Warning Notice:** {: .notice--warning}
{: .notice--warning}

**Danger Notice:** {: .notice--danger}
{: .notice--danger}

**Success Notice:** {: .notice--success}
{: .notice--success}

---


### Capture Notice 1 (Liquid Version)

{% highlight python linenos %}
{% raw %}
{% capture notice-1 %}{% endraw %}
**Notice Box**:
* capture と　endcapture で囲む
* リスト表示できます
* Code Blockも可能
```python
import numpy as np
import pandas as pd
import seaborn as sns
```
{% raw %}{% endcapture %}{% endraw %}
{% raw %}<div class="notice--info"><span style="font-size:1.15em;">{{ notice-1 | markdownify }}</span></div>
{% endraw %}

{% endhighlight %}


### Result1


{% capture notice-1 %}
**Notice Box**:
* capture と　endcapture で囲む
* リスト表示できます
* Code Blockも可能

```python
import numpy as np
import pandas as pd
import seaborn as sns
```
{% endcapture %}
<div class="notice--info"><span style="font-size:1.15em;">{{ notice-1 | markdownify }}</span></div>

---
### Capture Notice 2

{% highlight python linenos %}
{% raw %}
{% capture notice-1 %}{% endraw %}
**Notice Box**:
1. リスト表示できます
2. Tableも可能

| 左寄せ | 真ん中 | 右寄せ |
| :----- | :----: | -----: |
| 1-1    |  1-2   |    1-3 |
| 2-1    |  2-2   |    2-3 |
|====                                     
| footer | ft_1-2 | ft_1-3 |
{% raw %}{% endcapture %}{% endraw %}
{% raw %}<div class="notice--warning"><span style="font-size:1.25em;">{{ notice-1 | markdownify }}</span></div>
{% endraw %}

{% endhighlight %}


### Result2

{% capture notice-4 %}
**Notice Box**:
1. リスト表示できます
2. Tableも可能

| 左寄せ | 真ん中 | 右寄せ |
| :----- | :----: | -----: |
| 1-1    |  1-2   |    1-3 |
| 2-1    |  2-2   |    2-3 |
|====                                     
| footer | ft_1-2 | ft_1-3 |
{% endcapture %}
<div class="notice--warning"><span style="font-size:1.25em;">{{ notice-4 | markdownify }}</span></div>

---
### Capture Notice 3

{% highlight python linenos %}
{% raw %}
{% capture notice-1 %}{% endraw %}
**Notice Box**:
* capture と　endcapture で囲む
* リスト表示できます
* Quoteも可能
>
import numpy as np<br>
import pandas as pd<br>
import seaborn as sns<br>
>{:style="font-size:1.25em;"}
{% raw %}{% endcapture %}{% endraw %}
{% raw %}<div class="notice--success"><span style="font-size:1.15em;">{{ notice-1 | markdownify }}</span></div>
{% endraw %}

{% endhighlight %}


### Result3

{% capture notice-5 %}
**Notice Box**:
* capture と　endcapture で囲む
* リスト表示できます
* Quoteも可能
>
import numpy as np<br>
import pandas as pd<br>
import seaborn as sns<br>
>{:style="font-size:1.25em;"}
{% endcapture %}
<div class="notice--success"><span style="font-size:1.15em;">{{ notice-5 | markdownify }}</span></div>

---

### Capture Notice 4 (HTML Version)

{% highlight python linenos %}
<div class="notice--danger" markdown="1">
<span style="font-size:1.25em;">**Notice-Danger w/ コードブロック**</span>
<ol>
<li><span style="font-size:1.25em;">テキスト文１...</span></li>
<li><span style="font-size:1.25em;">テキスト文２....</span></li>
</ol>
```html
<html>
  <body>テキストBody<body>
</html>
```
</div>
{% endhighlight %}

---

### Result4

<div class="notice--danger" markdown="1">
<span style="font-size:1.25em;">**Notice-Danger w/ コードブロック**</span>
<ol>
<li><span style="font-size:1.25em;">テキスト文１...</span></li>
<li><span style="font-size:1.25em;">テキスト文２....</span></li>
</ol>
```html
<html>
  <body>テキストBody<body>
</html>
```
</div>

---

### 文字装飾_リンク付け


{% highlight python linenos %}

**Custom styled  [_link_](#文字装飾_リンク付け)付きテキスト**
{: style="テキスト-align: center; font-size:1.4em; color: #f78c6c;"}

これは、*red*{: style="color: red; font-weight: bold;"}.

{% endhighlight %}


### 結果

**Custom styled  [_link_](#文字装飾_リンク付け)付きテキスト**
{: style="テキスト-align: center; font-size:1.75em; color: #f78c6c;"}

これは、*red*{: style="color: red; font-weight: bold;"}.