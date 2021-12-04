
*The universal quantifier:*

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.1.png">

.. raw:: latex

   \begin{quote}
   \AXM{A(x)}
   \RLM{\mathord{\forall}\mathrm{I}}
   \UIM{\fa y A(y)}
   \DP
   \quad\quad
   \AXM{\fa x A(x)}
   \RLM{\mathord{\forall}\mathrm{E}}
   \UIM{A(t)}
   \DP
   \end{quote}

In the introduction rule, :math:`x` should not be free in any uncanceled hypothesis. In the elimination rule, :math:`t` can be any term that does not clash with any of the bound variables in :math:`A`.

*The existential quantifier:*

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.2.png">

.. raw:: latex

   \begin{quote}
   \AXM{A(t)}
   \RLM{\mathord{\exists}\mathrm{I}}
   \UIM{\exists  x A(x)}
   \DP
   \quad\quad
   \AXM{\exists  x A(x)}
   \AXM{}
   \RLM{1}
   \UIM{A(y)}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{B}
   \RLM{1 \;\; \mathord{\exists}\mathrm{E}}
   \BIM{B}
   \DP
   \end{quote}

In the introduction rule, :math:`t` can be any term that does not clash with any of the bound variables in :math:`A`. In the elimination rule, :math:`y` should not be free in :math:`B` or any uncanceled hypothesis.

*Equality:*

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.3.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{\mathrm{refl}}
   \UIM{t = t}
   \DP
   \quad
   \AXM{s = t}
   \RLM{\mathrm{symm}}
   \UIM{t = s}
   \DP
   \quad
   \AXM{r = s}
   \AXM{s = t}
   \RLM{\mathrm{trans}}
   \BIM{r = t}
   \DP
   \\
   \ \\
   \AXM{s = t}
   \RLM{\mathrm{subst}}
   \UIM{r(s) = r(t)}
   \DP
   \quad
   \AXM{s = t}
   \RLM{\mathrm{subst}}
   \AXM{P(s)}
   \BIM{P(t)}
   \DP
   \end{center}

Strictly speaking, only :math:`\mathrm{refl}` and the second substitution rule are necessary. The others can be derived from them.
