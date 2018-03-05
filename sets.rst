.. _sets:

Sets
====

We have come to a turning point in this textbook. We will henceforth abandon natural deduction, for the most part, and focus on ordinary mathematical proofs. We will continue to think about how informal mathematics can be represented in symbolic terms, and how the rules of natural deduction play out in the informal setting. But the emphasis will be on writing ordinary mathematical arguments, not designing proof trees. Lean will continue to serve as a bridge between the informal and formal realms.

In this chapter, we consider a notion that has come to play a fundamental role in mathematical reasoning, namely, that of a "set."

.. _elementary_set_theory:

Elementary Set Theory
---------------------

In a publication in the journal *Mathematische Annalen* in 1895, the German mathematician Georg Cantor presented the following
characterization of the notion of a *set* (or *Menge*, in his terminology):

    By a *set* we mean any collection M of determinate, distinct objects (called the *elements* of M) of our intuition or thought into a whole.

Since then, the notion of a set has been used to unify a wide range of abstractions and constructions. Axiomatic set theory, which we will discuss in a later chapter, provides a foundation for mathematics in which everything can be viewed as a set.

On a broad construal, *any* collection can be a set; for example, we can consider the set whose elements are Ringo Star, the number 7, and the set whose only member is the Empire State Building. With such a broad notion of set we have to be careful: Russell's paradox has us consider the set :math:`S` of all sets that are not elements of themselves, which leads to a contradiction when we ask whether :math:`S` is an element of itself. (Try it!) The axioms of set theory tell us which sets exist, and have been carefully designed to avoid paradoxical sets like that of the Russell paradox.

In practice, mathematicians are not so freewheeling in their use of sets. Typically, one fixes a domain such as the natural numbers, and consider subsets of that domain. In other words, we consider sets of numbers, sets of points, sets of lines, and so on, rather than arbitrary "sets." In this text, we will adopt this convention: when we talk about sets, we are always implicitly talking about sets of elements of some domain.

Given a set :math:`A` of objects in some domain and an object :math:`x`, we write :math:`x \in A` to say that :math:`x` is an element of :math:`A`. Cantor's characterization suggests that whenever we have some property, :math:`P`, of a domain, we can form the set of elements that have that property. This is denoted using "set-builder notation" as :math:`\{ x \mid P(x) \}`. For example, we can consider all the following sets of natural numbers:

-  :math:`\{n \mid \mbox{$n$ is even} \}`
-  :math:`\{n \mid \mbox{$n$ is prime} \}`
-  :math:`\{n \mid \mbox{$n$ is prime and greater than 2} \}`
-  :math:`\{n \mid \mbox{$n$ can be written as a sum of squares} \}`
-  :math:`\{n \mid \mbox{$n$ is equal to 1, 2, or 3}\}`

This last set is written more simply :math:`\{1, 2, 3\}`. If the domain is not clear from the context, we can specify it by writing it explicitly, for example, in the expression :math:`\{n \in \mathbb{N} \mid \text{$n$ is even} \}`.

Using set-builder notation, we can define a number of common sets and operations. The *empty set*, :math:`\emptyset`, is the set with no elements:

.. math::

   \emptyset = \{ x \mid \mbox{false} \}.

Dually, we can define the *universal set*, :math:`\mathcal U`, to be the set consisting of every element of the domain:

.. math::

   \mathcal U = \{ x \mid \mbox{true} \}.

Given two sets :math:`A` and :math:`B`, we define their *union* to be the set of elements in either one:

.. math::

   A \cup B = \{ x \mid \mbox{$x \in A$ or $x \in B$} \}.

And we define their *intersection* to be the set of elements of both:

.. math::

   A \cap B = \{ x \mid \mbox{$x \in A$ and $x \in B$} \}.

We define the *complement* of a set of :math:`A` to be the set of elements that are not in :math:`A`:

.. math::

   \overline A = \{ x \mid \mbox{$x \notin A$} \}.

We define the *set difference* of two sets :math:`A` and :math:`B` to be the set of elements in :math:`A` but not :math:`B`:

.. math::

   A \setminus B = \{ x \mid \mbox{$x \in A$ and $x \notin B$} \}.

Two sets are said to be equal if they have exactly the same elements. If :math:`A` and :math:`B` are sets, :math:`A` is said to be a *subset* of :math:`B`, written :math:`A \subseteq B`, if every element of :math:`A` is an element of :math:`B`. Notice that :math:`A` is equal to :math:`B` if and only if :math:`A` is a subset of :math:`B` and :math:`B` is a subset of :math:`A`.

Notice also that just everything we have said about sets so far is readily representable in symbolic logic. We can render the defining properties of the basic sets and constructors as follows:

- :math:`\forall x \; (x \in \emptyset \leftrightarrow \bot)`
- :math:`\forall x \; (x \in \mathcal U \leftrightarrow \top)`
- :math:`\forall x \; (x \in A \cup B \leftrightarrow x \in A \vee x \in B)`
- :math:`\forall x \; (x \in A \cap B \leftrightarrow x \in A \wedge x \in B)`
- :math:`\forall x \; (x \in \overline A \leftrightarrow x \notin A)`
- :math:`\forall x \; (x \in A \setminus B \leftrightarrow  x \in A \wedge x \notin B)`

The assertion that :math:`A` is a subset of :math:`B` can be written :math:`\forall x \; (x \in A \to x \in B)`, and the assertion that :math:`A` is equal to be can be written :math:`\forall x \; (x \in A \leftrightarrow  x \in B)`. These are all *universal* statements, that is, statements with universal quantifiers in front, followed by basic assertions and propositional connectives. What this means is that reasoning about sets formally often amounts to using nothing more than the rules for the universal quantifier together with the rules for propositional logic.

Logicians sometimes describe ordinary mathematical proofs as *informal*, in contrast to the *formal proofs* in natural deduction. When writing informal proofs, the focus is on readability. Here is an example.

----

**Theorem.** Let :math:`A`, :math:`B`, and :math:`C` denote sets of elements of some domain. Then :math:`A \cap (B \cup C) = (A \cap B) \cup (A \cap C)`.

**Proof.** Let :math:`x` be arbitrary, and suppose :math:`x` is in :math:`A \cap (B \cup C)`. Then :math:`x` is in :math:`A`, and either :math:`x` is in :math:`B` or :math:`x` is in :math:`C`. In the first case, :math:`x` is in :math:`A` and :math:`B`, and hence in :math:`A \cap B`. In the second case, :math:`x` is in :math:`A` and :math:`C`, and hence :math:`A \cap C`. Either way, we have that :math:`x` is in :math:`(A \cap B) \cup (A \cap C)`.

Conversely, suppose :math:`x` is in :math:`(A \cap B) \cup (A \cap C)`. There are now two cases.

First, suppose :math:`x` is in :math:`A \cap B`. Then :math:`x` is in both :math:`A` and :math:`B`. Since :math:`x` is in :math:`B`, it is also in :math:`B \cup C`, and so :math:`x` is in :math:`A \cap (B \cup C)`.

The second case is similar: suppose :math:`x` is in :math:`A \cap C`. Then :math:`x` is in both :math:`A` and :math:`C`, and so also in :math:`B \cup C`. Hence, in this case also, :math:`x` is in :math:`A \cap (B \cup C)`, as required.

----

Notice that this proof does not look anything like a proof in symbolic logic. For one thing, ordinary proofs tend to favor words over symbols. Of course, mathematics uses symbols all the time, but not in place of words like "and" and "not"; you will rarely, if ever, see the symbols :math:`\wedge` and :math:`\neg` in a mathematics textbook, unless it is a textbook specifically about logic.

Similarly, the structure of an informal proof is conveyed with ordinary paragraphs and punctuation. Don't rely on pictorial diagrams, line breaks, and indentation to convey the structure of a proof. Rather, you should rely on literary devices like signposting and foreshadowing. It is often helpful to present an outline of a proof or the key ideas before delving into the details, and the introductory sentence of a paragraph can help guide a reader's expectations, just as it does in an expository essay.

Nonetheless, you should be able to see elements of natural deduction implicitly in the proof above. In formal terms, the theorem is equivalent to the assertion

.. math::

   \forall x \; (x \in A \cap (B \cup C) \leftrightarrow  x \in (A \cap B) \cup (A \cap C)),

and the proof proceeds accordingly. The phrase "let :math:`x` be arbitrary" is code for the :math:`\forall` introduction rule, and the form of the rest of the proof is a :math:`\leftrightarrow` introduction. Saying that :math:`x` is in :math:`A \cap (B \cup C)` is implicitly an "and," and the argument uses :math:`\wedge` elimination to get :math:`x \in A` and :math:`x \in B \cup C`. Saying :math:`x \in B \cup C` is implicitly an "or," and the proof then splits on cases, depending on whether :math:`x \in B` or :math:`x \in C`.

Modulo the unfolding of definition of intersection and union in terms of "and" and "or," the "only if" direction of the previous proof could be represented in natural deduction like this:

.. TODO: change!

.. raw:: html

   <img src="_static/natural_deduction_for_first_order_logic.1.png">

.. raw:: latex

   \begin{prooftree}
   \small
   \AXM{}
   \RLM{1}
   \UIM{y \in A \cap (B \cup C)}
   \UIM{y \in B \cup C}

   \AXM{}
   \RLM{1}
   \UIM{y \in A \cap (B \cup C)}
   \UIM{y \in A}
   \AXM{}
   \RLM{2}
   \UIM{y \in B}
   \BIM{y \in A \cap B}
   \UIM{y \in (A \cap B) \cup (A \cap C)}

   \AXM{}
   \RLM{1}
   \UIM{y \in A \cap (B \cup C)}
   \UIM{y \in A}
   \AXM{}
   \RLM{2}
   \UIM{y \in C}
   \BIM{y \in A \cap C}
   \UIM{y \in (A \cap B) \cup (A \cap C)}
   \RLM{2}
   \TIM{y \in (A \cap B) \cup (A \cap C)}

   \AXM{\vdots}
   \RLM{1}
   \BIM{y \in A \cap (B \cup C) \leftrightarrow  y \in (A \cap B) \cup (A \cap C)}
   \UIM{\forall x \; (x \in A \cap (B \cup C) \leftrightarrow x \in (A \cap B) \cup (A \cap C))}
   \end{prooftree}

In the next chapter, we will see that this logical structure is made manifest in Lean. But writing long proofs in natural deduction is not the most effective to communicate the mathematical ideas. So our goal here is to teach you to think in terms of natural deduction rules, but express the steps in ordinary English.

Here is another example.

----

**Theorem.** :math:`(A \setminus B) \setminus C = A \setminus (B \cup C)`.

**Proof.** Let :math:`x` be arbitrary, and suppose :math:`x` is in :math:`(A \setminus B) \setminus C`. Then :math:`x` is in :math:`A \setminus B` but not :math:`C`, and hence it is in :math:`A` but not in :math:`B` or :math:`C`. This means that :math:`x` is in :math:`A` but not :math:`B \cup C`, and so in :math:`A \setminus (B \cup C)`.

Conversely, suppose :math:`x` is in :math:`A \setminus (B \cup C)`. Then :math:`x` is in :math:`A`, but not in :math:`B \cup C`. In particular, :math:`x` is in neither :math:`B` nor :math:`C`, because otherwise it would be in :math:`B \cup C`. So :math:`x` is in :math:`A \setminus B`, and hence in :math:`(A \setminus B) \setminus C`.

----

Perhaps the biggest difference between informal proofs and formal proofs is the level of detail. Informal proofs will often skip over details that are taken to be "straightforward" or "obvious," devoting more effort to spelling out inferences that are novel of unexpected.

Writing a good proof is like writing a good essay. To convince your readers that the conclusion is correct, you have to get them to understand the argument, without overwhelming them with unnecessary details. It helps to have a specific audience in mind. Try speaking the argument aloud to friends, roommates, and family members; if their eyes glaze over, it is unreasonable to expect anonymous readers to do better.

One of the best ways to learn to write good proofs is to *read* good proofs, and pay attention to the style of writing. Pick an example of a textbook that you find especially clear and engaging, and think about what makes it so.

Natural deduction and formal verification can help you understand the components that make a proof *correct*, but you will have to develop an intuitive feel for what makes a proof easy and enjoyable to read.

Calculations with Sets
----------------------

Calculation is a central to mathematics, and mathematical proofs often involve carrying out a sequence of calculations. Indeed, a calculation can be viewed as a proof in and of itself that two expressions describe the same entity.

In high school algebra, students are often asked to prove identities like the following:

----

**Proposition.** :math:`\frac{n(n+1)}{2} + (n + 1) = \frac{(n+1)(n+2)}{2}`, for every natural number :math:`n`.

----

In some places, students are asked to write proofs like this:

----

**Proof.**

.. math::

    \frac{n(n+1)}{2} + (n + 1) & =? \frac{(n+1)(n+2)}{2} \\
    \frac{n^2+n}{2} + \frac{2n + 2}{2} & =? \frac{n^2 + 3n + 2}{2} \\
    \frac{n^2+n + 2n + 2}{2} & =? \frac{n^2 + 3n + 2}{2} \\
    \frac{n^2+3n + 2}{2} & = \frac{n^2 + 3n + 2}{2}. \\

----

Mathematicians generally cringe when they see this. *Don't do it!* It looks like an instance of forward reasoning, where we start with a complex identity and end up proving :math:`x = x`. Of course, what is really meant is that each line follows from the next. There is a way of expressing this, with the phrase "it suffices to show." The following presentation comes closer to mathematical vernacular:

----

**Proof.** We want to show

.. math::

   \frac{n(n+1)}{2} + (n + 1) = \frac{(n+1)(n+2)}{2}.

To do that, it suffices to show

.. math::

    \frac{n^2+n}{2} + \frac{2n + 2}{2} = \frac{n^2 + 3n + 2}{2}.

For that, it suffices to show

.. math::

    \frac{n^2+n + 2n + 2}{2} = \frac{n^2 + 3n + 2}{2}.

But this last equation is clearly true.

----

The narrative doesn't flow well, however. Sometimes there are good reasons to work backward in a proof, but in this case it is easy to present the proof in a more forward-directed manner. Here is one example:

----

**Proof.** Calculating on the left-hand side, we have

.. math::

    \frac{n(n+1)}{2} + (n + 1) & = \frac{n^2+n}{2} + \frac{2n + 2}{2} \\
      & = \frac{n^2+n + 2n + 2}{2} \\
      & = \frac{n^2 + 3n + 2}{2}.

On the right-hand side, we also have

.. math::

    \frac{(n+1)(n+2)}{2} = \frac{n^2 + 3n + 2}{2}.

So :math:`\frac{n(n+1)}{2} + (n + 1) = \frac{n^2 + 3n + 2}{2}`, as required.

----

Mathematicians often use the abbreviations "LHS" and "RHS" for "left-hand side" and "right-hand side," respectively, in situations like this. In fact, here we can easily write the proof as a single forward-directed calculation:

----

**Proof.**

.. math::

    \frac{n(n+1)}{2} + (n + 1) & = \frac{n^2+n}{2} + \frac{2n + 2}{2} \\
      & = \frac{n^2+n + 2n + 2}{2} \\
      & = \frac{n^2 + 3n + 2}{2} \\
      & = \frac{(n+1)(n+2)}{2}.

----

Such a proof is clear, compact, and easy to read. The main challenge to the reader is to figure out what justifies each subsequent step. Mathematicians sometimes annotate such a calculation with additional information, or add a few words of explanation in the text before and/or after. But the ideal situation is to carry out the calculation is small enough steps so that each step is straightforward, and needs to no explanation. (And, once again, what counts as "straightforward" will vary depending on who is reading the proof.)

We have said that two sets are equal if they have the same elements. In the previous section, we proved that two sets are equal by reasoning about the elements of each, but we can often be more efficient. Assuming :math:`A`, :math:`B`, and :math:`C` are subsets of some domain :math:`\mathcal U`, the following identities hold:

-  :math:`A \cup \overline A = \mathcal U`
-  :math:`A \cap \overline A = \emptyset`
-  :math:`\overline {\overline A} = A`
-  :math:`A \cup A = A`
-  :math:`A \cap A = A`
-  :math:`A \cup \emptyset = A`
-  :math:`A \cap \emptyset = \emptyset`
-  :math:`A \cup \mathcal U = \mathcal U`
-  :math:`A \cap \mathcal U = A`
-  :math:`A \cup B = B \cup A`
-  :math:`A \cap B = B \cap A`
-  :math:`(A \cup B) \cup C = A \cup (B \cup C)`
-  :math:`(A \cap B) \cap C = A \cap (B \cap C)`
-  :math:`\overline{A \cap B} = \overline A \cup \overline B`
-  :math:`\overline{A \cup B} = \overline A \cap \overline B`
-  :math:`A \cap (B \cup C) = (A \cap B) \cup (A \cap C)`
-  :math:`A \cup (B \cap C) = (A \cup B) \cap (A \cup C)`
-  :math:`A \cap (A \cup B) = A`
-  :math:`A \cup (A \cap B) = A`

This allows us to prove further identities by calculating. Here is an example.

----

**Theorem**. Let :math:`A` and :math:`B` be subsets of some domain :math:`\mathcal U`. Then :math:`(A \cap \overline B) \cup B = A \cup B`.

**Proof**.

.. math::

   (A \cap \overline B) \cup B & = (A \cup B) \cap (\overline B \cup B)
   \\
   & = (A \cup B) \cap \mathcal U \\
   & = A \cup B.

----

Here is another example.

----

**Theorem**. Let :math:`A` and :math:`B` be subsets of some domain :math:`\mathcal U`. Then :math:`(A \setminus B) \cup (B \setminus A) = (A \cup B) \setminus (A \cap B)`.

**Proof**.

.. math::

   (A \setminus B) \cup (B \setminus A) & = (A \cap \overline B) \cup (B \cap \overline A) \\
   & = ((A \cap \overline B) \cup B) \cap ((A \cap \overline B) \cup \overline A) \\
   & = ((A \cup B) \cap (\overline B \cup B)) \cap ((A \cup \overline A) \cap (\overline B \cup \overline A)) \\
   & = ((A \cup B) \cap \mathcal U) \cap (\mathcal U \cap \overline{B \cap A}) \\
   & = (A \cup B) \cap (\overline{A \cap B}) \\
   & = (A \cup B) \setminus (A \cap B).

----

Classically, you may have noticed that propositions, under logical equivalence, satisfy identities similar to sets. That is no coincidence; both are instances of *boolean algebras*. Here are the identities above translated to the language of a boolean algebra:

-  :math:`A \vee \neg A = \top`
-  :math:`A \wedge \neg A = \bot`
-  :math:`\neg \neg A = A`
-  :math:`A \vee A = A`
-  :math:`A \wedge A = A`
-  :math:`A \vee \bot = A`
-  :math:`A \wedge \bot = \bot`
-  :math:`A \vee \top = \top`
-  :math:`A \wedge \top = A`
-  :math:`A \vee B = B \vee A`
-  :math:`A \wedge B = B \wedge A`
-  :math:`(A \vee B) \vee C = A \vee (B \vee C)`
-  :math:`(A \wedge B) \wedge C = A \wedge (B \wedge C)`
-  :math:`\neg{A \wedge B} = \neg A \vee \neg B`
-  :math:`\neg{A \vee B} = \neg A \wedge \neg B`
-  :math:`A \wedge (B \vee C) = (A \wedge B) \vee (A \wedge C)`
-  :math:`A \vee (B \wedge C) = (A \vee B) \wedge (A \vee C)`
-  :math:`A \wedge (A \vee B) = A`
-  :math:`A \vee (A \wedge B) = A`

Translated to the language of boolean algebras, the first theorem above is as follows:

----

**Theorem.** Let :math:`A` and :math:`B` be elements of a boolean algebra. Then :math:`(A \wedge \neg B) \vee B = B`.

**Proof.**

.. math::

   (A \wedge \neg B) \vee B & = (A \vee B) \wedge (\neg B \vee B)
   \\
   & = (A \vee B) \wedge \top \\
   & = (A \vee B).

----

Indexed Families of Sets
------------------------

If :math:`I` is a set, we will sometimes wish to consider a *family* :math:`(A_i)_{i \in I}` of sets indexed by elements of :math:`I`. For example, we might be interested in a sequence

.. math::

   A_0, A_1, A_2, \ldots 

of sets indexed by the natural numbers. The concept is best illustrated by some examples.

- For each natural number :math:`n`, we can define the set :math:`A_n` to be the set of people alive today that are of age :math:`n`. For each age we have the corresponding set. Someone of age 20 is an element of the set :math:`A_{20}`, while a newborn baby is an element of :math:`A_0`. The set :math:`A_{200}` is empty. This family :math:`(A_n)_{n\in\mathbb{N}}` is a is a family of sets indexed by the natural numbers.

-  For every real number :math:`r` we can define :math:`B_r` to be the set of positive real numbers larger than :math:`r`, so :math:`B_r = \{x\in \mathbb{R} \mid x > r \text{ and } x > 0\}`. Then :math:`(B_r)_{r\in\mathbb{R}}` is a family of sets indexed by the real numbers.

-  For every natural number :math:`n` we can define :math:`C_n=\{k\in\mathbb{N} \mid k \text{ is a divisor of } n\}` as the set of divisors of :math:`n`.

Given a family :math:`(A_i)_{i\in I}` of sets indexed by :math:`I`, we can form its *union*:

.. math::

   \bigcup_{i \in I} A_i = \{ x \mid x \in A_i \text{ for some $i \in I$} \}.

We can also form the *intersection* of a family of sets:

.. math::

   \bigcap_{i \in I} A_i = \{ x \mid x \in A_i \text{ for every $i \in I$} \}.

So an element :math:`x` is in :math:`\bigcup_{i \in I} A_i` if and only if :math:`x` is in :math:`A_i` for *some* :math:`i` in :math:`I`, and :math:`x` is in :math:`\bigcap_{i \in I} A_i` if and only if :math:`x` is in :math:`A_i` for every :math:`i` in :math:`I`. These operations are represented in symbolic logic by the existential and the universal quantifiers. We have:

-  :math:`\forall x \; (x \in \bigcup_{i \in I} A_i \leftrightarrow \exists i \in I \; (x \in A_i))`
-  :math:`\forall x \; (x \in \bigcap_{i \in I} A_i \leftrightarrow \forall i \in I \; (x \in A_i))`

Returning to the examples above, we can compute the union and intersection of each family. For the first example, :math:`\bigcup_{n \in \mathbb{N}} A_n` is the set of all living people, and :math:`\bigcap_{n \in \mathbb{N}} A_n = \emptyset`. Also, :math:`\bigcup_{r \in \mathbb{R}} B_r = \mathbb{R}_{>0}`, the set of all positive real numbers, and :math:`\bigcap_{r \in \mathbb{R}} B_r = \emptyset`. For the last example, we have :math:`\bigcup_{n \in \mathbb{N}} C_n = \mathbb{N}` and :math:`\bigcap_{n \in \mathbb{N}} C_n = \{1\}`, since 1 is a divisor of every natural number.

Suppose that :math:`I` contains just two elements, say :math:`I=\{c, d\}`. Let :math:`(A_i)_{i\in I}` be a family of sets indexed by :math:`I`. Because :math:`I` has two elements, this family consists of just the two sets :math:`A_c` and :math:`A_d`. Then the union and intersection of this family are just the union and intersection of the two sets:

.. math::

   \bigcup_{i \in I} A_i &= A_c \cup A_d\\
   \bigcap_{i \in I} A_i &= A_c \cap A_d.

This means that the union and intersection of two sets are just a special case of the union and intersection of a family of sets.

We also have equalities for unions and intersections of families of sets. Here are a few of them:

-  :math:`A \cap \bigcup_{i \in I} B_i = \bigcup_{i \in I} (A \cap B_i)`
-  :math:`A \cup \bigcap_{i \in I} B_i = \bigcap_{i \in I} (A \cup B_i)`
-  :math:`\overline{\bigcap_{i \in I} A_i} = \bigcup_{i \in I} \overline{A_i}`
-  :math:`\overline{\bigcup_{i \in I} A_i} = \bigcap_{i \in I} \overline{A_i}`
-  :math:`\bigcup_{i \in I} \bigcup_{j \in J} A_{i,j} = \bigcup_{j \in J} \bigcup_{i \in I} A_{i,j}`
-  :math:`\bigcap_{i \in I} \bigcap_{j \in J} A_{i,j} = \bigcap_{j \in J} \bigcap_{i \in I} A_{i,j}`

In the last two lines, :math:`A_{i,j}` is indexed by two sets :math:`I` and :math:`J`. This means that for every :math:`i \in I` and :math:`j\in J` we have a set :math:`A_{i,j}`. For the first four equalities, try to figure out what the rule means if the index set :math:`I` contains two elements.

Let's prove the first identity. Notice how the logical forms of the assertions :math:`x \in A \cap \bigcup_{i \in I} B_i` and :math:`x \in \bigcup_{i \in I} (A \cap B_i)` dictate the structure of the proof.

----

**Theorem.** Let :math:`A` be any subset of some domain :math:`U`, and let :math:`(B_i)_{i \in I}` be a family of subsets of :math:`U` indexed by :math:`I`. Then

.. math::

   A \cap \bigcup_{i \in I} B_i = \bigcup_{i \in I} (A \cap B_i).

**Proof.** Suppose :math:`x` is in :math:`A \cap \bigcup_{i \in I} B_i`. Then :math:`x` is in :math:`A` and :math:`x` is in :math:`B_j` for some :math:`j \in I`. So :math:`x` is in :math:`A \cap B_j`, and hence in :math:`\bigcup_{i \in I} (A \cap B_i)`.

Conversely, suppose :math:`x` is in :math:`\bigcup_{i \in I} (A \cap B_i)`. Then, for some :math:`j` in :math:`I`, :math:`x` is in :math:`A \cap B_j`. Hence :math:`x` is in :math:`A`, and since :math:`x` is in :math:`B_j`, it is in :math:`\bigcup_{i \in I} B_i`. Hence :math:`x` is in :math:`A \cap \bigcup_{i \in I} B_i`, as required.

----

.. _cartesian_product_and_power_set:

Cartesian Product and Power Set
-------------------------------

The *ordered pair* of two objects :math:`a` and :math:`b` is denoted :math:`(a, b)`. We say that :math:`a` is the *first component* and :math:`b` is the *second component* of the pair. Two pairs are only equal if the first component are equal and the second components are equal. In symbols, :math:`(a, b) = (c, d)` if and only if :math:`a = c` and :math:`b = d`.

Given two sets :math:`A` and :math:`B`, we define the *cartesian product* :math:`A \times B` of these two sets as the set of all pairs where the first component is an element in :math:`A` and the second component is an element in :math:`B`. In set-builder notation this means

.. math::

   A \times B = \{(a, b) \; \mid a \; \in A \text{ and } b \in B\}.

Note that if :math:`A` and :math:`B` are subsets of a particular domain :math:`\mathcal U`, the set :math:`A \times B` need not be a subset of the same domain. However, it will be a subset of :math:`\mathcal U \times \mathcal U`.

Some axiomatic foundations take the notion of a pair to be primitive. In axiomatic set theory, it is common to *define* an ordered pair to be a particular set, namely

.. math::

   (a, b) = \{\{a\}, \{a, b\}\}. 

Notice that if :math:`a = b`, this set has only one element:

.. math::

   (a, a) = \{\{a\},\{a, a\}\} = \{\{a\},\{a\}\} = \{\{a\}\}.

The following theorem shows that this definition is reasonable.

----

**Theorem.** Using the definition of ordered pairs above, we have :math:`(a, b) = (c, d)` if and only if :math:`a = c` and :math:`b = d`.

**Proof.** If :math:`a = c` and :math:`b = d` then clearly :math:`(a, b) = (c, d)`. For the other direction, suppose that :math:`(a, b) = (c, d)`, which means

.. math::

   \underbrace{\{\{a\}, \{a, b\}\}}_L = \underbrace{\{\{c\}, \{c, d\}\}}_R.

Suppose first that :math:`a = b`. Then :math:`L = \{\{a\}\}`. This means that :math:`\{c\} = \{a\}` and :math:`\{c, d\} = \{a\}`, from which we conclude that :math:`c = a` and :math:`d = a = b`.

Now suppose that :math:`a \neq b`. If :math:`\{c\} = \{a, b\}` then we conclude that :math:`a` and :math:`b` are both equal to :math:`c`, contradicting :math:`a \neq b`. Since :math:`\{c\}\in L`, :math:`\{c\}` must be equal to :math:`\{a\}`, which means that :math:`a = c`. We know that :math:`\{a, b\} \in R`, and since we know :math:`\{a, b\}\neq \{c\}`, we conclude :math:`\{a, b\} = \{c, d\}`. This means that :math:`b \in\{c, d\}`, since :math:`b \neq a = c`, we conclude that :math:`b = d`.

Hence in both cases we conclude that :math:`a = c` and :math:`b = d`, proving the theorem.

----

Using ordered pairs we can define the *ordered triple* :math:`(a, b, c)` to be :math:`(a, (b, c))`. Then we can prove that :math:`(a, b, c) = (d, e, f)` if and only if :math:`a = d`, :math:`b = e` and :math:`c = f`, which you are asked to do in the exercises. We can also define ordered :math:`n`-tuples, which are sequence of :math:`n` objects, in a similar way.

Given a set :math:`A` we can define the *power set* :math:`\mathcal P(A)` to be the set of all subsets of :math:`A`. In set-builder notation we can write this as

.. math::

   \mathcal P(A) = \{B \mid B \subseteq A\}.

If :math:`A` is a subset of :math:`\mathcal U`, :math:`\mathcal P(A)` may not be a subset of :math:`\mathcal U`, but it is always a subset of :math:`\mathcal P(\mathcal U)`.

Exercises
---------

#. Prove the following theorem: Let :math:`A`, :math:`B`, and :math:`C` be sets of elements of some domain. Then :math:`A \cup (B \cap C) = (A \cup B) \cap (A \cup C)`. (Henceforth, if we don't specify natural deduction or Lean, \`\`prove'' and \`\`show'' mean give an ordinary mathematical proof, using ordinary mathematical language rather than symbolic logic.)

#. Prove the following theorem: Let :math:`A` and :math:`B` be sets of elements of some domain. Then :math:`\overline{A \setminus B} = \overline{A} \cup B`.

#. Two sets :math:`A` and :math:`B` are said to be *disjoint* if they have no element in common. Show that if :math:`A` and :math:`B` are disjoint, :math:`C \subseteq A`, and :math:`D \subseteq B`, then :math:`C` and :math:`D` are disjoint.

#. Let :math:`A` and :math:`B` be sets. Show :math:`(A \setminus B) \cup (B \setminus A) = (A \cup B) \setminus (A \cap B)`, by showing that both sides have the same elements.

#. Let :math:`A`, :math:`B`, and :math:`C` be subsets of some domain :math:`\mathcal U`. Give a calculational proof of the identity :math:`A \setminus (B \cup C) = (A \setminus B) \setminus C`, using the identities above. Also use the fact that, in general, :math:`C \setminus D = C \cap \overline D`.

#. Similarly, give a calculational proof of :math:`(A \setminus B) \cup (A \cap B) = A`.

#. Give calculational proofs of the following:

   -  :math:`A \setminus B = A \setminus (A \cap B)`
   -  :math:`A \setminus B = (A \cup B) \setminus B`
   -  :math:`(A \cap B) \setminus C = (A \setminus C) \cap B`

#. Prove that if :math:`(A_{i,j})_{i \in I, j \in J}` is a family indexed by two sets :math:`I` and :math:`J`, then

   .. math::

        \bigcup_{i \in I}\bigcap_{j \in J} A_{i, j} \subseteq \bigcap_{j \in J}\bigcup_{i \in I} A_{i, j}.

   Also, find a family :math:`(A_{i,j})_{i \in I, j \in J}` where the reverse inclusion does not hold.

#. Prove using calculational reasoning that

   .. math::

        \left(\bigcup_{i \in I}A_i\right)\cap \left(\bigcup_{j \in J}B_j\right) = \bigcup_{\substack{i \in I \\ j \in J}}(A_i \cap B_j).

   The notation :math:`\bigcup_{\substack{i \in I \\ j \in J}}(A_i \cap B_j)` means :math:`\bigcup_{i \in I} \bigcup_{j \in J}(A_i \cap B_j)`.

#. Using the definition :math:`(a, b, c) = (a, (b, c))`, show that :math:`(a, b, c) = (d, e, f)` if and only if :math:`a = d`, :math:`b = e` and :math:`c = f`.

#. Prove that :math:`A \times (B \cup C) = (A \times B) \cup (A \times C)`

#. Prove that :math:`(A \cap B) \times (C \cap D) = (A \times C) \cap (B \times D)`. Find an expression for :math:`(A \cup B) \times (C \cup D)` consisting of unions of cartesian products, and prove that your expression is correct.

#. Prove that that :math:`A \subseteq B` if and only if :math:`\mathcal P(A) \subseteq \mathcal P(B)`.
