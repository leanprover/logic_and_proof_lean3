The Natural Numbers and Induction in Lean
=========================================

The goal of this chapter is to give a more axiomatic, foundational
account of the natural numbers and its basic operations. First, we will
do this informally, showing how operations like addition and
multiplication can be defined using the principle of recursion, and
showing how some of their basic properties can be proved using
induction. Then we will see how this plays out in the Lean theorem
prover, using Lean's built-in mechanisms for induction and recursion.

Defining the Arithmetic Operations Axiomatically
------------------------------------------------

Let :math:`\NN` be the set of natural numbers with least element
:math:`0`, and let :math:`\suc(m) = m + 1` be the successor function.
The structure :math:`( \NN,
0, \suc )` satisfies the following clauses:

-  :math:`0 \neq \suc(m)` for any :math:`m` in :math:`\NN`.
-  For every :math:`m` and :math:`n` in :math:`\NN`, if
   :math:`m \neq n`, then :math:`\suc(m) \neq
    \suc(n)`. In other words, :math:`\suc` is *injective*.
-  If :math:`A` is any subset of :math:`\NN` with the property that
   :math:`0` is in :math:`A` and whenever :math:`n` is in :math:`A` then
   :math:`\suc(n)` is in :math:`A`, then :math:`A = \NN`.

The last clause can be reformulated as the principle of induction:

    Suppose :math:`P(n)` is any property of natural numbers, such that
    :math:`P` holds of :math:`0`, and for every :math:`n`, :math:`P(n)`
    implies :math:`P(\suc(n))`. Then every :math:`P` holds of every
    natural number.

Remember that this principle can be used to justify the principle of
definition by recursion:

    Let :math:`A` be any set, :math:`a` be any element of :math:`A`, and
    let :math:`g(n,m)` be any function from :math:`\NN \times A` to
    :math:`A`. Then there is a unique function :math:`f: \NN \to A`
    satisfying the following two clauses:

    -  :math:`f(0) = a`
    -  :math:`f(\suc(n)) = g(n,f(n))` for every :math:`n` in :math:`N`.

We can use the principle of recursive definition to define addition with
the following two clauses:

.. raw:: latex

   \begin{align*}
   m + 0 & = m \\
   m + \suc(n) & = \suc(m + n)
   \end{align*}

Note that we are fixing :math:`m`, and viewing this as a function of
:math:`n`. If we write :math:`1 = \suc(0)`, :math:`2 = \suc(1)`, and so
on, it is easy to prove :math:`n + 1 = \suc(n)` from the definition of
addition.

We can proceed to define multiplication using the following two clauses:

.. raw:: latex

   \begin{align*}
   m \cdot 0 & = 0 \\
   m \cdot \suc(n) & = m \cdot n + m
   \end{align*}

We can also define a predecessor function by

.. raw:: latex

   \begin{align*}
   \fn{pred}(0) & = 0 \\
   \fn{pred}(\suc(n)) & = n,
   \end{align*}

and \`\`truncated subtraction'' by

.. raw:: latex

   \begin{align*}
   m \tsub 0 & = 0 \\
   m \tsub (\suc(n)) & = \fn{pred}(m \tsub n).
   \end{align*}

With these definitions and the induction principle, one can prove all
the following identities:

-  :math:`n \neq 0` implies :math:`\suc(\fn{pred}(n)) = n`
-  :math:`0 + n = n`
-  :math:`\suc(m) + n = \suc(m + n)`
-  :math:`(m + n) + k = m + (n + k)`
-  :math:`m + n = n + m`
-  :math:`m(n + k) = mn + mk`
-  :math:`0 \cdot n = 0`
-  :math:`1 \cdot n = x`
-  :math:`(mn)k = m(nk)`
-  :math:`mn = nm`

We will do the first five here, and leave the remaining ones as
exercises.

----

**Proposition.** For every natural number :math:`n`, if :math:`n \neq 0`
then :math:`\suc(\fn{pred}(n)) = n`.

**Proof.** By induction on :math:`n`. We have ruled out the case where
:math:`n` is :math:`0`, so we only need to show that the claim holds for
:math:`\suc(n)`. But in that case, we have
:math:`\suc(\fn{pred}(\suc(n)) = \suc(n)` by the second defining clause
of the predecessor function.

**Proposition.** For every :math:`n`, :math:`0 + n = n`.

**Proof.** By induction on :math:`n`. We have :math:`0 + 0 = 0` by the
first defining clause for addition. And assuming :math:`0 + n = n`, we
have :math:`0 + \suc(n) = \suc(0 + n) = n`, using the second defining
clause for addition.

**Proposition.** For every :math:`m` and :math:`n`,
:math:`\suc(m) + n = \suc(m + n)`.

**Proof.** Fix :math:`m` and use induction on :math:`n`. Then
:math:`n = 0`, we have :math:`\suc(m) + 0 = \suc(m) = \suc(m + 0)`,
using the first defining clause for addition. Assuming the claim holds
for :math:`n`, we have

.. raw:: latex

   \begin{align*}
   \suc(m) + \suc(n) & = \suc(\suc(m) + n) \\
   & = \suc (\suc (m + n)) \\
   & = \suc (m + \suc(n)),
   \end{align*}

using the inductive hypothesis and the second defining clause for
addition.

**Proposition.** For every :math:`m`, :math:`n`, and :math:`k`,
:math:`(m + n) + k = m + (n +
k)`.

**Proof.** By induction on :math:`k`. The case where :math:`k = 0` is
easy, and in the induction step we have

.. raw:: latex

   \begin{align*}
   (m + n) + \suc(k) & = \suc ((m + n) + k) \\
   & = \suc (m + (n + k)) \\
   & = m + \suc (n + k) \\
   & = m + (n + \suc (k)))
   \end{align*}

using the inductive hypothesis and the definition of addition.

**Proposition.** For every pair of natural numbers :math:`m` and
:math:`n`, :math:`m + n =
n + m`.

**Proof.** By induction on :math:`n`. The base case is easy using the
second proposition above. In the inductive step, we have

.. raw:: latex

   \begin{align*}
   m + \suc(n) & = \suc(m + n) \\
   & = \suc (n + m) \\
   & = \suc(n) + m
   \end{align*}

using the third proposition above.

----

Induction and Recursion in Lean
-------------------------------

Internally, in Lean, the natural numbers are defined as a type generated
inductively from an axiomatically declared ``zero`` and ``succ``
operation:

.. code:: lean

    namespace hide

    -- BEGIN
    inductive nat : Type :=
    | zero : nat
    | succ : nat → nat
    -- END
    end hide

If you click the button that copies this text into the editor in the
online version of this textbook, you will see that we wrap it with the
phrases ``namespace hide`` and ``end hide``. This puts the definition
into a new "namespace," so that the identifiers that are defined are
``hide.nat``, ``hide.nat.zero`` and ``hide.nat.succ``, to avoid
conflicting with the one that is in the Lean library. Below, we will do
that in a number of places where our examples duplicate objects defined
in the library. The unicode symbol ``ℕ``, entered with ``\N`` or
``\nat``, is a synonym for ``nat``.

Declaring ``nat`` as an inductively defined type means that we can
define functions by recursion, and prove theorems by induction. For
example, these are the first two recursive definitions presented in the
last chapter:

.. code:: lean

    open nat

    definition two_pow : ℕ → ℕ
    | 0        := 1 
    | (succ n) := 2 * two_pow n

    definition fact : ℕ → ℕ 
    | 0        := 1
    | (succ n) := (succ n) * fact n

Addition and numerals are defined in such a way that Lean recognizes
``succ n`` and ``n + 1`` as essentially the same, so we could instead
write these definitions as follows:

.. code:: lean

    open nat

    -- BEGIN
    definition two_pow : ℕ → ℕ
    | 0       := 1 
    | (n + 1) := 2 * two_pow n

    definition fact : ℕ → ℕ 
    | 0       := 1
    | (n + 1) := (n + 1) * fact n
    -- END

If we wanted to define the function ``m^n``, we would do that by fixing
``m``, and writing doing the recursion on the second argument:

.. code:: lean

    open nat

    -- BEGIN
    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * pow m n
    -- END

Lean is also smart enough to interpret more complicated forms of
recursion, like this one:

.. code:: lean

    definition fib : ℕ → ℕ
    | 0        := 0
    | 1        := 1
    | (n + 2)  := fib (n + 1) + fib n

In addition to defining functions by recursion, we can prove theorems by
induction. In Lean, each clause of a recursive definition results in a
new identity. For example, the two clauses in the definition of ``pow``
above give rise to the following two theorems:

.. code:: lean

    open nat

    namespace hide

    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * pow m n

    -- BEGIN
    proposition pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    proposition pow_succ (m n : ℕ) : pow m (succ n) = m * pow m n := rfl
    -- END

    end hide

Notice that we could alternatively have used ``(pow m n) * m`` in the
second clause of the definition of ``pow``. Of course, we can prove that
the two definitions are equivalent using the commutativity of
multiplication, but, using a proof by induction, we can also prove it
using only the associativity of multiplication, and the properties
``1 * m = m`` and ``m * 1 = m``. This is useful, because the power
function is also often used in situations where multiplication is not
commutative, such as with matrix multiplication. The theorem can be
proved in Lean as follows:

.. code:: lean

    import data.nat 
    open nat

    namespace hide

    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * (pow m n)

    proposition pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    proposition pow_succ (m n : ℕ) : pow m (succ n) = m * (pow m n) := rfl

    -- BEGIN
    theorem pow_succ' (m n : ℕ) : pow m (succ n) = (pow m n) * m :=
    nat.induction_on n
      (show pow m (succ 0) = pow m 0 * m, from calc
        pow m (succ 0) = m * pow m 0 : pow_succ
                   ... = m * 1       : pow_zero
                   ... = m           : mul_one
                   ... = 1 * m       : one_mul
                   ... = pow m 0 * m : pow_zero)
      (take n,
        assume ih : pow m (succ n) = pow m n * m,
        show pow m (succ (succ n)) = pow m (succ n) * m, from calc
          pow m (succ (succ n)) = m * (pow m (succ n)) : pow_succ
                            ... = m * (pow m n * m)    : ih
                            ... = (m * pow m n) * m    : mul.assoc
                            ... = pow m (succ n) * m   : pow_succ)
    -- END
    end hide

This is a typical proof by induction in Lean. It begins with the phrase
``nat.induction_on n``, and is followed by the base case and the
inductive hypothesis. The proof can be shortened with a clever use of
``rewrite``:

.. code:: lean

    import data.nat 
    open nat

    namespace hide

    definition pow : ℕ → ℕ → ℕ 
    | m 0        := 1
    | m (n + 1)  := m * (pow m n)

    proposition pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    proposition pow_succ (m n : ℕ) : pow m (succ n) = m * (pow m n) := rfl

    -- BEGIN
    theorem pow_succ' (m n : ℕ) : pow m (succ n) = (pow m n) * m :=
    nat.induction_on n
      (show pow m (succ 0) = pow m 0 * m, 
        by rewrite [pow_succ, pow_zero, mul_one, one_mul])
      (take n,
        assume ih : pow m (succ n) = pow m n * m,
        show pow m (succ (succ n)) = pow m (succ n) * m, 
          by rewrite [pow_succ, ih at {1}, -mul.assoc])
    -- END
    end hide

Remember that you can write a ``rewrite`` proof incrementally, checking
the error messages to make sure things are working so far, and to see
how far Lean got. The phrase ``ih at {1}`` tells Lean to apply the
inductive hypothesis only at the first place where it matches, and the
phrase ``-mul.assoc`` tells Lean to apply the associativity equation in
the backward direction.

In any case, the power function is already defined in the Lean library
as ``pow_nat``. (It is defined generically for any type that has a
multiplication; the ``nat`` in ``pow_nat`` refers to the fact that the
exponent is a natural number.) The definition is essentially the one
above, and the theorems above are also there:

.. code:: lean

    import data.nat 
    open nat

    check @pow_nat
    check @pow_zero
    check @pow_succ
    check @pow_succ'

The library also allows us to use the usual notation:

.. code:: lean

    import data.nat
    open nat

    -- BEGIN
    variables m n : ℕ

    check m^n
    -- END

As another example of a proof by induction, here is a proof of the
identity ``m^(n + k) = m^n * m^k``.

.. code:: lean

    import data.nat 
    open nat

    namespace hide

    -- BEGIN
    theorem pow_add (m n k : ℕ) : m^(n + k) = m^n * m^k :=
    nat.induction_on k
      (show m^(n + 0) = m^n * m^0, from calc
        m^(n + 0) = m^n       : add_zero
              ... = m^n * 1   : mul_one
              ... = m^n * m^0 : pow_zero)
      (take k,
        assume ih : m^(n + k) = m^n * m^k,
        show m^(n + succ k) = m^n * m^(succ k), from calc
          m^(n + succ k) = m^(succ (n + k)) : add_succ
                     ... = m^(n + k) * m    : pow_succ'
                     ... = m^n * m^k * m    : ih
                     ... = m^n * (m^k * m)  : mul.assoc
                     ... = m^n * m^(succ k) : pow_succ')
    -- END
    end hide

Notice the same pattern. This time, we do induction on ``k``, and the
base case and inductive step are routine. Once again, with a bit of
cleverness, we can shorten the proof with ``rewrite``:

.. code:: lean

    import data.nat 
    open nat

    namespace hide

    -- BEGIN
    theorem pow_add (m n k : ℕ) : m^(n + k) = m^n * m^k :=
    nat.induction_on k
      (show m^(n + 0) = m^n * m^0, 
        by rewrite [add_zero, pow_zero, mul_one]) 
      (take k,
        assume ih : m^(n + k) = m^n * m^k,
        show m^(n + succ k) = m^n * m^(succ k),
         by rewrite [add_succ, pow_succ', ih, mul.assoc, pow_succ'])
    -- END
    end hide

You should not hesitate to use ``calc``, however, to make the proofs
more explicit. Remember that you can also use ``calc`` and ``rewrite``
together, using ``calc`` to structure the calculational proof, and using
``rewrite`` to fill in each justification step.

Defining the Arithmetic Operations in Lean
------------------------------------------

In fact, addition and multiplication are defined in Lean essentially as
described in `Section
18.1 <#Defining_the_Arithmetic_Operations_Axiomatically>`__. The
defining equations for addition hold by reflexivity, but they are also
named ``add_zero`` and ``add_succ``:

.. code:: lean

    import data.nat 
    open nat

    variables m n : ℕ

    example : m + 0 = m := add_zero m
    example : m + succ n = succ (m + n) := add_succ m n

Similarly, we have the defining equations for the predecessor function
and multiplication:

.. code:: lean

    import data.nat 
    open nat

    check @pred_zero
    check @pred_succ
    check @mul_zero
    check @mul_succ

Here are the five propositions proved in `Section
18.1 <#Defining_the_Arithmetic_Operations_Axiomatically>`__.

.. code:: lean

    import data.nat 
    open nat

    namespace hide

    -- BEGIN
    theorem succ_pred (n : ℕ) : n ≠ 0 → succ (pred n) = n :=
    nat.induction_on n
      (assume H : 0 ≠ 0,
        show succ (pred 0) = 0, from absurd rfl H)
      (take n,
        assume ih,
        assume H : succ n ≠ 0,
        show succ (pred (succ n)) = succ n, 
          by rewrite pred_succ)

    theorem zero_add (n : nat) : 0 + n = n :=
    nat.induction_on n
      (show 0 + 0 = 0, from rfl)
      (take n,
        assume IH : 0 + n = n,
        show 0 + succ n = succ n, from
          calc
        0 + succ n = succ (0 + n) : rfl
          ... = succ n : IH)

    theorem succ_add (m n : nat) : succ m + n = succ (m + n) :=
    nat.induction_on n
      (show succ m + 0 = succ (m + 0), from rfl)
      (take n,
        assume IH : succ m + n = succ (m + n),
        show succ m + succ n = succ (m + succ n), from
          calc
        succ m + succ n = succ (succ m + n) : rfl
          ... = succ (succ (m + n)) : IH
          ... = succ (m + succ n) : rfl)

    theorem add_assoc (m n k : nat) : m + n + k = m + (n + k) :=
    nat.induction_on k
      (show m + n + 0 = m + (n + 0), by rewrite *add_zero)
      (take k, 
        assume ih : m + n + k = m + (n + k),
        show m + n + succ k = m + (n + (succ k)), from calc
          m + n + succ k = succ (m + n + k)   : add_succ
                     ... = succ (m + (n + k)) : ih
                     ... = m + (n + succ k)   : by rewrite *add_succ)

    theorem add_comm (m n : nat) : m + n = n + m :=
    nat.induction_on n
      (show m + 0 = 0 + m, by rewrite [add_zero, zero_add])
      (take n,
        assume ih : m + n = n + m,
        show m + succ n = succ n + m, from calc
          m + succ n = succ (m + n) : add_succ
                 ... = succ (n + m) : ih
                 ... = succ n + m   : succ_add)

    -- END
    end hide

Exercises
---------

#. Give an informal but detailed proof that for every natural number
   :math:`n`, :math:`1 \cdot n = n`.

#. Prove the multiplication is associative and commutative, in the same
   way.

#. Prove that multiplication distributes over addition: for every
   natural numbers :math:`m`, :math:`n`, and :math:`k`,
   :math:`m (n + k) = m n + m k`.

#. Prove :math:`(m^n)^k = m^{nk}`.

#. Formalize all these theorems in Lean.
