Relations in Lean
=================

In the last chapter, we noted that set theorists think of a binary relation :math:`R` on a set :math:`A` as a set of ordered pairs, so that :math:`R(a, b)` really means :math:`(a, b) \in R`. An alternative is to think of :math:`R` as a function which, when applied to :math:`a` and :math:`B`, returns the proposition that :math:`R(a, b)` holds. This is the viewpoint adopted by Lean: a binary relation on a type ``A`` is a function ``A → A → Prop``. Remember that the arrows associate to the right, so ``A → A → Prop`` really means ``A → (A → Prop)``. So, given ``a : A``, ``R a`` is a predicate (the property of being related to ``A``), and given ``a b : A``, ``R a b`` is a proposition.


Order Relations
---------------

With first-order logic, we can say what it means for a relation to be reflexive, symmetric, transitive, antisymmetric, and so on:

.. code-block:: lean

    namespace hide

    variable {A : Type}

    def reflexive (R : A → A → Prop) : Prop := 
    ∀ x, R x x

    def symmetric (R : A → A → Prop) : Prop := 
    ∀ x y, R x y → R y x

    def transitive (R : A → A → Prop) : Prop := 
    ∀ x y z, R x y → R y z → R x z

    def antisymmetric (R : A → A → Prop) : Prop := 
    ∀ x y, R x y → R y x → x = y

    end hide

We can then use the notions freely. Notice that Lean will unfold the definitions when necessary, for example, treating ``reflexive R`` as ``∀ x, R x x``.

.. code-block:: lean

    namespace hide

    variable {A : Type}

    def reflexive (R : A → A → Prop) : Prop := 
    ∀ x, R x x

    def symmetric (R : A → A → Prop) : Prop := 
    ∀ x y, R x y → R y x

    def transitive (R : A → A → Prop) : Prop := 
    ∀ x y z, R x y → R y z → R x z

    def antisymmetric (R : A → A → Prop) : Prop := 
    ∀ x y, R x y → R y x → x = y

    -- BEGIN
    variable R : A → A → Prop

    example (h : reflexive R) (x : A) : R x x := h x

    example (h : symmetric R) (x y : A) (h1 : R x y) : R y x :=
    h x y h1

    example (h : transitive R) (x y z : A) (h1 : R x y) (h2 : R y z) : 
      R x z :=
    h x y z h1 h2

    example (h : antisymmetric R) (x y : A) (h1 : R x y) 
        (h2 : R y x) : 
      x = y :=
    h x y h1 h2
    -- END
    
    end hide

In the command ``variable {A : Type}``, we put curly braces around ``A`` to indicate that it is an *implicit* argument, which is to say, you do not have to write it explicitly; Lean can infer it from the argument ``R``. That is why we can write ``reflexive R`` rather than ``reflexive A R``: Lean knows that ``R`` is a binary relation on ``A``, so it can infer that we mean reflexivity for binary relations on ``A``. 

Given ``h : transitive R``, ``h1 : R x y``, and ``h2 : R y z``, it is annoying to have to write ``h x y z h1 h2`` to prove ``R x z``. After all, Lean should be able to infer that we are talking about transitivity at ``x``, ``y``, and ``z``, from the fact that ``h1`` is ``R x y`` and ``h2`` is ``R y z``. Indeed, we can replace that information by underscores:

.. code-block:: lean

    namespace hide

    variable {A : Type}

    def transitive (R : A → A → Prop) : Prop := 
    ∀ x y z, R x y → R y z → R x z

    -- BEGIN
    variable R : A → A → Prop

    example (h : transitive R) (x y z : A) (h1 : R x y) 
        (h2 : R y z) : 
      R x z :=
    h _ _ _ h1 h2
    -- END
    
    end hide

But typing underscores is annoying, too. The best solution is to declare the arguments ``x y z`` to a transitivity hypothesis to be implicit as well:

.. code-block:: lean

    namespace hide

    -- BEGIN
    variable {A : Type}

    def transitive (R : A → A → Prop) : Prop := 
    ∀ {x y z}, R x y → R y z → R x z

    variable R : A → A → Prop

    example (h : transitive R) (x y z : A) (h1 : R x y) (h2 : R y z) : 
    R x z :=
    h h1 h2
    -- END
    
    end hide

In fact, the notions ``reflexive``, ``symmetric``, ``transitive``, and ``antisymmetric`` are defined in Lean's core library in exactly this way, so we are free to use them without defining them. (That is why we put our temporary definitions of in a namespace ``hide``; that means that the full name of our version of ``reflexive`` is ``hide.reflexive``, which, therefore, doesn't conflict with the one defined in the library.)

In :numref:`order_relations` we showed that a strict partial order---that is, a binary relation that is transitive and irreflexive---is also asymmetric. Here is a proof of that fact in Lean.

.. code-block:: lean

    variable A : Type
    variable R : A → A → Prop

    example (h1 : irreflexive R) (h2 : transitive R) : 
      ∀ x y, R x y → ¬ R y x :=
    assume x y,
    assume h3 : R x y,
    assume h4 : R y x,
    have h5 : R x x, from h2 h3 h4,
    have h6 : ¬ R x x, from h1 x, 
    show false, from h6 h5

In mathematics, it is common to use infix notation and a symbol like ``≤`` to denote a partial order. Lean supports this practice:
 
.. code-block:: lean

    section
    parameter A : Type
    parameter R : A → A → Prop

    local infix ≤ := R

    example (h1 : irreflexive R) (h2 : transitive R) : 
      ∀ x y, x ≤ y → ¬ y ≤ x :=
    assume x y,
    assume h3 : x ≤ y,
    assume h4 : y ≤ x,
    have h5 : x ≤ x, from h2 h3 h4,
    have h6 : ¬ x ≤ x, from h1 x, 
    show false, from h6 h5

    end

The ``parameter`` and ``parameters`` commands are similar to the ``variable`` and ``variables`` commands, except that parameters are fixed within a section. In other words, if you prove a theorem about ``R`` in the section above, you cannot apply that theorem to another relation, ``S``, without closing the section. Since the parameter ``R`` is fixed, Lean allows us to define notation for ``R`` to be used locally in the section.

In the example below, having fixed a partial order, ``R``, we define the corresponding strict partial order and prove that it is, indeed, a strict order.

.. code-block:: lean

    section
    parameters {A : Type} (R : A → A → Prop)
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
        have c ≤ b, from eq.subst ‹a = c› ‹a ≤ b›,
        have b = c, from antisymmR ‹b ≤ c› ‹c ≤ b›,
        show false, from ‹b ≠ c› ‹b = c›,
    show a < c, from and.intro ‹a ≤ c› ‹a ≠ c›
    end

Notice that we have used suggestive names ``reflR``, ``transR``, ``antisymmR`` instead of ``h1``, ``h2``, ``h3`` to help remember which hypothesis is which. The proof also uses anonymous ``have`` and ``assume``, referring back to them with the French quotes, ``\f<`` anf ``\f>``. Remember also that ``eq.subst ‹a = c› ‹a ≤ b›`` is a proof of the fact that amounts for substituting ``c`` for ``a`` in ``a ≤ b``. You can also use the equivalent notation ``‹a = c› ▸ ‹a ≤ b›``, where the triangle is written ``\t``.

In Section :numref:`order_relations`, we also noted that you can define a (weak) partial order from a strict one. We ask you to do this formally in the exercises below.

Here is one more example. Suppose ``R`` is a binary relation on a type ``A``, and we define ``S x y`` to mean that both ``R x y`` and ``R y x`` holds. Below we show that the resulting relation is reflexive and symmetric.

.. code-block:: lean

    section
    parameter A : Type
    parameter R : A → A → Prop

    variable h1 : transitive R
    variable h2 : reflexive R

    def S (x y : A) := R x y ∧ R y x

    example : reflexive S :=
    assume x,
    have R x x, from h2 x,
    show S x x, from and.intro this this

    example : symmetric S :=
    assume x y,
    assume h : S x y,
    have h1 : R x y, from h.left,
    have h2 : R y x, from h.right,
    show S y x, from ⟨h.right, h.left⟩ 
        
    end

In the exercises below, we ask you to show that ``S`` is transitive as well.

In the first example, we use the anonymous ``assume`` and ``have``, and then refer back to the ``have`` with the keyword ``this``. In the second example, we abbreviate ``and.left h`` and ``and.right h`` as ``h.left`` and ``h.right``, respectively. We also abbreviate ``and.intro h.right h.left`` with an anonymous constructor, writing ``⟨h.right, h.left⟩``. Lean figures out that we are trying to prove a conjunction, and figures out that ``and.intro`` is the relevant introduction principle. You can type the corner brackets with ``\<`` and ``\>``, respectively.

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

.. TODO(Jeremy): add a section on equivalence relations

Exercises
---------

#. Replace the ``sorry`` commands in the following proofs to show that we can create a partial order ``R'​`` out of a strict partial order ``R``.

   .. code-block:: lean

        section
        parameters {A : Type} {R : A → A → Prop}
        parameter (irreflR : irreflexive R)
        parameter (transR : transitive R)

        local infix < := R

        def R' (a b : A) : Prop := R a b ∨ a = b
        local infix ≤ := R'

        theorem reflR' (a : A) : a ≤ a := sorry

        theorem transR' {a b c : A} (h1 : a ≤ b) (h2 : b ≤ c): 
          a ≤ c := 
        sorry
        
        theorem antisymmR' {a b : A} (h1 : a ≤ b) (h2 : b ≤ a) : 
          a = b := 
        sorry

        end

#. Replace the ``sorry`` by a proof.

   .. code-block:: lean

        section
        parameters {A : Type} {R : A → A → Prop}
        parameter (reflR : reflexive R)
        parameter (transR : transitive R)

        def S (a b : A) : Prop := R a b ∧ R b a

        example : transitive S :=
        sorry

        end

#. Only one of the following two theorems is provable. Figure out which one is true, and replace the ``sorry`` command with a complete proof.

   .. code-block:: lean

       section
         parameters {A : Type} {a b c : A} {R : A → A → Prop}
         parameter (Rab : R a b)
         parameter (Rbc : R b c)
         parameter (nRac : ¬ R a c)

         -- Prove one of the following two theorems:

         theorem R_is_strict_partial_order : 
           irreflexive R ∧ transitive R :=
         sorry

         theorem R_is_not_strict_partial_order : 
           ¬(irreflexive R ∧ transitive R) :=
         sorry
       end


#. Complete the following proof.

   .. code-block:: lean

       open nat

       example : 1 ≤ 4 :=
       sorry
