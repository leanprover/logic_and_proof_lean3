.. _the_natural_numbers_and_induction_in_lean:

The Natural Numbers and Induction in Lean
=========================================

Induction and Recursion in Lean
-------------------------------

Internally, in Lean, the natural numbers are defined as a type generated inductively from an axiomatically declared ``zero`` and ``succ`` operation:

.. code-block:: lean

    namespace hidden

    -- BEGIN
    inductive nat : Type
    | zero : nat
    | succ : nat → nat
    -- END
    end hidden

If you click the button that copies this text into the editor in the online version of this textbook, you will see that we wrap it with the phrases ``namespace hidden`` and ``end hidden``. This puts the definition into a new "namespace," so that the identifiers that are defined are ``hidden.nat``, ``hidden.nat.zero`` and ``hidden.nat.succ``, to avoid conflicting with the one that is in the Lean library. Below, we will do that in a number of places where our examples duplicate objects defined in the library. The unicode symbol ``ℕ``, entered with ``\N`` or ``\nat``, is a synonym for ``nat``.

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
    | m (n + 1)  := pow m n * m

In fact, this is how the power function on the natural numbers, ``nat.pow``, is defined in Lean's library.

Lean is also smart enough to interpret more complicated forms of recursion, like this one:

.. code-block:: lean

    def fib : ℕ → ℕ
    | 0        := 0
    | 1        := 1
    | (n + 2)  := fib (n + 1) + fib n

In addition to defining functions by recursion, we can prove theorems by induction. In Lean, each clause of a recursive definition results in a new identity. For example, the two clauses in the definition of ``pow`` above give rise to the following two theorems:

.. code-block:: lean

    open nat

    theorem pow_zero (n : ℕ) : pow n 0 = 1 := rfl
    theorem pow_succ (m n : ℕ) : pow m (n+1) = pow m n * m := rfl

Lean defines the usual notation for exponentiation:

.. code-block:: lean

    open nat

    theorem pow_zero (n : ℕ) : n^0 = 1 := rfl
    theorem pow_succ (m n : ℕ) : m^(n+1) = m^n * m := rfl

Notice that we could alternatively have used ``m * pow m n`` in the second clause of the definition of ``pow``. Of course, we can prove that the two definitions are equivalent using the commutativity of multiplication, but, using a proof by induction, we can also prove it using only the associativity of multiplication, and the properties ``1 * m = m`` and ``m * 1 = m``. This is useful, because the power function is also often used in situations where multiplication is not commutative, such as with matrix multiplication. The theorem can be proved in Lean as follows:

.. code-block:: lean

  open nat

  theorem pow_succ' (m n : ℕ) : m^(succ n) = m * m^n :=
  nat.rec_on n
    (show m^(succ 0) = m * m^0, from calc
      m^(succ 0) = m^0 * m : by rw pow_succ
             ... = 1 * m   : by rw pow_zero
             ... = m       : by rw one_mul
             ... = m * 1   : by rw mul_one
             ... = m * m^0 : by rw pow_zero)
    (assume n,
      assume ih : m^(succ n) = m * m^n,
      show m^(succ (succ n)) = m * m^(succ n), from calc
        m^(succ (succ n)) = m^(succ n) * m   : by rw pow_succ
                      ... = (m * m^n) * m    : by rw ih
                      ... = m * (m^n * m)    : by rw mul_assoc
                      ... = m * m^(succ n)   : by rw pow_succ)

This is a typical proof by induction in Lean. It begins with the phrase ``nat.rec_on n``, and is followed by the base case and the inductive hypothesis. (The phrase ``open nat`` allows us to write ``pow`` instead of ``nat.pow``. The proof can be shortened using ``rewrite``:

.. code-block:: lean

  open nat

  theorem pow_succ' (m n : ℕ) : m^(succ n) = m * (m^n) :=
  nat.rec_on n
    (show m^(succ 0) = m * m^0,
      by rw [pow_succ, pow_zero, mul_one, one_mul])
    (assume n,
      assume ih : m^(succ n) = m * m^n,
      show m^(succ (succ n)) = m * m^(succ n),
        by rw [pow_succ, ih, mul_assoc, mul_comm (m^n)])

Remember that you can write a ``rewrite`` proof incrementally, checking the error messages to make sure things are working so far, and to see how far Lean got.

As another example of a proof by induction, here is a proof of the identity ``m^(n + k) = m^n * m^k``.

.. code-block:: lean

  open nat

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
                  ... = m^(n + k) * m    : by rw pow_succ
                  ... = m^n * m^k * m    : by rw ih
                  ... = m^n * (m^k * m)  : by rw mul_assoc
                  ... = m^n * m^(succ k) : by rw pow_succ)

Notice the same pattern. This time, we do induction on ``k``, and the base case and inductive step are routine. Once again, with a bit of cleverness, we can shorten the proof with ``rewrite``:

.. code-block:: lean

  open nat

  theorem pow_add (m n k : ℕ) : m^(n + k) = m^n * m^k :=
  nat.rec_on k
    (show m^(n + 0) = m^n * m^0,
      by rw [add_zero, pow_zero, mul_one])
    (assume k,
      assume ih : m^(n + k) = m^n * m^k,
      show m^(n + succ k) = m^n * m^(succ k),
      by rw [nat.add_succ, pow_succ, ih, mul_assoc, pow_succ])

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

    namespace hidden

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
    end hidden

Exercises
---------

#. Formalize as many of the identities from :numref:`defining_arithmetic_operations` as you can by replacing each `sorry` with a proof.

   .. code-block:: lean

       --1.a.
       example : ∀ m n k : nat, m * (n + k) = m * n + m * k := sorry

       --1.b.
       example : ∀ n : nat, 0 * n = 0 := sorry

       --1.c.
       example : ∀ n : nat, 1 * n = n := sorry

       --1.d.
       example : ∀ m n k : nat, (m * n) * k = m * (n * k) := sorry

       --1.e.
       example : ∀ m n : nat, m * n= n * m := sorry

#. Formalize as many of the identities from :numref:`arithmetic_on_the_natural_numbers` as you can by replacing each `sorry` with a proof.

   .. code-block:: lean

      --2.a.
      example : ∀ m n k : nat, n ≤ m → n + k ≤ m  + k := sorry

      --2.b.
      example : ∀ m n k : nat, n + k ≤ m + k → n ≤ m := sorry

      --2.c.
      example : ∀ m n k : nat, n ≤ m → n * k ≤ m * k := sorry

      --2.d.
      example : ∀ m n : nat, m ≥ n → m = n ∨ m ≥ n+1 := sorry

      --2.e.
      example : ∀ n : nat, 0 ≤ n := sorry