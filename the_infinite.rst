The Infinite
============

Equinumerosity
--------------

Remember that in :numref:`Chapter %s <combinatorics>` we defined, for each natural number :math:`n`, the set :math:`[n] = \{0, 1, \ldots, n-1\}`.  We then said that a set :math:`A` is *finite* if there is a bijection between :math:`A` and :math:`[n]` for some :math:`n`. A set is said to be *infinite* if it is not finite.

If :math:`A` and :math:`B` are two finite sets, then they have the same cardinality if and only if there is a bijection between them. It turns out that the same notion of "having the same cardinality" makes sense even if :math:`A` and :math:`B` are not finite.

----

**Definition.** Two sets :math:`A` and :math:`B` are said to be *equinumerous*, written :math:`A \approx B`, if there is a bijection between them. Equivalently, we say that :math:`A` and :math:`B` *have the same cardinality*.

----

At this stage, saying that :math:`A` and :math:`B` have the same cardinality may sound strange, because it is not clear that there is any object, "the cardinality of :math:`A`," that they both "have." It turns out that, in set-theoretic foundations, there are certain objects --- generalizations of the natural numbers --- that one can use to measure the size of an infinite set. There are known as the "cardinal numbers" or "cardinals." But they are irrelevant to our purposes here. For the rest of this chapter, when we say that :math:`A` and :math:`B` have the same cardinality, we mean neither more nor less than the fact that there is a bijection between them.

The following theorem says, essentially, that equinumerosity is an equivalence relation. (The caveat is that so far we have spoke only of relations between sets, and the collection of all sets is not itself a set.)

----

**Proposition**. Let :math:`A`, :math:`B`, and :math:`C` be any sets.

-  :math:`A \approx A`.
-  If :math:`A \approx B`, then :math:`B \approx A`.
-  If :math:`A \approx B` and :math:`B \approx C` then :math:`A \approx C`.

----

The proof is left as an exercise.

Countably Infinite Sets
-----------------------

The set of natural numbers, :math:`\mathbb{N}`, is a prototypical example of an infinite set. To see that it is infinite, suppose, on the other hand, that it is finite. This means that there is a bijection :math:`f` between :math:`\mathbb{N}` and :math:`[n]` for some natural number :math:`n`. We can restrict to the subset :math:`[n+1]` of :math:`\mathbb{N}`, and thereby obtain an injective map from :math:`[n+1]` to :math:`[n]`. But this violates the pigeonhole principle, proved in :numref:`Chapter %s <combinatorics>`.

----

**Definition.** A set is said to be *countably infinite* if it is equinumerous with :math:`\mathbb{N}`. A set is said to be *countable* if it is finite or countably infinite.

----

Since the identity map :math:`id(x) = x` is a bijection on any set, every set is equinumerous with itself, and thus :math:`\mathbb{N}` itself is countably infinite.

The term "countably infinite" is meant to be evocative. Suppose :math:`A` is a countable set. By definition, there is a bijection :math:`f : \mathbb{N} \to A`. So :math:`A` has a "first" element :math:`f(0)`, a "second" element :math:`f(1)`, a "third" element :math:`f(2)`, and so on. Since :math:`f` is a bijection, for every element :math:`a` of :math:`A`, :math:`a` is the :math:`n`\ th element enumerated in this way, for a unique value of :math:`n`. That is, each element of :math:`A` is "counted" at some finite stage.

With this definition in hand, it is natural to wonder which of our favorite sets are countable. Is the set of integers :math:`\mathbb{Z}` countable? How about the set of rationals :math:`\mathbb{Q}`, or the set of reals :math:`\mathbb{R}`? At this point, you should reflect on the logical form of the statement ":math:`A` is countable," and think about what is required to show that a set :math:`A` does or does not have this property.

----

**Theorem.** The set of integers, :math:`\mathbb{Z}`, is countable.

**Proof.** We need to show that there exists a bijection between :math:`\mathbb{N}` and :math:`\mathbb{Z}`. Define :math:`f : \mathbb{N} \to \mathbb{Z}` as follows:

.. math::

   f(n) = \begin{cases}
            n / 2 & \mbox{if $n$ is even} \\
            -(n + 1) / 2 & \mbox{if $n$ is odd.}
          \end{cases}    

We claim that :math:`f` is a bijection. To see that it is injective, suppose :math:`f(m) = f(n)`. If :math:`f(m)` (and hence also :math:`f(n)`) is nonnegative, then :math:`m` and :math:`n` are even, in which case :math:`m / 2 = n / 2` implies :math:`m = n`. Otherwise, :math:`m` and :math:`n` are odd, and again :math:`-(m+1) / 2 = -(n+1)/ 2` implies :math:`m = n`.

To see that :math:`f` is surjective, suppose :math:`a` is any integer. If :math:`a` is nonnegative, then :math:`a = f(2 a)`. If :math:`a` is strictly negative, then :math:`2 a - 1` is also strictly negative, and hence :math:`-(2 a - 1)` is an odd natural number. In that case, it is not hard to check that :math:`a = f(-(2a - 1))`.

----

We will now build up an arsenal of theorems that we can use to show that various sets are countable.

----

**Theorem.** A set :math:`A` is countable if and only if :math:`A` is empty or there is a surjective function :math:`f : \mathbb{N} \to A`.

**Proof.** For the forward direction, suppose :math:`A` is countable. Then it is either finite or countably infinite. If :math:`A` is countably infinite, there is a bijection from :math:`\mathbb{N}` to :math:`A`, and we are done. Suppose, then, that :math:`A` is finite. If :math:`A` is empty, we are done. Otherwise, for some :math:`n`, there is a bijection :math:`f : [n] \to A`, with :math:`n \geq 1`. Define a function :math:`g : \mathbb{N} \to A` as follows:

.. math::

   g(i) = \begin{cases}
            f(i) & \mbox{if $i < n$} \\
            f(0) & \mbox{otherwise.}
          \end{cases}

In other words, :math:`g` enumerates the elements of :math:`A` by using :math:`f` first, and then repeating the element :math:`f(0)`. Clearly :math:`f` is surjective, as required.

In the other direction, if :math:`A` is finite, then it is countable, and we are done. So suppose :math:`A` is not finite. Then it is not empty, and so there is a surjective function :math:`f : \mathbb{N} \to A`. We need to turn :math:`f` into a *bijective* function. The problem is that :math:`f` may not be injective, which is to say, elements in :math:`A` may be enumerated more than once. The solution is to define a function, :math:`g`, which eliminates all the duplicates. The idea is that :math:`g` should enumerate the elements :math:`f(0), f(1), f(2), \ldots`, but skip over the ones that have already been enumerated.

To be precise, the function :math:`g` is defined recursively as follows: :math:`g(0) = f(0)`, and for every :math:`i`, :math:`g(i+1) = f(j)`, where :math:`j` is the least natural number such that :math:`f(j)` is not among :math:`\{g(0), g(1), g(2), \ldots, g(i) \}`. The assumption that :math:`A` is infinite and :math:`f` is surjective guarantees that some such :math:`j` always exists.

We only need to check that :math:`g` is a bijection. By definition, for every :math:`i`, :math:`g(i+1)` is different from :math:`g(0), \ldots, g(i)`. This implies that :math:`g` is injective. But we can also show by induction that for every :math:`i`, :math:`\{g(0), \ldots, g(i)\} \supseteq \{ f(0), \ldots, f(i)\}`. Since :math:`f` is surjective, :math:`g` is too.

----

In a manner similar to the way we proved that the integers are countable, we can prove the following:

----

**Theorem.** If :math:`A` and :math:`B` are countably infinite, then so is :math:`A \cup B`.

**Proof.** Suppose :math:`f : \mathbb{N} \to A` and :math:`g : \mathbb{N} \to B` are surjective. Then we can define a function :math:`h : \mathbb{N} \to A \cup B`:

.. math::

   h(n) = \begin{cases}
            f(n/2) & \mbox{if $n$ is even} \\
            g((n-1)/2) & \mbox{if $n$ is odd.}
          \end{cases}

It is not hard to show that :math:`h` is surjective.

----

Intuitively, if :math:`A = \{ f(0), f(1), f(2), \ldots \}` and :math:`B = \{ g(0), g(1), g(2), \ldots\}`, then we can enumerate :math:`A \cup B` as :math:`\{ f(0), g(0), f(1), g(1), f(2), g(2), \ldots \}`.

The next two theorems are also helpful. The first says that to show that a set :math:`B` is countable, it is enough to "cover" it with a surjective function from a countable set. The second says that to show that a set :math:`A` is countable, then it is enough to embed it in a countable set.

----

**Theorem.** If :math:`A` is countable and :math:`f : A \to B` is surjective, then :math:`B` is countable.

**Proof.** If :math:`A` is countable, then there is a surjective function :math:`g : \mathbb{N} \to A`, and :math:`f \circ g` is a surjective function from :math:`\mathbb{N} \to B`.

**Theorem.** If :math:`B` is countable and :math:`f : A \to B` is injective, then :math:`A` is countable.

**Proof.** Assuming :math:`f : A \to B` is injective, it has a left inverse, :math:`g : B \to A`. Since :math:`g` has a right inverse, :math:`f`, we know that :math:`g` is surjective, and we can apply the previous theorem.

**Corollary.** If :math:`B` is countable and :math:`A \subseteq B`, then :math:`A` is countable.

**Proof.** The function :math:`f : A \to B` defined by :math:`f(x) = x` is injective.

----

Remember that :math:`\mathbb{N} \times \mathbb{N}` is the set of ordered pairs :math:`(i, j)` where :math:`i` and :math:`j` are natural numbers.

----

**Theorem.** :math:`\mathbb{N} \times \mathbb{N}` is countable.

**Proof.** Enumerate the elements as follows:

.. math::

   (0, 0), (1, 0), (0, 1), (2, 0), (1, 1), (1, 2), (3, 0), (2, 1), (1, 2), (0, 3), \ldots

----

.. TODO: add a picture here

If you think of the pairs as coordinates in the :math:`x`-:math:`y` plane, the pairs are enumerated along diagonals: first the diagonal with pairs whose elements sum to :math:`0`, then the diagonal with pairs whose elements sum to :math:`1`, and so on. This is often called a "dovetailing" argument, because if you imagine drawing a line that weaves back and forth through the pairs enumerated this ways, it will be analogous to the a carpenter's practice of using a dovetail to join two pieces of wood. (And that term, in turn, comes from the similarity to a dove's tail.)

As far as proofs go, the informal description above and the associated diagram are perfectly compelling. It is possible to describe a bijection between :math:`\mathbb{N} \times \mathbb{N}` explicitly, however, in algebraic terms. You are asked to do this in the exercises.

The previous theorem has a number of interesting consequences.

----

**Theorem.** If :math:`A` and :math:`B` are countable, then so is :math:`A \times B`.

**Proof.** If :math:`p` is any element of :math:`\mathbb{N} \times \mathbb{N}`, write :math:`p_0` and :math:`p_1` to denote the two components. Let :math:`f : \mathbb{N} \to \mathbb{N} \times \mathbb{N}` be a surjection, as guaranteed by the previous theorem. Suppose :math:`g : \mathbb{N} \to A` and :math:`h : \mathbb{N} \to B` be surjective. Then the function :math:`k(i) = ( g(f(i)_0), h(f(i)_1) )` is a surjective function from :math:`\mathbb{N}` to :math:`A \times B`.

**Theorem.** The set of rational numbers, :math:`\mathbb{Q}`, is countable.

**Proof.** By the previous theorem, we know that :math:`\mathbb{Z} \times \mathbb{Z}` is countable. Define :math:`f : \mathbb{Z} \times \mathbb{Z} \to \mathbb{Q}` by

.. math::

     f(i,j) = \begin{cases}
                i / j & \mbox{if $j \neq 0$} \\
                0 & \mbox{otherwise.}
              \end{cases}

Since every element of :math:`\mathbb{Q}` can be written as :math:`i / j` for some :math:`i` and :math:`j` in :math:`\mathbb{Z}`, :math:`f` is surjective.

**Theorem.** Suppose that :math:`A` is countable. For each :math:`n`, the set :math:`A^n` is countable.

**Proof.** Remember that we can identify the set of :math:`n`-tuples of elements from :math:`A` with :math:`A \times \ldots \times A`, where there are :math:`n` copies of :math:`A` in the product. The result follows using induction on :math:`n`.

**Theorem.** Let :math:`(A_i)_{i \in \mathbb{N}}` be a family of sets indexed by the natural numbers, and suppose that each :math:`A_i` is countable. Then :math:`\bigcup_i A_i` is countable.

**Proof.** Suppose for each :math:`i`, :math:`f_i` is a surjective function from :math:`\mathbb{N}` to :math:`A_i`. Then the function :math:`g(i, j) = f_i(j)` is a surjective function from :math:`\mathbb{N} \times \mathbb{N}` to :math:`\bigcup_i A_i`.

**Theorem.** Suppose that :math:`A` is countable. Then the set of finite sequences of elements of :math:`A` is countable.

**Proof.** The set of finite sequences of elements of :math:`A` is equal to :math:`\bigcup_i A^i`, and we can apply the previous two theorems.

----

Notice that the set of all alphanumeric characters and punctuation (say, represented as the set of all ASCII characters) is finite. Together with the last theorem, this implies that there are only countably many sentences in the English language (and, indeed, any language in which sentences are represented by finite sequences of symbols, chosen from any countable stock).

At this stage, it might seem as though everything is countable. In the next section, we will see that this is not the case: the set of real numbers, :math:`\mathbb{R}`, is not countable, and if :math:`A` is any set (finite or infinite), the powerset of :math:`A`, :math:`{\mathcal P}(A)`, is not equinumerous with :math:`A`.

Cantor's Theorem
----------------

A set :math:`A` is *uncountable* if it is not countable. Our goal is to prove the following theorem, due to Georg Cantor.

----

**Theorem.** The set of real numbers is uncountable.

**Proof.** Remember that :math:`[0,1]` denotes the closed interval :math:`\{ r \in \mathbb{R} \mid 0 \leq r \leq 1\}`. It suffices to show that there is no surjective function :math:`f : \mathbb{N} \to [0,1]`, since if :math:`\mathbb{R}` were countable, :math:`[0,1]` would be countable too.

Recall that every real number :math:`r \in [0,1]` has a decimal expansion of the form :math:`r = 0.r_0 r_1 r_2 r_3 r_4 \ldots`, where each :math:`r_i` is a digit in :math:`\{0, 1, \ldots, 9\}`. More formally, we can write :math:`r = \sum_{i = 0}^\infty \frac{r_i}{10^{i}}` for each :math:`r \in \mathbb{R}` with :math:`0 \leq r \leq 1`.

(Notice that :math:`1` can be written :math:`0.9999\ldots`. In general every other rational number in :math:`[0,1]` will have two representations of this form; for example, :math:`0.5 = 0.5000\ldots = 0.49999\ldots`. For concreteness, for these numbers we can choose the representation that ends with zeros.)

As a result, we can write

-  :math:`f(0) = 0.r^0_0 r^0_1 r^0_2 r^0_3 r^0_4 \ldots`
-  :math:`f(1) = 0.r^1_0 r^1_1 r^1_2 r^1_3 r^1_4 \ldots`
-  :math:`f(2) = 0.r^2_0 r^2_1 r^2_2 r^2_3 r^2_4 \ldots`
-  :math:`f(3) = 0.r^3_0 r^3_1 r^3_2 r^3_3 r^3_4 \ldots`
-  :math:`f(4) = 0.r^4_0 r^4_1 r^4_2 r^4_3 r^4_4 \ldots`
-  ...

(We use superscripts, :math:`r^i`, to denote the digits of :math:`f(i)`. The superscripts do not mean the ":math:`i`\ th power.")

Our goal is to show that :math:`f` is not surjective. To that end, define a new sequence of digits :math:`(r_i)_{i \in \mathbb{N}}` by

.. math::

   r_i = \begin{cases}
           7 & \mbox{if $r^i_i \neq 7$} \\
           3 & \mbox{otherwise.}
         \end{cases}

The define the real number :math:`r = 0.r_0 r_1 r_2 r_3 \ldots`. Then, for each :math:`i`, :math:`r` differs from :math:`f(i)` in the :math:`i`\ th digit. But this means that for every :math:`i`, :math:`f(i) \neq r`. Since :math:`r` is not in the range of :math:`f`, we see that :math:`f` is not surjective. Since :math:`f` was arbitrary, there is no surjective function from :math:`\mathbb{N}` to :math:`[0,1]`.

(We chose the digits :math:`3` and :math:`7` only to avoid :math:`0` and :math:`9`, to avoid the case where, for example, :math:`f(0) = 0.5000\ldots` and :math:`r = 0.4999\ldots`. Since there are no zeros or nines in :math:`r`, since the :math:`i`\ th digit of :math:`r` differs from :math:`f(i)`, it really is a different real number.)

----

This remarkable proof is known as a "diagonalization argument." We are trying to construct a real number with a certain property, namely, that it is not in the range of :math:`f`. We make a table of digits, in which the rows represent infinitely many constraints we have to satisfy (namely, that for each :math:`i`, :math:`f(i) \neq r`), and the columns represent opportunities to satisfy that constraint (namely, by choosing the :math:`i`\ th digit of :math:`r` appropriately). Then we complete the construction by stepping along the diagonal, using the :math:`i`\ th opportunity to satisfy the :math:`i`\ th constraint. This technique is used often in logic and computability theory.

The following provides another example of an uncountable set.

----

**Theorem.** The power set of the natural numbers, :math:`{\mathcal P}(\mathbb{N})`, is uncountable.

**Proof.** Let :math:`f : \mathbb{N} \to {\mathcal P}(\mathbb{N})` be any function. Once again, our goal is to show that :math:`f` is not surjective. Let :math:`S` be the set of natural numbers, defined as follows:

.. math::

   S = \{ n \in \mathbb{N} \mid n \notin f(n) \}.

In words, for every natural number, :math:`n`, :math:`n` is in :math:`S` if and only if it is not in :math:`f(n)`. Then clearly for every :math:`n`, :math:`f(n) \neq S`. So :math:`f` is not surjective.

----

We can also view this as a diagonalization argument: draw a table with rows and columns indexed by the natural numbers, where the entry in the :math:`i`\ th row and :math:`j`\ th column is "yes" if :math:`j` is an element of :math:`f(i)`, and "no" otherwise. The set :math:`S` is constructed by switching "yes" and "no" entries along the diagonal.

In fact, exactly the same argument yields the following:

----

**Theorem.** For every set :math:`A`, there is no surjective function from :math:`A` to :math:`{\mathcal P}(A)`.

**Proof.** As above, if :math:`f` is any function from :math:`A` to :math:`{\mathcal P}(A)`, the set :math:`S = \{ a \in A \mid a \notin f(a) \}` is not in the range of :math:`f`.

----

This shows that there is an endless hierarchy of infinities. For example, in the sequence :math:`\mathbb{N}, {\mathcal P}(\mathbb{N}), {\mathcal P}({\mathcal P}(\mathbb{N})), \ldots`, there is an injective function mapping each set into the next, but no surjective function. The union of all those sets is even larger still, and then we can take the power set of *that*, and so on. Set theorists are still today investigating the structure within this hierarchy.

An Alternative Definition of Finiteness
---------------------------------------

One thing that distinguishes the infinite from the finite is that an infinite set can have the same size as a proper subset of itself. For example, the natural numbers, the set of even numbers, and the set of perfect squares are all equinumerous, even though the latter two are strictly contained among the natural numbers.

In the nineteenth century, the mathematician Richard Dedekind used this curious property to *define* what it means to be finite. We can show that his definition is equivalent to ours, but the proof requires the axiom of choice.

----

**Definition.** A set is :math:`A` *Dedekind infinite* if :math:`A` is equinumerous with a proper subset of itself, and *Dedekind finite* otherwise.

**Theorem.** A set is Dedekind infinite if and only it is infinite.

**Proof.** Suppose :math:`A` is Dedekind infinite. We need to show it is not finite; suppose, to the contrary, it is bijective with :math:`[n]` for some :math:`n`. Composing bijections, we have that :math:`[n]` is bijective with a proper subset of itself. This means that there is an injective function :math:`f` from :math:`[n]` to a proper subset of :math:`n`. Modifying :math:`f`, we can get an injective function from :math:`[n]` into :math:`[n-1]`, contradicting the pigeonhole principle.

Suppose, on the other hand, that :math:`A` is infinite. We need to show that there is an injective function :math:`f` from :math:`A` to a proper subset of itself (because then :math:`f` is a bijection between :math:`A` and the range of :math:`f`). Choose a sequence of distinct element :math:`a_0, a_1, a_2, \ldots` of :math:`A`. Let :math:`f` map each :math:`a_i` to :math:`a_{i+1}`, but leave every other element of :math:`A` fixed. Then :math:`f` is injective, but :math:`a_0` is not in the range of :math:`f`, as required.

----

.. _the_cantor_bernstein_theorem:

The Cantor-Bernstein Theorem
----------------------------

Saying that :math:`A` and :math:`B` are equinumerous means, intuitively, that :math:`A` and :math:`B` have the same size. There is also a natural way of saying that :math:`A` is not larger than :math:`B`:

----

**Definition.** For two sets :math:`A` and :math:`B`, we say the cardinality of :math:`A` is less than or equal to the cardinality of :math:`B`, written :math:`A \preceq B`, when there is an injection :math:`f : A \to B`.

----

As an exercise, we ask you to show that :math:`\preceq` is a *preorder*, which is to say, it is reflexive and transitive. Here is a natural question: does :math:`A \preceq B` and :math:`B \preceq A` imply :math:`A \approx B`? In other words, assuming there are injective functions :math:`f : A \to B` and :math:`g : B \to A`, is there necessarily a bijection from :math:`A` to :math:`B`?

The answer is "yes," but the proof is tricky. The result is known as the *Cantor-Bernstein Theorem*, and we state it without proof.

----

**Theorem.** For any sets :math:`A` and :math:`B`, if :math:`A \preceq B` and :math:`B \preceq A`, then :math:`A \approx B`.

----

.. TODO: add a proof

Exercises
---------

#. Show that equinumerosity is reflexive, symmetric, and transitive.

#. Show that the function :math:`f(x) = x / (1 - x)` is a bijection between the interval :math:`[0,1)` and :math:`\mathbb{R}^{\geq 0}`.

#. Show that the :math:`g(x) = x / (1 - |x|)` gives a bijection between :math:`(-1, 1)` and :math:`\mathbb{R}`.

#. Define a function :math:`J : \mathbb{N} \times \mathbb{N} \to \mathbb{N}` by :math:`J(i,j) = \frac{(i + j)(i + j + 1)}{2} + i`. This goal of this problem is to show that :math:`J` is a bijection from :math:`\mathbb{N} \times \mathbb{N}` to :math:`\mathbb{N}`.

   a. Draw a picture indicating which pairs are sent to :math:`0, 1, 2, \ldots`.

   b. Let :math:`n = i + j`. Show that :math:`J(i,j)` is equal the number of pairs :math:`(u, v)` such that either :math:`u + v < n`, or :math:`u + v = n` and :math:`u < i`. (Use the fact that :math:`1 + 2 + \ldots + n = n(n+1)/2`.)

   c. Conclude that :math:`J` is surjective: to find :math:`i` and :math:`j` such that :math:`J(i,j) = k`, it suffices to find the largest :math:`n` such that :math:`n(n+1)/2 \leq k`, let :math:`i = k - n(n+1)/2`, and let :math:`j = n - i`.

   d. Conclude that :math:`J` is injective: if :math:`J(i,j) = J(i',j')`, let :math:`n = i + j` and :math:`n' = i' + j'`. Argue that :math:`n = n'`, and so :math:`i = i'` and :math:`j = j'`.

#. Let :math:`S` be the set of functions from :math:`\mathbb{N}` to :math:`\{ 0, 1\}`. Use a diagonal argument to show that :math:`S` is uncountable. (Notice that you can think of a function :math:`f: \mathbb{N} \to \{0, 1\}` as an infinite sequence of 0's and 1's, given by :math:`f(0), f(1), f(2), \ldots`. So, given a function :math:`F(n)` which, for each natural number :math:`n`, returns an infinite sequence of 0's and 1's, you need to find a sequence that is not in the image of :math:`F`.)

#. If :math:`f` and :math:`g` are functions from :math:`\mathbb{N}` to :math:`\mathbb{N}`, say that :math:`g` *eventually dominates* :math:`f` if there is some :math:`n` such that for every :math:`m \geq n`, :math:`g(m) > f(m)`. In other words, from some point on, :math:`g` is bigger than :math:`f`.

   Show that if :math:`f_0, f_1, f_2, \ldots` is any sequence of functions from :math:`\mathbb{N}` to :math:`\mathbb{N}`, indexed by the natural numbers, then there is a function :math:`g` that eventually dominates each :math:`f_i`. (Hint: construct :math:`g` so that for each :math:`i`, :math:`g(n) > f_i(n)` for every :math:`n \geq i`.)

#. Show that the relation :math:`\preceq` defined in :numref:`the_cantor_bernstein_theorem` is reflexive and transitive.