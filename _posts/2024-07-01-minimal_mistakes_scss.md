---
layout: single
title: Minimal mistakes の文字の大きさ変更のためのscss
header:
  overlay_image: images/header_G.png
  overlay_filter: rgba(70, 209, 36, 0.15)
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
tag: ["scss", "minimal_mistakes"]
---

Minimal mistakes の文字の大きさ変更のためのscss<!--more-->

#### Minimal Mistakes の文字の大きさをコントロールする

>**場所**<br>C:\Users\usr\project_name\\_sass\minimal-mistakes<br>
>            _sass\minimal-mistakes\\_base.scss<br>
>            _sass\minimal-mistakes\\_variables.scss<br> 
>            _sass\minimal-mistakes\_page.scss<br>
>            _sass\minimal-mistakes\_navigation.scss<br>

#### <p> の文字サイズとして、$type-size-5 を指定する

{% highlight css linenos  %}
# _sass\minimal-mistakes\_base.scss
p,
pre,
blockquote,
ul,
ol,
dl,
figure,
table,
fieldset {
  font-size: $type-size-5;  <== Key Parameter!!
  orphans: 3;
  widows: 3;
}

{% endhighlight %}

#### $type-size-5: 0.82em を指定する。起点となるサイズ指定


{% highlight css linenos  %}
# _sass\minimal-mistakes\_variables.scss

/* type scale */
$type-size-1: 2.20em !default; // ~39.056px
$type-size-2: 1.553em !default; // ~31.248px
$type-size-3: 1.01em !default; // ~25.008px
$type-size-4: 0.99em !default; // ~20px
$type-size-5: 0.82em !default; // ~16px   <== Key Parameter!!
$type-size-6: 0.75em !default; // ~12px
$type-size-7: 0.72em !default; // ~11px
$type-size-8: 0.68em !default; // ~10px

/* headline scale */
$h-size-1: 1.3em !default; // ~25.008px
$h-size-2: 1.2em !default; // ~20px
$h-size-3: 1.1em !default; // ~18px
$h-size-4: 1.0em !default; // ~17px
$h-size-5: 0.9em !default; // ~16.5px
$h-size-6: 0.8em !default; // ~16px

{% endhighlight %}

#### page で指定する<p>の相対サイズを'0.8em'に指定する


{% highlight css linenos  %}
# _sass\minimal-mistakes\_page.scss

.page__content {
  h2 {
    padding-bottom: 0.5em;
    border-bottom: 1px solid $border-color;
  }

	h1, h2, h3, h4, h5, h6 {
		.header-link {
			position: relative;
			inset-inline-start: 0.5em;
			opacity: 0;
			font-size: 0.8em;
			-webkit-transition: opacity 0.2s ease-in-out 0.1s;
			-moz-transition: opacity 0.2s ease-in-out 0.1s;
			-o-transition: opacity 0.2s ease-in-out 0.1s;
			transition: opacity 0.2s ease-in-out 0.1s;
		}

		&:hover .header-link {
			opacity: 1;
		}
	}

  p,
  li,
  dl {
    font-size: 0.8em;  <== 1.0em to 0.8em changed!   <== Key Parameter!!
  }

  /* paragraph indents */
  p {
    margin: 0 0 $indent-var;

    /* sibling indentation*/
    @if $paragraph-indent == true {
      & + p {
        text-indent: $indent-var;
        margin-top: -($indent-var);
      }
    }
  }

  a:not(.btn) {
    &:hover {
      text-decoration: underline;

      img {
        box-shadow: 0 0 10px rgba(#000, 0.25);
      }
    }
  }

  :not(pre) > code {
    padding-top: 0.1rem;
    padding-bottom: 0.1rem;
    font-size: 0.8em;
    background: $code-background-color;
    border-radius: $border-radius;

    &::before,
    &::after {
      letter-spacing: -0.2em;
      content: "\00a0"; /* non-breaking space*/
    }
  }

  dt {
    margin-top: 1em;
    font-family: $sans-serif;
    font-weight: bold;
  }

  dd {
    margin-inline-start: 1em;
    font-family: $sans-serif;
    font-size: $type-size-6;
  }

  .small {
    font-size: $type-size-6;
  }

  /* blockquote citations */
  blockquote + .small {
    margin-top: -1.5em;
    padding-inline-start: 1.25rem;
  }
}

{% endhighlight %}

#### menu で指定するフォントサイズの変更

{% highlight css linenos  %}
# _sass\minimal-mistakes\_navigation.scss


.toc__menu {
  margin: 0;
  padding: 0;
  width: 100%;
  list-style: none;
  font-size: $type-size-4;　　　<== size-6 から size-4

  @include breakpoint($large) {
    font-size: $type-size-6;    <== size-7 から size-6
  }

  a {
    display: block;
    padding: 0.25rem 0.75rem;
    color: $muted-text-color;
    font-weight: bold;
    line-height: 1.5;
    border-bottom: 1px solid $border-color;

    &:hover {
      color: $text-color;
    }
  }

  li ul > li a {
    padding-inline-start: 1.25rem;
    font-weight: normal;
  }

  li ul li ul > li a {
    padding-inline-start: 1.75rem;
  }

  li ul li ul li ul > li a {
    padding-inline-start: 2.25rem;
  }

  li ul li ul li ul li ul > li a {
    padding-inline-start: 2.75rem;
  }

  li ul li ul li ul li ul li ul > li a {
    padding-inline-start: 3.25rem;
  }
}

{% endhighlight %}
