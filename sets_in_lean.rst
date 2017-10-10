Sets in Lean
============

In the last chapter, we noted that although in axiomatic set theory one consider sets of disparate objects, it is more common in mathematics to consider subsets of some fixed domain, :math:`\mathcal U`. This is the way sets are handled in Lean. For any data type ``U``, Lean gives us a new data type, ``set U``, consisting of the sets of elements of ``U``. Thus, for example, we can reason about sets of natural numbers, or sets of integers, or sets of pairs of natural numbers.

.. _sets_in_lean_basics:

Basics
------

Given ``A : set U`` and ``x : U``, we can write ``x ∈ A`` to state that ``x`` is a member of the set ``A``. The character ``∈`` can be typed using ``\in``. We need to import the library file ``data.set`` and open the "namespace" set to have the notions and notations made available to us.

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U
    variable x : U

    #check x ∈ A
    #check A ∪ B
    #check B \ C
    #check C ∩ A
    #check -C
    #check ∅ ⊆ A
    #check B ⊆ univ

You can type the symbols ``⊆``, ``∅``, ``∪``, ``∩``, ``\`` as ``\subeq`` ``\empty``, ``\un``, ``\i``, and ``\\``, respectively. We have made the type variable ``U`` implicit, because it can typically be inferred from context. The universal set is denoted ``univ``, and set complementation is denoted with a negation symbol.

The following pattern can be used to show that ``A`` is a subset of ``B``:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A ⊆ B :=
    assume x,
    assume h : x ∈ A,
    show x ∈ B, from sorry
    -- END

And the following pattern be used to show that ``A`` and ``B`` are equal:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A = B :=
    eq_of_subset_of_subset
      (assume x,
        assume h : x ∈ A,
        show x ∈ B, from sorry)
      (assume x,
        assume h : x ∈ B,
        show x ∈ A, from sorry)
    -- END

Alternatively, we can use the following pattern:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A = B :=
    ext (assume x, iff.intro
      (assume h : x ∈ A,
        show x ∈ B, from sorry)
      (assume h : x ∈ B,
        show x ∈ A, from sorry))
    -- END

Here, ``ext`` is short for "extensionality." In symbolic terms, it is the following fact:

.. math::

    \forall x \; (x \in A \leftrightarrow x \in B) \to A = B.  

This reduces proving :math:`A = B` to proving :math:`\forall x \; (x \in A \leftrightarrow x \in B)`, which we can do using :math:`\forall` and :math:`\leftrightarrow` introduction.

Moreover, Lean supports the following nifty feature: the defining rules for union, intersection and other operations on sets are considered to hold "definitionally." This means that the expressions ``x ∈ A ∩ B`` and ``x ∈ A ∧ x ∈ B`` mean the same thing to Lean. This is the same for the other constructions on sets; for example ``x ∈ A \ B`` and ``x ∈ A ∧ ¬ (x ∈ B)`` mean the same thing to Lean. You can also write ``x ∉ B`` for ``¬ (x ∈ B)``, where ``∉`` is written using ``\notin``. For the other set constructions, the defining equivalences in the last chapter hold definitionally. The following example illustrates these features.

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : ∀ x, x ∈ A → x ∈ B → x ∈ A ∩ B :=
    assume x,
    assume : x ∈ A,
    assume : x ∈ B,
    show x ∈ A ∩ B, from and.intro ‹x ∈ A› ‹x ∈ B›

    example : A ⊆ A ∪ B :=
    assume x,
    assume : x ∈ A,
    show x ∈ A ∪ B, from or.inl this

    example : ∅ ⊆ A  :=
    assume x,
    assume : x ∈ ∅,
    show x ∈ A, from false.elim ‹x ∈ (∅ : set U)›
    -- END

Remember from :numref:`definitions_and_theorems` that we can use ``assume`` without a label, and refer back to hypotheses using French quotes. We have used this feature in the previous example. Without that feature, we could have written the examples above as follows:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : ∀ x, x ∈ A → x ∈ B → x ∈ A ∩ B :=
    assume x,
    assume h1 : x ∈ A,
    assume h2 : x ∈ B,
    show x ∈ A ∩ B, from and.intro h1 h2

    example : A ⊆ A ∪ B :=
    assume x,
    assume h : x ∈ A,
    show x ∈ A ∪ B, from or.inl h

    example : ∅ ⊆ A  :=
    assume x,
    assume : x ∈ ∅,
    show x ∈ A, from false.elim ‹x ∈ (∅ : set U)›
    -- END

Below, and in the chapters that follow, we will begin to use ``assume`` and ``have`` command without labels.

Notice also that in the last example, we had to annotate the empty set by writing ``(∅ : set U)`` to tell Lean which empty set we mean. Lean can often infer information like this from the context (for example, from the fact that we are trying to show ``x ∈ A``, where ``A`` has type ``set U``), but in this case, it needs a bit more help.

Alternatively, we can use versions theorems in the Lean library that are designed specifically for use with sets:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : ∀ x, x ∈ A → x ∈ B → x ∈ A ∩ B :=
    assume x,
    assume : x ∈ A,
    assume : x ∈ B,
    show x ∈ A ∩ B, from mem_inter ‹x ∈ A› ‹x ∈ B›

    example : A ⊆ A ∪ B :=
    assume x,
    assume h : x ∈ A,
    show x ∈ A ∪ B, from mem_union_left B h

    example : ∅ ⊆ A  :=
    assume x,
    assume : x ∈ ∅,
    show x ∈ A, from absurd this (not_mem_empty x)
    -- END

Remember that ``absurd`` can be used to prove any fact from two contradictory hypotheses ``h1 : P`` and ``h2 : ¬ P``. Here the ``not_mem_empty x`` is the fact ``x ∉ ∅``. You can see the statements of the theorems using the ``#check`` command in Lean:

.. code-block:: lean

    import data.set
    open set

    -- BEGIN
    #check @mem_inter
    #check @mem_of_mem_inter_left
    #check @mem_of_mem_inter_right
    #check @mem_union_left
    #check @mem_union_right
    #check @mem_or_mem_of_mem_union
    #check @not_mem_empty
    -- END

Here, the ``@`` symbol in Lean prevents it from trying to fill in implicit arguments automatically, and instead display the full statement of the theorem.

The fact that Lean can identify sets with their logical definitions makes it easy to prove inclusions between sets:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A \ B ⊆ A :=
    assume x,
    assume : x ∈ A \ B,
    show x ∈ A, from and.left this

    example : A \ B ⊆ -B :=
    assume x,
    assume : x ∈ A \ B,
    have x ∉ B, from and.right this,
    show x ∈ -B, from this
    -- END

Once again, we can use versions of the theorems designed specifically for sets:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A \ B ⊆ A :=
    assume x,
    assume : x ∈ A \ B,
    show x ∈ A, from mem_of_mem_diff this

    example : A \ B ⊆ -B :=
    assume x,
    assume : x ∈ A \ B,
    have x ∉ B, from not_mem_of_mem_diff this,
    show x ∈ -B, from this
    -- END

Some Identities
---------------

here is the proof of the first identity that we proved informally in the previous chapter:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    example : A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C) :=
    eq_of_subset_of_subset
      (assume x,
        assume h : x ∈ A ∩ (B ∪ C),
        have x ∈ A, from and.left h,
        have x ∈ B ∪ C, from and.right h,
        or.elim (‹x ∈ B ∪ C›)
          (assume : x ∈ B,
            have x ∈ A ∩ B, from and.intro ‹x ∈ A› ‹x ∈ B›,
            show x ∈ (A ∩ B) ∪ (A ∩ C), from or.inl this)
          (assume : x ∈ C,
            have x ∈ A ∩ C, from and.intro ‹x ∈ A› ‹x ∈ C›,
            show x ∈ (A ∩ B) ∪ (A ∩ C), from or.inr this))
      (assume x,
        assume : x ∈ (A ∩ B) ∪ (A ∩ C),
        or.elim this
          (assume h : x ∈ A ∩ B,
            have x ∈ A, from and.left h,
            have x ∈ B, from and.right h,
            have x ∈ B ∪ C, from or.inl this,
            show x ∈ A ∩ (B ∪ C), from and.intro ‹x ∈ A› this)
          (assume h : x ∈ A ∩ C,
            have x ∈ A, from and.left h,
            have x ∈ C, from and.right h,
            have x ∈ B ∪ C, from or.inr this,
            show x ∈ A ∩ (B ∪ C), from and.intro ‹x ∈ A› this))
    -- END

Notice that it is considerably longer than the informal proof in the last chapter, because we have spelled out every last detail. Unfortunately, this does not necessarily make it more readable. Keep in mind that you can always write long proofs incrementally, using ``sorry``. You can also break up long proofs into smaller pieces:

.. code-block:: lean

    import data.set
    open set

    variable {U : Type}
    variables A B C : set U

    -- BEGIN
    theorem inter_union_subset : A ∩ (B ∪ C) ⊆ (A ∩ B) ∪ (A ∩ C) :=
    assume x,
    assume h : x ∈ A ∩ (B ∪ C),
    have x ∈ A, from and.left h,
    have x ∈ B ∪ C, from and.right h,
    or.elim (‹x ∈ B ∪ C›)
      (assume : x ∈ B,
        have x ∈ A ∩ B, from and.intro ‹x ∈ A› ‹x ∈ B›,
        show x ∈ (A ∩ B) ∪ (A ∩ C), from or.inl this)
      (assume : x ∈ C,
        have x ∈ A ∩ C, from and.intro ‹x ∈ A› ‹x ∈ C›,
        show x ∈ (A ∩ B) ∪ (A ∩ C), from or.inr this)

    theorem inter_union_inter_subset : (A ∩ B) ∪ (A ∩ C) ⊆ A ∩ (B ∪ C) :=
    assume x,
    assume : x ∈ (A ∩ B) ∪ (A ∩ C),
    or.elim this
      (assume h : x ∈ A ∩ B,
        have x ∈ A, from and.left h,
        have x ∈ B, from and.right h,
        have x ∈ B ∪ C, from or.inl this,
        show x ∈ A ∩ (B ∪ C), from and.intro ‹x ∈ A› this)
      (assume h : x ∈ A ∩ C,
        have x ∈ A, from and.left h,
        have x ∈ C, from and.right h,
        have x ∈ B ∪ C, from or.inr this,
        show x ∈ A ∩ (B ∪ C), from and.intro ‹x ∈ A› this)

    example : A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C) :=
    eq_of_subset_of_subset
      (inter_union_subset A B C)
      (inter_union_inter_subset A B C)
    -- END

Notice that the two theorems depend on the variables ``A``, ``B``, and ``C``, which have to be supplied as arguments when they are applied. They also depend on the underlying type, ``U``, but because the variable ``U`` was marked implicit, Lean figures it out from the context.

In the last chapter we showed :math:`(A \cap \overline B) \cup B = B`. Here is the corresponding proof in Lean:

.. code-block:: lean

    import data.set
    open set

    variable  U : Type
    variables A B C : set U

    -- BEGIN
    example : (A ∩ -B) ∪ B = A ∪ B :=
    calc
      (A ∩ -B) ∪ B = (A ∪ B) ∩ (-B ∪ B) : by rewrite union_distrib_right
               ... = (A ∪ B) ∩ univ     : by rewrite compl_union_self
               ... = A ∪ B              : by rewrite inter_univ
    -- END

Translated to propositions, the theorem above states that for every pair of elements :math:`A` and :math:`B` in a Boolean algebra, :math:`(A \wedge \neg B) \vee B = B`. Lean allows us to do calculations on propositions as though they are elements of a Boolean algebra, with equality replaced by ``↔``.

.. TODO(Jeremy): put ``not_or_self`` into the library

.. code-block:: lean

    import logic.basic
    open classical

    theorem not_or_self (P : Prop) : (¬ P ∨ P) ↔ true :=
    iff.intro (λ h, trivial) (λ h, or.symm (em P))

    -- BEGIN
    variables A B : Prop

    example : (A ∧ ¬ B) ∨ B ↔ A ∨ B :=
    calc
        (A ∧ ¬ B) ∨ B ↔ (A ∨ B) ∧ (¬ B ∨ B) : by rw and_or_distrib_right
                    ... ↔ (A ∨ B) ∧ true      : by rw not_or_self
                    ... ↔ (A ∨ B)             : by rw and_true
    -- END

Power Sets and Indexed Families
-------------------------------

We can also work with power sets and indexed unions and intersections in Lean. If ``A : set U``, then ``powerset A`` is a subset of ``set U``, that is, we have ``powerset A : set (set X)``. For Lean, ``A ∈ powerset B`` means the same thing as ``A ⊆ B``, which, in turn, means ``∀x, x ∈ A → x ∈ B``.

.. code-block:: lean

    import data.set
    open set

    variable  {U : Type}
    variables (A B : set U)

    -- BEGIN
    #check powerset A

    example : A ∈ powerset (A ∪ B) :=
    assume x,
    assume : x ∈ A,
    show x ∈ A ∪ B, from or.inl ‹x ∈ A›
    -- END

A family of sets in Lean is written as ``A : I → set U`` where ``I`` is a ``Type``. Then the intersection and union of the family of sets ``A`` is written ``⋂i, A i`` ``⋃i, A i``. These characters can be typed with ``\I`` and ``\Un``. For Lean, ``x ∈ ⋂i, A i`` means ``∀i : I, x ∈ A i`` and ``x ∈ ⋃i, A i`` means ``∃i : I, x ∈ A i``. To refresh your memory at to how to work with the universal and existential quantifier in Lean, see :numref:`Chapters %s <first_order_logic_in_lean>`.

.. TODO(Jeremy): add ``mem_of_mem_Inter`` and ``mem_Union`` to library.

.. code-block:: lean

    import data.set
    open set

    theorem {u v} mem_of_mem_Inter {ι : Type u} {α : Type v}
    {a : α} {s : ι → set α} (h : a ∈ ⋂ i, s i) (i : ι) :
    a ∈ s i :=
    h (s i) ⟨i, rfl⟩

    theorem {u v} mem_Union {ι : Type u} {α : Type v}
    {a : α} {s : ι → set α} {i : ι} (h : a ∈ s i) : a ∈ ⋃ i, s i :=
    ⟨s i, ⟨⟨i, rfl⟩, h⟩⟩

    -- BEGIN
    variables {I U : Type}
    variables (A : I → set U)

    example (i₀ : I) : (⋂ i, A i) ⊆ (⋃ i, A i) :=
    assume x,
    assume h : x ∈ ⋂ i, A i,
    have x ∈ A i₀, from mem_of_mem_Inter h i₀,
    show x ∈ ⋃ i, A i, from mem_Union ‹x ∈ A i₀›
    -- END

Exercises
---------

#. Fill in the ``sorry``'s.

   .. code-block:: lean

       import data.set
       open set

       section
         variable  U : Type
         variable  A : U → Prop
         variable  B : U → U → Prop

         -- problem 1

         example (h : ∀ x y, A x → B x y) : ∀ x, (A x → ∀ y, B x y) :=
         sorry
       end

       section
         variable U : Type
         variables A B C : set U

         -- problem 2

         example : ∀ x, x ∈ A ∩ C → x ∈ A ∪ B :=
         sorry

         -- problem 3

         example : ∀ x, x ∈ -(A ∪ B) → x ∈ -A :=
         sorry
       end

#. Fill in the ``sorry``.

   .. code-block:: lean

       import logic.basic data.set
       open set

       variable {U : Type}

       /- defining "disjoint" -/

       definition disj (A B : set U) : Prop := ∀ ⦃x⦄, x ∈ A → x ∈ B → false

       example (A B : set U) (h : ∀ x, ¬ (x ∈ A ∧ x ∈ B)) : disj A B :=
       assume x,
       assume h1 : x ∈ A,
       assume h2 : x ∈ B,
       have h3 : x ∈ A ∧ x ∈ B, from and.intro h1 h2,
       show false, from h x h3

       -- notice that we do not have to mention x when applying h : disj A B
       example (A B : set U) (h1 : disj A B) (x : U) (h2 : x ∈ A) (h3 : x ∈ B) : false :=
       h1 h2 h3

       -- the same is true of ⊆
       example (A B : set U) (x : U) (h : A ⊆ B) (h1 : x ∈ A) : x ∈ B :=
       h h1

       /- problem 1 -/

       -- replace the "sorry" by a proof
       example (A B C D : set U) (h1 : disj A B) (h2 : C ⊆ A) (h3 : D ⊆ B) : disj C D :=
       sorry

#. Prove the following facts about indexed unions and intersections.

   .. code-block:: lean

       import data.set
       open set

       variables {I J U : Type}
       variables (A : I → J → set U)

       example : (⋃i, ⋂j, A i j) ⊆ (⋂j, ⋃i, A i j) :=
       sorry

   .. code-block:: lean

       import data.set
       open classical set

       variables {I U : Type}
       variables (A : I → set U) (B : set U)

       example : B ∩ (⋃i, A i) = ⋃i, B ∩ A i :=
       sorry

       -- Hint: the reverse inclusion of the following example requires classical reasoning
       example : B ∪ (⋂i, A i) = ⋂i, B ∪ A i :=
       sorry

#. Prove the following fact about power sets. You can use the theorems ``subset.trans`` and ``subset.refl``

   .. code-block:: lean

       import data.set
       open set

       variables {U : Type}
       variables (A B C : set U)

       -- For the exercise these two facts are useful
       example (h1 : A ⊆ B) (h2 : B ⊆ C) : A ⊆ C :=
       subset.trans h1 h2

       example : A ⊆ A :=
       subset.refl A

       example : A ⊆ B ↔ powerset A ⊆ powerset B :=
       sorry
