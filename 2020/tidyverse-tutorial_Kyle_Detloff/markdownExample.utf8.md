---
title: "t-test Power Simulation"
author: "Kyle Dettloff"
date: "04-09-2020"
header-includes:
- \let\rmarkdownfootnote\footnote%
- \def\footnote{\protect\rmarkdownfootnote}

- \usepackage{titling}
- \setlength{\droptitle}{-2em}

- \pretitle{\vspace{\droptitle}\centering\huge}
- \posttitle{\par}

- \preauthor{\centering\large\emph}
- \postauthor{\par}

- \predate{\centering\large\emph}
- \postdate{\par}
output: pdf_document
geometry: margin=0.5in
params:
  nsim: 
    label: "Number of Simulations"
    value: 1000
    input: slider
    min: 100
    max: 10000
    step: 10
    
  alpha:
    label: "alpha"
    value: 0.05
    input: numeric
    min: 0
    max: 1
    
  max.mean.diff:
    label: "Max Difference in Means"
    value: 3
    input: numeric
    min: 1
    max: 5
    
  sim1.n1:
    label: "Simulation 1: Sample Size Pop 1"
    value: 10
    input: numeric
    min: 2
    
  sim1.n2:
    label: "Simulation 1: Sample Size Pop 2"
    value: 10
    input: numeric
    min: 2
    
  sim1.sd1:
    label: "Simulation 1: Standard Deviation Pop 1"
    value: 1
    input: numeric
    min: 0
    
  sim1.sd2:
    label: "Simulation 1: Standard Deviation Pop 2"
    value: 1
    input: numeric
    min: 0
    
  sim1.eqvar:
    label: "Simulation 1: Unequal Variance?"
    value: FALSE
    input: checkbox
    
  sim2.n1:
    label: "Simulation 2: Sample Size Pop 1"
    value: 10
    input: numeric
    min: 2
    
  sim2.n2:
    label: "Simulation 2: Sample Size Pop 2"
    value: 10
    input: numeric
    min: 2
    
  sim2.sd1:
    label: "Simulation 2: Standard Deviation Pop 1"
    value: 1
    input: numeric
    min: 0
    
  sim2.sd2:
    label: "Simulation 2: Standard Deviation Pop 2"
    value: 1
    input: numeric
    min: 0
  
  sim2.eqvar:
    label: "Simulation 2: Unequal Variance?"
    value: FALSE
    input: checkbox
---

\pagenumbering{gobble}




\
**Simulation 1:** n~1~ = 10, n~2~ = 10, sd~1~ = 1, sd~2~ = 1, unequal variance  
**Simulation 2:** n~1~ = 10, n~2~ = 20, sd~1~ = 1, sd~2~ = 3, unequal variance
\

\begin{center}\includegraphics{markdownExample_files/figure-latex/unnamed-chunk-2-1} \end{center}

\newpage


Table: H~0~ Rejection Rates, alpha = 0.05

 Difference in Means   Simulation 1   Simulation 2
--------------------  -------------  -------------
                 0.0          0.047          0.014
                 0.1          0.046          0.016
                 0.2          0.071          0.008
                 0.3          0.078          0.026
                 0.4          0.145          0.017
                 0.5          0.204          0.029
                 0.6          0.231          0.049
                 0.7          0.336          0.047
                 0.8          0.369          0.062
                 0.9          0.482          0.075
                 1.0          0.527          0.110
                 1.1          0.626          0.144
                 1.2          0.726          0.165
                 1.3          0.782          0.214
                 1.4          0.850          0.245
                 1.5          0.873          0.287
                 1.6          0.937          0.317
                 1.7          0.956          0.374
                 1.8          0.968          0.423
                 1.9          0.978          0.479
                 2.0          0.989          0.493
                 2.1          0.995          0.537
                 2.2          0.999          0.606
                 2.3          0.998          0.646
                 2.4          0.996          0.708
                 2.5          1.000          0.753
                 2.6          1.000          0.784
                 2.7          1.000          0.812
                 2.8          1.000          0.828
                 2.9          1.000          0.883
                 3.0          1.000          0.885
