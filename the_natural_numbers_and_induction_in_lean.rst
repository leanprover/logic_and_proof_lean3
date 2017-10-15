.. _the_natural_numbers_and_induction_in_lean:

The Natural Numbers and Induction in Lean
=========================================

The goal of this chapter is to give a more axiomatic, foundational account of the natural numbers and its basic operations. First, we will do this informally, showing how operations like addition and multiplication can be defined using the principle of recursion, and showing how some of their basic properties can be proved using induction. Then we will see how this plays out in the Lean theorem prover, using Lean's built-in mechanisms for induction and recursion.

.. _defining_arithmetic_operations:

Defining Arithmetic Operations
------------------------------

Let :math:`\mathbb{N}` be the set of natural numbers with least element :math:`0`, and let :math:`\mathrm{succ}(m) = m + 1` be the successor function. The structure :math:`( \mathbb{N}, 0, \mathrm{succ} )` satisfies the following clauses:

-  :math:`0 \neq \mathrm{succ}(m)` for any :math:`m` in :math:`\mathbb{N}`.
-  For every :math:`m` and :math:`n` in :math:`\mathbb{N}`, if :math:`m \neq n`, then :math:`\mathrm{succ}(m) \neq \mathrm{succ}(n)`. In other words, :math:`\mathrm{succ}` is *injective*.
-  If :math:`A` is any subset of :math:`\mathbb{N}` with the property that :math:`0` is in :math:`A` and whenever :math:`n` is in :math:`A` then :math:`\mathrm{succ}(n)` is in :math:`A`, then :math:`A = \mathbb{N}`.

The last clause can be reformulated as the principle of induction:

    Suppose :math:`P(n)` is any property of natural numbers, such that :math:`P` holds of :math:`0`, and for every :math:`n`, :math:`P(n)` implies :math:`P(\mathrm{succ}(n))`. Then every :math:`P` holds of every natural number.

Remember that this principle can be used to justify the principle of definition by recursion:

    Let :math:`A` be any set, :math:`a` be any element of :math:`A`, and let :math:`g(n,m)` be any function from :math:`\mathbb{N} \times A` to :math:`A`. Then there is a unique function :math:`f: \mathbb{N} \to A` satisfying the following two clauses:

    -  :math:`f(0) = a`
    -  :math:`f(\mathrm{succ}(n)) = g(n,f(n))` for every :math:`n` in :math:`N`.

We can use the principle of recursive definition to define addition with the following two clauses:

.. math::

   m + 0 & = m \\
   m + \mathrm{succ}(n) & = \mathrm{succ}(m + n)

Note that we are fixing :math:`m`, and viewing this as a function of :math:`n`. If we write :math:`1 = \mathrm{succ}(0)`, :math:`2 = \mathrm{succ}(1)`, and so on, it is easy to prove :math:`n + 1 = \mathrm{succ}(n)` from the definition of addition.

We can proceed to define multiplication using the following two clauses:

.. math::

   m \cdot 0 & = 0 \\
   m \cdot \mathrm{succ}(n) & = m \cdot n + m

We can also define a predecessor function by

.. math::

   \mathrm{pred}(0) & = 0 \\
   \mathrm{pred}(\mathrm{succ}(n)) & = n,

and \`\`truncated subtraction'' by

.. math::

   m \dot - 0 & = 0 \\
   m \dot - (\mathrm{succ}(n)) & = \mathrm{pred}(m \dot - n).

With these definitions and the induction principle, one can prove all the following identities:

-  :math:`n \neq 0` implies :math:`\mathrm{succ}(\mathrm{pred}(n)) = n`
-  :math:`0 + n = n`
-  :math:`\mathrm{succ}(m) + n = \mathrm{succ}(m + n)`
-  :math:`(m + n) + k = m + (n + k)`
-  :math:`m + n = n + m`
-  :math:`m(n + k) = mn + mk`
-  :math:`0 \cdot n = 0`
-  :math:`1 \cdot n = x`
-  :math:`(mn)k = m(nk)`
-  :math:`mn = nm`

We will do the first five here, and leave the remaining ones as exercises.

----

**Proposition.** For every natural number :math:`n`, if :math:`n \neq 0` then :math:`\mathrm{succ}(\mathrm{pred}(n)) = n`.

**Proof.** By induction on :math:`n`. We have ruled out the case where :math:`n` is :math:`0`, so we only need to show that the claim holds for :math:`\mathrm{succ}(n)`. But in that case, we have :math:`\mathrm{succ}(\mathrm{pred}(\mathrm{succ}(n)) = \mathrm{succ}(n)` by the second defining clause of the predecessor function.

**Proposition.** For every :math:`n`, :math:`0 + n = n`.

**Proof.** By induction on :math:`n`. We have :math:`0 + 0 = 0` by the first defining clause for addition. And assuming :math:`0 + n = n`, we have :math:`0 + \mathrm{succ}(n) = \mathrm{succ}(0 + n) = n`, using the second defining clause for addition.

**Proposition.** For every :math:`m` and :math:`n`, :math:`\mathrm{succ}(m) + n = \mathrm{succ}(m + n)`.

**Proof.** Fix :math:`m` and use induction on :math:`n`. Then :math:`n = 0`, we have :math:`\mathrm{succ}(m) + 0 = \mathrm{succ}(m) = \mathrm{succ}(m + 0)`, using the first defining clause for addition. Assuming the claim holds for :math:`n`, we have

.. math::

   \mathrm{succ}(m) + \mathrm{succ}(n) & = \mathrm{succ}(\mathrm{succ}(m) + n) \\
   & = \mathrm{succ} (\mathrm{succ} (m + n)) \\
   & = \mathrm{succ} (m + \mathrm{succ}(n)),

using the inductive hypothesis and the second defining clause for addition.

**Proposition.** For every :math:`m`, :math:`n`, and :math:`k`, :math:`(m + n) + k = m + (n + k)`.

**Proof.** By induction on :math:`k`. The case where :math:`k = 0` is easy, and in the induction step we have

.. math::

   (m + n) + \mathrm{succ}(k) & = \mathrm{succ} ((m + n) + k) \\
   & = \mathrm{succ} (m + (n + k)) \\
   & = m + \mathrm{succ} (n + k) \\
   & = m + (n + \mathrm{succ} (k)))

using the inductive hypothesis and the definition of addition.

**Proposition.** For every pair of natural numbers :math:`m` and :math:`n`, :math:`m + n = n + m`.

**Proof.** By induction on :math:`n`. The base case is easy using the second proposition above. In the inductive step, we have

.. math::

   m + \mathrm{succ}(n) & = \mathrm{succ}(m + n) \\
   & = \mathrm{succ} (n + m) \\
   & = \mathrm{succ}(n) + m

using the third proposition above.

----

Induction and Recursion in Lean
-------------------------------

Internally, in Lean, the natural numbers are defined as a type generated inductively from an axiomatically declared ``zero`` and ``succ`` operation:

.. code-block:: lean

    namespace hide

    -- BEGIN
    inductive nat : Type
    | zero : nat
    | succ : nat → nat
    -- END
    end hide

If you click the button that copies this text into the editor in the online version of this textbook, you will see that we wrap it with the phrases ``namespace hide`` and ``end hide``. This puts the definition into a new "namespace," so that the identifiers that are defined are ``hide.nat``, ``hide.nat.zero`` and ``hide.nat.succ``, to avoid conflicting with the one that is in the Lean library. Below, we will do that in a number of places where our examples duplicate objects defined in the library. The unicode symbol ``ℕ``, entered with ``\N`` or ``\nat``, is a synonym for ``nat``.

Declaring ``nat`` as an inductively defined type means that we can define functions by recursion, and prove theorems by induction. For example, these are the first two recursive definitions presented in the last chapter:

.. code-block:: lean

    open nat

    def two_pow : ℕ → ℕ
    | 0        := 1 
    | (succ n) := 2 * two_pow n

    def fact : ℕ → ℕ 
    | 0        := 1
    | (succ n) := (succ n) * fact n

Addition and numerals are defined in such a way that Lean recognizes ``succ n`` and ``n + 1`` as essentially the same, so we could instead write these definitions as follows:

.. code-block:: lean

    def two_pow : ℕ → ℕ
    | 0       := 1 
    | (n + 1) := 2 * two_pow n

    def fact : ℕ → ℕ 
    | 0       := 1
    | (n + 1) := (n + 1) * fact n

If we wanted to define the function ``m^n``, we would do that by fixing ``m``, and writing doing the recursion on the second argument:

.. code-block:: lean

    def pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * pow m n

Lean is also smart enough to interpret more complicated forms of recursion, like this one:

.. code-block:: lean

    def fib : ℕ → ℕ
    | 0        := 0
    | 1        := 1
    | (n + 2)  := fib (n + 1) + fib n

In addition to defining functions by recursion, we can prove theorems by induction. In Lean, each clause of a recursive definition results in a new identity. For example, the two clauses in the definition of ``pow`` above give rise to the following two theorems:

.. code-block:: lean

    def pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * pow m n

    -- BEGIN
    theorem pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    theorem pow_succ (m n : ℕ) : pow m (n+1) = m * pow m n := rfl
    -- END

Notice that we could alternatively have used ``(pow m n) * m`` in the second clause of the definition of ``pow``. Of course, we can prove that the two definitions are equivalent using the commutativity of multiplication, but, using a proof by induction, we can also prove it using only the associativity of multiplication, and the properties ``1 * m = m`` and ``m * 1 = m``. This is useful, because the power function is also often used in situations where multiplication is not commutative, such as with matrix multiplication. The theorem can be proved in Lean as follows:

.. code-block:: lean

    open nat

    namespace hide

    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * (pow m n)

    theorem pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    theorem pow_succ (m n : ℕ) : pow m (succ n) = m * (pow m n) := rfl

    -- BEGIN
    theorem pow_succ' (m n : ℕ) : pow m (succ n) = (pow m n) * m :=
    nat.rec_on n
      (show pow m (succ 0) = pow m 0 * m, from calc
        pow m (succ 0) = m * pow m 0 : by rw pow_succ
                   ... = m * 1       : by rw pow_zero
                   ... = m           : by rw mul_one
                   ... = 1 * m       : by rw one_mul
                   ... = pow m 0 * m : by rw pow_zero)
      (assume n,
        assume ih : pow m (succ n) = pow m n * m,
        show pow m (succ (succ n)) = pow m (succ n) * m, from calc
          pow m (succ (succ n)) = m * (pow m (succ n)) : by rw pow_succ
                            ... = m * (pow m n * m)    : by rw ih
                            ... = (m * pow m n) * m    : by rw mul_assoc
                            ... = pow m (succ n) * m   : by rw pow_succ)
    -- END
    end hide

This is a typical proof by induction in Lean. It begins with the phrase ``nat.induction_on n``, and is followed by the base case and the inductive hypothesis. The proof can be shortened using ``rewrite`` and ``simp``:

.. code-block:: lean

    open nat

    namespace hide

    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * (pow m n)

    theorem pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    theorem pow_succ (m n : ℕ) : pow m (succ n) = m * (pow m n) := rfl

    -- BEGIN
    theorem pow_succ' (m n : ℕ) : pow m (succ n) = (pow m n) * m :=
    nat.rec_on n
      (show pow m (succ 0) = pow m 0 * m, 
        by rw [pow_succ, pow_zero, mul_one, one_mul])
      (assume n,
        assume ih : pow m (succ n) = pow m n * m,
        show pow m (succ (succ n)) = pow m (succ n) * m, 
          by simp [pow_succ, ih])
    -- END
    end hide

Remember that you can write a ``rewrite`` proof incrementally, checking the error messages to make sure things are working so far, and to see how far Lean got.

In any case, the power function is already defined in the Lean library as ``pow_nat``. (It is defined generically for any type that has a multiplication; the ``nat`` in ``pow_nat`` refers to the fact that the exponent is a natural number.) The definition is essentially the one above, and the theorems above are also there:

.. code-block:: lean

    import algebra.group_power
    local infix ` ^ ` := pow_nat

    #check @pow_nat
    #check @pow_zero
    #check @pow_succ
    #check @pow_succ'

    variables m n : ℕ

    #check m^n

.. TODO(Jeremy): the `import` and `local infix` are workarounds for the fact that the notation `^` is badly defined in the core library.

As another example of a proof by induction, here is a proof of the identity ``m^(n + k) = m^n * m^k``.

.. code-block:: lean

    import algebra.group_power
    local infix `^` := pow_nat

    namespace hide
    export nat (succ)

    -- BEGIN
    theorem pow_add (m n k : ℕ) : m^(n + k) = m^n * m^k :=
    nat.rec_on k
      (show m^(n + 0) = m^n * m^0, from calc
        m^(n + 0) = m^n       : by rw add_zero
              ... = m^n * 1   : by rw mul_one
              ... = m^n * m^0 : by rw pow_zero)
      (assume k,
        assume ih : m^(n + k) = m^n * m^k,
        show m^(n + succ k) = m^n * m^(succ k), from calc
          m^(n + succ k) = m^(succ (n + k)) : by rw nat.add_succ
                     ... = m^(n + k) * m    : by rw pow_succ'
                     ... = m^n * m^k * m    : by rw ih
                     ... = m^n * (m^k * m)  : by rw mul_assoc
                     ... = m^n * m^(succ k) : by rw pow_succ')
    -- END
    end hide

Notice the same pattern. This time, we do induction on ``k``, and the base case and inductive step are routine. Once again, with a bit of cleverness, we can shorten the proof with ``rewrite``:

.. code-block:: lean

    import algebra.group_power
    local infix `^` := pow_nat

    namespace hide
    export nat (succ)

    -- BEGIN
    theorem pow_add (m n k : ℕ) : m^(n + k) = m^n * m^k :=
    nat.rec_on k
      (show m^(n + 0) = m^n * m^0, 
        by rewrite [add_zero, pow_zero, mul_one]) 
      (assume k,
        assume ih : m^(n + k) = m^n * m^k,
        show m^(n + succ k) = m^n * m^(succ k),
         by rewrite [nat.add_succ, pow_succ', ih, mul_assoc, pow_succ'])
    -- END
    end hide

You should not hesitate to use ``calc``, however, to make the proofs more explicit. Remember that you can also use ``calc`` and ``rewrite`` together, using ``calc`` to structure the calculational proof, and using ``rewrite`` to fill in each justification step.

Defining the Arithmetic Operations in Lean
------------------------------------------

In fact, addition and multiplication are defined in Lean essentially as described in :numref:`defining_arithmetic_operations`. The defining equations for addition hold by reflexivity, but they are also named ``add_zero`` and ``add_succ``:

.. code-block:: lean

    open nat

    variables m n : ℕ

    example : m + 0 = m := add_zero m
    example : m + succ n = succ (m + n) := add_succ m n

Similarly, we have the defining equations for the predecessor function
and multiplication:

.. code-block:: lean

    open nat

    #check @pred_zero
    #check @pred_succ
    #check @mul_zero
    #check @mul_succ

Here are the five propositions proved in :numref:`defining_arithmetic_operations`.

.. code-block:: lean

    open nat

    namespace hide

    -- BEGIN
    theorem succ_pred (n : ℕ) : n ≠ 0 → succ (pred n) = n :=
    nat.rec_on n
      (assume H : 0 ≠ 0,
        show succ (pred 0) = 0, from absurd rfl H)
      (assume n,
        assume ih,
        assume H : succ n ≠ 0,
        show succ (pred (succ n)) = succ n, 
          by rewrite pred_succ)

    theorem zero_add (n : nat) : 0 + n = n :=
    nat.rec_on n
      (show 0 + 0 = 0, from rfl)
      (assume n,
        assume ih : 0 + n = n,
        show 0 + succ n = succ n, from
          calc
        0 + succ n = succ (0 + n) : rfl
          ... = succ n : by rw ih)

    theorem succ_add (m n : nat) : succ m + n = succ (m + n) :=
    nat.rec_on n
      (show succ m + 0 = succ (m + 0), from rfl)
      (assume n,
        assume ih : succ m + n = succ (m + n),
        show succ m + succ n = succ (m + succ n), from
          calc
        succ m + succ n = succ (succ m + n) : rfl
          ... = succ (succ (m + n)) : by rw ih
          ... = succ (m + succ n) : rfl)

    theorem add_assoc (m n k : nat) : m + n + k = m + (n + k) :=
    nat.rec_on k
      (show m + n + 0 = m + (n + 0), by rw [add_zero, add_zero])
      (assume k, 
        assume ih : m + n + k = m + (n + k),
        show m + n + succ k = m + (n + (succ k)), from calc
          m + n + succ k = succ (m + n + k)   : by rw add_succ
                     ... = succ (m + (n + k)) : by rw ih
                     ... = m + (n + succ k)   : by rw add_succ)

    theorem add_comm (m n : nat) : m + n = n + m :=
    nat.rec_on n
      (show m + 0 = 0 + m, by rewrite [add_zero, zero_add])
      (assume n,
        assume ih : m + n = n + m,
        show m + succ n = succ n + m, from calc
          m + succ n = succ (m + n) : by rw add_succ
                 ... = succ (n + m) : by rw ih
                 ... = succ n + m   : by rw succ_add)

    -- END
    end hide

Exercises
---------

#. Give an informal but detailed proof that for every natural number :math:`n`, :math:`1 \cdot n = n`.

#. Prove the multiplication is associative and commutative, in the same way.

#. Prove that multiplication distributes over addition: for every natural numbers :math:`m`, :math:`n`, and :math:`k`, :math:`m (n + k) = m n + m k`.

#. Prove :math:`(m^n)^k = m^{nk}`.

#. Formalize all these theorems in Lean.
