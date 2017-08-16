Relations in Lean
=================

In the last chapter, we noted that set theorists think of a binary
relation :math:`R` on a set :math:`A` as a set of ordered pairs, so that
:math:`R(a, b)` really means :math:`(a, b) \in R`. An alternative is to
think of :math:`R` as a function which, when applied to :math:`a` and
:math:`B`, returns the proposition that :math:`R(a, b)` holds. This is
the viewpoint adopted by Lean: a binary relation on a type ``A`` is a
function ``A → A → Prop``. So, if ``R`` is a binary relation on ``A``
and we have ``a b : A``, then ``R a b`` is a proposition.

As in informal mathematics, we often wish to use infix notation for
relations. We will see below that Lean supports this practice.

Order Relations
---------------

We can reason about partial orders in Lean by fixing a type, ``A``, and
a binary relation, ``R``, and working under the hypotheses that ``A`` is
reflexive, transitive, and antisymmetric:

.. code:: lean

    section
      parameters {A : Type} {R : A → A → Prop}
      parameter (reflR : reflexive R)
      parameter (transR : transitive R)
      parameter (antisymmR : ∀ {a b : A}, R a b → R b a → a = b)

      local infix ≤ := R
    end

The ``parameter`` and ``parameter`` commands are similar to the
``variable`` and ``premise`` commands, except that parameters are fixed
within a section. In other words, if you prove a theorem about ``R`` in
the section above, you cannot apply that theorem to another relation,
``S``, without closing the section. Since the parameter ``R`` is fixed,
Lean allows us to define notation for ``R``, to be used locally in the
section.

In the example below, having fixed a partial order, ``R``, we define the
corresponding strict partial order and prove that it is, indeed, a
strict order.

.. code:: lean

    open eq.ops

    section
      parameters {A : Type} {R : A → A → Prop}
      parameter (reflR : reflexive R)
      parameter (transR : transitive R)
      parameter (antisymmR : ∀ {a b : A}, R a b → R b a → a = b)

      local infix ≤ := R

      definition R' (a b : A) : Prop := a ≤ b ∧ a ≠ b

      local infix < := R'

      theorem irrefl (a : A) : ¬ a < a :=
      suppose a < a,
      have a ≠ a, from and.right this,
      have a = a, from rfl,
      show false, from `a ≠ a` `a = a`

      theorem trans {a b c : A} (H₁ : a < b) (H₂ : b < c) : a < c :=
      have a ≤ b, from and.left H₁,
      have a ≠ b, from and.right H₁,
      have b ≤ c, from and.left H₂,
      have b ≠ c, from and.right H₂,
      have a ≤ c, from transR `a ≤ b` `b ≤ c`,
      have a ≠ c, from 
        suppose a = c,
          have c ≤ b, from `a = c` ▸ `a ≤ b`,
          have b = c, from antisymmR `b ≤ c` `c ≤ b`,
          show false, from `b ≠ c` `b = c`, 
      show a < c, from and.intro `a ≤ c` `a ≠ c`
    end

Notice that we have used the command ``open eq.ops`` to avail ourselves
of the extra notation for equality proofs, so that the expression
```a = c` ▸ `a ≤ b``` denotes a proof of ``c ≤ b``.

In the exercises, we ask you to show the other direction of this: from a
strict partial order we can define a partial order.

Orderings on Numbers
--------------------

Conveniently, Lean has the normal orderings on the natural numbers,
integers, and so on defined already.

.. code:: lean

    open nat
    variables n m : ℕ

    #check 0 ≤ n
    #check n < n + 1

    example : 0 ≤ n := zero_le n
    example : n < n + 1 := self_lt_succ n

    example (H : n + 1 ≤ m) : n < m + 1 :=
    have H1 : n < n + 1, from self_lt_succ n,
    have H2 : n < m, from lt_of_lt_of_le H1 H,
    have H3 : m < m + 1, from self_lt_succ m,
    show n < m + 1, from lt.trans H2 H3

There are many theorems in Lean that are useful for proving facts about
inequality relations. We list some common ones here.

#. ``zero_le : ∀ a : A, 0 ≤ a``
#. ``self_lt_succ : ∀ a : A, a < a + 1``
#. ``le_succ : ∀ a : A, a ≤ a + 1``
#. ``le.trans : ∀ a b c : A, a ≤ b → b ≤ c → a ≤ c``
#. ``lt.trans : ∀ a b c : A, a < b → b < c → a < c``
#. ``lt_of_lt_of_le : ∀ a b c : A, a < b → b ≤ c → a < c``
#. ``lt_of_le_of_lt : ∀ a b c : A, a ≤ b → b < c → a < c``
#. ``le_of_lt : ∀ a b : A, a < b → a ≤ b``

Exercises
---------

#. Replace the ``sorry`` commands in the following proofs to show that
   we can create a partial order ``R'​`` out of a strict partial order
   ``R``.

   .. code:: lean

       open eq.ops

       section
         parameters {A : Type} {R : A → A → Prop}
         parameter (irreflR : irreflexive R)
         parameter (transR : transitive R)

         local infix < := R

         definition R' (a b : A) : Prop := R a b ∨ a = b
         local infix ≤ := R'

         theorem reflR' (a : A) : a ≤ a := sorry
         theorem transR' {a b c : A} (H1 : a ≤ b) (H2 : b ≤ c): a ≤ c := sorry
         theorem antisymmR' {a b : A} (H1 : a ≤ b) (H2 : b ≤ a) : a = b := sorry 
       end

#. Complete the following proof. Note: we write ``(1 : ℕ)`` instead of
   just ``1`` so that Lean does not confuse the natural number ``1``
   with the integer, rational, or so on.

   .. code:: lean

       open nat

       example : (1 : ℕ) ≤ (4 : ℕ) :=
       sorry

#. Only one of the following two theorems is provable. Figure out which
   one is true, and replace the ``sorry`` command with a complete proof.

   .. code:: lean

       open eq.ops
       section

         parameters {A : Type} {a b c : A} {R : A → A → Prop}
         parameter (Rab : R a b)
         parameter (Rbc : R b c)
         parameter (nRac : ¬ R a c)

         -- Prove one of the following two theorems:

         theorem R_is_strict_partial_order : irreflexive R ∧ transitive R :=
         sorry

         theorem R_is_not_strict_partial_order : ¬(irreflexive R ∧ transitive R) :=
         sorry
       end
