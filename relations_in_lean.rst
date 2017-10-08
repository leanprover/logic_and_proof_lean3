Relations in Lean
=================

In the last chapter, we noted that set theorists think of a binary relation :math:`R` on a set :math:`A` as a set of ordered pairs, so that :math:`R(a, b)` really means :math:`(a, b) \in R`. An alternative is to think of :math:`R` as a function which, when applied to :math:`a` and :math:`B`, returns the proposition that :math:`R(a, b)` holds. This is the viewpoint adopted by Lean: a binary relation on a type ``A`` is a function ``A → A → Prop``. So, if ``R`` is a binary relation on ``A`` and we have ``a b : A``, then ``R a b`` is a proposition.

As in informal mathematics, we often wish to use infix notation for relations. We will see below that Lean supports this practice.

Order Relations
---------------

We can reason about partial orders in Lean by fixing a type, ``A``, and a binary relation, ``R``, and working under the hypotheses that ``A`` is reflexive, transitive, and antisymmetric:

.. code-block:: lean

    section
      parameters {A : Type} {R : A → A → Prop}
      parameter (reflR : reflexive R)
      parameter (transR : transitive R)
      parameter (antisymmR : ∀ {a b : A}, R a b → R b a → a = b)

      local infix ≤ := R
    end

The ``parameter`` and ``parameter`` commands are similar to the ``variable`` and ``premise`` commands, except that parameters are fixed within a section. In other words, if you prove a theorem about ``R`` in the section above, you cannot apply that theorem to another relation, ``S``, without closing the section. Since the parameter ``R`` is fixed, Lean allows us to define notation for ``R``, to be used locally in the section.

In the example below, having fixed a partial order, ``R``, we define the corresponding strict partial order and prove that it is, indeed, a strict order.

.. code-block:: lean

    section
    parameters {A : Type} {R : A → A → Prop}
    parameter (reflR : reflexive R)
    parameter (transR : transitive R)
    parameter (antisymmR : ∀ {a b : A}, R a b → R b a → a = b)

    local infix ≤ := R

    definition R' (a b : A) : Prop := a ≤ b ∧ a ≠ b

    local infix < := R'

    theorem irrefl (a : A) : ¬ a < a :=
    assume : a < a,
    have a ≠ a, from and.right this,
    have a = a, from rfl,
    show false, from ‹a ≠ a› ‹a = a›

    theorem trans {a b c : A} (h₁ : a < b) (h₂ : b < c) : a < c :=
    have a ≤ b, from and.left h₁,
    have a ≠ b, from and.right h₁,
    have b ≤ c, from and.left h₂,
    have b ≠ c, from and.right h₂,
    have a ≤ c, from transR ‹a ≤ b› ‹b ≤ c›,
    have a ≠ c, from
        assume : a = c,
        have c ≤ b, from ‹a = c› ▸ ‹a ≤ b›,
        have b = c, from antisymmR ‹b ≤ c› ‹c ≤ b›,
        show false, from ‹b ≠ c› ‹b = c›,
    show a < c, from and.intro ‹a ≤ c› ‹a ≠ c›
    end

Notice that we have used the command ``open eq.ops`` to avail ourselves of the extra notation for equality proofs, so that the expression ```a = c` ▸ `a ≤ b``` denotes a proof of ``c ≤ b``.

In the exercises, we ask you to show the other direction of this: from a strict partial order we can define a partial order.

Orderings on Numbers
--------------------

Conveniently, Lean has the normal orderings on the natural numbers, integers, and so on defined already.

.. code-block:: lean

    open nat
    variables n m : ℕ

    #check 0 ≤ n
    #check n < n + 1

    example : 0 ≤ n := zero_le n
    example : n < n + 1 := lt_succ_self n

    example (h : n + 1 ≤ m) : n < m + 1 :=
    have h1 : n < n + 1, from lt_succ_self n,
    have h2 : n < m, from lt_of_lt_of_le h1 h,
    have h3 : m < m + 1, from lt_succ_self m,
    show n < m + 1, from lt.trans h2 h3

There are many theorems in Lean that are useful for proving facts about inequality relations. We list some common ones here.

.. code-block:: lean

    variables (A : Type) [partial_order A]
    variables a b c : A

    #check (le_trans : a ≤ b → b ≤ c → a ≤ c)
    #check (lt_trans : a < b → b < c → a < c)
    #check (lt_of_lt_of_le : a < b → b ≤ c → a < c)
    #check (lt_of_le_of_lt : a ≤ b → b < c → a < c)
    #check (le_of_lt : a < b → a ≤ b)

Here the declaration at the top says that ``A`` has the structure of a partial order. There are also properties that are specific to some domains, like the natural numbers:

.. code-block:: lean

    variable n : ℕ

    #check (nat.zero_le : ∀ n : ℕ, 0 ≤ n)
    #check (nat.lt_succ_self : ∀ n : ℕ, n < n + 1)
    #check (nat.le_succ : ∀ n : ℕ, n ≤ n + 1)

Exercises
---------

#. Replace the ``sorry`` commands in the following proofs to show that we can create a partial order ``R'​`` out of a strict partial order ``R``.

   .. code-block:: lean

        section
        parameters {A : Type} {R : A → A → Prop}
        parameter (irreflR : irreflexive R)
        parameter (transR : transitive R)

        local infix < := R

        definition R' (a b : A) : Prop := R a b ∨ a = b
        local infix ≤ := R'

        theorem reflR' (a : A) : a ≤ a := sorry
        theorem transR' {a b c : A} (h1 : a ≤ b) (h2 : b ≤ c): a ≤ c := sorry
        theorem antisymmR' {a b : A} (h1 : a ≤ b) (h2 : b ≤ a) : a = b := sorry
        end

#. Complete the following proof. Note: we write ``(1 : ℕ)`` instead of just ``1`` so that Lean does not confuse the natural number ``1`` with the integer, rational, or so on.

   .. code-block:: lean

       open nat

       example : (1 : ℕ) ≤ (4 : ℕ) :=
       sorry

#. Only one of the following two theorems is provable. Figure out which one is true, and replace the ``sorry`` command with a complete proof.

   .. code-block:: lean

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
