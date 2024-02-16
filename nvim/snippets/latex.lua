
return {
    require("luasnip").add_snippets("plain",
    { trig = "article" },
    { t([[
    \documentclass[12pt]{article}
    \usepackage[utf8]{inputenc}
    \usepackage{polski}
    \usepackage{enumitem}
    \usepackage{amsmath}


    \title{Zadanie 1--1}
    \author{Patryk Lisik}
    \date{\(15\) Listopad  2023}

    \begin{document}

    \maketitle
    \renewcommand{\abstractname}{Treść}

    \begin{abstract}
    \end{abstract}


    \section*{Rozwiązanie}

    \end{document}
    ]]) }
    ),
}
