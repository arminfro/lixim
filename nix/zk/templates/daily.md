---
id: {{ id }}
created: {{ format-date now 'timestamp' }}
keywords: []
abstract: |
subtitle:
linkcolor: blue
pandoc_:
  - output: .pdf
  - toc: true
  - toc-depth: 6
course: {{ dir }}
aliases:
  - {{ format-date now 'timestamp' }}
author: {{ env.ZK_NAME }}
tags:
  - daily
  - {{ format-date now 'CW_%V/%y' }}
  - {{ format-date now '%B/%y' }}
---

# {{format-date now "full"}}

## Morning

## Forenoon

## Afternoon

## Evening

## Night
