Natural Deduction for First Order Logic
=======================================

Rules of Inference
------------------

In the last chapter, we discussed the language of first-order logic, and the rules that govern their use. We summarize them here:

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

In the introduction rule, :math:`t` cant be any term that does not clash with any of the bound variables in :math:`A`. In the elimination rule, :math:`y` should not be free in :math:`B` or any uncanceled hypothesis.

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

The Universal Quantifier
------------------------

The following example of a proof in natural deduction shows that if, for every :math:`x`, :math:`A(x)` holds, and for every :math:`x`, :math:`B(x)` holds, then for every :math:`x`, they both hold:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.4.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\fa x A(x)}
   \UIM{A(y)}
   \AXM{}
   \RLM{2}
   \UIM{\fa x B(x)}
   \UIM{B(y)}
   \BIM{A(y) \wedge B(y)}
   \UIM{\fa y (A(y) \wedge B(y))}
   \RLM{2}
   \UIM{\fa x B(x) \to \fa y (A(y) \wedge B(y))}
   \RLM{1}
   \UIM{\fa x A(x) \to (\fa x B(x) \to \fa y (A(y) \wedge B(y)))}
   \end{prooftree}

Notice that neither of the assumptions 1 or 2 mention :math:`y`, so that :math:`y` is really "arbitrary" at the point where the universal quantifiers are introduced.

Here is another example:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.5.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\fa x A(x)}
   \UIM{A(y)}
   \UIM{A(y) \vee B(y)}
   \UIM{\fa x (A(x) \vee B(x))}
   \RLM{1}
   \UIM{\fa x A(x) \to \fa x (A(x) \vee B(x))}
   \end{prooftree}

As an exercise, try proving the following:

.. math:: 

   \forall x \; (A(x) \to B(x)) \to (\forall x \; A(x) \to \forall x \; B(x)).

Here is a more challenging exercise. Suppose I tell you that, in a town, there is a (male) barber that shaves all and only the men who do not shave themselves. You can show that this is a contradiction, arguing informally, as follows:

    By the assumption, the barber shaves himself if and only if he does not shave himself. Call this statement (*).

    Suppose the barber shaves himself. By (*), this implies that he does not shave himself, a contradiction. So, the barber does not shave himself.

    But using (*) again, this implies that the barber shaves himself, which contradicts the fact we just showed, namely, that the barber does not shave himself.

Try to turn this into a formal argument in natural deduction.

Let us return to the example of the natural numbers, to see how deductive notions play out there. Suppose we have defined :math:`\mathit{even}` and :math:`\mathit{odd}` in such a way that we can prove:

-  :math:`\forall n \; (\neg \mathit{even}(n) \to \mathit{odd}(n))`
-  :math:`\forall n \; (\mathit{odd}(n) \to \neg \mathit{even}(n))`

Then we can go on to derive :math:`\forall n \; (\mathit{even}(n) \vee \mathit{odd}(n))` as follows:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.6.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \UIM{\mathit{even}(n) \vee \neg \mathit{even}(n)}
   \AXM{}
   \RLM{1}
   \UIM{\mathit{even}(n)}
   \UIM{\mathit{even}(n) \vee \mathit{odd}(n)}
   \AXM{}
   \UIM{\fa n (\neg \mathit{even}(n) \to \mathit{odd}(n))}
   \UIM{\neg \mathit{even} (n) \to \mathit{odd}(n)}
   \AXM{}
   \RLM{1}
   \UIM{\neg \mathit{even}(n)}
   \BIM{\mathit{odd}(n)}
   \UIM{\mathit{even}(n) \vee \mathit{odd}(n)}
   \RLM{1}
   \TIM{\mathit{even}(n) \vee \mathit{odd}(n)}
   \UIM{\fa n (\mathit{even} (n) \vee \mathit{odd}(n))}
   \end{prooftree}

We can also prove and :math:`\forall n \; \neg (\mathit{even}(n) \wedge \mathit{odd}(n))`:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.7.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \UIM{\mathit{odd}(n) \to \neg \mathit{even}(n)}
   \AXM{}
   \RLM{H}
   \UIM{\mathit{even}(n) \wedge \mathit{odd}(n)}
   \UIM{\mathit{odd}(n)}
   \BIM{\neg \mathit{even}(n)}
   \AXM{}
   \RLM{H}
   \UIM{\mathit{even}(n) \wedge \mathit{odd}(n)}
   \UIM{\mathit{even}(n)}
   \BIM{\bot}
   \RLM{H}
   \UIM{\neg (\mathit{even}(n) \wedge \mathit{odd}(n))}
   \UIM{\fa n \neg (\mathit{even}(n) \wedge \mathit{odd}(n))}
   \end{prooftree}

As we move from modeling basic rules of inference to modeling actual mathematical proofs, we will tend to shift focus from natural deduction to formal proofs in Lean. Natural deduction has its uses: as a model of logical reasoning, it provides us with a convenient means to study metatheoretic properties such as soundness and completeness. For working *within* the system, however, proof languages like Lean's tend to scale better, and produce more readable proofs.

The Existential Quantifier
--------------------------

Remember that the intuition behind the elimination rule for the existential quantifier is that if we know :math:`\exists x \; A(x)`, we can temporarily reason about an arbitrary element :math:`y` satisfying :math:`A(y)` in order to prove a conclusion that doesn't depend on :math:`y`. Here is an example of how it can be used. The next proof says that if we know there is something satisfying both :math:`A` and :math:`B`, then we know, in particular, that there is something satisfying :math:`A`.

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.8.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\exists  x (A(x) \wedge B(x))}
   \AXM{}
   \RLM{2}
   \UIM{A(y) \wedge B(y)}
   \UIM{A(y)}
   \UIM{\exists  x A(x)}
   \RLM{2}
   \BIM{\exists  x A(x)}
   \RLM{1}
   \UIM{\exists  x (A(x) \wedge B(x)) \to \exists  x A(x)}
   \end{prooftree}

The following proof shows that if there is something satsifying either :math:`A` or :math:`B`, then either there is something satisfying :math:`A`, or there is something satisfying :math:`B`.

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.9.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\ex x (A(x) \vee B(x))}
   \AXM{}
   \RLM{2}
   \UIM{A(y) \vee B(y)}
   \AXM{}
   \RLM{3}
   \UIM{A(y)}
   \UIM{\ex x A(x)}
   \UIM{\ex x A(x) \vee \ex x B(x)}
   \AXM{}
   \RLM{3}
   \UIM{B(y)}
   \UIM{\ex x B(x)}
   \UIM{\ex x A(x) \vee \ex x B(x)}
   \RLM{3}
   \TIM{\ex x A(x) \vee \ex x B(x)}
   \RLM{2}
   \BIM{\ex x A(x) \vee \ex x B(x)}
   \RLM{1}
   \UIM{\ex x (A(x) \vee B(x)) \to \ex x A(x) \vee \ex x B(x))}
   \end{prooftree}

The following example is more involved:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.10.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{2}
   \UIM{\ex x (A(x) \wedge B(x))}
   \AXM{}
   \RLM{1}
   \UIM{\fa x (A(x) \to \neg B(x))}
   \UIM{A(x) \to \neg B(x)}
   \AXM{}
   \RLM{3}
   \UIM{A(x) \wedge B(x)}
   \UIM{A(x)}
   \BIM{\neg B(x)}
   \AXM{}
   \RLM{3}
   \UIM{A(x) \wedge B(x)}
   \UIM{B(x)}
   \BIM{\bot}
   \RLM{3}
   \BIM{\bot}
   \RLM{2}
   \UIM{\neg\ex x(A(x) \wedge B(x))}
   \RLM{1}
   \UIM{\fa x (A(x) \to \neg B(x)) \to \neg\ex x(A(x) \wedge B(x))}
   \end{prooftree}

In this proof, the existential elimination rule (the line labeled :math:`3`) is used to cancel two hypotheses at the same time. Note that when this rule is applied, the hypothesis :math:`\forall x \; (A(x) \to \neg B(x))` has not yet been canceled. So we have to make sure that this formula doesn't contain the variable :math:`x` freely. But this is o.k., since this hypothesis contains :math:`x` only as a bound variable.

Another example is that if :math:`x` does not occur in :math:`P`, then :math:`\exists x \; P` is equivalent to :math:`P`:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.11.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\ex x P}
   \AXM{}
   \RLM{2}
   \UIM{P}
   \RLM{2}
   \BIM{P}
   \AXM{}
   \RLM{1}
   \UIM{P}
   \UIM{\ex x P}
   \RLM{1}
   \BIM{\ex x P \leftrightarrow P}
   \end{prooftree}

This short but tricky, so let us go through it carefully. On the left, we assume :math:`\exists x \; P` to conclude :math:`P`. We assume :math:`P`, and now we can immediately cancel this assumption by existential elimination, since :math:`x` does not occur in :math:`P`, so it doesn't occur freely in any assumption or in the conclusion. On the right we use existential introduction to conclude :math:`\exists x \; P` from :math:`P`.

.. _equality:

Equality
--------

Recall the natural deduction rules for equality:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.12.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \UIM{t = t}
   \DP
   \quad
   \AXM{s = t}
   \UIM{t = s}
   \DP
   \quad
   \AXM{r = s}
   \AXM{s = t}
   \BIM{r = t}
   \DP
   \\
   \ \\
   \AXM{s = t}
   \UIM{r(s) = r(t)}
   \DP
   \quad
   \AXM{s = t}
   \AXM{P(s)}
   \BIM{P(t)}
   \DP
   \end{center}

Keep in mind that we have implicitly fixed some first-order language, and :math:`r`, :math:`s`, and :math:`t` are any terms in that language. Recall also that we have adopted the practice of using functional notation with terms. For example, if we think of :math:`r(x)` as the term :math:`(x + y) \times (z + 0)` in the language of arithmetic, then :math:`r(0)` is the term :math:`(0 + y) \times (z + 0)` and :math:`r(u + v)` is :math:`((u + v) + y) \times (z + 0)`. So one example of the first inference on the second line is this:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.13.png">

.. raw:: latex

   \begin{center}
   \AXM{u + v = 0}
   \UIM{((u + v) + y) \times (z + 0) = (0 + y) \times (z + 0)}
   \DP
   \end{center}

The second axiom on that line is similar, except now :math:`P(x)` stands for any *formula*, as in the following inference:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.13a.png">

.. raw:: latex

   \begin{center}
   \AXM{u + v = 0}
   \AXM{x + (u + v) < y}
   \BIM{x + 0 < y}
   \DP
   \end{center}

Notice that we have written the reflexivity axiom, :math:`t = t`, as a rule with no premises. If you use it in a proof, it does not count as a hypothesis; it is built into the logic.

In fact, we can think of the first inference on the second line as a special case of the first. Consider, for example, the formula :math:`((u + v) + y) \times (z + 0) = (x + y) \times (z + 0)`. If we plug :math:`u + v` in for :math:`x`, we get an instance of reflexivity. If we plug in :math:`0`, we get the conclusion of the first example above. The following is therefore a derivation of the first inference, using only reflexivity and the second substitution rule above:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.14.png">

.. raw:: latex

   \begin{center}
   \AXM{u + v = 0}
   \AXM{}
   \UIM{((u + v) + y) \times (z + 0) = ((u + v) + y) \times (z + 0)}
   \BIM{((u + v) + y) \times (z + 0) = (0 + y) \times (z + 0)}
   \DP
   \end{center}

Roughly speaking, we are replacing the second instance of :math:`u + v` in an instance of reflexivity with :math:`0` to get the conclusion we
want.

Equality rules let us carry out calculations in symbolic logic. This typically amounts to using the equality rules we have already discussed, together with a list of general identities. For example, the following identities hold for any real numbers :math:`x`, :math:`y`, and :math:`z`:

-  commutativity of addition: :math:`x + y = y + x`
-  associativity of addition: :math:`(x + y) + z = x + (y + z)`
-  additive identity: :math:`x + 0 = 0 + x = x`
-  additive inverse: :math:`-x + x = x + -x = 0`
-  multiplicative identity: :math:`x \cdot 1 = 1 \cdot x = x`
-  commutativity of multiplication: :math:`x \cdot y = y \cdot x`
-  associativity of multiplication: :math:`(x \cdot y) \cdot z = x \cdot (y \cdot z)`
-  distributivity: :math:`x \cdot (y + z) = x \cdot y + x \cdot z, \quad (x + y) \cdot z = x \cdot z + y \cdot z`

You should imagine that there are implicit universal quantifiers in front of each statement, asserting that the statement holds for *any* values of :math:`x`, :math:`y`, and :math:`z`. Note that :math:`x`, :math:`y`, and :math:`z` can, in particular, be integers or rational numbers as well. Calculations involving real numbers, rational numbers, or integers generally involve identities like this.

The strategy is to use the elimination rule for the universal quantifier to instantiate general identities, use symmetry, if necessary, to orient an equation in the right direction, and then using the substitution rule for equality to change something in a previous result. For example, here is a natural deduction proof of a simple identity, :math:`\forall x, y, z \; ((x + y) + z = (x + z) + y)`, using only commutativity and associativity of addition. We have taken the liberty of using a brief name to denote the relevant identities, and combining multiple instances of the universal quantifier introduction and elimination rules into a single step.

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.15.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \UIM{\mathsf{assoc}}
   \UIM{(x + z) + y = x + (z + y)}
   \UIM{x + (z + y) = (x + z) + y}
   \AXM{}
   \UIM{\mathsf{comm}}
   \UIM{y + z = z + y}
   \AXM{}
   \UIM{\mathsf{assoc}}
   \UIM{(x + y) + z = x + (y + z)}
   \BIM{(x + y) + z = x + (z + y)}
   \BIM{(x + y) + z = (x + z) + y}
   \UIM{\fa {x, y, z} ((x + y) + z = (x + z) + y)}
   \DP
   \end{center}

There is generally nothing interesting to be learned from carrying out such calculations in natural deduction, but you should try one or two examples to get the hang of it, and then take pleasure in knowing that it is possible.

Counterexamples and Relativized Quantifiers
-------------------------------------------

Consider the statement:

    Every prime number is odd.

In first-order logic, we could formulate this as :math:`\forall p \; (\mathit{prime}(p) \to \mathit{odd}(p))`. This statement is false, because there is a prime number which is even, namely the number 2. This is called a *counterexample* to the statement.

More generally, given a formula :math:`\forall x \; A(x)`, a counterexample is a value :math:`t` such that :math:`\neg A(t)` holds. Such a counterexample shows that the original formula is false, because we have the following equivalence: :math:`\neg \forall x \; A(x) \leftrightarrow \exists x \; \neg A(x)`. So if we find a value :math:`t` such that :math:`\neg A(t)` holds, then by the existential introduction rule we can conclude that :math:`\exists x \; \neg A(x)`, and then by the above equivalence we have :math:`\neg \forall x \; A(x)`. Here is a proof of the equivalence:

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.16.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{}
   \RLM{1}
   \UIM{\neg\fa x A(x)}
   \AXM{}
   \RLM{4}
   \UIM{\neg(\ex x \neg A(x))}
   \AXM{}
   \RLM{5}
   \UIM{\neg A(x)}
   \UIM{\ex x \neg A(x)}
   \BIM{\bot}
   \RLM{5}
   \UIM{A(x)}
   \UIM{\fa x A(x)}
   \BIM{\bot}
   \RLM{4}
   \UIM{\ex x \neg A(x)}
   \AXM{}
   \RLM{1}
   \UIM{\ex x \neg A(x)}
   \AXM{}
   \RLM{3}
   \UIM{\neg A(y)}
   \AXM{}
   \RLM{2}
   \UIM{\fa x A(x)}
   \UIM{A(y)}
   \BIM{\bot}
   \RLM{3}
   \BIM{\bot}
   \RLM{2}
   \UIM{\neg\fa x A(x)}
   \RLM{1}
   \BIM{\neg\fa x A(x) \leftrightarrow \ex x \neg A(x)}
   \end{prooftree}

One remark about the proof: at the step marked by :math:`4` we *cannot* use the existential introduction rule, because at that point our only assumption is :math:`\neg \forall x \; A(x)`, and from that assumption we cannot prove :math:`\neg A(t)` for a particular term :math:`t`. So we use a proof by contradiction there.

As an exercise, prove the "dual" equivalence yourself: :math:`\neg \exists x \; A(x) \leftrightarrow \forall x \; \neg A(x)`. This can be done without using proof by contradiction.

In :numref:`Chapter %s <first_order_logic>` we saw examples of how to use relativization to restrict the scope of a universal quantifier. Suppose we want to say "every prime number is greater than 1". In first order logic this can be written as :math:`\forall n (\mathit{prime}(n) \to n > 1)`. The reason is that the original statement is equivalent to the statement "for every natural number, if it is prime, then it is greater than 1". Similarly, suppose we want to say "there exists a prime number greater than 100." This is equivalent to saying "there exists a natural number which is prime and greater than 100," which can be expressed as :math:`\exists n \; (\mathit{prime}(n) \wedge n > 100)`.

As an exercise you can prove the above results about negations of quantifiers also for relativized quantifiers. Specifically, prove the following statements:

-  :math:`\neg \exists x \; (A(x) \wedge B(x)) \leftrightarrow \forall x \; ( A(x) \to \neg B(x))`
-  :math:`\neg \forall x \; (A(x) \to B(x)) \leftrightarrow \exists x (A(x) \wedge \neg B(x))`

For reference, here is a list of valid sentences involving quantifiers:

-  :math:`\forall x \; A \leftrightarrow A` if :math:`x` is not free in :math:`A`
-  :math:`\exists x \; A \leftrightarrow A` if :math:`x` is not free in :math:`A`
-  :math:`\forall x \; (A(x) \land B(x)) \leftrightarrow \forall x \; A(x) \land \forall x \; B(x)`
-  :math:`\exists x \; (A(x) \land B) \leftrightarrow \exists \; x A(x) \land B` if :math:`x` is not free in :math:`B`
-  :math:`\exists x \; (A(x) \lor B(x)) \leftrightarrow \exists \; x A(x) \lor \exists \; x B(x)`
-  :math:`\forall x \; (A(x) \lor B) \leftrightarrow \forall x \; A(x) \lor B` if :math:`x` is not free in :math:`B`
-  :math:`\forall x \; (A(x) \to B) \leftrightarrow (\exists x \; A(x) \to B)` if :math:`x` is not free in :math:`B`
-  :math:`\exists x \; (A(x) \to B) \leftrightarrow (\forall x \; A(x) \to B)` if :math:`x` is not free in :math:`B`
-  :math:`\forall x \; (A \to B(x)) \leftrightarrow (A \to \forall x \; B(x))` if :math:`x` is not free in :math:`A`
-  :math:`\exists x \; (A(x) \to B) \leftrightarrow (A(x) \to \exists \; x B)` if :math:`x` is not free in :math:`B`
-  :math:`\exists x \; A(x) \leftrightarrow \neg \forall x \; \neg A(x)`
-  :math:`\forall x \; A(x) \leftrightarrow \neg \exists x \; \neg A(x)`
-  :math:`\neg \exists x \; A(x) \leftrightarrow \forall x \; \neg A(x)`
-  :math:`\neg \forall x \; A(x) \leftrightarrow \exists x \; \neg A(x)`

All of these can be derived in natural deduction. The last two allow us to push negations inwards, so we can continue to put first-order formulas in negation normal form. Other rules allow us to bring quantifiers to the front of any formula, though, in general, there will be multiple ways of doing this. For example, the formula

.. math::

   \forall x \; A(x) \to \exists y \; \forall z \; B(y, z)

is equivalent to both

.. math::

   \exists x, y \; \forall z \; (A(x) \to B(y, z))

and

.. math::

   \exists y \; \forall z \; \exists x \; (A(x) \to B(y, z)).

A formula with all the quantifiers in front is said to be in *prenex* form.

Exercises
---------

#. Give a natural deduction proof of

   .. math::
        \forall x \; (A(x) \to B(x)) \to (\forall x \; A(x) \to \forall x \; B(x)).

#. Give a natural deduction proof of :math:`\forall x \; B(x)` from hypotheses :math:`\forall x \; (A(x) \vee B(x))` and :math:`\forall y \; \neg A(y)`.

#. From hypotheses :math:`\forall x \; (\mathit{even}(x) \vee \mathit{odd}(x))` and :math:`\forall x \; (\mathit{odd}(x) \to \mathit{even}(s(x)))` give a natural deduction proof :math:`\forall x \; (\mathit{even}(x) \vee \mathit{even}(s(x)))`. (It might help to think of :math:`s(x)` as the function defined by :math:`s(x) = x + 1`.)

#. Give a natural deduction proof of :math:`\exists x \; A(x) \vee \exists x \; B(x) \to \exists x \; (A(x) \vee B(x))`.

#. Give a natural deduction proof of :math:`\exists x \; (A(x) \wedge C(x))` from the assumptions :math:`\exists x \; (A(x) \wedge B(x))` and :math:`\forall x \; (A(x) \wedge B(x) \to C(x))`.

#. Prove some of the other equivalences in the last section.

#. Consider some of the various ways of expressing "nobody trusts a politician" in first-order logic:

   -  :math:`\forall x \; (\mathit{politician}(x) \to \forall y \; (\neg \mathit{trusts}(y,x)))`
   -  :math:`\forall x,y \; (\mathit{politician}(x) \to \neg \mathit{trusts}(y,x))`
   -  :math:`\neg \exists x,y \; (\mathit{politician}(x) \wedge \mathit{trusts}(y,x))`
   -  :math:`\forall x, y \; (\mathit{trusts}(y,x) \to \neg \mathit{politician}(x))`

   They are all logically equivalent. Show this for the second and the fourth, by giving natural deduction proofs of each from the other. (As a shortcut, in the :math:`\forall` introduction and elimination rules, you can introduce / eliminate both variables in one step.)

#. Formalize the following statements, and give a natural deduction proof in which the first three statements appear as (uncancelled) hypotheses, and the last line is the conclusion:

   -  Every young and healthy person likes baseball.
   -  Every active person is healthy.
   -  Someone is young and active.
   -  Therefore, someone likes baseball.

   Use :math:`Y(x)` for "is young," :math:`H(x)` for "is healthy," :math:`A(x)` for "is active," and :math:`B(x)` for "likes baseball."

#. Give a natural deduction proof of :math:`\forall x, y, z \; (x = z \to (y = z \to x = y))` using the equality rules in :numref:`equality`.

#. Give a natural deduction proof of :math:`\forall x, y \; (x = y \to y = x)` using only these two hypotheses (and none of the new equality rules):

   -  :math:`\forall x \; (x = x)`
   -  :math:`\forall u, v, w \; (u = w \to (v = w \to u = v))`

   (Hint: Choose instantiations of :math:`u`, :math:`v`, and :math:`w` carefully. You can instantiate all the universal quantifiers in one step, as on the last homework assignment.)

#. Give a natural deduction proof of :math:`\neg \exists x \; (A(x) \wedge B(x)) \leftrightarrow \forall x \; (A(x) \to \neg B(x))`

#. Give a natural deduction proof of :math:`\neg \forall x \; (A(x) \to B(x)) \leftrightarrow \exists x \; (A(x) \wedge \neg B(x))`

#. Remember that both the following express :math:`\exists!x \; A(x)`, that is, the statement that there is a unique :math:`x` satisfying :math:`A(x)`:

   -  :math:`\exists x \; (A(x) \wedge \forall y \; (A(y) \to y = x))`
   -  :math:`\exists x \; A(x) \wedge \forall y \; \forall y' \; (A(y) \wedge A(y') \to y = y')`

   Do the following:

   -  Give a natural deduction proof of the second, assuming the first as a hypothesis.
   -  Give a natural deduction proof of the first, asssuming the second as a hypothesis.

   (Warning: these are long.)
