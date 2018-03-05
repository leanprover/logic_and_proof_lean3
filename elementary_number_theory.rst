.. _elementary_number_theory:

Elementary Number Theory
========================

In the last two chapters, we saw that the natural numbers are characterized by the fact that they support *proof by induction* and *definition by recursion*. Moreover, with these components, we can actually define :math:`+`, :math:`\times`, and :math:`<` in a suitable axiomatic foundation, and prove that they have the relevant properties. In :numref:`the_integers` we also discussed the integers, which include negative numbers and support the operation of subtraction.

The natural numbers and the integers are the central components of *number theory*, a branch of mathematics dating back to the ancients. In this chapter, we will discuss some of the rudiments of this subject.

The Quotient-Remainder Theorem
------------------------------

A key property of the integers that we will use here is the quotient-remainder theorem:

----

**Theorem.** Let :math:`n` and :math:`m` be integers with :math:`m > 0`. Then there are integers :math:`q` and :math:`r` satisfying :math:`n = m q + r` and :math:`0 \le r < m`.

**Proof.** First we prove this in the case where :math:`n` is a natural number, in which case use complete induction on :math:`n`. Let :math:`n` be any natural number. If :math:`n < m`, then we can take :math:`q = 0` and :math:`r = n`, and we indeed have :math:`n = m q + r` and :math:`0 \le r < m`. Otherwise, we have :math:`n \geq m`. In this case :math:`n - m` is a natural number smaller than :math:`n`. By induction hypothesis, we know that we can find :math:`q'` and :math:`r'` such that :math:`n - m = m q' + r'` and :math:`0 \le r' < m`. Then we can choose :math:`q = q' + 1` and :math:`r = r'`, and we obtain :math:`n = m q + r` and :math:`0 \le r < m`, as desired.

If :math:`n` is negative, then :math:`-(n+1)` is a natural number, hence we can use the previous part for :math:`-(n+1)` to obtain :math:`q'` and :math:`r'` such that :math:`-(n+1) = m q' + r'` and :math:`0 \le r' < m`. Now let :math:`q = -(q' + 1)` and :math:`r = m - r' - 1`. Then we can compute

.. math::

   m q + r &= -m (q' + 1) + m - r' - 1\\
   &=  -(m q' + r') - m + m - 1\\
   &= -(-(n+1)) - 1\\
   &= n + 1 - 1\\
   &= n.

Also, since :math:`r' \geq 0` we have :math:`r < m` and since :math:`r' < m` we have :math:`r \geq 0`. This completes the proof.

----

Intuitively, :math:`q` is the integer *quotient* when you divide :math:`n` by :math:`m` and :math:`r` is the *remainder*. Remember that using the word "the" presupposes that there are unique values meeting that description. That is, in fact, the case:

----

**Proposition.** If :math:`n` and :math:`m` are as above, :math:`n = m q + r` and :math:`n = m q' + r'` with both :math:`r` and :math:`r'` less than :math:`m`, then :math:`q = q'` and :math:`r = r'`.

**Proof.** By assumption, we have :math:`mq + r = m q' + r'`. It suffices to show that :math:`q = q'`, because then :math:`m q = m q'`, and hence :math:`r = r'`.

Suppose :math:`q \ne q'`. Then either :math:`q < q'` or :math:`q' < q`. Suppose without loss of generality that :math:`q < q'`. (The other case is symmetric.) Then :math:`m q < m q'`, so we can subtract :math:`mq` from both sides of the equality :math:`mq + r = m q' + r'` to obtain

.. math::

   r = m q' + r' - m q = m (q - q') + r'.

But since :math:`q' < q`, we have :math:`q - q' \ge 1`, which means

.. math::

   m (q - q') + r' \ge m + r' \ge m,

which contradicts the fact that :math:`r < m`.

----

Divisibility
------------

We can define divisibility on the integers as follows.

----

**Definition.** Given two integers :math:`m` and :math:`n`, we say that :math:`m` *is a divisor of* :math:`n`, written :math:`m \mid n`, if there exists some integer :math:`k` such that :math:`m \cdot k = n`. We also say that :math:`n` *is divisible by* :math:`m` or that :math:`m` *divides* :math:`n`. We write :math:`m \nmid n` to say that :math:`m` is not a divisor of :math:`n`.

----

We can now prove the following:

----

**Theorem.** The relation :math:`\mid` is reflexive and transitive. Also, if :math:`n \mid m` and :math:`m \mid n`, then :math:`m = \pm n`. This means that restricted to the natural numbers, this relation is a partial order.

**Proof.** Reflexivity is immediate, because :math:`n \cdot 1 = n`, hence :math:`n\mid n`.

For transitivity, suppose :math:`m \mid n` and :math:`n \mid r`. Then there are :math:`k,\ell` such that :math:`m \cdot k = n` and :math:`n \cdot \ell = r`. Now we compute

.. math::

   m \cdot (k \cdot \ell) &= (m \cdot k) \cdot \ell \\
   & = n \cdot \ell  \\
   & = r.

Suppose that :math:`n` and :math:`m` are integers such that :math:`n\mid m` and :math:`m \mid n`. Then there exist :math:`k` and :math:`\ell` such that :math:`n\cdot k = m` and :math:`m \cdot \ell = n`. We distinguish two cases. If :math:`n = 0`, then we have :math:`m = n\cdot k = 0 = n`, so we are done. If :math:`n \neq 0`, then we use the the equations to get :math:`n \cdot k \cdot \ell = m \cdot \ell = n`, and we can cancel :math:`n` on both sides to get :math:`k \cdot \ell = 1`. We conclude that :math:`k = \ell = \pm 1`, hence we get :math:`m = n \cdot k = \pm n`.

Note that this means that if :math:`n` and :math:`m` are both natural numbers, then :math:`n = m`, which means that :math:`\mid` is antisymmetric, and hence a partial order, on the natural numbers.

----

See Exercise 1 for some basic properties of divisibility.

An integer is *even* if it is divisible by :math:`2`, in other words, :math:`n` is even if :math:`2 \mid n`. An integer is *odd* if it is not even. Of course, odd numbers are of the form :math:`2k+1` for some :math:`k`, and we can prove this now.

----

**Theorem.** If :math:`n` is an odd integer, then :math:`n=2k+1` for some integer :math:`k`.

**Proof.** By the quotient-remainder theorem, we can write :math:`n = 2k+r` for some integers :math:`k` and :math:`r` with :math:`0\le r < 2`. The last condition means that :math:`r = 0` or :math:`r = 1`. In the first case, we have :math:`n = 2k`, hence :math:`2 \mid n`, contradicting that :math:`n` is odd. So we have :math:`r = 1`, which means that :math:`n = 2k+1`.

**Theorem.** Every sequence of :math:`k` consecutive numbers contains a number divisible by :math:`k`.

**Proof.** Denote the largest element of the sequence by :math:`n`. This means that the sequence is :math:`n - (k - 1), \ldots, n - 1, n`. By the quotient-remainder theorem, we have :math:`n = q k + r` for some integers :math:`q` and :math:`r` with :math:`0\leq r < k`. From these inequalities we conclude that :math:`n - r` is in our sequence, and :math:`n - r = q k`, hence divisible by :math:`k`.

----

**Definition.** Given two integers :math:`m` and :math:`n` such that either :math:`m \neq 0` or :math:`n \neq 0`, we define the *greatest common divisor* :math:`\gcd(m,n)` of :math:`m` and :math:`n` to be the largest integer :math:`d` which is both a divisor of :math:`m` and :math:`n`, that is :math:`d \mid m` and :math:`d \mid n`.

This largest integer exists, because there is at least one common divisor, but only finitely many. There is at least one, since 1 is a common divisor of any two integers, and there are finitely many, since a nonzero number has only finitely many divisors.

If :math:`n = m = 0`, then we define :math:`\gcd(0,0) = 0`.

----

The greatest common divisor of two numbers is always a natural number, since 1 is always a common divisor of two numbers. As an example, let us compute the greatest common divisor of 6 and 28. The positive divisors of 6 are :math:`\{1, 2, 3, 6\}` and the positive divisors of 28 are :math:`\{1, 2, 4, 7, 14, 28\}`. The largest number in both these sets is 2, which is the greatest common divisor of 6 and 28.

However, computing the greatest common divisor of two numbers by listing all the divisors of both numbers is a lot of work, so we will now consider a method to compute the greatest common divisor more efficiently.

----

**Lemma.** For all integers :math:`n`, :math:`m` and :math:`k` we have :math:`\gcd(n,m)=\gcd(m,n-km)`.

**Proof.** Let :math:`d = \gcd(n,m)` and :math:`r = n-km`. If :math:`n = m = 0`, then :math:`d = 0 = \gcd(m,r)`, and we're done.

In the other case we first show that the set of common divisors of :math:`n` and :math:`m` is the same as the set of the common divisors of :math:`m` and :math:`r`. To see this, let :math:`d' \mid m` and :math:`d' \mid n`. Then also :math:`d' \mid n - km` by Exercise 1 below. Hence :math:`d'` is a common divisor of :math:`m` and :math:`r`. On the other hand, if :math:`d'` is a divisor of :math:`m` and :math:`r`, then :math:`d' \mid r + km`, hence :math:`d' \mid n`, hence :math:`d'` is a common divisor of :math:`n` and :math:`m`.

Since the sets of common divisors are the same, the largest element in each set is also the same, hence :math:`\gcd(n,m)=\gcd(m,n-km)`.

**Lemma.** For all integers :math:`n` we have :math:`\gcd(n,0)=|n|`.

**Proof.** Every number is a divisor of 0, hence the greatest common divisor of :math:`n` and 0 is just the greatest divisor of :math:`n`, which is the absolute value of :math:`n`.

----

These two lemmas give us a quick way to compute the greatest common divisor of two numbers. This is called the *Euclidean Algorithm*. Suppose we want to compute :math:`\gcd(a, b)`.

-  We let :math:`r_0 = a` and :math:`r_1 = b`.
-  Given :math:`r_n` and :math:`r_{n+1}` we compute :math:`r_{n+2}` as the remainder of of :math:`r_n` when divided by :math:`r_{n+1}`.
-  Once :math:`r_n = 0`, we stop, and :math:`\gcd(a, b) = |r_{n-1}|`.

This works, because by the lemmas above, we have :math:`\gcd(r_k,r_{k+1}) = \gcd(r_{k+1}, r_{k+2})`, since :math:`r_{k+2} = r_k - qr_{k+1}` for some :math:`q`. Hence if :math:`r_n=0` we have

.. math::

   \gcd(a,b)=\gcd(r_0,r_1)=\gcd(r_{n-1},r_n)=\gcd(r_{n-1},0)=|r_{n-1}|.

For example, suppose we want to compute the greatest common divisor of 1311 and 5757. We compute the following remainders:

.. math::

   5757 &= 4\times1311 + 513\\
   1311 &= 2\times513 + 285\\
   513 &= 1\times285 + 228\\
   285 &= 1\times228 + 57\\
   228 &= 4\times57 + 0.

Hence :math:`\gcd(1311,5757) = 57`. This is much quicker than computing all the divisors of both 1311 and 5757.

Here is an important result about greatest common divisors. It is only called a "lemma" for historical reasons.

----

**Theorem** (B‎ézout's Lemma). Let :math:`s` and :math:`t` be integers. Then there are integers :math:`a` and :math:`b` such that :math:`as+bt=\gcd(s,t)`.

**Proof.** We compute :math:`\gcd(s,t)` by the Euclidean Algorithm given above, and during the algorithm we get the intermediate values :math:`r_0, r_1, \ldots, r_n` where :math:`r_n = 0`. Now by induction on :math:`k` we prove that we can write :math:`r_k = a_ks+b_kt` for some integers :math:`a_k` and :math:`b_k`. Indeed: :math:`r_0 = 1\cdot s + 0\cdot t` and :math:`r_1 = 0\cdot s + 1\cdot t`. Now if we assume that :math:`r_k = a_ks+b_kt` and :math:`r_{k+1} = a_{k+1}s+b_{k+1}t`, we know that :math:`r_{k+2} = r_k - q\cdot r_{k+1}`, where :math:`q` is the quotient of :math:`r_k` when divided by :math:`r_{k+1}`. These equations together give

.. math::

   r_{k+2} = (a_k-qa_{k+1})s + (b_k-qb_{k+1})t.

This completes the induction. In particular, :math:`r_{n-1} = a_{n-1}s+b_{n-1}t`, and since :math:`\gcd(s,t)=\pm r_{n-1}` we can write :math:`\gcd(s,t)` as :math:`as+bt` for some :math:`a` and :math:`b`.

----

**Corollary.** If :math:`c` is any common divisor of :math:`n` and :math:`m`, then :math:`c \mid \gcd(n, m)`.

**Proof.** By B‎ézout's Lemma, there are :math:`a` and :math:`b` such that :math:`\gcd(n,m)=an+bm`. Since :math:`c` divides both :math:`n` and :math:`m`, :math:`c` divides :math:`an+bm` by Exercise 1 below, and hence also :math:`\gcd(n,m)`.

----

Of special interest are pairs of integers which have no divisors in common, except 1 and :math:`-1`.

----

**Definition.** Two integers :math:`n` and :math:`m` are *coprime* if :math:`\gcd(n,m) = 1`.

----

**Proposition.** Let :math:`n`, :math:`m` and :math:`k` be integers such that :math:`n` and :math:`k` are coprime. If :math:`k \mid nm` then :math:`k \mid m`.

**Proof.** By B‎ézout's Lemma, there are :math:`a` and :math:`b` such that :math:`an+bk = 1`. Multiplying by :math:`m` gives :math:`anm + bkm = m` Since :math:`k` divides :math:`nm`, :math:`k` divides the left-hand side of the equation, hence :math:`k \mid m`.

----

Prime Numbers
-------------

In this section we consider properties of prime numbers.

----

**Definition.** An integer :math:`p\geq 2` is called *prime* if the only positive divisors of :math:`p` are 1 and :math:`p`. An integer :math:`n \geq 2` which is not prime is called *composite*.

----

An equivalent definition of a prime number is a positive number with exactly 2 positive divisors.

Recall from :numref:`Chapter %s <the_natural_numbers_and_induction>` that every natural number greater than 1 can be written as the product of primes. In particular, ever natural number greater than 1 is divisible by some prime number.

We now prove some other properties about prime numbers.

----

**Theorem.** There are infinitely many primes.

**Proof.** Suppose for the sake of contradiction that there are only finitely many primes :math:`p_1, p_2, \ldots, p_k`. Let :math:`n = p_1 \times p_2 \times \cdots \times p_k`. Since :math:`n` is divisible by :math:`p_i` for all :math:`i\leq k` we know that :math:`n+1` is not divisible by :math:`p_i` for any :math:`i`. However, we assumed that these are all primes, contradicting the fact that every number is divisible by a prime number.

**Lemma.** If :math:`n` is an integer and :math:`p` is a prime number, then either :math:`n` and :math:`p` are coprime or :math:`p \mid n`.

**Proof.** Let :math:`d = \gcd(n, p)`. Since :math:`d` is a positive divisor of :math:`p`, either :math:`d = 1` or :math:`d = p`. In the first case, :math:`n` and :math:`p` are coprime by definition, and in the second case we have :math:`p \mid n`.

**Proposition.** If :math:`n` and :math:`m` are integers and :math:`p` is a prime number such that :math:`p \mid nm` then either :math:`p \mid n` or :math:`p \mid m`.

**Proof.** Suppose that :math:`p \nmid n`. By the previous lemma, this means that :math:`p` and :math:`n` are coprime. From this we can conclude that :math:`p \mid m`.

----

The last result in this section captures that the primes are the "building blocks" of the positive integers for multiplication: all other integers can be written as a product of primes in an essentially unique way.

----

**Theorem** (Fundamental Theorem of Arithmetic). Let :math:`n > 0` be an integer. Then there are primes :math:`p_1, \ldots, p_k` such that :math:`n = p_1\times \cdots \times p_k`. Moreover, these primes are unique up to reordering. That means that if there are prime numbers :math:`q_1, \ldots, q_\ell` such that :math:`q_1\times \cdots \times q_\ell = n`, then the :math:`q_i` are a reordering of the :math:`p_i`. To be completely precise, this means that there is a bijection :math:`\sigma : \{1, \ldots, k\} \to \{1, \ldots, k\}` such that :math:`q_i = p_{\sigma(i)}`.

**Remark.** 1 can be written as the product of zero prime numbers. The *empty product* is defined to be 1.

**Proof.** We have already seen that every number can be written as the product of primes, so we only need to prove the uniqueness up to reordering. Suppose this is not true, and by the least element principle, let :math:`n` be the smallest positive integers such that :math:`n` can be written as the product of primes in two ways: :math:`n = p_1\times \cdots \times p_k = q_1 \times \cdots \times q_\ell`.

Since 1 can be written as product of primes *only* as empty product, we have :math:`n > 1`, hence :math:`k \geq 1`. Since :math:`p_k` is prime, we must have :math:`p_k \mid q_j` for some :math:`j \leq \ell`. By swapping :math:`q_j` and :math:`q_\ell`, we may assume that :math:`j = \ell`. Since :math:`q_\ell` is also prime, we have :math:`p_k = q_\ell`.

Now we have :math:`p_1\times \cdots \times p_{k-1} = q_1 \times \cdots \times q_{\ell-1}`. This product is smaller than :math:`n`, but can be written as product of primes in two different ways. But we assumed :math:`n` was the smallest such number. Contradiction!

----

.. _modular_arithmetic:

Modular Arithmetic
------------------

In the discussion of equivalence relations in :numref:`equivalence_relations_and_equality` we considered the example of the relation of modular equivalence on the integers. This is sometimes thought of as "clock arithmetic." Suppose you have a 12-hour clock without a minute hand, so it only has an hour hand which can point to the hours 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 and then it wraps to 12 again. We can do arithmetic with this clock.

-  If the hand currently points to 10, then 5 hours later it will point to 3.
-  If the hand points to 7, then 23 hours before that, it pointed to 8.
-  If the hand points to 9, and we work for a 8 hours, then when we are done the hand will point to 5. If we worked twice as long, starting at 9, the hand will point to 1.

We want to write these statements using mathematical notation, so that we can reason about them more easily. We cannot write :math:`10 + 5 = 3` for the first expression, because that would be false, so instead we use the notation :math:`10 + 5 \equiv 3 \pmod{12}`. The notation :math:`\pmod{12}` indicates that we forget about multiples of 12, and we use the "congruence" symbol with three horizontal lines to remind us that these values are not exactly equal, but only equal up to multiples of 12. The other two lines can be formulated as :math:`7 - 23 \equiv 8 \pmod{12}` and :math:`9 + 2 \cdot 8 \equiv 1 \pmod{12}`.

Here are some more examples:

-  :math:`6 + 7 \equiv 1 \pmod{12}`
-  :math:`6 \cdot 7 \equiv 42 \equiv 6 \pmod{12}`
-  :math:`7 \cdot 5 \equiv 35 \equiv -1 \pmod{12}`

The last example shows that we can use negative numbers as well.

We now give a precise definition.

----

**Definition.** For integers :math:`a`, :math:`b` and :math:`n` we say that :math:`a` and :math:`b` are *congruent modulo* :math:`n` if :math:`n \mid a - b`. This is written :math:`a \equiv b \pmod{n}`. The number :math:`n` is called the *modulus*.

----

Typically we only use this definition when the modulus :math:`n` is positive.

----

**Theorem.** Congruence modulo :math:`n` is an equivalence relation.

**Proof.** We have to show that congruence modulo :math:`n` is reflexive, symmetric and transitive.

It is reflexive, because :math:`a - a = 0`, so :math:`n \mid a - a`, and hence :math:`a\equiv a \pmod{n}`.

To show that it is symmetric, suppose that :math:`a \equiv b \pmod{n}`. Then by definition, :math:`n \mid a - b`. So :math:`n \mid (-1) \cdot (a - b)`, which means that :math:`n \mid b - a`. This means by definition that :math:`b \equiv a \pmod{n}`.

To show that it is transitive, suppose that :math:`a \equiv b \pmod{n}` and :math:`b \equiv c \pmod{n}`. Then we have :math:`n \mid a - b` and :math:`n \mid b - c`. Hence we have :math:`n \mid (a - b) + (b - c)` which means that :math:`n \mid a - c`. So :math:`a \equiv c \pmod{n}`.

----

This theorem justifies the "chaining" notation we used above when we wrote :math:`7 \cdot 5 \equiv 35 \equiv -1 \pmod{12}`. Since congruence modulo 12 is transitive, we can now actually conclude that :math:`7\cdot 5\equiv -1 \pmod{12}`.

----

**Theorem.** Suppose that :math:`a\equiv b \pmod{n}` and :math:`c\equiv d\pmod{n}`. Then :math:`a+c\equiv b+d \pmod{n}` and :math:`a\cdot c\equiv b\cdot d\pmod{n}`.

Moreover, if :math:`a\equiv b \pmod{n}` then :math:`a^k\equiv b^k \pmod{n}` for all natural numbers :math:`k`.

**Proof.** We know that :math:`n \mid a - b` and :math:`n \mid c - d`. For the first statement, we can calculate that :math:`(a + c) - (b + d) = (a - b) + (c - d)`, so we can conclude that :math:`n \mid (a + c) - (b + d)` hence that :math:`a+c\equiv b+d\pmod{n}`.

For the second statement, we want to show that :math:`n \mid a\cdot c - b\cdot d`. We can factor :math:`a\cdot c - b\cdot d = (a - b)\cdot c + b\cdot(c-d)`. Now :math:`n` divides both summands on the right, hence :math:`n` divides :math:`a\cdot c - b\cdot d`, which means that :math:`a\cdot c\equiv b\cdot d\pmod{n}`.

The last statement follows by induction on :math:`k`. If :math:`k = 0`, then :math:`1\equiv 1 \pmod{n}`, and for the induction step, suppose that :math:`a^k\equiv b^k\pmod{n}`, then we have :math:`a^{k+1}= a\cdot a^k \equiv b \cdot b^k = b^{k+1} \pmod{n}`

----

This theorem is useful for carrying out computations modulo :math:`n`. Here are some examples.

-  Suppose we want to compute :math:`77 \cdot 123` modulo 12. We know that :math:`77 \equiv 5 \pmod{12}` and :math:`123 \equiv 3 \pmod{12}`, so :math:`77 \cdot 123 \equiv 5 \cdot 3 \equiv 15 \equiv 3 \pmod{12}`
-  Suppose we want to compute :math:`99 \cdot 998` modulo 10. We know that :math:`99 \equiv -1\pmod{10}` and :math:`998 \equiv -2 \pmod{10}`, hence :math:`99 \cdot 998 \equiv (-1) \cdot (-2) \equiv 2 \pmod{10}`.
-  Suppose we want to know the last digit of :math:`101^{101}`. Notice that the last digit of a number :math:`n` is congruent to :math:`n` modulo 10, so we can just compute :math:`101^{101} \equiv 1^{101} \equiv 1 \pmod{10}`. So the last digit of :math:`101^{101}` is 1.

*Warning.* You cannot do all computations you might expect with modular arithmetic:

-  You are not allowed to divide congruent numbers in modular arithmetic. For example :math:`12 \equiv 16 \pmod{4}`, but we are not allowed to divide both sides of the equation by 2, because :math:`6 \not\equiv 8 \pmod{4}`.
-  You are not allowed to compute in exponents with modular arithmetic. For example :math:`8 \equiv 3 \pmod{5}`, but :math:`2^8 \not\equiv 2^3 \pmod{5}`. To see this: :math:`2^8 = 256 \equiv 1 \pmod{5}`, but :math:`2^3 = 8 \equiv 3 \pmod{5}`.

Recall the quotient-remainder theorem: if :math:`n > 0`, then any integer :math:`a` can be expressed as :math:`a = n q + r`, where :math:`0 \le r < n`. In the language of modular arithmetic this means that :math:`a \equiv r \pmod{n}`. So if :math:`n > 0`, then every integer is congruent to a number between 0 and :math:`n-1` (inclusive). So there "are only :math:`n` different numbers" when working modulo :math:`n`. This can be used to prove many statements about the natural numbers.

----

**Proposition.** For every integer :math:`k`, :math:`k^2+1` is not divisible by 3.

**Proof.** Translating this problem to modular arithmetic, we have to show that :math:`k^2+1 \not\equiv 0 \pmod{3}` or in other words that :math:`k^2\not\equiv 2 \pmod{3}` for all :math:`k`. By the quotient-remainder theorem, we know that :math:`k` is either congruent to 0, 1 or 2, modulo 3. In the first case, :math:`k^2\equiv 0^2\equiv 0\pmod{3}`. In the second case, :math:`k^{2}\equiv 1^2 \equiv 1 \pmod{3}`, and in the last case we have :math:`k^{2}\equiv2^2\equiv4\equiv1\pmod{3}`. In all of those cases, :math:`k^2\not\equiv2\pmod{3}`. So :math:`k^2+1` is never divisible by 3.

----

**Proposition.** For all integers :math:`a` and :math:`b`, :math:`a^2+b^2-3` is not divisible by 4.

**Proof.** We first compute the squares modulo 4. We compute

.. math::

   0^2&\equiv 0\pmod{4}\\
   1^2&\equiv 1\pmod{4}\\
   2^2&\equiv 0\pmod{4}\\
   3^2&\equiv 1\pmod{4}.

Since every number is congruent to 0, 1, 2 or 3 modulo 4, we know that every square is congruent to 0 or 1 modulo 4. This means that there are only four possibilities for :math:`a^2+b^2\pmod{4}`. It can be congruent to :math:`0+0`, :math:`1+0`, :math:`0+1` or :math:`0+0`. In all those cases, :math:`a^2+b^2\not\equiv 3\pmod{4}` Hence :math:`4\nmid a^2+b^2-3`, proving the proposition.

----

Recall that we warned you about dividing in modular arithmetic. This doesn't always work, but often it does. For example, suppose we want to solve :math:`2n \equiv 1 \pmod{5}`. We cannot solve this by saying that :math:`n \equiv \frac12 \pmod{5}`, because we cannot work with fractions in modular arithmetic. However, we can still solve it by multiplying both sides with 3. Then we get :math:`6n \equiv 3 \pmod{5}`, and since :math:`6\equiv 1 \pmod{5}` we get :math:`n \equiv 3 \pmod{5}`. So instead of dividing by 2 we could multiply by 3 to get the answer. The reason this worked is because :math:`2\times 3\equiv 1\pmod{5}`.

----

**Definition.** Let :math:`n` and :math:`a` be integers. A *multiplicative inverse of* :math:`a` *modulo* :math:`n` is an integer :math:`b` such that :math:`ab \equiv 1\pmod{n}`.

----

For example, 3 is a multiplicative inverse of 5 modulo 7, since :math:`3\times 5\equiv1\pmod{7}`. But :math:`2` has no multiplicative inverse modulo 6. Indeed, suppose that :math:`2b\equiv 1 \pmod{6}`, then :math:`6 \mid 2b-1`. However, :math:`2b-1` is odd, and cannot be divisible by an even number. We can use multiplicative inverses to solve equations. If we want to solve :math:`ax\equiv c \pmod{n}` for :math:`x` and we know that :math:`b` is a multiplicative inverse of :math:`a`, the solution is :math:`x\equiv bc \pmod{n}` which we can see by multiplying both sides by :math:`b`.

----

**Lemma** Let :math:`n` and :math:`a` be integers. :math:`a` has at most one multiplicative inverse modulo :math:`n`. That is, if :math:`b` and :math:`b'` are both multiplicative inverses of :math:`a` modulo :math:`n`, then :math:`b\equiv b'\pmod{n}`.

**Proof.** Suppose that :math:`ab\equiv 1 \equiv ab' \pmod{n}`. Then we can compute :math:`bab'` in two ways: :math:`b \equiv b(ab') = (ba)b' \equiv b' \pmod{n}`.

**Proposition.** Let :math:`n` and :math:`a` be integers. :math:`a` has a multiplicative inverse modulo :math:`n` if and only if :math:`n` and :math:`a` are coprime.

**Proof.** Suppose :math:`b` is a multiplicative inverse of :math:`a` modulo :math:`n`. Then :math:`n \mid ab - 1`. Let :math:`d = \gcd(a, b)`. Since :math:`d \mid n` we have :math:`d \mid ab-1`. But since :math:`d` is a divisor of :math:`ab`, we have :math:`d \mid ab - (ab-1) = 1`. Since :math:`d\geq0` we have :math:`d=1`. Hence :math:`n` and :math:`a` are coprime.

On the other hand, suppose that :math:`n` and :math:`a` are coprime. By B‎ézout's Lemma we know that there are integers :math:`b` and :math:`c` such that :math:`cn+ba=\gcd(n,a)=1`. We can rewrite this to :math:`ab - 1 = (-c)n`, hence :math:`n \mid ab - 1`, which means by definition :math:`ab \equiv 1 \pmod{n}`. This means that :math:`b` is a multiplicative inverse of :math:`a` modulo :math:`n`.

----

Note that if :math:`p` is a prime number and :math:`a` is a integer not divisible by :math:`p`, then :math:`a` and :math:`p` are coprime, hence :math:`a` has a multiplicative inverse.

Properties of Squares
---------------------

Mathematicians from ancient times have been interested in the question as to which integers can be written as a sum of two squares. For example, we can write :math:`2 = 1^1 + 1^1`, :math:`5 = 2^2 + 1^2`, :math:`13 = 3^2 + 2^2`. If we make a sufficiently long list of these, an interesting pattern emerges: if two numbers can be written as a sum of two squares, then so can their product. For example, :math:`10 = 5 \cdot 2`, and we can write :math:`10 = 3^2 + 1^2`. Or :math:`65 = 13 \cdot 5`, and we can write :math:`65 = 8^2 + 1^2`.

At first, one might wonder whether this is just a coincidence. The following provides a proof of the fact that it is not.

----

**Theorem.** Let :math:`x` and :math:`y` be any two integers. If :math:`x` and :math:`y` are both sums of two squares, then so is :math:`x y`.

**Proof.** Suppose :math:`x = a^2 + b^2`, and suppose :math:`y = c^2 + d^2`. I claim that

.. math::

   xy = (ac - bd)^2 + (ad + bc)^2.

To show this, notice that on the one hand we have

.. math::

   xy = (a^2 + b^2) (c^2 + d^2) = a^2 c^2 + a^2 d^2 + b^2 c^2 + b^2 d^2.

On the other hand, we have

.. math::

   (ac - bd)^2 + (ad + bc)^2 & = (a^2c^2 - 2abcd + b^2 d^2) + (a^2 d^2 + 2 a b c d + b^2 c^2) \\
    & = a^2 c^2 + b^2 d^2 + a^2 d^2 + b^2 c^2.

Up to the order of summands, the two right-hand sides are the same.

----

We will now prove that :math:`\sqrt{2}` is not a fraction of two integers.

----

**Theorem.** There are no integers :math:`a` and :math:`b` such that :math:`\frac ab=\sqrt{2}`.

**Proof.** Suppose that :math:`\frac ab=\sqrt{2}` for some integers :math:`a` and :math:`b`. By canceling common factors, we may assume that :math:`a` and :math:`b` are coprime. By squaring both sides, we get :math:`\frac{a^2}{b^2}=2`, and multiplying both sides by :math:`b^2` gives :math:`a^2=2b^2`. Since :math:`2b^2` is even, we know that :math:`a^2` is even, and since odd squares are odd, we conclude that :math:`a` is even. Hence we can write :math:`a = 2c` for some integer :math:`c`. This means that :math:`(2c)^2=2b^2`, hence :math:`2c^2=b^2`. The same reasoning shows that :math:`b` is even. But we assumed that :math:`a` and :math:`b` are coprime, which contradicts the fact that they are both even.

Hence there are no integers :math:`a` and :math:`b` such that :math:`\frac ab=\sqrt{2}`.

----

Exercises
---------

#. Prove the following properties about divisibility (for any integers :math:`a`, :math:`b` and :math:`c`):

   -  If :math:`a \mid b` and :math:`a \mid c` then :math:`a \mid b + c` and :math:`a \mid b - c`.
   -  If :math:`a \mid b` then :math:`a \mid bc`.
   -  :math:`a \mid 0`;
   -  If :math:`0 \mid a` then :math:`a = 0`.
   -  If :math:`a \neq 0` then the statements :math:`b \mid c` and :math:`ab \mid ac` are equivalent.
   -  If :math:`a \mid b` and :math:`b \neq 0` then :math:`|a| \leq |b|`.

#. Prove that for any integer :math:`n`, :math:`n^2` leaves a remainder of 0 or 1 when you divide it by 4. Conclude that :math:`n^2 + 2` is never divisible by 4.

#. Prove that if :math:`n` is odd, :math:`n^2 - 1` is divisible by 8.

#. Prove that if :math:`m` and :math:`n` are odd, then :math:`m^2 + n^2` is even but not divisible by 4.

#. Say that two integers "have the same parity" if they are both even or both odd. Prove that if :math:`m` and :math:`n` are any two integers, then :math:`m + n` and :math:`m - n` have the same parity.

#. Write 11160 as product of primes.

#. List all the divisors of 42 and 198, and find the greatest common divisor by looking at the largest number in both lists. Also compute the greatest common divisor of the numbers by the Euclidean Algorithm.

#. Compute :math:`\gcd(15, 55)`, :math:`\gcd(12345, 54321)` and :math:`\gcd(-77, 110)`

#. Show by induction on :math:`n` that for every pair of integers :math:`x` and :math:`y`, :math:`x - y` divides :math:`x^n - y^n`. (Hint: in the induction step, write :math:`x^{n+1} - y^{n+1}` as :math:`x^n (x - y) + x^n y - y^{n+1}`.)

#. Compute :math:`2^{12} \pmod{13}`. Use this to compute :math:`2^{1212004} \pmod{13}`.

#. Find the last digit of :math:`99^{99}`. Can you also find the last two digits of this number?

#. Prove that :math:`50^{22} - 22^{50}` is divisible by 7.

#. Check whether the following multiplicative inverses exist, and if so, find them.

   -  the multiplicative inverse of 5 modulo 7
   -  the multiplicative inverse of 17 modulo 21
   -  the multiplicative inverse of 4 modulo 14
   -  the multiplicative inverse of :math:`-2` modulo 9

#. Find all integers :math:`x` such that :math:`75x \equiv 45 \pmod{8}`.

#. Show that for every integer :math:`n` the number :math:`n^4` is congruent to 0 or 1 modulo 5. Hint: to simplify the computation, use that :math:`4^4\equiv(-1)^4\pmod{5}`.

#. Prove that the equation :math:`n^4+m^4=k^4+3` has no solutions in the integers. (Hint: use the previous exercise.)

#. Suppose :math:`p` is a prime number such that :math:`p \nmid k`. Show that if :math:`kn\equiv km \pmod{p}` then :math:`n \equiv m \pmod{p}`.

#. Let :math:`n`, :math:`m` and :math:`c` be given integers. Use B‎ézout's Lemma to prove that the equation :math:`an+bm=c` has a solution for integers :math:`a` and :math:`b` if and only if :math:`\gcd(n, m) \mid c`.

#. Suppose that :math:`a \mid n` and :math:`a \mid n` and let :math:`d = \gcd(n,m)`. Prove that :math:`\gcd(\frac na, \frac ma) =\frac da`. Conclude that for any two integers :math:`n` and :math:`m` with greatest common divisor :math:`d` the numbers :math:`\frac nd` and :math:`\frac md` are coprime.
