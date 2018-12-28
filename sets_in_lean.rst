Sets in Lean
============

In the last chapter, we noted that although in axiomatic set theory one considers sets of disparate objects, it is more common in mathematics to consider subsets of some fixed domain, :math:`\mathcal U`. This is the way sets are handled in Lean. For any data type ``U``, Lean gives us a new data type, ``set U``, consisting of the sets of elements of ``U``. Thus, for example, we can reason about sets of natural numbers, or sets of integers, or sets of pairs of natural numbers.

.. _sets_in_lean_basics:

Basics
------

Given ``A : set U`` and ``x : U``, we can write ``x ∈ A`` to state that ``x`` is a member of the set ``A``. The character ``∈`` can be typed using ``\in``.

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

You can type the symbols ``⊆``, ``∅``, ``∪``, ``∩``, ``\`` as ``\subeq`` ``\empty``, ``\un``, ``\i``, and ``\``, respectively. We have made the type variable ``U`` implicit, because it can typically be inferred from context. The universal set is denoted ``univ``, and set complementation is denoted with a negation symbol. Basic set-theoretic notions like these are defined in Lean's core library, but additional theorems and notation are available in an auxiliary library that we have loaded with the command ``import data.set``, which has to appear at the beginning of a file. The command ``open set`` lets us refer to a theorem named ``set.mem_union`` as ``mem_union``.

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

And the following pattern can be used to show that ``A`` and ``B`` are equal:

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

Remember from :numref:`definitions_and_theorems` that we can use ``assume`` without a label, and refer back to hypotheses using French quotes, entered with ``\f<`` and ``\f>``. We have used this feature in the previous example. Without that feature, we could have written the examples above as follows:

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
    assume h : x ∈ (∅ : set U),
    show x ∈ A, from false.elim h
    -- END

Below, and in the chapters that follow, we will begin to use ``assume`` and ``have`` command without labels, but you should feel free to adopt whatever style you prefer.

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

Here, the ``@`` symbol in Lean prevents it from trying to fill in implicit arguments automatically, forcing it to display the full statement of the theorem.

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

The fact that Lean has to unfold definitions means that it can be confused at times. For example, in the proof below, if you replace the last line by ``sorry``, Lean has trouble figuring out that you want it to unfold the subset symbol:

.. code-block:: lean

    variable  {U : Type}
    variables A B : set U

    example : A ∩ B ⊆ B ∩ A :=
    assume x,
    assume h : x ∈ A ∩ B,
    have h1 : x ∈ A, from and.left h,
    have h2 : x ∈ B, from and.right h,
    and.intro h2 h1

One workaround is to use the ``show`` command; in general, providing Lean with such additional information is often helpful. Another is to workaround is to give the theorem a name, which prompts Lean to use a slightly different method of processing the proof, fixing the problem as a lucky side effect.

.. code-block:: lean

    variable  {U : Type}
    variables A B : set U

    -- BEGIN
    example : A ∩ B ⊆ B ∩ A :=
    assume x,
    assume h : x ∈ A ∩ B,
    have h1 : x ∈ A, from and.left h,
    have h2 : x ∈ B, from and.right h,
    show x ∈ B ∩ A, from sorry

    theorem my_example : A ∩ B ⊆ B ∩ A :=
    assume x,
    assume h : x ∈ A ∩ B,
    have h1 : x ∈ A, from and.left h,
    have h2 : x ∈ B, from and.right h,
    sorry
    -- END

Some Identities
---------------

Here is the proof of the first identity that we proved informally in the previous chapter:

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

    theorem inter_union_inter_subset : 
      (A ∩ B) ∪ (A ∩ C) ⊆ A ∩ (B ∪ C) :=
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

In the last chapter, we showed :math:`(A \cap \overline B) \cup B = B`. Here is the corresponding proof in Lean:

.. code-block:: lean

    import data.set
    open set

    variable  U : Type
    variables A B C : set U

    -- BEGIN
    example : (A ∩ -B) ∪ B = A ∪ B :=
    calc
      (A ∩ -B) ∪ B = (A ∪ B) ∩ (-B ∪ B) : by rw union_distrib_right
               ... = (A ∪ B) ∩ univ     : by rw compl_union_self
               ... = A ∪ B              : by rw inter_univ
    -- END

Translated to propositions, the theorem above states that for every pair of elements :math:`A` and :math:`B` in a Boolean algebra, :math:`(A \wedge \neg B) \vee B = B`. Lean allows us to do calculations on propositions as though they are elements of a Boolean algebra, with equality replaced by ``↔``.

.. TODO(Jeremy): put ``not_or_self`` into the library
.. TODO(Jeremy): give lists of the calculation lemmas for sets and propositions (and make sure the library has a good list)

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

Indexed Families
----------------

Remember that if :math:`(A_i)_{i \in I}` is a family of sets indexed by :math:`I`, then :math:`\bigcap_{i \in I} A_i` denotes the intersection of all the sets :math:`A_i`, and :math:`\bigcup_{i \in I} A_i` denotes their union. In Lean, we can specify that ``A`` is a family of sets by writing ``A : I → set U`` where ``I`` is a ``Type``. In other words, a family of sets is really a function which for each element ``i`` of type ``I`` returns a set ``A i``. We can then define the union and intersection as follows:

.. code-block:: lean

    variables {I U : Type}
    
    def Union (A : I → set U) : set U := { x | ∃ i : I, x ∈ A i }
    def Inter (A : I → set U) : set U := { x | ∀ i : I, x ∈ A i }

    section
    variables (x : U) (A : I → set U)

    example (h : x ∈ Union A) : ∃ i, x ∈ A i := h
    example (h : x ∈ Inter A) : ∀ i, x ∈ A i := h
    end

The examples show that Lean can unfold the definitions so that ``x ∈ Inter A`` can be treated as ``∀ i, x ∈ A i`` and ``x ∈ Union A`` can be treated as ``∃ i, x ∈ A i``. To refresh your memory as to how to work with the universal and existential quantifiers in Lean, see :numref:`Chapters %s <first_order_logic_in_lean>`. We can then define notation for the indexed union and intersection:

.. code-block:: lean

    variables {I U : Type}
    
    def Union (A : I → set U) : set U := { x | ∃ i : I, x ∈ A i }
    def Inter (A : I → set U) : set U := { x | ∀ i : I, x ∈ A i }

    -- BEGIN
    notation `⋃` binders `, ` r:(scoped f, Union f) := r
    notation `⋂` binders `, ` r:(scoped f, Inter f) := r

    variables (A : I → set U) (x : U)

    example (h : x ∈ ⋃ i, A i) : ∃ i, x ∈ A i := h
    example (h : x ∈ ⋂ i, A i) : ∀ i, x ∈ A i := h
    -- END

You can type ``⋂`` and ``⋃`` with ``\I`` and ``\Un``, respectively. As with quantifiers, the notation ``⋃ i, A i`` and ``⋂ i, A i`` bind the variable ``i`` in the expression, and the scope extends as widely as possible. For example, if you write ``⋂ i, A i ∪ B``, Lean assumes that the ith element of the sequence is ``A i ∪ B``. If you want to restrict the scope more narrowly, use parentheses.

The good news is that Lean's library does define indexed union and intersection, with this notation, and the definitions are made available with ``import data.set``. The bad news is that it uses a different definition, so that ``x ∈ Inter A`` and ``x ∈ Union A`` are *not* definitionally equal to ``∀ i, x ∈ A i`` and ``∃ i, x ∈ A i``, as above. The good news is that Lean at least knows that they are equivalent:

.. code-block:: lean

    import data.set
    open set

    variables {I U : Type}
    variables {A B : I → set U}

    theorem exists_of_mem_Union {x : U} (h : x ∈ ⋃ i, A i) : 
      ∃ i, x ∈ A i := 
    by simp * at *

    theorem mem_Union_of_exists {x : U} (h : ∃ i, x ∈ A i) : 
      x ∈ ⋃ i, A i :=
    by simp * at *

    theorem forall_of_mem_Inter {x : U} (h : x ∈ ⋂ i, A i) : 
      ∀ i, x ∈ A i :=
    by simp * at *

    theorem mem_Inter_of_forall {x : U} (h : ∀ i, x ∈ A i) : 
      x ∈ ⋂ i, A i :=
    by simp * at *

The command ``simp * at *`` calls upon Lean's automation to carry out the proofs. Here is an example of how these can be used:

.. code-block:: lean

    import data.set
    open set

    section
    variables {I U : Type}
    variables {A B : I → set U}

    theorem exists_of_mem_Union {x : U} (h : x ∈ ⋃ i, A i) : ∃ i, x ∈ A i := 
    by simp * at *

    theorem mem_Union_of_exists {x : U} (h : ∃ i, x ∈ A i) : x ∈ ⋃ i, A i :=
    by simp * at *

    theorem forall_of_mem_Inter {x : U} (h : x ∈ ⋂ i, A i) : ∀ i, x ∈ A i :=
    by simp * at *

    theorem mem_Inter_of_forall {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp * at *

    -- BEGIN
    example : (⋂ i, A i ∩ B i) = (⋂ i, A i) ∩ (⋂ i, B i) :=
    ext $ 
    assume x : U,
    iff.intro 
    (assume h : x ∈ ⋂ i, A i ∩ B i,
        have h1 : ∀ i, x ∈ A i ∩ B i, from forall_of_mem_Inter h,
        have h2 : ∀ i, x ∈ A i, from assume i, and.left (h1 i),
        have h3 : ∀ i, x ∈ B i, from assume i, and.right (h1 i),
        have h4 : x ∈ ⋂ i, A i, from mem_Inter_of_forall h2,
        have h5 : x ∈ ⋂ i, B i, from mem_Inter_of_forall h3,
        and.intro h4 h5)
    (assume h : x ∈ (⋂ i, A i) ∩ (⋂ i, B i),
        have h1 : ∀ i, x ∈ A i, 
          from forall_of_mem_Inter (and.left h),
        have h2 : ∀ i, x ∈ B i, 
          from forall_of_mem_Inter (and.right h),
        have h3 : ∀ i, x ∈ A i ∩ B i, 
          from assume i, and.intro (h1 i) (h2 i),
        show x ∈ ⋂ i, A i ∩ B i, from mem_Inter_of_forall h3)
    -- END
        
    end

.. TODO(Jeremy): we can add this later
    example : (⋂ i, A i ∩ B i) = (⋂ i, A i) ∩ (⋂ i, B i) :=
    by finish [set_eq_def]

.. TODO(Jeremy): add all these to the library

Even better, we can prove introduction and elimination rules for intersection and union:

.. code-block:: lean

    import data.set
    open set

    variables {I U : Type}
    variables {A : I → set U}

    theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp; assumption

    @[elab_simple]
    theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
    by simp at h; apply h
    
    theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : 
      x ∈ ⋃ i, A i :=
    by {simp, existsi i, exact h}

    theorem Union.elim {b : Prop} {x : U}
    (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → b) : b :=
    by {simp at h₁, cases h₁ with i h, exact h₂ i h}

Don't worry about what the proofs mean. What is important is how they can be used, which is what the following patterns illustrate:

.. code-block:: lean

    import data.set
    open set

    section
    variables {I U : Type}
    variables {A : I → set U}

    theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp; assumption

    @[elab_simple]
    theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
    by simp at h; apply h 
    
    theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
    by {simp, existsi i, exact h}

    theorem Union.elim {P : Prop} {x : U}
    (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → P) : P :=
    by {simp at h₁, cases h₁ with i h, exact h₂ i h}

    -- BEGIN
    example (x : U) : x ∈ ⋂ i, A i :=
    Inter.intro $
    assume i,
    show x ∈ A i, from sorry

    example (x : U) (i : I) (h : x ∈ ⋂ i, A i) : x ∈ A i :=
    Inter.elim h i

    example (x : U) (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
    Union.intro i h

    example (C : Prop) (x : U) (h : x ∈ ⋃ i, A i) : C :=
    Union.elim h $
    assume i,
    assume h : x ∈ A i,
    show C, from sorry
    -- END

    end

Remember that the dollar sign saves us the trouble of having to put parentheses around the rest of the proof. Notice that with ``Inter.intro`` and ``Inter.elim``, proofs using indexed intersections looks just like proofs using the universal quantifier. Similarly, ``Union.intro`` and ``Union.elim`` mirror the introduction and elimination rules for the existential quantifier. The following example provides one direction of an equivalence proved above:

.. code-block:: lean

    import data.set
    open set

    section
    variables {I U : Type}
    variables {A : I → set U}

    theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp; assumption

    @[elab_simple]
    theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
    by simp at h; apply h 
    
    theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
    by {simp, existsi i, exact h}

    theorem Union.elim {P : Prop} {x : U}
    (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → P) : P :=
    by {simp at h₁, cases h₁ with i h, exact h₂ i h}
    end

    section
    -- BEGIN
    variables {I U : Type}
    variables (A : I → set U) (B : I → set U) (C : set U)

    example : (⋂ i, A i ∩ B i) ⊆ (⋂ i, A i) ∩ (⋂ i, B i) :=
    assume x : U, 
    assume h : x ∈ ⋂ i, A i ∩ B i,
    have h1 : x ∈ ⋂ i, A i, from
        Inter.intro $
        assume i : I,
        have h2 : x ∈ A i ∩ B i, from Inter.elim h i,
        show x ∈ A i, from and.left h2,
    have h2 : x ∈ ⋂ i, B i, from
        Inter.intro $
        assume i : I,
        have h2 : x ∈ A i ∩ B i, from Inter.elim h i,
        show x ∈ B i, from and.right h2,
    show x ∈ (⋂ i, A i) ∩ (⋂ i, B i), from and.intro h1 h2
    -- END
    end

You are asked to prove the other direction in the exercises below. Here is an example that shows how to use the introduction and elimination rules for indexed union:

.. code-block:: lean

    import data.set
    open set

    section
    variables {I U : Type}
    variables {A : I → set U}

    theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp; assumption

    @[elab_simple]
    theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
    by simp at h; apply h 
    
    theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
    by {simp, existsi i, exact h}

    theorem Union.elim {P : Prop} {x : U}
    (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → P) : P :=
    by {simp at h₁, cases h₁ with i h, exact h₂ i h}
    end

    section
    -- BEGIN
    variables {I U : Type}
    variables (A : I → set U) (B : I → set U) (C : set U)

    example : (⋃ i, C ∩ A i) ⊆ C ∩ (⋃i, A i) :=
    assume x,
    assume h : x ∈ ⋃ i, C ∩ A i,
    Union.elim h $
    assume i, 
    assume h1 : x ∈ C ∩ A i,
    have h2 : x ∈ C, from and.left h1,
    have h3 : x ∈ A i, from and.right h1,
    have h4 : x ∈ ⋃ i, A i, from Union.intro i h3,
    show x ∈ C ∩ ⋃ i, A i, from and.intro h2 h4
    -- END
    end

Once again, we ask you to prove the other direction in the exercises below.

Sometimes we want to work with families :math:`(A_{i, j})_{i \in I, j \in J}` indexed by two variables. This is also easy to manage in Lean: if we declare ``A : I → J → set U``, then given ``i : I`` and ``j : J``, we have that ``A i j : set U``. (You should interpret the expression ``I → J → set U`` as ``I → (J → set U)``, so that ``A i`` has type ``J → set U``, and then ``A i j`` has type ``set U``.) Here is an example of a proof involving a such a doubly-indexed family: 

.. code-block:: lean

    import data.set
    open set

    section
    variables {I U : Type}
    variables {A : I → set U}

    theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
    by simp; assumption

    @[elab_simple]
    theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
    by simp at h; apply h 

    theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
    by {simp, existsi i, exact h}

    theorem Union.elim {P : Prop} {x : U}
    (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → P) : P :=
    by {simp at h₁, cases h₁ with i h, exact h₂ i h}

    end

    -- BEGIN
    section
    variables {I J U : Type}
    variables (A : I → J → set U)

    example : (⋃i, ⋂j, A i j) ⊆ (⋂j, ⋃i, A i j) :=
    assume x,
    assume h : x ∈ ⋃i, ⋂j, A i j,
    Union.elim h $
    assume i,
    assume h1 : x ∈ ⋂ j, A i j,
    show x ∈ ⋂j, ⋃i, A i j, from 
        Inter.intro $
        assume j,
        have h2 : x ∈ A i j, from Inter.elim h1 j,
        Union.intro i h2
    end
    -- END


Power Sets
----------

We can also define the power set in Lean:

.. code-block:: lean

    variable {U : Type}

    def powerset (A : set U) : set (set U) := {B : set U | B ⊆ A}

    example (A B : set U) (h : B ∈ powerset A) : B ⊆ A :=
    h

As the example shows, ``B ∈ powerset A`` is then definitionally the same as ``B ⊆ A``.

In fact, ``powerset`` is defined in Lean in exactly this way, and is available to you when you ``import data.set`` and ``open set``. Here is an example of how it is used:

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

In essence, the example proves ``A ⊆ A ∪ B``. In the exercises below, we ask you to prove, formally, that for every ``A B : set U``, we have ``powerset A ⊆ powerset B``

Exercises
---------

#. Fill in the ``sorry``'s.

   .. code-block:: lean

       section
         variable U : Type
         variables A B C : set U

         example : ∀ x, x ∈ A ∩ C → x ∈ A ∪ B :=
         sorry

         example : ∀ x, x ∈ -(A ∪ B) → x ∈ -A :=
         sorry
       end

#. Fill in the ``sorry``.

   .. code-block:: lean

    import data.set
    open set

    section
    variable {U : Type}

    /- defining "disjoint" -/

    def disj (A B : set U) : Prop := ∀ ⦃x⦄, x ∈ A → x ∈ B → false

    example (A B : set U) (h : ∀ x, ¬ (x ∈ A ∧ x ∈ B)) : 
      disj A B :=
    assume x,
    assume h1 : x ∈ A,
    assume h2 : x ∈ B,
    have h3 : x ∈ A ∧ x ∈ B, from and.intro h1 h2,
    show false, from h x h3

    -- notice that we do not have to mention x when applying 
    --   h : disj A B
    example (A B : set U) (h1 : disj A B) (x : U) 
        (h2 : x ∈ A) (h3 : x ∈ B) :
      false :=
    h1 h2 h3

    -- the same is true of ⊆
    example (A B : set U) (x : U) (h : A ⊆ B) (h1 : x ∈ A) : 
      x ∈ B :=
    h h1

    example (A B C D : set U) (h1 : disj A B) (h2 : C ⊆ A) 
        (h3 : D ⊆ B) :
      disj C D :=
    sorry
    end

#. Prove the following facts about indexed unions and intersections, using the theorems ``Inter.intro``, ``Inter.elim``, ``Union.intro``, and ``Union.elim`` listed above.

   .. code-block:: lean

        import data.set
        open set

        section
        variables {I U : Type}
        variables {A B : I → set U}

        theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
        by simp; assumption

        @[elab_simple]
        theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
        by simp at h; apply h

        theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
        by {simp, existsi i, exact h}

        theorem Union.elim {b : Prop} {x : U}
        (h₁ : x ∈ ⋃ i, A i) (h₂ : ∀ (i : I), x ∈ A i → b) : b :=
        by {simp at h₁, cases h₁ with i h, exact h₂ i h}

        end

        -- BEGIN
        variables {I U : Type}
        variables (A : I → set U) (B : I → set U) (C : set U)

        example : (⋂ i, A i) ∩ (⋂ i, B i) ⊆ (⋂ i, A i ∩ B i) :=
        sorry

        example : C ∩ (⋃i, A i) ⊆ ⋃i, C ∩ A i :=
        sorry
        -- END

#. Prove the following fact about power sets. You can use the theorems ``subset.trans`` and ``subset.refl``

    .. code-block:: lean

        import data.set
        open set

        -- BEGIN
        variable  {U : Type}
        variables A B C : set U

        -- For this exercise these two facts are useful
        example (h1 : A ⊆ B) (h2 : B ⊆ C) : A ⊆ C :=
        subset.trans h1 h2

        example : A ⊆ A :=
        subset.refl A

        example (h : A ⊆ B) : powerset A ⊆ powerset B :=
        sorry

        example (h : powerset A ⊆ powerset B) : A ⊆ B :=
        sorry
        -- END
