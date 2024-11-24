local ls = require("luasnip")


return {
    -- To return multiple snippets, use one `return` statement per snippet file
    -- and return a table of Lua snippets.
    ls.snippet(
        "article",
        { ls.text_node(
            [[
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
    ls.snippet(
        "ltex lang",
        { ls.text_node("% LTeX: language=pl-PL") }
    ),
}
