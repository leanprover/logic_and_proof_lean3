.. _combinatorics:

Combinatorics
=============

Combinatorics is the art of counting without counting. It is a fundamental mathematical task to determine how many things there are in a given collection, and when the collection is large, it can be tedious or infeasible to count the elements individually. Moreover, when the collection is described in terms of a changing parameter (say, a natural number, :math:`n`), we would like a formula that tells us how the number of objects depends on that parameter. In this chapter we will set up a foundation for achieving this goal, and learn some of the tricks of the
trade.

Finite Sets and Cardinality
---------------------------

It will be helpful, for every natural number :math:`n`, to have a canonical set of elements of size :math:`n`. To that end, we will choose the set

.. math::

   [n] = \{ m \mid m < n \} = \{ 0, 1, \ldots, n-1 \}.

We used the same notation, :math:`[n]`, to describe equivalence classes with respect to an equivalence relation, but hopefully our intended meaning will always be clear from the context.

A set :math:`A` of elements is said to be *finite* if there is a bijection from :math:`[n]` to :math:`A` for some :math:`n`. In that case, we would like to say that :math:`A` *has* :math:`n` *elements*, or that the set :math:`A` *has cardinality* :math:`n`, and write :math:`|A| = n`. But to do so, we need to know that when :math:`A` is finite, there is a unique :math:`n` with the property above.

Suppose there are bijections from both :math:`[m]` and :math:`[n]` to :math:`A`. Composing the first bijection with the inverse of the second, we get a bijection from :math:`[m]` to :math:`[n]`. It seems intuitively clear that this implies :math:`m = n`, but our goal is to prove this from the fundamental properties of sets, functions, and the natural numbers.

So suppose, for the sake of contradiction, :math:`m \neq n`. Without loss of generality, we can assume :math:`m > n` (why?). In particular, there is an injective function :math:`f` from :math:`[m]` to :math:`[n]`. Since :math:`m > n`, :math:`m \geq n+1`, and so we can restrict :math:`f` to get an injective function from :math:`[n+1]` to :math:`[n]`. The next theorem shows that this cannot happen.

----

**Theorem.** For any natural number :math:`n`, there is no injective function from :math:`[n+1]` to :math:`[n]`.

**Proof.** By induction on :math:`n`. The theorem is clear when :math:`n = 0`, because :math:`[1] = \{ 0 \}` and :math:`[0] = \emptyset`. If :math:`f` were an injective function from :math:`[1]` to :math:`[0]`, we would have :math:`f(0) \in \emptyset`, which is impossible.

So suppose the claim is true for :math:`n`, and suppose :math:`f` is an injective function from :math:`[n+2]` to :math:`[n+1]`. We consider two cases.

In the first case, suppose :math:`n` is not in the image of :math:`f`. Then :math:`f` maps :math:`[n+2]` to :math:`[n]`, and restricting the domain, we have an injective function from :math:`[n+1]` to :math:`[n]`, contradicting the inductive hypothesis.

In the second case, there is some :math:`m < n + 2` such that :math:`f(m) = n`. The idea is to alter :math:`f` slightly to get an injective function from :math:`[n+1]` to :math:`[n]`, again contradicting the inductive hypothesis. If :math:`m = n + 1`, which is to say it is the last element of :math:`[n+2]` that is mapped to the last element of :math:`[n+1]`, we can just restrict :math:`f` to :math:`[n+1]`. The fact that :math:`f` was injective implies that all the elements in :math:`[n+1]` are mapped to :math:`n`.

Otherwise, define :math:`f' : [n+1] \to [n]` by

.. math::

   f'(i) =
     \begin{cases}
       f(i) & \mbox{if $i \neq m$} \\
       f(n+1) & \mbox{if $i = m$.}
     \end{cases}

In other words, we map :math:`m` to the value that :math:`n+1` was mapped to. Since :math:`f` is injective, :math:`f(n+1) \neq f(m)`, and so :math:`f(n+1) < n`, as required. It is not hard to check that :math:`f'` is injective, so we have the contradiction we were after.

----

This theorem is known as the "pigeonhole principle." It implies that if :math:`n + 1` pigeons inhabit :math:`n` holes, then at least one hole has more than one pigeon. The principle implies that for every finite set :math:`A`, there is a unique :math:`n` such that there is a bijection from :math:`[n]` to :math:`A`, and we can define the cardinality of :math:`A` to be that :math:`n`.

.. _counting_principles:

Counting Principles
-------------------

Here is a basic counting principle.

----

**Theorem.** Let :math:`A` and :math:`B` be disjoint finite sets. Then :math:`| A \cup B | = | A | + | B |`.

**Proof.** Suppose :math:`f : [m] \to A` and :math:`g : [n] \to B` are bijections. Define :math:`h : [m + n] \to A \cup B` by

.. math::

   h(i) =
     \begin{cases}
       f(i) & \mbox{if $i < m$} \\
       g(i - m) & \mbox{if $m \leq i < m + n$.}    
     \end{cases}

To see that :math:`h` is surjective, note that every :math:`k` in :math:`A \cup B` can be written as either :math:`k = f(i)` for some :math:`i \in [m]` or :math:`k = g(j)` for some :math:`j \in [n]`. In the first case, :math:`k = f(i) = h(i)`, and in the second case, :math:`k = g(j) = h(m + j)`.

It is not hard to show that :math:`h` is also injective. Suppose :math:`h(i) = h(j)`. If :math:`h(i)` is in :math:`A`, then it is not in the range of :math:`g`, and so we must have :math:`h(i) = f(i)` and :math:`h(j) = f(j)`. Then :math:`f(i) = f(j)`, the injectivity of :math:`f` implies that :math:`i = j`. If :math:`h(i)` is instead in :math:`B`, the argument it similar.

----

The proof only spells out our basic intuitions: if you want to list all of the elements of :math:`A \cup B`, you can list all the elements of :math:`A` and then all the elements of :math:`B`. And if :math:`A` and :math:`B` have no elements in common, then to count the elements of :math:`A \cup B`, you can count the elements of :math:`A` and then continue counting the elements of :math:`B`. Once you are comfortable translating the intuitive argument into a precise mathematical proof (and mathematicians generally are), you can use the more intuitive descriptions (and mathematicians generally do).

Here is another basic counting principle:

----

**Theorem.** Let :math:`A` and :math:`B` be finite sets. Then :math:`| A \times B | = | A | \cdot | B |`.

----

Notice that this time we are counting the number of ordered pairs :math:`(a, b)` with :math:`a \in A` and :math:`b \in B`. The exercises ask you to give a detailed proof of this theorem. There are at least two ways to go about it. The first is to start with bijections :math:`f : [m] \to A` and :math:`g : [n] \to B` and describe an explicit bijection :math:`h : [m \cdot n] \to A \times B`. The second is to fix :math:`m`, say, and use induction on :math:`n` and the previous counting principle. Notice that if :math:`U` and :math:`V` are any sets and :math:`w` is not in :math:`V`, we have

.. math::

   U \times (V \cup \{ w \}) = (U \times V) \cup (U \times \{w\}),

and the two sets in this union are disjoint.

Just as we have notions of union :math:`\bigcup_{i\in I} A_i` and intersection :math:`\bigcap_{i \in I} A_i` for indexed families of sets, it is useful to have a notion of a product :math:`\prod_{i \in I} A_i`. We can think of an element :math:`a` of this product as a function which, for each element :math:`i \in I`, returns an element :math:`a_i \in A_i`. For example, when :math:`I = \{1, 2, 3\}`, an element of :math:`\prod_{i \in I} A_i` is just a triple :math:`a_1, a_2, a_3` with :math:`a_1 \in A_1`, :math:`a_2 \in A_2`, and :math:`a_3 \in A_3`. This is essentially the same as :math:`A_1 \times A_2 \times A_3`, up to the fiddly details as to whether we represent a triple as a function or with iterated pairing :math:`(a_1, (a_2, a_3))`.

----

**Theorem.** Let :math:`I` be a finite index set, and let :math:`(A_i)_{i \in I}` be a family of finite sets. Then:

-  If each pair of sets :math:`A_i`, :math:`A_j` are disjoint, then :math:`|\bigcup_{i \in I} A_i| = \sum_{i \in I} | A_i |`.
-  :math:`| \prod_{i \in I} A_i | = \prod_{i \in I} | A_i |`.

**Proof.** By induction on :math:`|I|`, using the previous counting principles.

----

We can already use these principles to carry out basic calculations.

----

**Example.** The dessert menu at a restaurant has four flavors of ice cream, two kinds of cake, and three kinds of pie. How many dessert choices are there?

**Solution.** :math:`4 + 2 + 3 = 9`, the cardinality of the union of the three disjoint sets.

**Example.** The menu at a diner has 6 choices of appetizers, 7 choices of entrée, and 5 choices of dessert. How many choices of three-course dinners are there?

**Solution.** A three-course dinner is a triple consisting of an appetizer, an entrée, and a dessert. There are therefore :math:`6 \cdot 7 \cdot 5 = 210` options.

----

A special case of the previous counting principles arises when all the sets have the same size. If :math:`I` has cardinality :math:`k` and each :math:`A_i` has cardinality :math:`n`, then the cardinality of :math:`\bigcup_{i \in I} A_i` is :math:`k \cdot n` if the sets are pairwise disjoint, and the cardinality of :math:`\prod_{i \in I} A_i` is :math:`n^k`.

----

**Example.** A deck of playing cards has four suits (diamonds, hearts, spades, and clubs) and 13 cards in each suit, for a total of :math:`4 \cdot 13 = 52`.

**Example.** A binary string of length :math:`n` is a sequence of :math:`n` many 0's and 1's. We can think of this as an element of

.. math::

   \{0, 1\}^n = \prod_{i < n} \{0, 1\},

so there are :math:`2^n` many binary strings of length :math:`n`.

----

There is another counting principle that is almost too obvious to mention: if :math:`A` is a finite set and there is a bijection between :math:`A` and :math:`B`, then :math:`B` is also finite, and :math:`|A| = |B|`.

----

**Example.** Consider the power set of :math:`[n]`, that is, the collection of all subsets of :math:`\{0, 1, 2, \ldots, n-1\}`. There is a one-to-one correspondence between subsets and binary strings of length :math:`n`, where element :math:`i` of the string is :math:`1` if :math:`i` is in the set and :math:`0` otherwise. As a result, we have :math:`| \mathcal P ([n]) | = 2^n`.

----

Ordered Selections
------------------

Let :math:`S` be a finite set, which we will think of as being a set of options, such as items on a menu or books that can be selected from a shelf. We now turn to a family of problems in combinatorics that involves making repeated selections from that set of options. In each case, there are finitely many selections, and the order counts: there is a first choice, a second one, a third one, and so on.

In the first variant of the problem, you are allowed to repeat a choice. For example, if you are choosing 3 flavors from a list of 31 ice cream flavors, you can choose "chocolate, vanilla, chocolate." This is known as *ordered selection with repetition*. If you are making :math:`k` choices from among :math:`n` options in :math:`S`, such a selection is essentially a tuple :math:`(a_0, a_1, \ldots, a_{k-1})`, where each :math:`a_i` is one of the :math:`n` elements in :math:`S`. In other words, the set of ways of making :math:`k` selections from :math:`S` with repetition is the set :math:`S^k`, and we have seen in the last section that if :math:`S` has cardinality :math:`n`, the set :math:`S^k` has cardinality :math:`n^k`.

----

**Theorem.** Let :math:`S` be a set of :math:`n` elements. Then the number of ways of making :math:`k` selections from :math:`S` with repetition allowed is :math:`n^k`.

**Example.** How many three-letter strings (like "xyz," "qqa," ...) can be formed using the twenty-six letters of the alphabet?

**Solution.** We have to make three selections from a set of 26 elements, for a total of :math:`26^3 = 17,576` possibilities.

----

Suppose instead we wish to make :math:`k` ordered selections, but we are not allowed to repeat ourselves. This would arise, from example, if a museum had 26 paintings in its storeroom, and has to select three of them to put on display, ordered from left to right along a wall. There are 26 choices for the first position. Once we have made that choice, 25 remain for the second position, and then 24 remain for the third. So it seems clear that there are :math:`26 \cdot 25 \cdot 24` arrangements overall.

Let us try to frame the problem in mathematical terms. We can think of an ordered selection of :math:`k` elements from a set :math:`S` without repetition as being an *injective function* :math:`f` from :math:`[k]` to :math:`S`. The element :math:`f(0)` is the first choice; :math:`f(1)` is the second choice, which has to be distinct from :math:`f(0)`; :math:`f(2)` is the third choice, which has to be distinct from :math:`f(0)` and :math:`f(1)`; and so on.

----

**Theorem.** Let :math:`A` and :math:`B` be finite sets, with :math:`|A| = k` and :math:`|B| = n`, and :math:`k \le n`. The number of injective functions from :math:`A` to :math:`B` is :math:`n \cdot (n - 1) \cdot \ldots \cdot (n - k + 1)`.

**Proof.** Using induction on :math:`k`, we will show that for every :math:`A`, :math:`B`, and :math:`n \geq k`, the claim holds. When :math:`k = 0` there is only one injective function, namely the function with empty domain. Suppose :math:`A` has cardinality :math:`k + 1`, let :math:`a_0` be any element of :math:`A`. Then any injective function from :math:`A` to :math:`B` can be obtained by choosing an element :math:`b_0` for the image of :math:`a_0`, and then choosing an injective function from :math:`A \setminus \{ a_0 \}` to :math:`B \setminus \{ b_0 \}`. There are :math:`n` choices of :math:`b_0`, and since :math:`| A \setminus \{ a_0 \} | = n - 1` and :math:`|B \setminus \{ b_0 \} | = k - 1`, there are :math:`(n - 1) \cdot \ldots \cdot (n - k + 1)` choices of the injective function, by the inductive hypothesis.

**Theorem.** Let :math:`S` be a finite set, with :math:`|S| = n`. Then the number of ways of making :math:`k` selections from :math:`S` without repetition allowed is :math:`n \cdot (n - 1) \cdot \ldots \cdot (n - k + 1)`.

**Proof.** This is just a restatement of the previous theorem, where :math:`A = [k]` and :math:`B = S`.

----

If :math:`A` is a finite set, a bijection :math:`f` from :math:`A` to :math:`A` is also called a *permutation* of :math:`A`. The previous theorem shows that if :math:`|A| = n` then the number of permutations of :math:`A` is :math:`n \cdot (n - 1) \cdot \ldots \cdot 1`. This quantity comes up so often that it has a name, :math:`n` *factorial*, and a special notation, :math:`n!`. If we think of the elements of :math:`A` listed in some order, a permutation of :math:`A` is essentially an ordered selection of :math:`n` elements from :math:`A` without repetition: we choose where to map the first element, then the second element, and so on. It is a useful convention to take :math:`0!` to be equal to :math:`1`.

The more general case where we are choosing only :math:`k` elements from a set :math:`A` is called a :math:`k`-permutation of :math:`A`. The theorem above says that the number of :math:`k`-permutations of an :math:`n`-element set is equal to :math:`n! / (n - k)!`, because if you expand the numerator and denominator into products and cancel, you get exactly the :math:`n \cdot (n - 1) \cdot \ldots \cdot (n - k + 1)`. This number is often denoted :math:`P(n, k)` or :math:`P^n_k`, or some similar variant. So we have :math:`P(n, k) = n! / (n - k)!`. Notice that the expression on the right side of the equality provides an efficient way of writing the value of :math:`P(n, k)`, but an inefficient way of calculating it.

.. _combinations_and_binomial_coefficients:

Combinations and Binomial Coefficients
--------------------------------------

In the last section, we calculated the number of ways in which a museum could arrange three paintings along a wall, chosen from among 26 paintings in its storeroom. By the final observation in the previous section, we can write this number as :math:`26! / 23!`.

Suppose now we want to calculate the number of ways that a museum can choose three paintings from its storeroom to put on display, where we do not care about the order. In other words, if :math:`a`, :math:`b`, and :math:`c` are paintings, we do not want to distinguish between choosing :math:`a` then :math:`b` then :math:`c` and choosing :math:`c` then :math:`b` then :math:`a`. When we were arranging paintings along all wall, it made sense to consider these two different arrangements, but if we only care about the *set* of elements we end up with at the end, the order that we choose them does not matter.

The problem is that each set of three paintings will be counted multiple times. In fact, each one will be counted six times: there are :math:`3! = 6` permutations of the set :math:`\{a, b, c\}`, for example. So to count the number of outcomes we simply need to divide by 6. In other words, the number we want is :math:`\frac{26!}{3! \cdot 23!}`.

There is nothing special about the numbers :math:`26` and :math:`3`. The same formula holds for what we will call *unordered selections of* :math:`k` *elements from a set of* :math:`n` *elements*, or :math:`k`-*combinations from an* :math:`n`-*element set*. Our goal is once again to describe the situation in precise mathematical terms, at which point we will be able to state the formula as a theorem.

In fact, describing the situation in more mathematical terms is quite easy to do. If :math:`S` is a set of :math:`n` elements, an unordered selection of :math:`k` elements from :math:`S` is just a subset of :math:`S` that has cardinality :math:`k`.

----

**Theorem.** Let :math:`S` be any set with cardinality :math:`n`, and let :math:`k \leq n`. Then the number of subsets of :math:`S` of cardinality :math:`k` is :math:`\frac{n!}{k!(n-k)!}`.

**Proof.** Let :math:`U` be the set of unordered selections of :math:`k` elements from :math:`S`, let :math:`V` be the set of permutations of :math:`[k]`, and let :math:`W` be the set of *ordered* selections of :math:`k` elements from :math:`S`. There is a bijection between :math:`U \times V` and :math:`W`, as follows. Suppose we assign to every :math:`k`-element subset :math:`\{ a_0, \ldots, a_{k-1} \}` of :math:`S` some way of listing the elements, as shown. Then given any such set and any permutation :math:`f` of :math:`[k]`, we get an ordered the ordered selection :math:`(a_{f(0)}, a_{f(1)}, \ldots, a_{f(k-1)})`. Any ordered selection arises from such a subset and a suitable permutation, so the mapping is surjective. And a different set or a different permutation results in a different ordered selection, so the mapping is injective. 

By the counting principles, we have

.. math::

   P(n, k) = |W| = |U \times V| = |U| \cdot |V| = |U| \cdot k!,

so we have :math:`|U| = P(n,k) / k! = \frac{n!}{k!(n-k)!}`.

**Example.** Someone is going on vacation and wants to choose three outfits from ten in their closet to pack in their suitcase. How many choices do they have?

**Solution.** :math:`\frac{10!}{3! 7!} = \frac{10 \cdot 9 \cdot 8}{3 \cdot 2 \cdot 1} = 120`.

----

The number of unordered selections of :math:`k` elements from a set of size :math:`n`, or, equivalently, the number of :math:`k`-combinations from an :math:`n`-element set, is typically denoted by :math:`\binom{n}{k}`, :math:`C(n, k)`, :math:`C^n_k`, or something similar. We will use the first notation, because it is most common. Notice that :math:`\binom{n}0 = 1` for every :math:`n`; this makes sense, because there is exactly one subset of any :math:`n`-element set of cardinality :math:`0`.

Here is one important property of this function.

----

**Theorem.** For every :math:`n` and :math:`k \leq n`, we have :math:`\binom{n}{k} = \binom{n}{n - k}`.

**Proof.** This is an easy calculation:

.. math::

   \frac{n!}{(n - k)! (n - (n - k))!} = \frac{n!}{(n - k)! k!}.

But it is also easy to see from the combinatorial interpretation: choosing :math:`k` outfits from :math:`n` to take on vacation is the same task as choosing :math:`n - k` outfits to leave home.

----

Here is another important property.

----

**Theorem.** For every :math:`n` and :math:`k`, if :math:`k + 1 \leq n`,
then

.. math::

   \binom{n+1}{k+1} = \binom{n}{k+1} + \binom{n}{k}.

**Proof.** One way to understand this theorem is in terms of the combinatorial interpretation. Suppose you want to choose :math:`k+1` outfits out of :math:`n + 1`. Set aside one outfit, say, the blue one. Then you have two choices: you can either choose :math:`k+1` outfits from the remaining ones, with :math:`\binom{n}{k+1}` possibilities; or you can take the blue one, and choose :math:`k` outfits from the remaining ones.

The theorem can also be proved by direct calculation. We can express the left-hand side of the equation as follows:

.. math::

   \binom{n+1}{k+1} & = \frac{(n + 1)!}{(k+1)!((n+1)-(k+1))!} \\ & = \frac{(n + 1)!}{(k+1)!(n - k)!}.

Similarly, we can simplify the right-hand side:

.. math::

   \binom{n}{k+1} + \binom{n}{k} & = \frac{n!}{(k+1)!(n-(k+1))!} + \frac{n!}{k!(n-k)!} \\
   & = \frac{n!(n-k)}{(k+1)!(n-k-1)!(n-k)} + \frac{(k+1)n!}{(k+1)k!(n-k)!} \\
   & = \frac{n!(n-k)}{(k+1)!(n-k)!} + \frac{(k+1)n!}{(k+1)!(n-k)!} \\
   & = \frac{n!(n-k + k + 1)}{(k+1)!(n-k)!} \\
   & = \frac{n!(n + 1)}{(k+1)!(n-k)!} \\
   & = \frac{(n + 1)!}{(k+1)!(n-k)!}.

Thus the left-hand side and the right-hand side are equal.

----

For every :math:`n`, we know :math:`\binom{n}{0} = \binom{n}{n} = 1`. The previous theorem then gives a recipe to compute all the binomial coefficients: once we have determine :math:`\binom{n}{k}` for some :math:`n` and every :math:`k \leq n`, we can determine the values of :math:`\binom{n+1}{k}` for every :math:`k \leq n + 1` using the recipe above. The results can be displayed graphically in what is known as *Pascal's triangle*:

.. commented out csv-table::
   :align: center

   ,,,,1
   ,,,1,,1
   ,,1,,2,,1
   ,1,,3,,3,,1
   1,,4,,6,,4,,1

.. raw:: html

   <img src="_static/combinatorics.1.png">

.. raw:: latex

   \begin{center}
   \begin{tabular}{rccccccccc}
       &    &    &    &  1 \\\noalign{\smallskip\smallskip}
       &    &    &  1 &    &  1 \\\noalign{\smallskip\smallskip}
       &    &  1 &    &  2 &    &  1 \\\noalign{\smallskip\smallskip}
       &  1 &    &  3 &    &  3 &    &  1 \\\noalign{\smallskip\smallskip}
     1 &    &  4 &    &  6 &    &  4 &    &  1 \\\noalign{\smallskip\smallskip}
   \end{tabular}
   \end{center}

Specifically, if we start counting at :math:`0`, the :math:`k`\ th element of the :math:`n`\ th row is equal to :math:`\binom{n}{k}`.

There is also a connection between :math:`\binom{n}{k}` and the polynomials :math:`(a + b)^n`, namely, that the :math:`k`\ th coefficient of :math:`(a + b)^n` is exactly :math:`\binom{n}{k}`. For example, we have

.. math::

   (a + b)^4 = a^4 + 4 a^3 b + 6 a^2 b^2 + 4 a b^3 + b^4.

For that reason, the values :math:`\binom{n}{k}` are often called *binomial coefficients*, and the statement that

.. math::

   (a + b)^n = \sum_{k \le n} \binom{n}{k} a^{n-k} b^k

is known as the *binomial theorem*.

There are a couple of ways of seeing why this theorem holds. One is to expand the polynomial,

.. math::

   (a + b)^n = (a + b) (a + b) \cdots (a + b)

and notice that the coefficient of the term :math:`a^{n-k} b^k` is equal to the number of ways of taking the summand :math:`b` in exactly :math:`k` positions, and :math:`a` in the remaining :math:`n - k` positions. Another way to prove the result is to use induction on :math:`n`, and use the identity :math:`\binom{n+1}{k+1} = \binom{n}{k+1} + \binom{n}{k}`. The details are left as an exercise.

Finally, we have considered ordered selections with and without repetitions, and unordered selections without repetitions. What about unordered selections with repetitions? In other words, given a set :math:`S` with :math:`n` elements, we would like to know how many ways there are of making :math:`k` choices, where we can choose elements of :math:`S` repeatedly, but we only care about the number of times each element was chosen, and not the order. We have the following:

----

The number of unordered selections of :math:`k` elements from an :math:`n`-element set, with repetition, is :math:`\binom{n + k - 1}{k}`.

----

A proof of this is outlined in the exercises.

The Inclusion-Exclusion Principle
---------------------------------

Let :math:`A` and :math:`B` be any two subsets of some domain, :math:`U`. Then :math:`A = A \setminus B \cup (A \cap B)`, and the two sets in the union are disjoint, so we have :math:`|A| = |A \setminus B| + |A \cap B|`. This means :math:`|A \setminus B| = |A| - |A \cap B|`. Intuitively, this makes sense: we can count the elements of :math:`A \setminus B` by counting the elements in :math:`A`, and then subtracting the number of elements that are in both :math:`A` and :math:`B`.

Similarly, we have :math:`A \cup B = A \cup (B \setminus A)`, and the two sets on the right-hand side of this equation are disjoint, so we
have

.. math::

     |A \cup B| = |A| + |B \setminus A| = |A| + |B| - |A \cap B|.

If we draw a Venn diagram, this makes sense: to count the elements in :math:`A \cup B`, we can add the number of elements in :math:`A` to the number of elements in :math:`B`, but then we have to subtract the number of elements of both.

What happen when there are three sets? To compute :math:`|A \cup B \cup C|`, we can start by adding the number of elements in each, and then subtracting the number of elements of :math:`| A \cap B |`, :math:`|A \cap C|`, and :math:`|B \cap C|`, each of which have been double-counted. But thinking about the Venn diagram should help us realize that then we have over-corrected: each element of :math:`A \cap B \cap C` was counted three times in the original sum, and the subtracted three times. So we need to add them back in:

.. math::

     | A \cup B \cup C | = | A | + | B | + | C | - | A \cap B | - | A \cap C | - | B \cap C | + | A \cap B \cap C |. 

This generalizes to any number of sets. To state the general result, suppose the sets are numbered :math:`A_0, \ldots, A_{n-1}`. For each nonempty subset :math:`I` of :math:`\{0, \ldots, n-1 \}`, consider :math:`\bigcap_{i \in I} A_i`. If :math:`|I|` is odd (that is, equal to 1, 3, 5, …) we want to add the cardinality of the intersection; if it is even we want to subtract it. This recipe is expressed compactly by the following formula:

.. math::

   \left| \bigcup_{i < n} A_i \right| = \sum_{\emptyset \ne I \subseteq [n]} (-1)^{|I|} \left| \bigcap_{i \in I} A_i \right| .

You are invited to try proving this as an exercise, if you are ambitious. The following example illustrates its use:

----

**Example.** Among a group of college Freshmen, 30 are taking Logic, 25 are taking History, and 20 are taking French. Moreover, 11 are taking Logic and History, 10 are taking Logic and French, 7 are taking History and French, and 3 are taking all three. How many students are taking at least one of the three classes?

**Solution.** Letting :math:`L`, :math:`H`, and :math:`F` denote the sets of students taking Logic, History, and French, respectively, we have

.. math::

   | L \cup H \cup F | = 30 + 25 + 20 - 11 - 10 - 7 + 3 = 50. 

----

Exercises
---------

#. Suppose that, at a party, every two people either know each other or don't. In other words, ":math:`x` knows :math:`y`" is symmetric. Also, let us ignore the complex question of whether we always know ourselves by restricting attention to the relation between distinct people; in other words, for this problem, take ":math:`x` knows :math:`y`" to be irreflexive as well.

   Use the pigeonhole principle (and an additional insight) to show that there must be two people who know exactly the same number of people.

#. Show that in any set of :math:`n + 1` integers, two of them are equivalent modulo :math:`n`.

#. Spell out in detail a proof of the second counting principle in :numref:`counting_principles`.

#. An ice cream parlor has 31 flavors of ice cream.

   a. Determine how many three-flavor ice-cream cones are possible, if we care about the order and repetitions are allowed. (So choosing chocolate-chocolate-vanilla scoops, from bottom to top, is different from choosing chocolate-vanilla-chocolate.)

   b. Determine how many three flavor ice-cream cones are possible, if we care about the order, but repetitions are not allowed.

   c. Determine how many three flavor ice-cream cones are possible, if we don't care about the order, but repetitions are not allowed.

#. A club of 10 people has to elect a president, vice president, and secretary. How many possibilities are there:

   a. if no person can hold more than one office?

   b. if anyone can hold any number of those offices?

   c. if anyone can hold up to two offices?

   d. if the president cannot hold another office, but the vice president and secretary may or may not be the same person?

#. How many 7 digit phone numbers are there, if any 7 digits can be used? How many are there is the first digit cannot be 0?

#. In a class of 20 kindergarten students, two are twins. How many ways are there of lining up the students, so that the twins are standing together?

#. A woman has 8 murder mysteries sitting on her shelf, and wants to take three of them on a vacation. How many ways can she do this?

#. In poker, a "full house" is a hand with three of one rank and two of another (for example, three kings and two fives). Determine the number of full houses in poker.

#. We saw in :numref:`combinations_and_binomial_coefficients` that

   .. math::

      \binom{n+1}{k+1} = \binom{n}{k+1} + \binom{n}{k}.

   Replacing :math:`k + 1` by :math:`k`, whenever :math:`1 \leq k \leq n`, we have

   .. math::

      \binom{n+1}{k} = \binom{n}{k} + \binom{n}{k-1}.

   Use this to show, by induction on :math:`n`, that for every :math:`k \leq n`, that if :math:`S` is any set of :math:`n` elements, :math:`\binom{n}{k}` is the number of subsets of :math:`S` with :math:`k` elements.

#. How many distinct arrangements are there of the letters in the word MISSISSIPPI?

   (Hint: this is tricky. First, suppose all the S's, I's, and P's were painted different colors. Then determine how many distinct arrangements of the letters there would be. In the absence of distinguishing colors, determine how many times each configuration appeared in the first count, and divide by that number.

#. Prove the inclusion exclusion principle.

#. Use the inclusion exclusion principle to determine the number of integers less than 100 that are divisible by 2, 3, or 5.

#. Show that the number of *unordered* selections of :math:`k` elements from an :math:`n`-element set is :math:`\binom{n + k - 1}{k}`.

   Hint: consider :math:`[n]`. We need to choose some number :math:`i_0` of 0's, some number :math:`i_1` of 1's, and so on, so that :math:`i_0 + i_1 + \ldots + i_{n-1} = k`. Suppose we assign to each such tuple a the following binary sequence: we write down :math:`i_0` 0's, then a 1, then :math:`i_1` :math:`0's`, then a 1, then :math:`i_2` 0's, and so on. The result is a binary sequence of length :math:`n + k - 1` with exactly :math:`k` 1's, and such binary sequence arises from a unique tuple in this way.
