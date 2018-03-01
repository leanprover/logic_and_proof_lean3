.. _first_order_logic:

First Order Logic
=================

Propositional logic provides a good start at describing the general principles of logical reasoning, but it does not go far enough. Some of the limitations are apparent even in the "Malice and Alice" example from :numref:`Chapter %s <propositional_logic>`. Propositional logic does not give us the means to express a general principle that tells us that if Alice is with her son on the beach, then her son is with Alice; the general fact that no child is younger than his or her parent; or the general fact that if someone is alone, they are not with someone else. To express principles like these, we need a way to talk about objects and individuals, as well as their properties and the relationships between them. These are exactly what is provided by a more expressive logical framework known as *first-order logic*, which will be the topic of the next few chapters.

.. _functions_predicates_and_relations:

Functions, Predicates, and Relations
------------------------------------

Consider some ordinary statements about the natural numbers:

-  Every natural number is even or odd, but not both.
-  A natural number is even if and only if it is divisible by two. 
-  If some natural number, :math:`x`, is even, then so is :math:`x^2`.
-  A natural number :math:`x` is even if and only if :math:`x + 1` is odd.
-  Any prime number that is greater than 2 is odd.
-  For any three natural numbers :math:`x`, :math:`y`, and :math:`z`, if :math:`x` divides :math:`y` and :math:`y` divides :math:`z`, then :math:`x` divides :math:`z`.

These statements are true, but we generally do not think of them as *logically valid*: they depend on assumptions about the natural numbers, the meaning of the terms "even" and "odd," and so on. But once we accept the first statement, for example, it seems to be a logical consequence that the number of stairs in the White House is either even or odd, and, in particular, if it is not even, it is odd. To make sense of inferences like these, we need a logical system that can deal with objects, their properties, and relations between them.

Rather than fix a single language once and for all, first-order logic allows us to specify the symbols we wish to use for any given domain of interest. In this section, we will use the following running example:

-  The domain of interest is the natural numbers, :math:`\mathbb{N}`.
-  There are objects, :math:`0`, :math:`1`, :math:`2`, :math:`3`, ....
-  There are functions, addition and multiplication, as well as the square function, on this domain.
-  There are predicates on this domain, "even," "odd," and "prime."
-  There are relations between elements of this domain, "equal," "less than", and "divides."

For our logical language, we will choose symbols 1, 2, 3, :math:`\mathit{add}`, :math:`\mathit{mul}`, :math:`\mathit{square}`, :math:`\mathit{even}`, :math:`\mathit{odd}`, :math:`\mathit{prime}`, :math:`\mathit{lt}`, and so on, to denote these things. We will also have variables :math:`x`, :math:`y`, and :math:`z` ranging over the natural numbers. Note all of the following.

-  Functions can take different numbers of arguments: if :math:`x` and :math:`y` are natural numbers, it makes sense to write :math:`\mathit{mul}(x, y)` and :math:`\mathit{square}(x)`. So :math:`\mathit{mul}` takes two arguments, and :math:`\mathit{square}` takes only one.
-  Predicates and relations can also be understood in these terms. The predicates :math:`\mathit{even}(x)` and :math:`\mathit{prime}(x)` take one argument, while the binary relations :math:`\mathit{divides}(x, y)` and :math:`\mathit{lt}(x,y)` take two arguments.
-  Functions are different from predicates! A function takes one or more arguments, and returns a *value*. A predicate takes one or more arguments, and is either true or false. We can think of predicates as returning propositions, rather than values.
-  In fact, we can think of the constant symbols :math:`1, 2, 3, \ldots` as special sorts of function symbols that take zero arguments. Analogously, we can consider the predicates that take zero arguments to be the constant logical values, :math:`\top` and :math:`\bot`.
-  In ordinary mathematics, we often use "infix" notation for binary functions and relations. For example, we usually write :math:`x \times y` or :math:`x \cdot y` instead of :math:`\mathit{mul}(x, y)`, and we write :math:`x < y` instead of :math:`\mathit{lt}(x, y)`. We will use these conventions when writing proofs in natural deduction, and they are supported in Lean as well.
-  We will treat the equality relation, :math:`x = y`, as a special binary relation that is included in every first-order language.

First-order logic allows us to build complex expressions out of the basic ones. Starting with the variables and constants, we can use the function symbols to build up compound expressions like these:

.. math::

   x + y + z, \quad (x + 1) \times y \times y, \quad \mathit{square} (x + y \times z)

Such expressions are called "terms." Intuitively, they name objects in the intended domain of discourse.

Now, using the predicates and relation symbols, we can make assertions about these expressions:

.. math::

   \mathit{even}(x + y + z), \quad \mathit{prime}((x + 1) \times y \times y), \quad
   \mathit{square} (x + y \times z) = w, \quad x + y < z

Even more interestingly, we can use propositional connectives to build compound expressions like these:

-  :math:`\mathit{even}(x + y + z) \wedge \mathit{prime}((x + 1) \times y \times y)`
-  :math:`\neg (\mathit{square} (x + y \times z) = w) \vee x + y < z`
-  :math:`x < y \wedge \mathit{even}(x) \wedge \mathit{even}(y) \to x + 1 < y`

The second one, for example, asserts that either :math:`(x + yz)^2` is not equal to :math:`w`, or :math:`x + y` is less than :math:`z`. Remember, these are expressions in symbolic logic; in ordinary mathematics, we would express the notions using words like "is even" and "if and only if," as we did above. We will use notation like this whenever we are in the realm of symbolic logic, for example, when we write proofs in natural deduction. Expressions like these are called *formulas*. In contrast to terms, which name things, formulas *say things*; in other words, they make assertions about objects in the domain of discourse.

The Universal Quantifier
------------------------

What makes first-order logic powerful is that it allows us to make general assertions using *quantifiers*. The universal quantifier :math:`\forall` followed by a variable :math:`x` is meant to represent the phrase "for every :math:`x`." In other words, it asserts that every value of :math:`x` has the property that follows it. Using the universal quantifier, the examples with which we began the previous section can be expressed as follows:

- :math:`\forall x \; ((\mathit{even}(x) \vee \mathit{odd}(x)) \wedge \neg (\mathit{even}(x) \wedge \mathit{odd}(x)))`
- :math:`\forall x \; (\mathit{even}(x) \leftrightarrow 2 \mid x)`
- :math:`\forall x \; (\mathit{even}(x) \to \mathit{even}(x^2))`
- :math:`\forall x \; (\mathit{even}(x) \leftrightarrow \mathit{odd}(x+1))`
- :math:`\forall x \; (\mathit{prime}(x) \wedge x > 2 \to \mathit{odd}(x))`
- :math:`\forall x \; \forall y \; \forall z (x \mid y \wedge y \mid z \to x \mid z)`

It is common to combine multiple quantifiers of the same kind, and write, for example, :math:`\forall x, y, z \; (x \mid y \wedge y \mid z \to x \mid z)` in the last expression.

Here are some notes on syntax:

- In symbolic logic, the universal quantifier is usually taken to bind tightly. For example, :math:`\forall x \; P \vee Q` is interpreted as :math:`(\forall x \; P) \vee Q`, and we would write :math:`\forall x \; (P \vee Q)` to extend the scope.

- Be careful, however. In other contexts, especially in computer science, people often give quantifiers the *widest* scope possible. This is the case with Lean. For example, ``∀ x, P ∨ Q`` is interpreted as ``∀ x, (P ∨ Q)``, and we would write ``(∀ x, P) ∨ Q`` to limit the scope.

- After the quantifier :math:`\forall  x`, the variable :math:`x` is *bound*. For example, the expression :math:`\forall x \; (\mathit{even}(x) \vee \mathit{odd}(x))` is expresses that every number is even or odd. Notice that the variable :math:`x` does not appear anywhere in the informal statement. The statement is not about :math:`x` at all; rather :math:`x` is a dummy variable, a placeholder that stands for the "thing" referred to within a phrase that beings with the words "every thing." We think of the expression :math:`\forall x \; (\mathit{even}(x) \vee \mathit{odd}(x))` as being the same as the expression :math:`\forall y \; (\mathit{even}(y) \vee \mathit{odd}(y))`. Lean also treats these expressions as the same.

- In Lean, the expression ``∀ x y z, x ∣ y → y ∣ z → x ∣ z`` is interpreted as ``∀ x y z, x ∣ y → (y ∣ z → x ∣ z)``, with parentheses associated to the *right*. The part of the expression after the universal quantifier can therefore be interpreted as saying "given that ``x`` divides ``y`` and that ``y`` divides ``z``, ``x`` divides ``z``." The expression is logically equivalent to ``∀ x y z, x ∣ y ∧ y ∣ z → x ∣ z``, but we will see that, in Lean, it is often convenient to express facts like this as an iterated implication.

A variable that is not bound is called *free*. Notice that formulas in first-order logic say things about their free variables. For example, in the interpretation we have in mind, the formula :math:`\forall y \; (x \le y)` says that :math:`x` is less than or equal to every natural number. The formula :math:`\forall z \; (x \le z)` says exactly the same thing; we can always rename a bound variable, as long as we pick a name that does not clash with another name that is already in use. On the other hand, the formula :math:`\forall y (w \le y)` says that :math:`w` is less than or equal to every natural number. This is an entirely different statement: it says something about :math:`w`, rather than :math:`x`. So renaming a *free* variable changes the meaning of a formula.

Notice also that some formulas, like :math:`\forall x, y \; (x \le y \vee y \le x)`, have no free variables at all. Such a formula is called a *sentence*, because it makes an outright assertion, a statement that is either true or false about the intended interpretation. In :numref:`Chapter %s <semantics_of_first_order_logic>` we will make the notion of an "intended interpretation" precise, and explain what it means to be "true in an interpretation." For now, the idea that formulas say things about about object in an intended interpretation should motivate the rules for reasoning with such expressions.

In :numref:`Chapter %s <introduction>` we proved that the square root of two is irrational. One way to construe the statement is as follows:

    For every pair of integers, :math:`a` and :math:`b`, if :math:`b \ne 0`, it is not the case that :math:`a^2 = 2 b^2`.

The advantage of this formulation is that we can restrict our attention to the integers, without having to consider the larger domain of rationals. In symbolic logic, assuming our intended domain of discourse is the integers, we would express this theorem using the universal quantifier:

.. math::

   \forall  a, b \; b \ne 0 \to \neg (a^2 = 2 b^2). 

Notice that we have kept the conventional mathematical notation :math:`b \ne 0` to say that :math:`b` is not equal to 0, but we can think of this as an abbreviation for :math:`\neg (b = 0)`.  How do we prove such a theorem? Informally, we would use such a pattern:

    Let :math:`a` and :math:`b` be arbitrary integers, suppose :math:`b \ne 0`, and suppose :math:`a^2 = 2 b^2`.

    ...

    Contradiction.

What we are really doing is proving that the universal statement holds, by showing that it holds of "arbitrary" values :math:`a` and :math:`b`. In natural deduction, the proof would look something like this:

.. raw:: html

   <img src="_static/first_order_logic.3.png">

.. raw:: latex

   \begin{center}
   \AXM{}
   \RLM{1}
   \UIM{b \ne 0}
   \noLine
   \UIM{\vdots}
   \AXM{}
   \RLM{2}
   \UIM{a^2 = 2 \times b^2}
   \noLine
   \UIM{\vdots}
   \noLine
   \BIM{\bot}
   \RLM{2}
   \UIM{\neg (a^2 = 2 \times b^2)}
   \RLM{1}
   \UIM{b \ne 0 \to \neg (a^2 = 2 \times b^2)}
   \UIM{\forall b \; (b \ne 0 \to \neg (a^2 = 2 \times b^2))}
   \UIM{\forall a \; \forall b \; (b \ne 0 \to \neg (a^2 = 2 \times b^2))}
   \DP
   \end{center}

Notice that after the hypotheses are canceled, we have proved :math:`b \ne 0 \to \neg (a^2 = 2 \times b^2)` without making any assumptions about :math:`a` and :math:`b`; at this stage in the proof, they are "arbitrary," justifying the application of the universal quantifiers in the next two rules.

This example motivates the following rule in natural deduction:

.. raw:: html

   <img src="_static/first_order_logic.4.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{A(x)}
   \UIM{\forall x \; A(x)}
   \end{prooftree}

provided :math:`x` is not free in any uncanceled hypothesis. Here :math:`A(x)` stands for any formula that (potentially) mentions :math:`x`. Also remember that if :math:`y` is any "fresh" variable that does not occur in :math:`A`, we are thinking of :math:`\forall x \; A(x)` as being the same as :math:`\forall y \; A(y)`.

What about the elimination rule? Suppose we know that every number is even or odd. Then, in an ordinary proof, we are free to assert ":math:`a` is even or :math:`a` is odd," or ":math:`a^2` is even or :math:`a^2` is odd." In terms of symbolic logic, this amounts to the following inference: from :math:`\forall x \; (\mathit{even}(x) \vee \mathit{odd}(x))`, we can conclude :math:`\mathit{even}(t) \vee \mathit{odd}(t)` for any term :math:`t`. This motivates the elimination rule for the universal quantifier:

.. raw:: html

   <img src="_static/first_order_logic.5.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{\forall x A(x)}
   \UIM{A(t)}
   \end{prooftree}

where :math:`t` is an arbitrary term.

In a sense, this feels like the elimination rule for implication; we might read the hypothesis as saying "if :math:`x` is any thing, then :math:`x` is even or odd." The conclusion is obtained by applying it to the fact that :math:`n` is a thing. Note that, in general, we could replace :math:`n` by any *term* in the language, like :math:`n (m + 5) +2`. Similarly, the introduction rule feels like the introduction rule for implication. If we want to show that everything has a certain property, we temporarily let :math:`x` denote an arbitrary thing, and then show that it has the relevant property.

The Existential Quantifier
--------------------------

Dual to the universal quantifier is the existential quantifier, :math:`\exists`, which is used to express assertions such as "some number is even," or, "between any two even numbers there is an odd number."

The following statements about the natural numbers assert the existence of some natural number:

-  There exists an odd composite number. (Remember that a natural number is *composite* if it is greater than 1 and not prime.)
-  Every natural number greater than one has a prime divisor.
-  For every :math:`n`, if :math:`n` has a prime divisor smaller than :math:`n`, then :math:`n` is composite.

These statements can be expressed in first-order logic using the existential quantifier as follows:

-  :math:`\exists n\;  (\mathit{odd}(n) \wedge \mathit{composite}(n))`
-  :math:`\forall n \; (n > 1 \to \exists p \; (\mathit{prime}(p) \wedge p \mid n))`
-  :math:`\forall n \; ((\exists p \; (p \mid n \wedge \mathit{prime}(p) \wedge p < n)) \to \mathit{composite}(n))`

After we write :math:`\exists n`, the variable :math:`n` is bound in the formula, just as for the universal quantifier. So the formulas :math:`\exists n \; \mathit{composite}(n)` and :math:`\exists m \; \mathit{composite}(m)` are considered the same.

How do we prove such existential statements? Suppose we want to prove that there exists an odd composite number. To do this, we just present a candidate, and show that the candidate satisfies the required properties. For example, we could choose 15, and then show that 15 is odd and that 15 is composite. Of course, there's nothing special about 15, and we could have proven it also using a different number, like 9 or 35. The choice of candidate does not matter, as long as it has the required property.

In a natural deduction proof this would look like this:

.. raw:: html

   <img src="_static/first_order_logic.6.png">

.. raw:: latex

   \begin{center}
   \AXM{\vdots}
   \noLine
   \UIM{\mathit{odd}(15)\wedge\mathit{composite}(15)}
   \UIM{\exists n(\mathit{odd}(n)\wedge\mathit{composite}(n))}
   \DP
   \end{center}

This illustrates the introduction rule for the existential quantifier:

.. raw:: html

   <img src="_static/first_order_logic.7.png">

.. raw:: latex

   \begin{center}
   \AXM{A(t)}
   \UIM{\exists x A(x)}
   \DP
   \end{center}

where :math:`t` is any term. So to prove an existential formula, we just have to give one particular term for which we can prove that formula. Such term is called a *witness* for the formula.

What about the elimination rule? Suppose that we know that :math:`n` is some natural number and we know that there exists a prime :math:`p` such that :math:`p < n` and :math:`p \mid n`. How can we use this to prove that :math:`n` is composite? We can reason as follows:

    Let :math:`p` be any prime such that :math:`p < n` and :math:`p \mid n`.

    ...

    Therefore, :math:`n` is composite.

First, we assume that there is some :math:`p` which satisfies the properties :math:`p` is prime, :math:`p < n` and :math:`p \mid n`, and then we reason about that :math:`p`. As with case-based reasoning using "or," the assumption is only temporary: if we can show that :math:`n` is composite from that assumption, that we have essentially shown that :math:`n` is composite assuming the existence of such a :math:`p`. Notice that in this pattern of reasoning, :math:`p` should be "arbitrary." In other words, we should not have assumed anything about :math:`p` beforehand, we should not make any additional assumptions about :math:`p` along the way, and the conclusion should not mention :math:`p`. Only then does it makes sense to say that the conclusion follows from the "mere" existence of a :math:`p` with the assumed properties.

In natural deduction, the elimination rule is expressed as follows:

.. raw:: html

   <img src="_static/first_order_logic.8.png">

.. raw:: latex

   \begin{prooftree}
   \AXM{\exists x A(x)}
   \AXM{}
   \RLM{1}
   \UIM{A(y)}
   \noLine
   \UIM{\vdots}
   \noLine
   \UIM{B}
   \RLM{1}
   \BIM{B}
   \end{prooftree}

Here we require that :math:`y` is not free in :math:`B`, and that the only uncanceled hypotheses where :math:`y` occurs freely are the hypotheses :math:`A(y)` that are canceled when you apply this rule. Formally, this is what it means to say that :math:`y` is "arbitrary." As was the case for or elimination and implication introduction, you can use the hypothesis :math:`A(y)` multiple times in the proof of :math:`B`, and cancel all of them at once.

Intuitively, the rule says that you can prove :math:`B` from the assumption :math:`\exists x A(x)` by assuming :math:`A(y)` for a fresh variable :math:`y`, and concluding, in any number of steps, that :math:`B` follows. You should compare this rule to the rule for or elimination, which is somewhat analogous. In the following example, we show that if :math:`A(x)` always implies :math:`\neg B(x)`, then there cannot be an :math:`x` for which both :math:`A(x)` and :math:`B(x)` holds.

.. _relativization_and_sorts:

Relativization and Sorts
------------------------

In first-order logic as we have presented it, there is one intended "universe" of objects of discourse, and the universal and existential quantifiers range over that universe. For example, we could design a language to talk about people living in a certain town, with a relation :math:`\mathit{loves}(x, y)` to express that :math:`x` loves :math:`y`. In such a language, we might express the statement that "everyone loves someone" by writing :math:`\forall x \; \exists y \; \mathit{loves}(x, y)`.

You should keep in mind that, at this stage, :math:`\mathit{loves}` is just a symbol. We have designed the language with a certain interpretation in mind, but one could also interpret the language as making statements about the natural numbers, where :math:`\mathit{loves}(x, y)` means that :math:`x` is less than or equal to :math:`y`. In that interpretation, the sentence

.. math::

   \forall {x, y, z} \; (\mathit{loves}(x, y) \wedge \mathit{loves}(y, z) \to \mathit{loves}(x, z))

is true, though in the original interpretation it makes an implausible claim about the nature of love triangles. In :numref:`Chapter %s <semantics_of_first_order_logic>`, we will spell out the notion that the deductive rules of first-order logic enable us to determine the statements that are true in *all* interpretations, just as the rules of propositional logic enable us to determine the statements that are true under all truth assignments.

Returning to the original example, suppose we want to represent the statement that, in our town, all the women are strong and all the men are good looking. We could do that with the following two sentences:

-  :math:`\forall x \; (\mathit{woman}(x) \to \mathit{strong}(x))`
-  :math:`\forall x \; (\mathit{man}(x) \to \mathit{good{\mathord{\mbox{-}}}looking}(x))`

These are instances of *relativization*. The universal quantifier ranges over all the people in the town, but this device gives us a way of using implication to restrict the scope of our statements to men and women, respectively. The trick also comes into play when we render "every prime number greater than two is odd":

.. math::

   \forall x \; (\mathit{prime}(x) \wedge x > 2 \to \mathit{odd}(x)).

We could also read this more literally as saying "for every number :math:`x`, if :math:`x` is prime and :math:`x` is greater than to 2, then :math:`x` is odd," but it is natural to read it as a restricted quantifier.

It is also possible to relativize the existential quantifier to say things like "some woman is strong" and "some man is good-looking." These are expressed as follows:

-  :math:`\exists x \; (\mathit{woman}(x) \wedge \mathit{strong}(x))`
-  :math:`\exists x \; (\mathit{man}(x) \wedge \mathit{good\mathord{\mbox{-}}looking}(x))`

Notice that although we used implication to relativize the universal quantifier, here we need to use conjunction instead of implication. The expression :math:`\exists x \; (\mathit{woman}(x) \to \mathit{strong}(x))` says that there is something with the property that if it is a woman, then it is strong. Classically this is equivalent to saying that there is something which is either not a woman or is strong, which is a funny thing to say.

Now, suppose we are studying geometry, and we want to express the fact that given any two distinct points :math:`p` and :math:`q` and any two lines :math:`L` and :math:`M`, if :math:`L` and :math:`M` both pass through :math:`p` and :math:`q`, then they have to be the same. (In other words, there is at most one line between two distinct points.) One option is to design a first-order logic where the intended universe is big enough to include both points and lines, and use relativization:

.. math::

   \forall {p, q, L, M} (\mathit{point}(p) \wedge \mathit{point}(q) \wedge
   \mathit{line}(L) \wedge \mathit{line}(M) \\
   \wedge \mathit{on}(p,L) \wedge \mathit{on}(q,L) \wedge \mathit{on}(p,M) \wedge
   \mathit{on}(q,M) \to L = M)

But dealing with such predicates is tedious, and there is a mild extension of first-order logic, called *many-sorted first-order logic*, which builds in some of the bookkeeping. In many-sorted logic, one can have different sorts of objects --- such as points and lines --- and a separate stock of variables and quantifiers ranging over each. Moreover, the specification of function symbols and predicate symbols indicates what sorts of arguments they expect, and, in the case of function symbols, what sort of argument they return. For example, we might choose to have a sort with variables :math:`p, q, r, \ldots` ranging over points, a sort with variables :math:`L, M, N, \ldots` ranging over lines, and a relation :math:`\mathit{on}(p, L)` relating the two. Then the assertion above is rendered more simply as follows:

.. math::

   \forall {p, q, L, M} \; (\mathit{on}(p,L) \wedge \mathit{on}(q,L) \wedge \mathit{on}(p,M) \wedge \mathit{on}(q,M) \to L = M)

Equality
--------

In symbolic logic, we use the expression :math:`s = t` to express the fact that :math:`s` and :math:`t` are "equal" or "identical." The equality symbol is meant to model what we mean when we say, for example, "Alice's brother is the victim," or "2 + 2 = 4." We are asserting that two different descriptions refer to the same object. Because the notion of identity can be applied to virtually any domain of objects, it is viewed as falling under the province of logic.

Talk of "equality" or "identity" raises messy philosophical questions, however. Am I the same person I was three days ago? Are the two copies of *Huckleberry Finn* sitting on my shelf the same book, or two different books? Using symbolic logic to model identity presupposes that we have in mind a certain way of carving up and interpreting the world. We assume that our terms refer to distinct entities, and writing :math:`s = t` asserts that the two expressions refer to the same thing. Axiomatically, we assume that equality satisfies the following three properties:

-  *reflexivity*: :math:`t = t`, for any term :math:`t`
-  *symmetry*: if :math:`s = t`, then :math:`t = s`
-  *transitivity*: if :math:`r = s` and :math:`s = t`, then :math:`r = t`

These properties are not enough to characterize equality, however. If two expressions denote the same thing, then we should be able to substitute one for any other in any expression. It is convenient to adopt the following convention: if :math:`r` is any term, we may write :math:`r(x)` to indicate that the variable :math:`x` may occur in :math:`r`. Then, if :math:`s` is another term, we can thereafter write :math:`r(s)` to denote the result of replacing :math:`s` for :math:`x` in :math:`r`. The substitution rule for terms thus reads as follows: if :math:`s = t`, then :math:`r(s) = r(t)`.

We already adopted a similar convention for formulas: if we introduce a formula as :math:`A(x)`, then :math:`A(t)` denotes the result of substituting :math:`t` for :math:`x` in :math:`A`. With this in mind, we can write the rules for equality as follows:

.. raw:: html

   <img src="_static/first_order_logic.10.png">

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

In the next chapter, you will learn how to use them.

Using equality, we can define even more quantifiers.

-  We can express "there are at least two elements :math:`x` such that :math:`A(x)` holds" as :math:`\exists x \; \exists y \; (x \neq y \wedge A(x) \wedge A(y))`.

-  We can express "there are at most two elements :math:`x` such that :math:`A(x)` holds" as :math:`\forall x \; \forall y \; \forall z \; (A(x) \wedge A(y) \wedge A(z) \to x = y \vee y = z \vee x = z)`. This states that if we have three elements :math:`a` for which :math:`A(a)` holds, then two of them must be equal.

-  We can express "there are exactly two elements :math:`x` such that :math:`A(x)` holds" as the conjunction of the above two statements.

As an exercise, write out in first order logic the statements that there are at least, at most, and exactly three elements :math:`x` such that :math:`A(x)` holds.

In logic, the expression :math:`\exists!x \; A(x)` is used to express the fact that there is a *unique* :math:`x` satisfying :math:`A(x)`, which is to say, there is exactly one such :math:`x`. As above, this can be expressed as follows:

.. math::

   \exists x \; A(x) \wedge \forall y \; \forall {y'} \; (A(y) \wedge A(y') \to y = y')

The first conjunct says that there is at least one object satisfying :math:`A`, and the second conjunct says that there is at most one. The same thing can be expressed more concisely as follows:

.. math::

   \exists x \; (A(x) \wedge \forall y \; (A(y) \to y = x))

You should think about why this second expression works. In the next chapter we will see that, using the rules of natural deduction, we can prove that these two expressions are equivalent.

Exercises
---------

#. A *perfect number* is a number that is equal to the sum of its proper divisors, that is, the numbers that divide it, other than itself. For example, 6 is perfect, because :math:`6 = 1 + 2 + 3`.

   Using a language with variables ranging over the natural numbers and suitable functions and predicates, write down first-order sentences asserting the following. Use a predicate :math:`\mathit{perfect}` to express that a number is perfect.

   a. 28 is perfect.

   b. There are no perfect numbers between 100 and 200.

   c. There are (at least) two perfect numbers between 200 and 10,000. (Express this by saying that there are perfect numbers :math:`x` and :math:`y` between 200 and 10,000, with the property that :math:`x \neq y`.)

   d. Every perfect number is even.

   e. For every number, there is a perfect number that is larger than it. (This is one way to express the statement that there are infinitely many perfect numbers.)

   Here, the phrase "between :math:`a` and :math:`b`" is meant to include :math:`a` and :math:`b`.

   By the way, we do not know whether the last two statements are true. They are open questions.

#. Using a language with variables ranging over people, and predicates :math:`\mathit{trusts}(x,y)`, :math:`\mathit{politician}(x)`, :math:`\mathit{knows}(x, y)`, and :math:`\mathit{related\mathord{\mbox{-}}to}(x, y)`, and :math:`\mathit{rich}(x)`, write down first-order sentences asserting the following:

   a. Nobody trusts a politician.

   b. Anyone who trusts a politician is crazy.

   c. Everyone knows someone who is related to a politician.

   d. Everyone who is rich is either a politician or knows a politician.

   In each case, some interpretation may be involved. Notice that writing down a logical expression is one way of helping to clarify the meaning.
