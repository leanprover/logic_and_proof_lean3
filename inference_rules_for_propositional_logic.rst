
*Implication:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.8.png">

.. raw:: latex

   \begin{quote}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{B}
   \RLM{1 \;\; \mathord{\to}\mathrm{I}}
   \UIM{A \to B}
   \DP
   \quad\quad
   \AXM{A \to B}
   \AXM{A}
   \RLM{\mathord{\to}\mathrm{E}}
   \BIM{B}
   \DP
   \end{quote}

*Conjunction:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.9.png">

.. raw:: latex

   \begin{quote}
   \AXM{A}
   \AXM{B}
   \RLM{\mathord{\wedge}\mathrm{I}}
   \BIM{A \wedge B}
   \DP
   \quad\quad
   \AXM{A \wedge B}
   \RLM{\mathord{\wedge}\mathrm{E_l}}
   \UIM{A}
   \DP
   \quad\quad
   \AXM{A \wedge B}
   \RLM{\mathord{\wedge}\mathrm{E_r}}
   \UIM{B}
   \DP
   \end{quote}

*Negation:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.10.png">

.. raw:: latex

   \begin{quote}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{\bot}
   \RLM{1 \;\; \neg \mathrm{I}}
   \UIM{\neg A}
   \DP
   \quad\quad
   \AXM{\neg A}
   \AXM{A}
   \RLM{\neg \mathrm{E}}
   \BIM{\bot}
   \DP
   \end{quote}

*Disjunction:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.11.png">

.. raw:: latex

   \begin{quote}
   \AXM{A}
   \RLM{\mathord{\vee}\mathrm{I_l}}
   \UIM{A \vee B}
   \DP
   \quad\quad
   \AXM{B}
   \RLM{\mathord{\vee}\mathrm{I_r}}
   \UIM{A \vee B}
   \DP
   \quad\quad
   \AXM{A \vee B}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{C}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{C}
   \RLM{1 \;\; \mathord{\vee}\mathrm{E}}
   \TIM{C}
   \DP
   \end{quote}

*Truth and falsity:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.12.png">

.. raw:: latex

   \begin{quote}
   \AXM{\bot}
   \RLM{\bot \mathrm{E}}
   \UIM{A}
   \DP
   \quad\quad
   \AXM{}
   \RLM{\top \mathrm{I}}
   \UIM{\top}
   \DP
   \end{quote}

*Bi-implication:*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.13.png">

.. raw:: latex

   \begin{quote}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{B}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{A}
   \RLM{1 \;\; \mathord{\leftrightarrow}\mathrm{I}}
   \BIM{A \leftrightarrow B}
   \DP
   \AXM{A \leftrightarrow B}
   \AXM{A}
   \RLM{\mathord{\leftrightarrow}\mathrm{E}_l}
   \BIM{B}
   \DP
   \quad\quad
   \AXM{A \leftrightarrow B}
   \AXM{B}
   \RLM{\mathord{\leftrightarrow}\mathrm{E}_r}
   \BIM{A}
   \DP
   \end{quote}

*Reductio ad absurdum (proof by contradiction):*

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.14.png">

.. raw:: latex

   \begin{quote}
   \AXM{}
   \RLM{1}
   \UIM{\neg A}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{\bot}
   \RLM{1 \;\; \mathrm{RAA}}
   \UIM{A}
   \DP
   \end{quote}
