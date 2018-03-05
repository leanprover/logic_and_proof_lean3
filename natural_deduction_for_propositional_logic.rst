Natural Deduction for Propositional Logic
=========================================

Reflecting on the arguments in the previous chapter, we see that, intuitively speaking, some inferences are *valid* and some are not. For example, if, in a chain of reasoning, we had established ":math:`A` and :math:`B`," it would seem perfectly reasonable to conclude :math:`B`. If we had established :math:`A`, :math:`B`, and "If :math:`A` and :math:`B` then :math:`C`," it would be reasonable to conclude :math:`C`. On the other hand, if we had established ":math:`A` or :math:`B`," we would not be justified concluding :math:`B` without further information.

The task of symbolic logic is to develop a precise mathematical theory that explains which inferences are valid and why. There are two general approaches to spelling out the notion of validity. In this chapter, we will consider the *deductive* approach: an inference is valid if it can be justified by fundamental rules of reasoning that reflect the meaning of the logical terms involved. In :numref:`Chapter %s <semantics_of_propositional_logic>` we will consider the "semantic" approach: an inference is valid if it is an instance of a pattern that always yields a true conclusion from true hypotheses.

.. _derivations_in_natural_deduction:

Derivations in Natural Deduction
--------------------------------

We have seen that the language of propositional logic allows us to build up expressions from propositional variables :math:`A, B, C, \ldots` using propositional connectives like :math:`\to`, :math:`\wedge`, :math:`\vee`, and :math:`\neg`. We will now consider a formal deductive system that we can use to *prove* propositional formulas. There are a number of such systems on offer; the one will use is called *natural deduction*, designed by Gerhard Gentzen in the 1930s.

In natural deduction, every proof is a proof from *hypotheses*. In other words, in any proof, there is a finite set of hypotheses :math:`\{ B, C, \ldots \}` and a conclusion :math:`A`, and what the proof shows is that :math:`A` follows from :math:`B, C, \ldots`.

Like formulas, proofs are built by putting together smaller proofs, according to the rules. For instance, the way to read the and-introduction rule

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.1.png">

.. raw:: latex

   \begin{center}
   \AXM{A}
   \AXM{B}
   \BIM{A \wedge B}
   \DP
   \end{center}

is as follows: if you have a proof :math:`P_1` of :math:`A` from some hypotheses, and you have a proof :math:`P_2` of :math:`B` from some hypotheses, then you can put them together using this rule to obtain a proof of :math:`A \wedge B`, which uses all the hypotheses in :math:`P_1` together with all the hypotheses in :math:`P_2`. For example, this is a proof of :math:`(A \wedge B) \wedge (A \wedge C)` from three hypotheses, :math:`A`, :math:`B`, and :math:`C`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.2.png">

.. raw:: latex

   \begin{center}
   \AXM{A}
   \AXM{B}
   \BIM{A \wedge B}
   \AXM{A}
   \AXM{C}
   \BIM{A \wedge C}
   \BIM{(A \wedge B) \wedge (A \wedge C)}
   \DP
   \end{center}

One thing that makes natural deduction confusing is that when you put together proofs in this way, hypotheses can be eliminated, or, as we will say, *canceled*. For example, we can apply the implies-introduction rule to the last proof, and obtain the following proof of :math:`B \to (A \wedge B) \wedge (A \wedge C)` from only *two* hypotheses, :math:`A` and :math:`C`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.3.png">

.. raw:: latex

   \begin{center}
   \AXM{A}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \BIM{A \wedge B}
   \AXM{A}
   \AXM{C}
   \BIM{A \wedge C}
   \BIM{(A \wedge B) \wedge (A \wedge C)}
   \RLM{1}
   \UIM{B \to (A \wedge B) \wedge (A \wedge C)}
   \DP
   \end{center}

Here, we have used the label 1 to indicate the place where the hypothesis :math:`B` was canceled. Any label will do, though we will tend to use numbers for that purpose.

We can continue to cancel the hypothesis :math:`A`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.4.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{2}
   \UIM{A}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \BIM{A \wedge B}
   \AXM{}
   \RLM{2}
   \UIM{A}
   \AXM{C}
   \BIM{A \wedge C}
   \BIM{(A \wedge B) \wedge (A \wedge C)}
   \RLM{1}
   \UIM{B \to (A \wedge B) \wedge (A \wedge C)}
   \RLM{2}
   \UIM{A \to (B \to (A \wedge B) \wedge (A \wedge C))}
   \DP
   \end{center}

The result is a proof using only the hypothesis :math:`C`. We can continue to cancel that hypothesis as well:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.5.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{2}
   \UIM{A}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \BIM{A \wedge B}
   \AXM{}
   \RLM{2}
   \UIM{A}
   \AXM{}
   \RLM{3}
   \UIM{C}
   \BIM{A \wedge C}
   \BIM{(A \wedge B) \wedge (A \wedge C)}
   \RLM{1}
   \UIM{B \to (A \wedge B) \wedge (A \wedge C)}
   \RLM{2}
   \UIM{A \to (B \to (A \wedge B) \wedge (A \wedge C))}
   \RLM{3}
   \UIM{C \to (A \to (B \to (A \wedge B) \wedge (A \wedge C)))}
   \DP
   \end{center}

The resulting proof uses no hypothesis at all. In other words, it establishes the conclusion outright.

Notice that in the second step, we canceled two "copies" of the hypothesis :math:`A`. In natural deduction, we can choose which hypotheses to cancel; we could have canceled either one, and left the other hypothesis *open*. In fact, we can also carry out the implication-introduction rule and cancel *zero* hypotheses. For example, the following is a short proof of :math:`A \to B` from the hypothesis :math:`B`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.6.png">

.. raw:: latex

   \begin{center}
   \AXM{B}
   \UIM{A \to B}
   \DP
   \end{center}

In this proof, zero copies of :math:`A` are canceled.

Also notice that although we are using letters like :math:`A`, :math:`B`, and :math:`C` as propositional variables, in the proofs above we can replace them by any propositional formula. For example, we can replace :math:`A` by the formula :math:`(D \vee E)` everywhere, and still have correct proofs. In some presentations of logic, different letters are used for to stand for propositional variables and arbitrary propositional formulas, but we will continue to blur the distinction. You can think of :math:`A`, :math:`B`, and :math:`C` as standing for propositional variables or formulas, as you prefer. If you think of them as propositional variables, just keep in mind that in any rule or proof, you can replace every variable by a different formula, and still have a valid rule or proof.

Finally, notice also that in these examples, we have assumed a special rule as the starting point for building proofs. It is called the assumption rule, and it looks like this:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.7.png">

.. raw:: latex

   \begin{center}
   \AXM{A}
   \DP
   \end{center}

What it means is that at any point we are free to simply assume a formula, :math:`A`. The single formula :math:`A` constitutes a one-line proof, and the way to read this proof is as follows: assuming :math:`A`, we have proved :math:`A`.

The remaining rules of inference were given in the last chapter, and we summarize them here.

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

Examples
--------

Let us consider some more examples of natural deduction proofs. In each case, you should think about what the formulas say and which rule of inference is invoked at each step. Also pay close attention to which hypotheses are canceled at each stage. If you look at any node of the tree, what has been established at that point is that the claim follows from all the hypotheses above it that haven't been canceled yet.

The following is a proof of :math:`A \to C` from :math:`A \to B` and :math:`B \to C`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.15.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \AXM{A \to B}
   \BIM{B}
   \AXM{B \to C}
   \BIM{C}
   \RLM{1}
   \UIM{A \to C}
   \DP
   \end{center}

Intuitively, the formula

.. math::

   (A \to B) \wedge (B \to C) \to (A \to C)

"internalizes" the conclusion of the previous proof. The :math:`\wedge` symbol is used to combine hypotheses, and the :math:`\to` symbol is used to express that the right-hand side is a consequence of the left. Here is a proof of that formula:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.16.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \AXM{}
   \RLM{2}
   \UIM{(A \to B) \wedge (B \to C)}
   \UIM{A \to B}
   \BIM{B}
   \AXM{}
   \RLM{2}
   \UIM{(A \to B) \wedge (B \to C)}
   \UIM{B \to C}
   \BIM{C}
   \RLM{1}
   \UIM{A \to C}
   \RLM{2}
   \UIM{(A \to B) \wedge (B \to C) \to (A \to C)}
   \DP
   \end{center}

The next proof shows that if a conclusion, :math:`C`, follows from :math:`A` and :math:`B`, then it follows from their conjunction.

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.17.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{2}
   \UIM{A \to (B \to C)}
   \AXM{}
   \RLM{1}
   \UIM{A \wedge B}
   \UIM{A}
   \BIM{B \to C}
   \AXM{}
   \RLM{1}
   \UIM{A \wedge B}
   \UIM{B}
   \BIM{C}
   \RLM{1}
   \UIM{A \wedge B \to C}
   \RLM{2}
   \UIM{(A \to (B \to C)) \to
   (A \wedge B \to C)}
   \DP
   \end{center}

The conclusion of the next proof can be interpreted as saying that if it is not the case that one of :math:`A` or :math:`B` is true, then they are both false. It illustrates the use of the rules for negation.

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.19.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{3}
   \UIM{\neg (A \vee B)}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \UIM{A \vee B}
   \BIM{\bot}
   \RLM{1}
   \UIM{\neg A}
   \AXM{}
   \RLM{3}
   \UIM{\neg (A \vee B)}
   \AXM{}
   \RLM{2}
   \UIM{B}
   \UIM{A \vee B}
   \BIM{\bot}
   \RLM{2}
   \UIM{\neg B}
   \BIM{\neg A \wedge \neg B}
   \RLM{3}
   \UIM{\neg (A \vee B) \to \neg A \wedge \neg B}
   \DP
   \end{center}

Finally, the next two examples illustrate the use of the *ex falso* rule. The first is a derivation of an arbitrary formula :math:`B` from :math:`\neg A` and :math:`A`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.20.png">

.. raw:: latex

   \begin{center}
   \AXM{\neg A}
   \AXM{A}
   \BIM{\bot}
   \UIM{B}
   \DP
   \end{center}

The second shows that :math:`B` follows from :math:`A` and :math:`\neg A \vee B`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.21.png">

.. raw:: latex

   \begin{center}
   \AXM{\neg A \vee B}
   \AXM{}
   \RLM{1}
   \UIM{\neg A}
   \AXM{A}
   \BIM{\bot}
   \UIM{B}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \RLM{1}
   \TIM{B}
   \DP
   \end{center}

In some proof systems, these rules are taken to be part of the system. But we do not need to that with our system: these two examples show that the rules can be *derived* from our other rules.

.. _forward_and_backward_reasoning:

Forward and Backward Reasoning
------------------------------

Natural deduction is supposed to represent an idealized model of the patterns of reasoning and argumentation we use, for example, when working with logic puzzles as in the last chapter. There are obvious differences: we describe natural deduction proofs with symbols and two-dimensional diagrams, whereas our informal arguments are written with words and paragraphs. It is worthwhile to reflect on what *is* captured by the model. Natural deduction is supposed to clarify the *form* and *structure* of our logical arguments, describe the appropriate means of justifying a conclusion, and explain the sense in which the rules we use are valid.

Constructing natural deduction proofs can be confusing, but it is helpful to think about *why* it is confusing. We could, for example, decide that natural deduction is not a good model for logical reasoning. Or we might come to the conclusion that the features of natural deduction that make it confusing tell us something interesting about ordinary arguments.

In the "official" description, natural deduction proofs are constructed by putting smaller proofs together to obtain bigger ones. To prove :math:`A \wedge B \to B \wedge A`, we start with the hypothesis :math:`A \wedge B`. Then we construct, separately, the following two proofs:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.22.png">

.. raw:: latex

   \begin{center}
   \AXM{A \wedge B}
   \UIM{B}
   \DP
   \quad\quad
   \AXM{A \wedge B}
   \UIM{A}
   \DP
   \end{center}

Then we use these two proofs to construct the following one:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.23.png">

.. raw:: latex

   \begin{center}
   \AXM{A \wedge B}
   \UIM{B}
   \AXM{A \wedge B}
   \UIM{A}
   \BIM{B \wedge A}
   \DP
   \end{center}

Finally, we apply the implies-introduction rule to this proof to cancel the hypothesis and obtain the desired conclusion:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.24.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{1}
   \UIM{A \wedge B}
   \UIM{B}
   \AXM{}
   \RLM{1}
   \UIM{A \wedge B}
   \UIM{A}
   \BIM{B \wedge A}
   \RLM{1}
   \UIM{A \wedge B \to B \wedge A}
   \DP
   \end{center}

The process is similar to what happens in an informal argument, where we start with some hypotheses, and work forward towards a conclusion.

----

Suppose Susan is tall and John is happy.

Then, in particular, John is happy.

Also, Susan is tall.

So John is happy and Susan is tall.

Therefore we have shown that if Susan is tall and John is happy, then John is happy and Susan is tall.

----

However, when we *read* natural deduction proofs, we often read them backward. First, we look at the bottom to see what is being proved. Then we consider the rule that is used to prove it, and see what premises the rule demands. Then we look to see how those claims are proved, and so on. Similarly, when we *construct* a natural deduction proof, we typically work backward as well: we start with the claim we are trying to prove, put that at the bottom, and look for rules to apply.

At times that process breaks down. Suppose we are left with a goal that is a single propositional variable, :math:`A`. There are no introduction rules that can be applied, so, unless :math:`A` is a hypothesis, it has to come from an elimination rule. But that underspecifies the problem: perhaps the :math:`A` comes from applying the and-elimination rule to :math:`A \wedge B`, or from applying the or-elimination rule to :math:`C` and :math:`C \to A`. At that point, we look to the hypotheses, and start working forward. If, for example, our hypotheses are :math:`C` and :math:`C \to A \wedge B`, we would then work forward to obtain :math:`A \wedge B` and :math:`A`.

There is thus a general heuristic for proving theorems in natural deduction:

#. Start by working backward from the conclusion, using the introduction rules. For example, if you are trying to prove a statement of the form :math:`A \to B`, add :math:`A` to your list of hypotheses and try to derive :math:`B`. If you are trying to prove a statement of the form :math:`A \wedge B`, use the and-introduction rule to reduce your task to proving :math:`A`, and then proving :math:`B`.

#. When you have run out things to do in the first step, use elimination rules to work forward. If you have hypotheses :math:`A \to B` and :math:`A`, apply modus ponens to derive :math:`B`. If you have a hypothesis :math:`A \vee B`, use or-elimination to split on cases, considering :math:`A` in one case and :math:`B` in the other.

In :numref:`Chapter %s <classical_reasoning>` we will add one more element to this list: if all else fails, try a proof by contradiction.

The tension between forward and backward reasoning is found in informal arguments as well, in mathematics and elsewhere. When we prove a theorem, we typically reason forward, using assumptions, hypotheses, definitions, and background knowledge. But we also keep the goal in mind, and that helps us make sense of the forward steps.

When we turn to interactive theorem proving, we will see that *Lean* has mechanisms to support both forward and backward reasoning. These form a bridge between informal styles of argumentation and the natural deduction model, and thereby provide a clearer picture of what is going
on.

Another confusing feature of natural deduction proofs is that every hypothesis has a *scope*, which is to say, there are only certain points in the proof where an assumption is available for use. Of course, this is also a feature of informal mathematical arguments. Suppose a paragraph begins "Let :math:`x` be any number less than 100," argues that :math:`x` has at most five prime factors, and concludes "thus we have shown that every number less than 100 has at most five factors." The reference ":math:`x`", and the assumption that it is less than 100, is only active within the scope of the paragraph. If the next paragraph begins with the phrase "Now suppose :math:`x` is any number greater than 100," then, of course, the assumption that :math:`x` is less than 100 no longer applies.

In natural deduction, a hypothesis is available from the point where it is assumed until the point where it is canceled. We will see that interactive theorem proving languages also have mechanisms to determine the scope of references and hypotheses, and that these, too, shed light on scoping issues in informal mathematics.

Reasoning by Cases
------------------

The rule for eliminating a disjunction is confusing, but we can make sense of it with an example. Consider the following informal argument:

----

George is either at home or on campus.

If he is at home, he is studying.

If he is on campus, he is with his friends.

Therefore, George is either studying or with his friends.

----

Let :math:`A` be the statement that George is at home, let :math:`B` be the statement that George is on campus, let :math:`C` be the statement that George is studying, and let :math:`D` be the statement the George is with his friends. Then the argument above has the following pattern: from :math:`A \vee B`, :math:`A \to C`, and :math:`B \to D`, conclude :math:`C \vee D`. In natural deduction, we can not get away with drawing this conclusion in a single step, but it does not take too much work to flesh it out into a proper proof. Informally, we have to argue as follows.

----

Georges is either at home or on campus.

    Case 1: Suppose he is at home. We know that if he is at home, then he is studying. So, in this case, he is studying. Therefore, in this case, he is either studying or with his friends.

    Case 2: Suppose he is on campus. We know that if he is on campus, then he is with his friends. So, in this case, he is with his friends. Therefore, in this case, he is either studying or with his friends.

Either way, George is either studying or with his friends.

----

The natural deduction proof looks as follows:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.25.png">

.. raw:: latex

   \begin{center}
   \AXM{A \vee B}
   \AXM{A \to C}
   \AXM{}
   \RLM{1}
   \UIM{A}
   \BIM{C}
   \UIM{C \vee D}
   \AXM{B \to D}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \BIM{D}
   \UIM{C \vee D}
   \RLM{1}
   \TIM{C \vee D}
   \DP
   \end{center}

You should think about how the structure of this proof reflects the informal case-based argument above it.

For another example, here is a proof of :math:`A \wedge (B \vee C) \to (A \wedge B) \vee (A \wedge C)`:

.. raw:: html

   <img src="_static/natural_deduction_for_propositional_logic.18.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{2}
   \UIM{A \wedge (B \vee C)}
   \UIM{B \vee C}
   \AXM{}
   \RLM{2}
   \UIM{A \wedge (B \vee C)}
   \UIM{A}
   \AXM{}
   \RLM{1}
   \UIM{B}
   \BIM{A \wedge B}
   \UIM{(A \wedge B) \vee (A \wedge C)}
   \AXM{}
   \RLM{2}
   \UIM{A \wedge (B \vee C)}
   \UIM{A}
   \AXM{}
   \RLM{1}
   \UIM{C}
   \BIM{A \wedge C}
   \UIM{(A \wedge B) \vee (A \wedge C)}
   \RLM{1}
   \TIM{(A \wedge B) \vee (A \wedge C)}
   \RLM{2}
   \UIM{(A \wedge (B \vee C)) \to ((A \wedge B) \vee (A \wedge C))}
   \DP
   \end{center}


Some Logical Identities
-----------------------

Two propositional formulas, :math:`A` and :math:`B`, are said to be *logically equivalent* if :math:`A \leftrightarrow B` is provable. Logical equivalences are similar to identities like :math:`x + y = y + x` that occur in algebra. In particular, one can show that if two formulas are equivalent, then one can substitute one for the other in any formula, and the results will also be equivalent. (Some proof systems take this to be a basic rule, and interactive theorem provers can accommodate it, but we will *not* take it to be a fundamental rule of natural deduction.)

For reference, the following list contains some commonly used propositional equivalences, along with some noteworthy formulas. Think about why, intuitively, these formulas should be true.

#. Commutativity of :math:`\wedge`: :math:`A \wedge B \leftrightarrow B \wedge A`
#. Commutativity of :math:`\vee`: :math:`A \vee B \leftrightarrow B \vee A`
#. Associativity of :math:`\wedge`: :math:`(A \wedge B) \wedge C \leftrightarrow A \wedge (B \wedge C)`
#. Associativity of :math:`\vee` :math:`(A \vee B) \vee C \leftrightarrow A \vee (B \vee C)`
#. Distributivity of :math:`\wedge` over :math:`\vee`: :math:`A \wedge (B \vee C) \leftrightarrow (A \wedge B) \vee (A \wedge C)`
#. Distributivity of :math:`\vee` over :math:`\wedge`: :math:`A \vee (B \wedge C) \leftrightarrow (A \vee B) \wedge (A \vee C)`
#. :math:`(A \to (B \to C)) \leftrightarrow (A \wedge B \to C)`.
#. :math:`(A \to B) \to ((B \to C) \to (A \to C))`
#. :math:`((A \vee B) \to C) \leftrightarrow (A \to C) \wedge (B \to C)`
#. :math:`\neg (A \vee B) \leftrightarrow \neg A \wedge \neg B`
#. :math:`\neg (A \wedge B) \leftrightarrow \neg A \vee \neg B`
#. :math:`\neg (A \wedge \neg A)`
#. :math:`\neg (A \to B) \leftrightarrow A \wedge \neg B`
#. :math:`\neg A \to (A \to B)`
#. :math:`(\neg A \vee B) \leftrightarrow (A \to B)`
#. :math:`A \vee \bot \leftrightarrow A`
#. :math:`A \wedge \bot \leftrightarrow \bot`
#. :math:`A \vee \neg A`
#. :math:`\neg (A \leftrightarrow \neg A)`
#. :math:`(A \to B) \leftrightarrow (\neg B \to \neg A)`
#. :math:`(A \to C \vee D) \to ((A \to C) \vee (A \to D))`
#. :math:`(((A \to B) \to A) \to A)`

All of these can be derived in natural deduction using the fundamental rules listed in :numref:`derivations_in_natural_deduction`. But some of them require the use of the *reductio ad absurdum* rule, or proof by contradiction, which we have not yet discussed in detail. We will discuss the use of this rule, and other patterns of classical logic, in the :numref:`Chapter %s <classical_reasoning>`.

Exercises
---------

When constructing proofs in natural deduction, use *only* the list of
rules given in :numref:`derivations_in_natural_deduction`.

#. Give a natural deduction proof of :math:`\neg (A \wedge B) \to (A \to \neg B)`.

#. Give a natural deduction proof of :math:`(A \to C) \wedge (B \to \neg C) \to \neg (A \wedge B)`.

#. Give a natural deduction proof of :math:`(A \wedge B) \to ((A \to C) \to \neg (B \to \neg C))`.

#. Take another look at Exercise 3 in the last chapter. Using propositional variables :math:`A`, :math:`B`, and :math:`C` for "Alan likes kangaroos," "Betty likes frogs" and "Carl likes hamsters," respectively, express the three hypotheses in the previous problem as symbolic formulas, and then derive a contradiction from them in natural deduction.

#. Give a natural deduction proof of :math:`A \vee B \to B \vee A`.

#. Give a natural deduction proof of :math:`\neg A \wedge \neg B \to \neg (A \vee B)`

#. Give a natural deduction proof of :math:`\neg (A \wedge B)` from :math:`\neg A \vee \neg B`. (You do not need to use proof by contradiction.)

#. Give a natural deduction proof of :math:`\neg (A \leftrightarrow \neg A)`.

#. Give a natural deduction proof of :math:`(\neg A \leftrightarrow \neg B)` from hypothesis :math:`A \leftrightarrow B`.