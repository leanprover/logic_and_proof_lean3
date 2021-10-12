.. _semantics_of_first_order_logic:

Semantics of First Order Logic
==============================

In :numref:`Chapter %s <semantics_of_propositional_logic>`, we emphasized a distinction between the *syntax* and the *semantics* of propositional logic. Syntactic questions have to do with the formal structure of formulas and the conditions under which different types of formulas can be derived. Semantic questions, on the other hand, concern the *truth* of a formula relative to some truth assignment.

As you might expect, we can make a similar distinction in the setting of first order logic. The previous two chapters have focused on syntax, but some semantic ideas have slipped in. Recall the running example with domain of interest :math:`{\mathbb N}`, constant symbols 0, 1, 2, 3, function symbols :math:`\mathit{add}` and :math:`\mathit{mul}`, and predicate symbols :math:`\mathit{even}, \mathit{prime}, \mathit{equals}, \mathit{le}`, etc. We know that the sentence :math:`\forall y \; \mathit{le}(0, y)` is true in this example, if :math:`\mathit{le}` is interpreted as the less-than-or-equal-to relation on the natural numbers. But if we consider the domain :math:`{\mathbb Z}` instead of :math:`{\mathbb N}`, that same formula becomes false. The sentence :math:`\forall y \; \mathit{lt}(0,y)` is also false if we consider the domain :math:`{\mathbb N}`, but (somewhat perversely) interpret the predicate :math:`\mathit{lt}(x, y)` as the relation ":math:`x` is greater than :math:`y`" on the natural numbers.

This indicates that the truth or falsity or a first order sentence can depend on how we interpret the quantifiers and basic relations of the language. But some formulas are true under any interpretation: for instance, :math:`\forall y \; (\mathit{le}(0, y) \to \mathit{le}(0, y))` is true under all the interpretations considered in the last paragraph, and, indeed, under any interpretation we choose. A sentence like this is said to be *valid*; this is the analogue of a tautology in propositional logic, which is true under every possible truth assignment.

We can broaden the analogy: a "model" in first order logic is the analogue of a truth assignment in propositional logic. In the propositional case, choosing a truth assignment allowed us to assign truth values to all formulas of the language; now, choosing a model will allow us to assign truth values to all sentences of a first order language. The aim of the next section is to make this notion more precise.

Interpretations
---------------

The symbols of the language in our running example---0, 1, :math:`\mathit{add}`, :math:`\mathit{prime}`, and so on---have very suggestive names. When we interpret sentences of this language over the domain :math:`{\mathbb N}`, for example, it is clear for which elements of the domain :math:`\mathit{prime}` "should" be true, and for which it "should" be false. But let us consider a first order language that has only two unary predicate symbols :math:`\mathit{fancy}` and :math:`\mathit{tall}`. If we take our domain to be :math:`{\mathbb N}`, is the sentence :math:`\forall x \; (\mathit{fancy}(x) \to \mathit{tall}(x))` true or false?

The answer, of course, is that we don't have enough information to say. There's no obvious meaning to the predicates :math:`\mathit{fancy}` or :math:`\mathit{tall}`, at least not when we apply them to natural numbers. To make sense of the sentence, we need to know which numbers are fancy and which ones are tall. Perhaps multiples of 10 are fancy, and even numbers are tall; in this case, the formula is true, since every multiple of 10 is even. Perhaps prime numbers are fancy and odd numbers are tall; then the formula is false, since 2 is fancy but not tall.

We call each of these descriptions an *interpretation* of the predicate symbols :math:`\mathit{fancy}` and :math:`\mathit{tall}` in the domain :math:`{\mathbb N}`. Formally, an interpretation of a unary predicate :math:`P` in a domain :math:`D` is the set of elements of :math:`D` for which :math:`P` is true. For an example, the standard interpretation of :math:`\mathit{prime}` in :math:`{\mathbb N}` that we used above was just the set of prime natural numbers.

We can interpret constant, function, and relation symbols in a similar way. An interpretation of constant symbol :math:`c` in domain :math:`D` is an element of :math:`D`. An interpretation of a function symbol :math:`f` with arity :math:`n` is a function that maps :math:`n` elements of :math:`D` to another element of :math:`D`. An interpretation of a relation symbol :math:`R` with arity :math:`n` is the set of :math:`n` tuples of elements of :math:`D` for which :math:`R` is true.

It is important to emphasize the difference between a syntactic predicate symbol (or function symbol, or constant symbol) and the semantic predicate (or function, or object) to which it is interpreted. The former is a symbol, relates to other symbols, and has no meaning on its own until we specify an interpretation. Strictly speaking, it makes no sense to write :math:`\mathit{prime}(3)`, where :math:`\mathit{prime}` is a predicate symbol and 3 is a natural number, since the argument to :math:`\mathit{prime}` is supposed to be a syntactic term. Sometimes we may obscure this distinction, as above when we specified a language with constant symbols 0, 1, and 2. But there is still a fundamental distinction between the objects of the domain and the symbols we use to represent them.

Sometimes, when we interpret a language in a particular domain, it is useful to implicitly introduce new constant symbols into the language to denote elements of this domain. Specifically, for each element :math:`a` of the domain, we introduce a constant symbol :math:`\bar a`, which is interpreted as :math:`a`. Then the expression :math:`\mathit{prime}(\bar 3)` does make sense. Interpreting the predicate symbol :math:`\mathit{prime}` in the natural way, this expression will evaluate to true. We think of :math:`\bar 3` as a linguistic "name" that represents the natural number 3, in the same way that the phrase "Aristotle" is a name that represents the ancient Greek philosopher.

Truth in a Model
----------------

Fix a first-order language. Suppose we have chosen a domain :math:`D` in which to interpret the language, along with an interpretation in :math:`D` of each of the symbols of that language. We will call this structure---the domain :math:`D`, paired with the interpretation---a *model* for the language. A model for a first-order language is directly analogous to a truth assignment for propositional logic, because it provides all the information we need to determine the truth value of each sentence in the language.

The procedure for evaluating the truth of a sentence based on a model works the way you think it should, but the formal description is subtle. Recall the difference between *terms* and *assertions* that we made earlier in Chapter 4. Terms, like :math:`a`, :math:`x + y`, or :math:`f(c)`, are meant to represent objects. A term does not have a truth value, since (for example) it makes no sense to ask whether 3 is true or false. Assertions, like :math:`P(a)`, :math:`R(x, f(y))`, or :math:`a + b > a \wedge \mathit{prime}(c)`, apply predicate or relation symbols to terms to produce statements that could be true or false.

The interpretation of a term in a model is an element of the domain of that model. The model directly specifies how to interpret constant symbols. To interpret a term :math:`f(t)` created by applying a function symbol to another term, we interpret the term :math:`t`, and then apply the interpretation of :math:`f` to this term. (This process makes sense, since the interpretation of :math:`f` is a function on the domain.) This generalizes to functions of higher arity in the obvious way. We will not yet interpret terms that include free variables like :math:`x` and :math:`y`, since these terms do not pick out unique elements of the domain. (The variable :math:`x` could potentially refer to any object.)

For example, suppose we have a language with two constant symbols, :math:`a` and :math:`b`, a unary function symbol :math:`f`, and a binary function symbol :math:`g`. Let :math:`{\mathcal M}` be the model with domain :math:`{\mathbb N}`, where :math:`a` and :math:`b` are interpreted as :math:`3` and :math:`5`, respectively, :math:`f(x)` is interpreted as the function which maps any natural number :math:`n` to :math:`n^2`, and :math:`g` is the addition function. Then the term :math:`g(f(a),b)` denotes the natural number :math:`3^2+5 = 14`.

Similarly, the interpretation of an assertion is a value :math:`\mathbf{T}` or :math:`\mathbf{F}`. For the sake of brevity, we will introduce new notation here: if :math:`A` is an assertion and :math:`{\mathcal M}` is a model of the language of :math:`A`, we write :math:`{\mathcal M} \models A` to mean that :math:`A` evaluates to :math:`\mathbf{T}` in :math:`{\mathcal M}`, and :math:`{\mathcal M} \not\models A` to mean that :math:`A` evaluates to :math:`\mathbf{F}`. (You can read the symbol :math:`\models` as "models" or "satisfies" or "validates.")

To interpret a predicate or relation applied to some terms, we first interpret the terms as objects in the domain, and then see if the interpretation of the relation symbol is true of those objects. To continue with the example, suppose our language also has a relation symbol :math:`\mathit{R}`, and we extend :math:`{\mathcal M}` to interpret :math:`R` as the greater-than-or-equal-to relation. Then we have :math:`{\mathcal M} \not \models R(a, b)`, since 3 is not greater than 5, but :math:`{\mathcal M} \models R(g(f(a),b),b)`, since 14 is greater than 5.

Interpreting expressions using the logical connectives :math:`\wedge`, :math:`\vee`, :math:`\to`, and :math:`\neg` works exactly as it did in the propositional setting. :math:`{\mathcal M} \models A \wedge B` exactly when :math:`{\mathcal M} \models A` and :math:`{\mathcal M} \models B`, and so on.

We still need to explain how to interpret existential and universal expressions. We saw that :math:`\exists x \; A` intuitively meant that there was *some* element of the domain that would make :math:`A` true, when we "replaced" the variable :math:`x` with that element. To make this a bit more precise, we say that :math:`{\mathcal M} \models \exists x A` exactly when there is an element :math:`a` in the domain of :math:`{\mathcal M}` such that, when we interpret :math:`x` as :math:`a`, then :math:`{\mathcal M} \models A`. To continue the example above, we have :math:`{\mathcal M} \models \exists x \; (R(x, b))`, since when we interpret :math:`x` as 6 we have :math:`{\mathcal M} \models R(x, b)`.

More concisely, we can say that :math:`{\mathcal M} \models \exists x \; A` when there is an :math:`a` in the domain of :math:`{\mathcal M}` such that :math:`{\mathcal M} \models A[\bar a / x]`. The notation :math:`A[\bar a / x]` indicates that every occurrence of :math:`x` in :math:`A` has been replaced by the symbol :math:`\bar a`.

Finally, remember, :math:`\forall x \; A` means that :math:`A` is true for all possible values of :math:`x`. We make this precise by saying that :math:`{\mathcal M} \models \forall x \; A` exactly when for every element :math:`a` in the domain of :math:`{\mathcal M}`, interpreting :math:`x` as :math:`a` gives that :math:`{\mathcal M} \models A`. Alternatively, we can say that :math:`{\mathcal M} \models \forall x \; A` when for every :math:`a` in the domain of :math:`{\mathcal M}`, we have :math:`{\mathcal M} \models A[\bar a / x]`. In our example above, :math:`{\mathcal M} \not\models \forall x \; (R(x, b))`, since when we interpret :math:`x` as 2 we do not have :math:`{\mathcal M} \models R(x, b)`.

These rules allow us to determine the truth value of any *sentence* in a model. (Remember, a sentence is a formula with no free variables.) There are some subtleties: for instance, we've implicitly assumed that our formula doesn't quantify over the same variable twice, as in :math:`\forall x \; \exists x \; A`. But for the most part, the interpretation process tells us to "read" a formula as talking directly about objects in the domain.

Examples
--------

Take a simple language with no constant symbols, one relation symbol :math:`\leq`, and one binary function symbol :math:`+`. Our model :math:`{\mathcal M}` will have domain :math:`{\mathbb N}`, and the symbols will be interpreted as the standard less-than-or-equal-to relation and addition function.

Think about the following questions before you read the answers below. Remember, our domain is :math:`{\mathbb N}`, not :math:`{\mathbb Z}` or any other number system.

#. Is it true that :math:`{\mathcal M} \models \exists x \; (x \leq x)`? What about :math:`{\mathcal M} \models \forall x \; (x \leq x)`?
#. Similarly, what about :math:`{\mathcal M} \models \exists x \; (x + x \leq x)`? :math:`{\mathcal M} \models \forall x \; (x + x \leq x)`?
#. Do the sentences :math:`\exists x \; \forall y \; (x \leq y)` and :math:`\forall x \; \exists y \; (x \leq y)` mean the same thing? Are they true or false?
#. Can you think of a formula :math:`A` in this language, with one free variable :math:`x`, such that :math:`{\mathcal M} \models \forall x \; A` but :math:`{\mathcal M} \not \models \exists x \; A`?

These questions indicate a subtle, and often tricky, interplay between the universal and existential quantifiers. Once you've thought about them a bit, read the answers:

#. Both of these statements are true. For the former, we can (for example) interpret :math:`x` as the natural number 0. Then, :math:`{\mathcal M} \models x \leq x`, so the existential is true. For the latter, pick an arbitrary natural number :math:`n`; it is still the case that when we interpret :math:`x` as :math:`n`, we have :math:`{\mathcal M} \models x \leq x`.
#. The first statement is true, since we can interpret :math:`x` as 0. The second statement, though, is false. When we interpret :math:`x` as 1 (or, in fact, as any natural number besides 0), we see that :math:`{\mathcal M} \not \models x + x \leq x`.
#. These sentences do *not* mean the same thing, although in the specified model, both are true. The first expresses that some natural number is less than or equal to every natural number. This is true: 0 is less than or equal to every natural number. The second sentence says that for every natural number, there is another natural number at least as big. Again, this is true: every natural number :math:`a` is less than or equal to :math:`a`. If we took our domain to be :math:`{\mathbb Z}` instead of :math:`{\mathbb N}`, the first sentence would be false, while the second would still be true.
#. The situation described here is impossible in our model. If :math:`{\mathcal M} \models \forall x A`, then :math:`{\mathcal M} \models A [\bar 0 / x]`, which implies that :math:`{\mathcal M} \models \exists x A`. The only time this situation can happen is when the domain of our model is empty.

Now consider a different language with constant symbol 2, predicate symbols :math:`\mathit{prime}` and :math:`\mathit{odd}`, and binary relation :math:`<`, interpreted in the natural way over domain :math:`{\mathbb N}`. The sentence :math:`\forall x \; (2 < x \wedge \mathit{prime}(x) \to \mathit{odd}(x))` expresses the fact that every prime number bigger than 2 is odd. It is an example of *relativization*, discussed in :numref:`relativization_and_sorts`. We can now see semantically how relativization works. This sentence is true in our model if, for every natural number :math:`n`, interpreting :math:`x` as :math:`n` makes the sentence true. If we interpret :math:`x` as 0, 1, or 2, or as any non-prime number, the hypothesis of the implication is false, and thus :math:`2 < x \wedge \mathit{prime}(x) \to \mathit{odd}(x)` is true. Otherwise, if we interpret :math:`x` as a prime number bigger than 2, both the hypothesis and conclusion of the implication are true, and :math:`2 < x \wedge \mathit{prime}(x) \to \mathit{odd}(x)` is again true. Thus the universal statement holds. It was an example like this that partially motivated our semantics for implication back in Chapter 3; any other choice would make relativization impossible.

For the next example, we will consider models that are given by a rectangular grid of "dots." Each dot has a color (red, blue, or green) and a size (small or large). We use the letter :math:`R` to represent a large red dot and :math:`r` to represent a small red dot, and similarly for :math:`G, g, B, b`.

The logical language we use to describe our dot world has predicates :math:`\mathit{red}`, :math:`\mathit{green}`, :math:`\mathit{blue}`, :math:`\mathit{small}` and :math:`\mathit{large}`, which are interpreted in the obvious ways. The relation :math:`\mathit{adj}(x, y)` is true if the dots referred to by :math:`x` and :math:`y` are touching, not on a diagonal. The relations :math:`\mathit{same{\mathord{\mbox{-}}}color}(x, y)`, :math:`\mathit{same{\mathord{\mbox{-}}}size}(x, y)`, :math:`\mathit{same{\mathord{\mbox{-}}}row}(x, y)`, and :math:`\mathit{same{\mathord{\mbox{-}}}column}(x, y)` are also self-explanatory. The relation :math:`\mathit{left{\mathord{\mbox{-}}}of}(x, y)` is true if the dot referred to by :math:`x` is left of the dot referred to by :math:`y`, regardless of what rows the dots are in. The interpretations of :math:`\mathit{right{\mathord{\mbox{-}}}of}`, :math:`\mathit{above}`, and :math:`\mathit{below}` are similar.

Consider the following sentences:

#. :math:`\forall x \; (\mathit{green}(x) \vee \mathit{blue}(x))`
#. :math:`\exists x, y \;  (\mathit{adj}(x, y) \wedge \mathit{green}(x) \wedge \mathit{green}(y))`
#. :math:`\exists x \; ((\exists z \; \mathit{right{\mathord{\mbox{-}}}of}(z, x)) \wedge (\forall y \; (\mathit{left{\mathord{\mbox{-}}}of}(x, y) \to \mathit{blue}(y) \vee \mathit{small}(y))))`
#. :math:`\forall x \; (\mathit{large}(x) \to \exists y \; (\mathit{small}(y) \wedge \mathit{adj}(x, y)))`
#. :math:`\forall x \; (\mathit{green}(x) \to \exists y \; (\mathit{same{\mathord{\mbox{-}}}row}(x, y) \wedge \mathit{blue}(y)))`
#. :math:`\forall x, y \; (\mathit{same{\mathord{\mbox{-}}}row}(x, y) \wedge \mathit{same{\mathord{\mbox{-}}}column}(x, y) \to x = y)`
#. :math:`\exists x \; \forall y \; (\mathit{adj}(x, y) \to \neg \mathit{same{\mathord{\mbox{-}}}size}(x, y))`
#. :math:`\forall x \; \exists y \; (\mathit{adj}(x, y) \wedge \mathit{same{\mathord{\mbox{-}}}color}(x, y))`
#. :math:`\exists y \; \forall x \; (\mathit{adj}(x, y) \wedge \mathit{same{\mathord{\mbox{-}}}color}(x, y))`
#. :math:`\exists x \; (\mathit{blue}(x) \wedge \exists y \; (\mathit{green}(y) \wedge \mathit{above}(x, y)))`

We can evaluate them in this particular model:

+---+---+---+---+
| R | r | g | b |
+---+---+---+---+
| R | b | G | b |
+---+---+---+---+
| B | B | B | b |
+---+---+---+---+

There they have the following truth values:

#. false
#. true
#. true
#. false
#. true
#. true
#. false
#. true
#. false
#. true

For each sentence, see if you can find a model that makes the sentence true, and another that makes it false. For an extra challenge, try to make all of the sentences true simultaneously. Notice that you can use any number of rows and any number of columns.

Validity and Logical Consequence
--------------------------------

We have seen that whether a formula is true or false often depends on the model we choose. Some formulas, though, are true in every possible model. An example we saw earlier was :math:`\forall y \; (\mathit{le}(0, y) \to \mathit{le}(0, y))`. Why is this sentence valid? Suppose :math:`{\mathcal M}` is an arbitrary model of the language, and suppose :math:`a` is an arbitrary element of the domain of :math:`{\mathcal M}`. Either :math:`{\mathcal M} \models \mathit{le}(0, \bar a)` or :math:`{\mathcal M} \models \neg \mathit{le}(0, \bar a)`. In either case, the propositional semantics of implication guarantee that :math:`{\mathcal M} \models \mathit{le}(0, \bar a) \to \mathit{le}(0, \bar a)`. We often write :math:`\models A` to mean that :math:`A` is valid.

In the propositional setting, there is an easy method to figure out if a formula is a tautology or not. Writing the truth table and checking for any rows ending with :math:`\mathbf{F}` is algorithmic, and we know from the beginning exactly how large the truth table will be. Unfortunately, we cannot do the same for first-order formulas. Any language has infinitely many models, so a "first-order" truth table would be infinitely long. To make matters worse, even checking whether a formula is true in a single model can be a non-algorithmic task. To decide whether a universal statement like :math:`\forall x \; P(x)` is true in a model with an infinite domain, we might have to check whether :math:`P` is true of infinitely many elements.

This is not to say that we can *never* figure out if a first-order sentence is a tautology. For example, we have argued that :math:`\forall y \; (\mathit{lt}(0, y) \to \mathit{lt}(0, y))` was one. It is just a more difficult question than for propositional logic.

As was the case with propositional logic, we can extend the notion of validity to a notion of logical consequence. Fix a first-order language, :math:`L`. Suppose :math:`\Gamma` is a set of sentences in :math:`L`, and :math:`A` is a sentence of :math:`L`. We will say that :math:`A` *is a logical consequence of* :math:`\Gamma` if every model of :math:`\Gamma` is a model of :math:`A`. This is one way of spelling out that :math:`A` is a "necessary consequence" of :math:`A`: under any interpretation, if the hypotheses in :math:`\Gamma` come out true, :math:`A` is true as well.

Soundness and Completeness
--------------------------

In propositional logic, we saw a close connection between the provable formulas and the tautologies---specifically, a formula is provable if and only if it is a tautology. More generally, we say that a formula :math:`A` is a logical consequence of a set of hypotheses, :math:`\Gamma`, if and only if there is a natural deduction proof of :math:`A` from :math:`\Gamma`. It turns out that the analogous statements hold for first order logic.

The "soundness" direction---the fact that if :math:`A` is provable from :math:`\Gamma` then :math:`A` is true in any model of :math:`\Gamma`---holds for reasons that are similar to the reasons it holds in the propositional case. Specifically, the proof proceeds by showing that each rule of natural deduction preserves the truth in a model.

The completeness theorem for first order logic was first proved by Kurt Gödel in his 1929 dissertation. Another, simpler proof was later provided by Leon Henkin.

----

**Theorem.** If a formula :math:`A` is a logical consequence of a set of sentences :math:`\Gamma`, then :math:`A` is provable from :math:`\Gamma`.

----

Compared to the version for propositional logic, the first order completeness theorem is harder to prove. We will not go into too much detail here, but will indicate some of the main ideas. A set of sentences is said to be *consistent* if you cannot prove a contradiction from those hypotheses. Most of the work in Henkin's proof is done by the following "model existence" theorem:

----

**Theorem.** Every consistent set of sentences has a model.

----

From this theorem, it is easy to deduce the completeness theorem. Suppose there is no proof of :math:`A` from :math:`\Gamma`. Then the set :math:`\Gamma \cup \{ \neg A \}` is consistent. (If we could prove :math:`\bot` from :math:`\Gamma \cup \{ \neg A \}`, then by the *reductio ad absurdum* rule we could prove :math:`A` from :math:`\Gamma`.) By the model existence theorem, that means that there is a model :math:`{\mathcal M}` of :math:`\Gamma \cup \{ \neg A \}`. But this is a model of :math:`\Gamma` that is not a model of :math:`A`, which means that :math:`A` is not a logical consequence of :math:`\Gamma`.

The proof of the model existence theorem is intricate. Somehow, from a consistent set of sentences, one has to build a model. The strategy is to build the model out of syntactic entities, in other words, to use terms in an expanded language as the elements of the domain.

The moral here is much the same as it was for propositional logic. Because we have developed our syntactic rules with a certain semantics in mind, the two exhibit different sides of the same coin: the provable sentences are exactly the ones that are true in all models, and the sentences that are provable from a set of hypotheses are exactly the ones that are true in all models of those hypotheses.

We therefore have another way to answer the question posed in the previous section. To show that a sentence is valid, there is no need to check its truth in every possible model. Rather, it suffices to produce a proof.

Exercises
---------

#. In a first-order language with a binary relation, :math:`R(x,y)`, consider the following sentences:

   -  :math:`\exists x \; \forall y \; R(x, y)`
   -  :math:`\exists y \; \forall x \; R(x, y)`
   -  :math:`\forall x,y \; (R(x,y) \wedge x \neq y \to \exists z \; (R(x,z) \wedge R(z,y) \wedge x \neq z \wedge y \neq z))`

   For each of the following structures, determine whether of each of
   those sentences is true or false.

   -  the structure :math:`(\mathbb N, \leq)`, that is, the interpretation in the natural numbers where :math:`R` is :math:`\leq`
   -  the structure :math:`(\mathbb Z, \leq)`
   -  the structure :math:`(\mathbb Q, \leq)`
   -  the structure :math:`(\mathbb N, \mid)`, that is, the interpretation in the natural numbers where :math:`R` is the "divides" relation
   -  the structure :math:`(P(\mathbb N), \subseteq)`, that is, the interpretation where variables range over sets of natural numbers,
      where :math:`R` is interpreted as the subset relation.

#. Create a 4 x 4 "dots" world that makes all of the following sentences
   true:

   -  :math:`\forall x \; (\mathit{green}(x) \vee \mathit{blue}(x))`

   -  :math:`\exists x, y \; (\mathit{adj}(x, y) \wedge \mathit{green}(x) \wedge \mathit{green}(y))`

   -  :math:`\exists x \; (\exists z \; \mathit{right{\mathord{\mbox{-}}}of}(z, x) \wedge \forall y \; (\mathit{left{\mathord{\mbox{-}}}of}(x, y) \to \mathit{blue}(y) \vee \mathit{small}(y)))`

   -  :math:`\forall x \; (\mathit{large}(x) \to \exists y \; (\mathit{small}(y) \wedge \mathit{adj}(x, y)))`

   -  :math:`\forall x \; (\mathit{green}(x) \to \exists y \; (\mathit{same{\mathord{\mbox{-}}}row}(x, y) \wedge \mathit{blue}(y)))`

   -  :math:`\forall x, y \; (\mathit{same{\mathord{\mbox{-}}}row}(x, y) \wedge \mathit{same\mathord{\mbox{-}} column}(x, y) \to x = y)`

   -  :math:`\exists x \; \forall y \; (\mathit{adj}(x, y) \to \neg \mathit{same{\mathord{\mbox{-}}}size}(x, y))`

   -  :math:`\forall x \; \exists y \; (\mathit{adj}(x, y) \wedge \mathit{same{\mathord{\mbox{-}}}color}(x, y))`

   -  :math:`\exists y \; \forall x \; (\mathit{adj}(x, y) \to \mathit{same{\mathord{\mbox{-}}}color}(x, y))`

   -  :math:`\exists x \; (\mathit{blue}(x) \wedge \exists y \; (\mathit{green}(y) \wedge \mathit{above}(x, y)))`

#. Fix a first-order language :math:`L`, and let :math:`A` and :math:`B` be any two sentences in :math:`L`. Remember that :math:`\vDash A` means that :math:`A` is valid. Unpacking the definitions, show that if :math:`\vDash A \wedge B`, then :math:`\vDash A` and :math:`\vDash B`.

#. Give a concrete example to show that :math:`\vDash A \vee B` does not necessarily imply :math:`\vDash A` or :math:`\vDash B`. In other words, pick a language :math:`L` and choose particular sentences :math:`A` and :math:`B` such that :math:`A \vee B` is valid but neither :math:`A` nor :math:`B` is valid.

#. Consider the three formulas :math:`\forall x \; R(x, x)`, :math:`\forall x\; \forall y \; (R (x, y) \to R (y, x))`, and :math:`\forall x \; \forall y \; \forall z \; (R(x, y) \wedge R(y, z) \to R(x, z))`.
   These sentences say that :math:`R` is reflexive, symmetric, and transitive.
   For each pair of sentences, find a model that makes those two sentences true and the third false.
   This shows that these sentences are logically independent: no one is entailed by the others.

#. Show that if a set of formulas :math:`\{\psi_1, \ldots, \psi_n\}` is semantically inconsistent, then it entails every formula :math:`\phi`.
   Does the converse also hold?

#. Give a formula :math:`\psi` such that the set :math:`\{P(c), \neg P(D), \psi \}` is consistent, and so is the set :math:`\{P(c), \neg P(D), \neg \psi \}`.

#. For each the following formulas, show whether the formula is valid, satisfiable, or unsatisfiable.

   - :math:`\exists x \; \forall y \; R (y, x) \wedge R (x, y)`
   - :math:`(\exists x \; \forall y \; R (x, y)) \to (\exists x \; \exists y \; R (x, y))`
   - :math:`(\exists x\; P (x)) \wedge (\exists x \; \neg P(x))`
