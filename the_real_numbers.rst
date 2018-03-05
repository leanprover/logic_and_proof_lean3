.. _the_real_numbers:

The Real Numbers
================

The Number Systems
------------------

We have already come across some of the fundamental number systems: the natural numbers, :math:`\mathbb{N}`, the integers, :math:`\mathbb{Z}`, and the rationals, :math:`\mathbb{Q}`. In a sense, each subsequent element of the list was designed to remedy defects in the previous system. We can subtract any integer from any other integer and end up with another integer, and we can divide any rational number by a nonzero rational number and end up with a rational number.

The integers satisfy all of the following properties:

-  Addition is associative and commutative.
-  There is an additive identity, :math:`0`, and every element :math:`x` has an additive inverse, :math:`-x`.
-  Multiplication is associative and commutative.
-  There is a multiplicative identity, :math:`1`. 
-  Multiplication distributes over addition: for every :math:`x`, :math:`y`, and :math:`z`, we have :math:`x (y + z) = x y + x z`.
-  The ordering :math:`\leq` is a total order.
-  For any elements :math:`x`, :math:`y`, and :math:`z`, if :math:`x \leq y` then :math:`x + z \leq y + z`.
-  For any elements :math:`x` and :math:`y`, if :math:`0 \leq x` and :math:`0 \leq y` then :math:`0 \leq x y`.

The first five clauses say that with :math:`\times`, :math:`+`, :math:`0`, and :math:`1`, the integers form a *commutative ring*, and the last three say that together with :math:`\leq`, the structure is an *ordered ring*. The natural numbers lack additive inverses, so they satisfy a slightly weaker set of axioms that make them an *ordered semiring*. On the other hand, the rational numbers also form an ordered ring, satisfying the following additional property:

-  Every nonzero element has a multiplicative inverse, :math:`x^{-1}`.

This makes them an instance of an *ordered field*.

It is worth knowing that once we have the natural numbers, it is possible to *construct* the integers and rational numbers, using set-theoretic constructions you have already seen. For example, we can take an integer to be a pair :math:`(i, n)` of natural numbers where :math:`i` is either 0 or 1, with the intention that :math:`(0, n)` represents the positive integer :math:`n`, and :math:`(1, n)` represents the negative integer :math:`-(n+1)`. (We use :math:`-(n+1)` instead of :math:`-n` to avoid having two representations of :math:`0`.) With this definition, the integers are simply :math:`\{0, 1\} \times \mathbb{N}`. We can then go on to define the operations of addition and multiplication, the additive inverse, and the order relation, and prove they have the desired properties.

This construction has the side effect that the natural numbers themselves are not integers; for example, we have to distinguish between the natural number :math:`2` and the integer :math:`2`. This is the case in Lean. In ordinary mathematics, it is common to think of the natural numbers as a subset of the integers. Once we construct the integers, however, we can throw away the old version of the natural numbers, and afterwards identify the natural numbers as nonnegative integers.

We can do the same for the rationals, defining them to be the set of pairs :math:`(a, b)` in :math:`\mathbb{Z} \times \mathbb{N}`, where either :math:`a = 0` and :math:`b = 1`, or :math:`b > 0` and :math:`a` and :math:`b` have no common divisor (other than :math:`1` and :math:`-1`). The idea is that :math:`(a, b)` represents :math:`a / b`. With this definition, the rationals are really a subset of :math:`\mathbb{Z} \times \mathbb{N}`, and we can then define all the operations accordingly.

In the next section, we will define a more sophisticated approach, one which will scale to a definition of the real numbers. And in a later chapter, we will show how to construct the natural numbers from the axioms of set theory. This shows that we can construct all the number systems from the bottom up.

But first, let us pause for a moment to consider why the real numbers are needed. We have seen that :math:`2` has no rational square root. This means, in a sense, that there is a "gap" in the rationals: the are rationals whose squares are arbitrarily close to 2, but there is no rational :math:`x` with the property that :math:`x^2 = 2`. But it seems intuitively clear that there should be some *number* with that property: :math:`\sqrt{2}` is the length of the diagonal of a square with side length :math:`1`. Similarly, :math:`\pi`, the area of a circle with radius 1, is missing from the rationals. These are the kinds of defects that the real numbers are designed to repair.

You may be used to thinking of real numbers as (potentially) infinite decimals: for example, :math:`\sqrt{2} = 1.41421356\ldots` and :math:`\pi = 3.14159265\ldots`. A central goal of this chapter is to make the "..." precise. The idea is that we can take an infinite decimal to represent a sequence of rational approximations. For example, we can approximate the square root of 2 with the sequence :math:`1, 1.4, 1.41, 1.414, \ldots`. We would like to define :math:`\sqrt{2}` to be the "limit" of that sequence, but we have seen that the sequence does not have a limit in the rationals. So we have to construct new objects, the real numbers, to serve that purpose.

In fact, we will define the real numbers, more or less, to *be* such sequences of rational approximations. But we will have to deal with the fact that, for example, there are *lots* of ways of approximating the square root of two. For example, we can just as well approach it from above, :math:`2, 1.5, 1.42, \ldots`, or by oscillating above and below. The next section will show us how to "glue" all these sequences together and treat them as a single object.

.. _quotient_constructions:

Quotient Constructions
----------------------

Let :math:`A` be any set, and let :math:`\equiv` be any equivalence relation on :math:`A`. Recall from :numref:`equivalence_relations_and_equality` that we can assign to every element :math:`a` of :math:`A` the equivalence class :math:`[a]`, where :math:`b \in [a]` means :math:`b \equiv a`. This assignment has the property that for every :math:`a` and :math:`b`, :math:`a \equiv b` if and only if :math:`[a] = [b]`.

Given any set :math:`A` and equivalence relation :math:`\equiv`, define :math:`A / \mathord{\equiv}` to be the set :math:`\{ [ a ] \mid a \in A \}` of *equivalence classes* of :math:`A` modulo :math:`\equiv`. This set is called ":math:`A` modulo :math:`\mathord{\equiv}`," or the *quotient* of :math:`A` by :math:`\equiv`. You can think of this as the set :math:`A` where equivalent elements are "glued together" to make a coarser set.

For example, if we consider the integers :math:`\mathbb{Z}` with :math:`\equiv` denoting equivalence modulo 5 (as in :numref:`modular_arithmetic`), then :math:`\mathbb{Z} / \mathord{\equiv}` is just :math:`\{ [0], [1], [2], [3], [4] \}`. We can define addition on :math:`\mathbb{Z} / \mathord{\equiv}` by :math:`[a] + [b] = [a + b]`. For this definition to make sense, it is important to know that the right-hand side does not depend on which representatives of :math:`[a]` and :math:`[b]` we choose. In other words, we need to know that whenever :math:`[a] = [a']` and :math:`[b] = [b']`, then :math:`[a + b] = [a' + b']`. This, in turn, is equivalent to saying that if :math:`a \equiv a'` and :math:`b \equiv b'`, then :math:`a + b \equiv a' + b'`. In other words, we require that the operation of addition *respects* the equivalence relation, and we saw in :numref:`modular_arithmetic` that this is in fact the case.

This general strategy for transferring a function defined on a set to a function defined on a quotient of that set is given by the following theorem.

----

**Theorem.** Let :math:`A` and :math:`B` be any sets, let :math:`\equiv` be any equivalence relation defined on :math:`A`, and let :math:`f : A \to B`. Suppose :math:`f` respects the equivalence relation, which is to say, for every :math:`a` and :math:`a'` in :math:`A`, if :math:`a \equiv a'`, then :math:`f(a) = f(a')`. Then there is a unique function :math:`\bar f : A / \mathord{\equiv} \to B`, defined by :math:`\bar f ([a]) = f(a)` for every :math:`a` in :math:`A`.

**Proof.** We have defined the value of :math:`\bar f` on an equivalence class :math:`x` by writing :math:`x = [a]`, and setting :math:`\bar f(x) = f(a)`. In other words, we say that :math:`\bar f(x) = y` if and only if there is an :math:`a` such that :math:`x = [a]`, and :math:`f(a) = y`. What is dubious about the definition is that, a priori, it might depend on how we express :math:`x` in that form; in other words, we need to show that there is a *unique* :math:`y` meeting this description. Specifically, we need to know that if :math:`x = [a] = [a']`, then :math:`f(a) = f(a')`. But since :math:`[a] = [a']` is equivalent to :math:`a \equiv a'`, this amounts to saying that :math:`f` respects the equivalence relation, which is exactly what we have assumed.

----

Mathematicians often "define" :math:`\bar f` by the equation :math:`\bar f ([a])= f(a)`, and then express the proof above as a proof that ":math:`\bar f` is well defined." This is confusing. What they really mean is what the theorem says, namely, that there is a unique function meeting that description.

To construct the integers, start with :math:`\mathbb{N} \times \mathbb{N}`. Think of the pair of natural numbers :math:`(m, n)` as representing :math:`m - n`, where the subtraction takes place in the integers (which we haven't constructed yet!). For example, both :math:`(2, 5)` and :math:`(6, 9)` represent the integer :math:`-3`. Intuitively, the pairs :math:`(m, n)` and :math:`(m', n')` will represent the same integer when :math:`m - n = m' - n'`, but we cannot say this yet, because we have not yet defined the appropriate notion of subtraction. But the equation is equivalent to :math:`m + n' = m' + n`, and *this* makes sense with addition on the natural numbers.

----

**Definition.** Define the relation :math:`\equiv` on :math:`\mathbb{N} \times \mathbb{N}` by :math:`(m, n) \equiv (m', n')` if and only if :math:`m + n' = m' + n`.

**Proposition.** :math:`\equiv` is an equivalence relation.

**Proof.** For reflexivity, it is clear that :math:`(m, n) \equiv (m, n)`, since :math:`m + n = m + n`.

For symmetry, suppose :math:`(m, n) \equiv (m', n')`. This means :math:`m + n' = m' + n`. But the symmetry of equality implies :math:`(m', n') \equiv (m, n)`, as required.

For transitivity, suppose :math:`(m, n) \equiv (m', n')`, and :math:`(m', n') = (m'', n'')`. Then we have :math:`m + n' = m' + n` and :math:`m' + n'' = n' + m''`. Adding these equations, we get

.. math::

   m + n' + m' + n'' = m' + n + n' + m''.

Subtracting :math:`m' + n'` from both sides, we get :math:`m + n'' = n + m''`, which is equivalent to :math:`(m, n) = (m'', n'')`, as required.

----

We can now define the integers to be :math:`\mathbb{N} \times \mathbb{N} / \mathord{\equiv}`. How should we define addition? If :math:`[(m, n)]` represents :math:`m - n`, and :math:`[(u, v)]` represents :math:`u - v`, then :math:`[(m, n)] + [(u, v)]` should represent :math:`(m + u) - (n + v)`. Thus, it makes sense to define :math:`[(m, n)] + [(u, v)]` to be :math:`[(m + u) - (n + v)]`. For this to work, we need to know that the operation which sends :math:`(m, n)` and :math:`(u, v)` to :math:`(m + u, n + v)` respects the equivalence relation.

----

**Proposition.** If :math:`(m, n) \equiv (m', n')` and :math:`(u, v) \equiv (u', v')`, then :math:`(m + u, n + v) \equiv (m' + u', n' + v')`.

**Proof.** The first equivalence means :math:`m + n' = m' + n`, and the second means :math:`u + v' = u' + v`. Adding the two equations, we get :math:`(m + u) + (n' + v') \equiv (m' + u') + (n + v)`, which is exactly the same as saying :math:`(m + u, n + v) \equiv (m' + u', n' + v')`.

----

Every natural number :math:`n` can be represented by the integer :math:`[(n, 0)]`, and, in particular, :math:`0` is represented by :math:`[(0, 0)]`. Moreover, if :math:`[(m, n)]` is any integer, we can define its negation to be :math:`[(n, m)]`, since :math:`[(m, n)] + [(n, m)] = [(m + n, n + m)] = [(0, 0)]`, since :math:`(m + n, n + m) \equiv (0, 0)`. In short, we have "invented" the negative numbers!

We could go on this way to define multiplication and the ordering on the integers, and prove that they have the desired properties. We could also carry out a similar construction for the rational numbers. Here, we would start with the set :math:`\mathbb{Z} \times \mathbb{Z}^{>0}`, where :math:`\mathbb{Z}^{>0}` denotes the strictly positive integers. The idea, of course, is that :math:`(a, b)` represents :math:`(a / b)`. With that in mind, it makes sense to define :math:`(a, b) \equiv (c, d)` if :math:`a d = b c`. We could go on to define addition, multiplication, and the ordering there, too. The details are tedious, however, and not very illuminating. So we turn, instead, to a construction of the real numbers.

Constructing the Real Numbers
-----------------------------

The problem we face is that the sequence :math:`1, 1.4, 1.41, 1.414, 1.4142, \ldots` of rational numbers seems to approach a value that *would* be the square root of 2, but there is no rational number that can play that role. The next definition captures the notion that this sequence of numbers "seems to approach a value," without referring to a value that it is approaching.

----

**Definition.** A sequence of rational numbers :math:`(q_i)_{i \in \mathbb{N}}` is *Cauchy* if for every rational number :math:`\varepsilon > 0`, there is some natural number :math:`N \in \mathbb{N}` such that for all :math:`i, j \geq N`, we have that :math:`|q_i - q_j| < \varepsilon`.

----

Roughly speaking, a Cauchy sequence is one where the elements become arbitrarily close, not just to their successors but to all following elements. It is common in mathematics to use :math:`\varepsilon` to represent a quantity that is intended to denote something small; you should read the phrase "for every :math:`\varepsilon > 0`" as saying "no matter how small :math:`\varepsilon` is." So a sequence is Cauchy if, for any :math:`\varepsilon > 0`, no matter how small, there is some point :math:`N`, beyond which the elements stay within a distance of :math:`\varepsilon` of one another.

Cauchy sequences can be used to describe these gaps in the rationals, but, as noted above, many Cauchy sequences can be used to describe the same gap. At this stage, it is slightly misleading to say that they "approach the same point," since there is no rational point that they approach; a more precise statement is that the sequences eventually become arbitrarily close.

----

**Definition.** Two Cauchy sequences :math:`p = (p_i)_{i \in \mathbb{N}}` and :math:`q = (q_i)_{i \in \mathbb{N}}` are *equivalent* if for every rational number :math:`\varepsilon > 0`, there is some natural number :math:`N \in \mathbb{N}` such that for all :math:`i \geq N`, we have that :math:`|p_i - q_i| < \varepsilon`. We will write :math:`p \equiv q` to express that :math:`p` is equivalent to :math:`q`.

**Proposition.** :math:`\equiv` is an equivalence relation on Cauchy sequences.

**Proof.** Reflexivity and symmetry are easy, so let us prove transitivity. Suppose :math:`(p_i) \equiv (q_i)` and :math:`(q_i) \equiv (r_i)`. We want to show that the sequence :math:`(q_i)` is equivalent to :math:`(r_i)`. So, given any :math:`\varepsilon > 0`, choose :math:`N_0` large enough such that for every :math:`i \ge N_0`, :math:`|p_i - q_i| < \varepsilon / 2`. Choose another number, :math:`N_1`, so that for every :math:`i \geq N_1`, :math:`|q_i - r_i| < \varepsilon / 2`. Let :math:`N = \max(N_0, N_1)`. Then for every :math:`i \geq N`, we have

.. math::

    |p_i - r_i | = |(p_i - q_i) + (q_i - r_i)| < |p_i - q_i| + |q_i - r_i| \leq \varepsilon / 2 + \varepsilon / 2 = \varepsilon,

as required.

----

Notice that the proof uses the *triangle inequality*, which states for any rational numbers :math:`a` and :math:`b`, :math:`|a + b| \leq |a| + |b|`. If we define :math:`|a|` to be the maximum of :math:`a` and :math:`-a`, the triangle inequality in fact holds for any ordered ring:

----

**Theorem.** Let :math:`a` and :math:`b` be elements of any ordered ring. Then :math:`|a + b| \leq |a| + |b|`.

**Proof.** By the definition of absolute value, it suffices to show that :math:`a + b \leq |a| + |b|` and :math:`-(a + b) \leq |a| + |b|`. The first claim follows from the fact that :math:`a \leq |a|` and :math:`b \leq |b|`. For the second claim, we similarly have :math:`-a \leq |a|` and :math:`-b \leq |b|`, so :math:`-(a + b) = -a + - b \leq |a| + |b|`.

----

In the theorem above, if we let :math:`a = x - y` and :math:`b = y - z`, we get :math:`|x - z| \leq |x - y| + |y - z|`. The fact that :math:`|x - y|` represents the distance between :math:`x` and :math:`y` on the number line explains the name: for any three "points" :math:`x`, :math:`y`, and :math:`z`, the distance from :math:`x` to :math:`z` can't be any greater than the distance from :math:`x` to :math:`y` plus the distance from :math:`y` to :math:`z`.

We now let :math:`A` be the set of Cauchy sequences of rationals, and define the real numbers, :math:`\mathbb{R}`, to be :math:`A / \mathord{\equiv}`. In other words, the real numbers are the set of Cauchy sequence of rationals, modulo the equivalence relation we just defined.

Having the set :math:`\mathbb{R}` by itself is not enough: we also would like to know how to add, subtract, multiply, and divide real numbers. As with the integers, we need to define operations on the underlying set, and then show that they respect the equivalence relation. For example, we will say how to add Cauchy sequences of rationals, and then show that if :math:`p_1 \equiv p_2` and :math:`q_1 \equiv q_2`, then :math:`p_1 + q_1 \equiv p_2 + q_2`. We can then lift this definition to :math:`\mathbb{R}` by defining :math:`[p] + [q]` to be :math:`[p + q]`.

Luckily, it is easy to define addition, subtraction, and multiplication on Cauchy sequences. If :math:`p = (p_i)_{i \in \mathbb{N}}` and :math:`q = (q_i)_{i \in \mathbb{N}}` are Cauchy sequences, let :math:`p + q = (p_i + q_i)_{i \in \mathbb{N}}`, and similarly for subtraction and multiplication. It is trickier to show that these sequences are Cauchy themselves, and to show that the operations have the appropriate algebraic properties. We ask you to prove some of these properties in the exercises.

We can identify each rational number :math:`q` with the constant Cauchy sequence :math:`q, q, q, \ldots`, so the real numbers include all the rationals. The next step is to abstract away the details of the particular construction we have chosen, so that henceforth we can work with the real numbers abstractly, and no longer think of them as given by equivalence classes of Cauchy sequences of rationals.

The Completeness of the Real Numbers
------------------------------------

We constructed the real numbers to fill in the gaps in the rationals. How do we know that we have got them all? Perhaps we need to construct even more numbers, using Cauchy sequences of reals? The next theorem tells us that, on the contrary, there is no need to extend the reals any further in this way.

----

**Definition.** Let :math:`r` be a real number. A sequence :math:`(r_i)_{i \in \mathbb{N}}` of real numbers *converges* to :math:`r` if, for every :math:`\varepsilon > 0`, there is an :math:`N` such that for every :math:`i \geq N`, :math:`|r_i - r| < \varepsilon`.

**Definition.** A sequence :math:`(r_i)_{i \in \mathbb{N}}` *converges* if it converges to some :math:`r`.

**Theorem.** Every Cauchy sequence of real numbers converges.

----

The statement of the theorem is often expressed by saying that the real numbers are *complete*. Roughly, it says that everywhere you look for a real number, you are bound to find one. Here is a similar principle.

----

**Definition.** An element :math:`u \in \mathbb{R}` is said to be an *upper bound* to a subset :math:`S \subseteq \mathbb{R}` if everything in :math:`S` is less than or equal to :math:`u`. :math:`S` is said to be *bounded* if there is an upper bound to :math:`S`. An element :math:`u` is said to be a *least upper bound* to :math:`S` if it is an upper bound to :math:`S`, and nothing smaller than :math:`u` is an upper bound to :math:`S`.

**Theorem.** Let :math:`S` be a bounded, nonempty subset of :math:`\mathbb{R}`. Then :math:`S` has a least upper bound.

----

The rational numbers do not have this property: if we set :math:`S = \{x \in \mathbb{Q} \mid x^2 < 2\}`, then the rational number 2 is an upper bound for :math:`S`, but :math:`S` has no least upper bound in :math:`\mathbb{Q}`.

It is a fundamental theorem that the real numbers are characterized exactly by the property that they are a complete ordered field, such that every real number :math:`r` is less than or equal to some natural number :math:`N`. Any two models that meet these requirements must behave in exactly the same way, at least insofar as the constants :math:`0` and :math:`1`, the operations :math:`+` and :math:`*`, and the relation :math:`\leq` are concerned. This fact is extremely powerful because it allows us to avoid thinking about the Cauchy sequence construction in normal mathematics. Once we have shown that our construction meets these requirements, we can take :math:`\mathbb{R}` to be "the" unique complete totally ordered field and ignore any implementation details. We are also free to implement :math:`\mathbb{R}` in any way we choose, and as long as it meets this interface, and as long as they do not refer to the underlying representations, any theorems we prove about the reals will hold equally well for all constructions.

.. TODO(Jeremy) [More needed here.]

An Alternative Construction
---------------------------

Many sources use an alternative construction of the reals, taking them instead to be *Dedekind cuts*. A Dedekind cut is an ordered pair :math:`(A, B)` of sets of rational numbers with the following properties:

-  Every rational number :math:`q` is in either :math:`A` or :math:`B`.
-  Each :math:`a \in A` is less than every :math:`b \in B`.
-  There is no greatest element of :math:`A`.
-  :math:`A` and :math:`B` are both nonempty.

The first two properties show why we call this pair a "cut." The set :math:`A` contains all of the rational numbers to the left of some mark on the number line, and :math:`B` all of the points to the right. The third property tells us something about what happens exactly at that mark. But there are two possibilities: either :math:`B` has a least element, or it doesn't. Picturing the situation where :math:`A` has no greatest element and :math:`B` has no least element may be tricky, but consider the example :math:`A = \{x \in \mathbb{Q} \mid x^2 < 2\}` and :math:`B = \{x \in \mathbb{Q} \mid x^2 > 2\}`. There is no rational number :math:`q` such that :math:`q^2 = 2`, but there are rational numbers on either side that are arbitrarily close; thus neither :math:`A` nor :math:`B` contains an endpoint.

We can define :math:`\mathbb{R}` to be the set of Dedekind cuts. A Dedekind cut :math:`(A, B)` corresponds to a rational number :math:`q` if :math:`q` is the least element of :math:`B`, and to an irrational number if :math:`B` has no least element. It is straightforward to define addition on :math:`\mathbb{R}`:

.. math::

    (A_1, B_1) + (A_2, B_2) = ( \{a_1 + a_2 \mid a_1 \in A_1, a_2 \in A_2 \}, \{b_1 + b_2 \mid b_1 \in B_1, b_2 \in B_2 \} ).

Some authors prefer this construction to the Cauchy sequence construction because it avoids taking the quotient of a set, and thus removes the complication of showing that arithmetic operations respect equivalence. Others prefer Cauchy sequences since they provide a clearer notion of approximation: if a real number :math:`r` is given by a Cauchy sequence :math:`(q_i)_{i \in \mathbb{N}}`, then an arbitrarily close rational approximation of :math:`r` is given by :math:`q_N` for a sufficiently large :math:`N`.

For most mathematicians most of the time, though, the difference is immaterial. Both constructions create complete linear ordered fields, and in a certain sense, they create the *same* complete linear ordered field. Strictly speaking, the set of Cauchy reals is not equal to the set of Dedekind reals, since one consists of equivalence classes of rational Cauchy sequences and one consists of pairs of sets of rationals. But there is a bijection between the two sets that preserves the field properties. That is, there is a bijection :math:`f` from the Cauchy reals to the Dedekind reals such that

-  :math:`f(0)=0`
-  :math:`f(1)=1`
-  :math:`f(x+y)=f(x)+f(y)`
-  :math:`f(x \cdot y)=f(x) \cdot f(y)`
-  :math:`f(-x)=-f(x)`
-  :math:`f(x^{-1})=f(x)^{-1}`
-  :math:`f(x) \leq f(y) \iff x \leq y`

We say that the two constructions are *isomorphic*, and that the function :math:`f` is an *isomorphism*. Since we often only care about the real numbers in regard to their status as a complete ordered field, and the two constructions are indistinguishable as ordered fields, it makes no difference which construction is used.

Exercises
---------

#. Show that addition for the integers, as defined in :numref:`quotient_constructions`, is commutative and associative.

#. Show from the construction of the integers in :numref:`quotient_constructions` that :math:`a + 0 = a` for every integer :math:`a`.

#. Define subtraction for the integers by :math:`a - b = a + (-b)`, and show that :math:`a - b + b = a` for every pair of integers :math:`a` and :math:`b`.

#. Define multiplication for the integers, by first defining it on the underlying representation and then showing that the operation respects the equivalence relation.

#. Show that every Cauchy sequence is bounded: that is, if :math:`(q_i)_{i \in \mathbb{N}}` is Cauchy, there is some rational :math:`M` such that :math:`|q_i| \leq M` for all :math:`i`. Hint: try letting :math:`\varepsilon = 1`.

#. Let :math:`p = (p_i)_{i \in \mathbb{N}}` and :math:`q = (q_i)_{i \in \mathbb{N}}` be Cauchy sequences. Define :math:`p + q = (p_i + q_i)_{i \in \mathbb{N}}` and :math:`p q = (p_i  q_i)_{i \in \mathbb{N}}`.

   a. Show that :math:`p + q` is Cauchy. That is, for arbitrary :math:`\varepsilon > 0`, show that there exists an :math:`N` such that for all :math:`i, j \geq N`, :math:`|(p_i + q_i) - (p_j + q_j)| < \varepsilon`.

   b. Show that :math:`p q` is Cauchy. In addition to the triangle inequality, you will find the previous exercise useful.

#. These two parts show that addition of Cauchy sequences respects equivalence.

   a. Show that if :math:`p, p', q` are Cauchy sequences and :math:`p \equiv p'`, then :math:`p + q \equiv p' + q`.

   b. Using the first part of this problem, show that if :math:`p, p', q, q'` are Cauchy sequences, :math:`p \equiv p'`, and :math:`q \equiv q'`, then :math:`p + q \equiv p' + q'`. You can use the fact that addition on the real numbers is commutative.

#. Show that if :math:`(A_1, B_1)` and :math:`(A_2, B_2)` are Dedekind cuts, then :math:`(A_1, B_1) + (A_2, B_2)` is also a Dedekind cut.
