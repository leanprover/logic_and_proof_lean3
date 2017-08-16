Functions in Lean
=================

Functions and Symbolic Logic
----------------------------

Let us now consider functions in formal terms. Even though we have
avoided the use of quantifiers and logical symbols in the definitions in
the last chapter, by now you should be seeing them lurking beneath the
surface. That fact that two functions :math:`f, g : X \to Y` are equal
if and only if they take the same values at every input can be expressed
as follows:

.. raw:: latex

   \begin{equation*}
   \fa {x \in X} (f(x) = g(x)) \liff f = g 
   \end{equation*}

This principle is a known as *function extensionality*, analogous to the
principle of extensionality for sets, discussed in `Section
12.1 <12_Sets_in_Lean.org::#Basics>`__. Recall that the notation
:math:`\fa {x \in X} P(x)` abbreviates :math:`\fa x
(x \in X \to P(x))`, and :math:`\ex {x \in X} P(x)` abbreviates
:math:`\ex x (x
\in X \wedge P(x))`, thereby relativizing the quantifiers to :math:`A`.

We can avoid set-theoretic notation if we assume we are working in a
logical formalism with basic types for :math:`X` and :math:`Y`, so that
we can specify that :math:`x` ranges over :math:`X`. In that case, we
will write instead

.. raw:: latex

   \begin{equation*}
   \fa {x : X} (f(x) = g(x)) \liff f = g 
   \end{equation*}

to indicate that the quantification is over :math:`X`. Henceforth, we
will assume that all our variables range over some type, though we will
sometimes omit the types in the quantifiers when they can be inferred
from context.

The function :math:`f` is injective if it satisfies

.. math::


   \fa {x_1, x_2 : X} (f(x_1) = f(x_2) \to x_1 = x_2),

 and :math:`f` is surjective if

.. math::


   \fa {y : Y} \ex {x : X} (f(x) = y).

 If :math:`f : X \to Y` and :math:`g: Y \to X`, :math:`g` is a left
inverse to :math:`f` if

.. math::


   \fa {x : X} g(f(x)) = a.

 Notice that this is a universal statement, and it is equivalent to the
statement that :math:`f` is a right inverse to :math:`g`.

Remember that in logic it is common to use lambda notation to define
functions. We can denote the identity function by :math:`\lam x x`, or
perhaps :math:`\lam {x : X} x` to emphasize that the domain of the
function is :math:`X`. If :math:`f : X \to Y` and :math:`g : Y \to Z`,
we can define the composition :math:`g \circ f` by
:math:`g \circ f = \lam {x : X} g(f(x))`.

Remember that if :math:`P(x)` is any predicate, then in first order
logic we can assert that there exists a unique :math:`x` satisfying
:math:`P(x)`, written :math:`\exunique x P(x)`, with the conjunction of
the following two statements:

-  :math:`\ex x P(x)`
-  :math:`\fa {x_1, x_2} (P(x_1) \wedge P(x_2) \to x_1 = y_1)`

Equivalently, we can write

.. math::


   \ex x (P(x) \wedge \fa {x'} (P(x') \to x' = x)).

 Assuming :math:`\exunique x P(x)`, the following two statements are
equivalent:

-  :math:`\ex x (P(x) \wedge Q(x))`
-  :math:`\fa x (P(x) \to Q(x))`

and both can be taken to assert that "the :math:`x` satisfying :math:`P`
also satisfies :math:`Q`."

A binary relation :math:`R` on :math:`X` and :math:`Y` is functional if
it satisfies

.. math::


   \fa x \exunique y R(x,y).

 In that case, a logician might use "iota notation,"

.. math::


   f(x) = \iota y \; R(x, y)

 to define :math:`f(x)` to be equal to the unique :math:`y` satisfying
:math:`R(x,y)`. If :math:`R` satisfies the weaker property

.. math::


   \fa x \ex y R(x,y),

 a logician might use "the Hilbert epsilon" to define a function

.. math::


   f(x) = \varepsilon y \; R(x, y)

 to "choose" a value of :math:`y` satisfying :math:`R(x, y)`. As we have
noted above, this is an implicit use of the axiom of choice.

Second- and Higher-Order Logic
------------------------------

In contrast to first-order logic, where we start with a fixed stock of
function and relation symbols, the topics we have been considering in
the last few chapters encourage us to consider a more expressive
language with variables ranging over functions and relations as well.
For example, saying that a function :math:`f : X \to Y` has a
left-inverse implicitly involves a quantifying over functions,

.. raw:: latex

   \begin{equation*}
   \ex g \fa x g(f(x)) = x.
   \end{equation*}

The theorem that asserts that if any function :math:`f` from :math:`X`
to :math:`Y` is injective then it has a left-inverse can be expressed as
follows:

.. raw:: latex

   \begin{equation*}
   \fa {x_1, x_2} (f(x_1) = f(x_2) \to x_1 = x_2) \to \ex g \fa x g(f(x))
   = x.
   \end{equation*}

Similarly, saying that two sets :math:`X` and :math:`Y` have a
one-to-one correspondence asserts the existence of a function
:math:`f : X \to Y` as well as an inverse to :math:`f`. For another
example, in `Section
15.4 <15_Functions.org::#Functions_and_Relations>`__ we asserted that
every functional relation gives rise to a corresponding function, and
vice-versa.

What makes these statements interesting is that they involve
quantification, both existential and universal, over functions and
relations. This takes us outside the realm of first-order logic. One
option is to develop a theory in the language of first-order logic in
which the universe contains functions, and relations as objects; we will
see later that this is what axiomatic set theory does. An alternative is
to extend first-order logic to involve new kinds of quantifiers and
variables, to range over functions and relations. This is what
higher-order logic does.

There are various ways to go about this. In view of the relationship
between functions and relations described above, one can take relations
as basic, and define functions in terms of them, or vice-versa. The
following formulation of higher-order logic, due to the logician Alonzo
Church, follows the latter approach. It is sometimes known as *simple
type theory*.

Start with some basic types, :math:`X, Y, Z, \ldots` and a special type,
:math:`\fn{Prop}`, of propositions. Add the following two rules to build
new types:

-  If :math:`U` and :math:`V` are types, so is :math:`U \times V`.
-  If :math:`U` and :math:`V` are types, so is :math:`U \to V`.

The first intended to denote the type of ordered pairs :math:`(u, v)`,
where :math:`u` is in :math:`U` and :math:`v` is in :math:`V`. The
second is intended to denote the type of functions from :math:`U` to
:math:`V`. Simple type theory now adds the following means of forming
expressions:

-  If :math:`u` is of type :math:`U` and :math:`v` is of type :math:`V`,
   :math:`(u, v)` is of type :math:`v`.
-  If :math:`p` is of type :math:`U \times V`, then :math:`(p)_1` is of
   type :math:`U` and :math:`(p)_2` if of type :math:`V`. (These are
   intended to denote the first and second element of the pair
   :math:`p`.)
-  If :math:`x` is a variable of type :math:`U`, and :math:`v` is any
   expression of type :math:`V`, then :math:`\lam x v` is of type
   :math:`U \to V`.
-  If :math:`f` is of type :math:`U \to V` and :math:`u` is of type
   :math:`U`, :math:`f(u)` is of type :math:`V`.

In addition, simple type theory provides all the means we have in
first-order logic --- boolean connectives, quantifiers, and equality --
to build propositions.

A function :math:`f(x, y)` which takes elements of :math:`X` and
:math:`Y` to a type :math:`Z` is viewed as an object of type
:math:`X \times Y \to Z`. Similarly, a binary relation :math:`R(x,y)` on
:math:`X` and :math:`Y` is viewed as an object of type :math:`X
\times Y \to \fn{Prop}`. What makes higher-order logic "higher order" is
that we can iterate the function type operation indefinitely. For
example, if :math:`\NN` is the type of natural numbers,
:math:`\NN \to \NN` denotes the type of functions from the natural
numbers to the natural numbers, and :math:`(\NN \to \NN) \to \NN`
denotes the type of functions :math:`F(f)` which take a function as
argument, and returns a natural number.

We have not specified the syntax and rules of higher-order logic very
carefully. This is done in a number of more advanced logic textbooks.
The fragment of higher-order logic which allows only functions and
relations on the basic types (without iterating these constructions) is
known as second-order logic.

These notions should seem familiar; we have been using these
constructions, with similar notation, in Lean. Indeed, Lean's logic is
an even more elaborate and expressive system of logic, which fully
subsumes all the notions of higher-order logic we have discussed here.

Functions in Lean
-----------------

The fact that the notions we have been discussing have such a
straightforward logical form means that it is easy to define them in
Lean. The main difference between the formal representation in Lean and
the informal representation above is that, in Lean, we distinguish
between a type ``X`` and a subset ``A : set X`` of that type.

In Lean's library, composition and identity are defined as follows:

.. code:: lean

    namespace hide
    -- BEGIN
    variables {X Y Z : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λx, f (g x)

    infixr  ` ∘ ` := comp

    definition id (x : X) : X :=
    x
    -- END
    end hide

Ordinarily, to use these definitions the notation, you use the command
``open function``. We omit this command here, because we are duplicating
the definitions, for expository purposes.

Ordinarily, we use ``funext`` (for "function extensionality") to prove
that two functions are equal.

.. code:: lean

    variables {X Y : Type}

    -- BEGIN
    example (f g : X → Y) (H : ∀ x, f x = g x) : f = g := 
    funext H
    -- END

But Lean can prove some basic identities by simply unfolding definitions
and simplifying expressions, using reflexivity.

.. code:: lean

    variables {X Y Z W : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λ x, f (g x)

    infixr  ` ∘ ` := comp

    -- BEGIN
    lemma left_id (f : X → Y) : id ∘ f = f := rfl

    lemma right_id (f : X → Y) : f ∘ id = f := rfl

    theorem comp.assoc (f : Z → W) (g : Y → Z) (h : X → Y) : 
      (f ∘ g) ∘ h = f ∘ (g ∘ h) := rfl

    theorem comp.left_id (f : X → Y) : id ∘ f = f := rfl

    theorem comp.right_id (f : X → Y) : f ∘ id = f := rfl
    -- END

We can define what it means for :math:`f` to be injective, surjective,
or bijective:

.. code:: lean

    variables {X Y Z : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λ x, f (g x)

    infixr  ` ∘ ` := comp

    -- BEGIN
    definition injective (f : X → Y) : Prop := ∀ ⦃x₁ x₂⦄, f x₁ = f x₂ → x₁ = x₂

    definition surjective (f : X → Y) : Prop := ∀ y, ∃ x, f x = y

    definition bijective (f : X → Y) := injective f ∧ surjective f
    -- END

Marking the variables ``x₁`` and ``x₂`` implicit in the definition of
``injective`` means that we do not have to write them as often.
Specifically, given ``H : injective f``, and ``H₁ x₁ : f x₁ = f
x₂``, we write ``H H₁`` rather than ``H x₁ x₂ H₁`` to show ``x₁ = x₂``.

We can then prove that the identity function is bijective:

.. code:: lean

    variables {X Y Z : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λ x, f (g x)

    infixr  ` ∘ ` := comp

    definition injective (f : X → Y) : Prop := ∀ ⦃x₁ x₂⦄, f x₁ = f x₂ → x₁ = x₂

    definition surjective (f : X → Y) : Prop := ∀ y, ∃ x, f x = y

    definition bijective (f : X → Y) := injective f ∧ surjective f

    -- BEGIN
    theorem injective_id : injective (@id X) := 
    take x₁ x₂, 
    assume H : id x₁ = id x₂, 
    show x₁ = x₂, from H

    theorem surjective_id : surjective (@id X) := 
    take y, 
    show ∃ x, id x = y, from exists.intro y rfl

    theorem bijective_id : bijective (@id X) := 
    and.intro injective_id surjective_id
    -- END

More interestingly, we can prove that the composition of injective
functions is injective, and so on.

.. code:: lean

    variables {X Y Z : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λ x, f (g x)

    infixr  ` ∘ ` := comp

    definition injective (f : X → Y) : Prop := ∀ ⦃x₁ x₂⦄, f x₁ = f x₂ → x₁ = x₂

    definition surjective (f : X → Y) : Prop := ∀ y, ∃ x, f x = y

    definition bijective (f : X → Y) := injective f ∧ surjective f

    -- BEGIN
    theorem injective_comp {g : Y → Z} {f : X → Y} 
        (Hg : injective g) (Hf : injective f) :
      injective (g ∘ f) :=
    take x₁ x₂, 
    suppose (g ∘ f) x₁ = (g ∘ f) x₂, 
    have f x₁ = f x₂, from Hg this,
    show x₁ = x₂, from Hf this

    theorem surjective_comp {g : Y → Z} {f : X → Y} 
        (Hg : surjective g) (Hf : surjective f) :
      surjective (g ∘ f) :=
    take z,
    obtain y (Hy : g y = z), from Hg z,
    obtain x (Hx : f x = y), from Hf y,
    have g (f x) = z, from eq.subst (eq.symm Hx) Hy,
    show ∃ x, g (f x) = z, from exists.intro x this

    theorem bijective_comp {g : Y → Z} {f : X → Y} 
        (Hg : bijective g) (Hf : bijective f) :
      bijective (g ∘ f) :=
    obtain Hginj Hgsurj, from Hg,
    obtain Hfinj Hfsurj, from Hf,
    and.intro (injective_comp Hginj Hfinj) (surjective_comp Hgsurj Hfsurj)
    -- END

The notions of left and right inverse are defined in the expected way.

.. code:: lean

    variables {X Y : Type}

    -- BEGIN
    -- g is a left inverse to f
    definition left_inverse (g : Y → X) (f : X → Y) : Prop := ∀ x, g (f x) = x

    -- g is a right inverse to f
    definition right_inverse (g : Y → X) (f : X → Y) : Prop := left_inverse f g
    -- END

In particular, composing with a left or right inverse yields the
identity.

.. code:: lean

    variables {X Y Z : Type}

    definition comp (f : Y → Z) (g : X → Y) : X → Z :=
    λ x, f (g x)

    infixr  ` ∘ ` := comp

    definition left_inverse (g : Y → X) (f : X → Y) : Prop := ∀ x, g (f x) = x

    definition right_inverse (g : Y → X) (f : X → Y) : Prop := left_inverse f g

    -- BEGIN
    definition id_of_left_inverse {g : Y → X} {f : X → Y} : left_inverse g f → g ∘ f = id :=
    assume H, funext H

    definition id_of_right_inverse {g : Y → X} {f : X → Y} : right_inverse g f → f ∘ g = id :=
    assume H, funext H
    -- END

Notice that we need to use ``funext`` to show the equality of functions.

The following shows that if a function has a left inverse, then it is
injective, and if it has a right inverse, then it is surjective.

.. code:: lean

    variables {X Y : Type}

    definition injective (f : X → Y) : Prop := ∀ ⦃x₁ x₂⦄, f x₁ = f x₂ → x₁ = x₂

    definition surjective (f : X → Y) : Prop := ∀ y, ∃ x, f x = y

    definition left_inverse (g : Y → X) (f : X → Y) : Prop := ∀x, g (f x) = x

    definition right_inverse (g : Y → X) (f : X → Y) : Prop := left_inverse f g

    -- BEGIN
    theorem injective_of_left_inverse {g : Y → X} {f : X → Y} : 
      left_inverse g f → injective f :=
    assume h, take x₁ x₂, assume feq,
    calc x₁ = g (f x₁) : by rewrite h
        ... = g (f x₂) : feq
        ... = x₂       : by rewrite h

    theorem surjective_of_right_inverse {g : Y  → X} {f : X → Y} : 
      right_inverse g f → surjective f :=
    assume h, take y,
    let  x : X := g y in
    have f x = y, from calc
      f x  = (f (g y))    : rfl
       ... = y            : h y,
    show ∃ x, f x = y, from exists.intro x this
    -- END

Defining the Inverse Classically
--------------------------------

All the theorems listed in the previous section are found in the Lean
library, and are available to you when you open the function namespace
with ``open function``:

.. code:: lean

    open function

    check comp
    check left_inverse
    check has_right_inverse

Defining inverse functions, however, requires classical reasoning, which
we get by opening the classical namespace:

.. code:: lean

    open classical

    section
      variables A B : Type
      variable P : A → Prop
      variable R : A → B → Prop

      example : (∀ x, ∃ y, R x y) → ∃ f, ∀ x, R x (f x) :=
      axiom_of_choice

      example (H : ∃ x, P x) : P (some H) :=
      some_spec H
    end

The axiom of choice tells us that if, for every ``x : X``, there is a
``y : Y`` satisfying ``R x y``, then there is a function ``f : X → Y``
which, for every ``x`` chooses such a ``y``. In Lean, this "axiom" is
proved using a classical construction, the ``some`` function (sometimes
called "the indefinite description operator") which, given that there is
some ``x`` satisfying ``P x``, returns such an ``x``. With these
constructions, the inverse function is defined as follows:

.. code:: lean

    open classical function

    variables {X Y : Type}

    noncomputable definition inverse (f : X → Y) (default : X) : Y → X :=
    λ y, if H : ∃ x, f x = y then some H else default

Lean requires us to acknowledge that the definition is not
computational, since, first, it may not be algorithmically possible to
decide whether or not condition ``H`` holds, and even if it does, it may
not be algorithmically possible to find a suitable value of ``x``.

Below, the proposition ``inverse_of_exists`` asserts that ``inverse``
meets its specification, and the subsequent theorem shows that if ``f``
is injective, then the ``inverse`` function really is a left inverse.

.. code:: lean

    open classical function

    variables {X Y : Type}

    noncomputable definition inverse (f : X → Y) (default : X) : Y → X :=
    λ y, if H : ∃ x, f x = y then some H else default

    -- BEGIN
    proposition inverse_of_exists (f : X → Y) (default : X) (y : Y) 
      (H : ∃ x, f x = y) :
    f (inverse f default y) = y :=
    have H1 : inverse f default y = some H, from dif_pos H,
    have H2 : f (some H) = y, from some_spec H,
    eq.subst (eq.symm H1) H2

    theorem is_left_inverse_of_injective (f : X → Y) (default : X) 
      (injf : injective f) :
    left_inverse (inverse f default) f :=
    let finv := (inverse f default) in
    take x,
    have H1 : ∃ x', f x' = f x, from exists.intro x rfl,
    have H2 : f (finv (f x)) = f x, from inverse_of_exists f default (f x) H1,
    show finv (f x) = x, from injf H2
    -- END

Functions and Sets in Lean
--------------------------

In `Section 7.4 <07_First_Order_Logic.org::#Relativization_and_Sorts>`__
we saw how to represent relativized universal and existential
quantifiers when formalizing phrases like "every prime number greater
than two is odd" and "some prime number is even." In a similar way, we
can relativize statements to sets. In symbolic logic, the expression
:math:`\ex {x \in A} P (x)` abbreviates :math:`\ex x (x \in A
\wedge P(x))`, and :math:`\fa {x \in A} P (x)` abbreviates
:math:`\fa x (x \in A
\to P(x))`.

Lean's library also defines notation for relativized quantifiers, though
for notational reasons, we need to use a subscripted 0:

.. code:: lean

    import data.set
    open set

    variables (X : Type) (A : set X) (P : X → Prop)

    example (H : ∀ x, x ∈ A → P x) : ∀₀ x ∈ A, P x := H
    example (H : ∃ x, x ∈ A ∧ P x) : ∃₀ x ∈ A, P x := H

In the definition of the bounded quantifiers above, the variable ``x``
is marked implicit. So, for example, we can apply the hypothesis ``H :
∀₀ x ∈ A, P x`` as follows:

.. code:: lean

    import data.set
    open set 

    variables (X : Type) (A : set X) (P : X → Prop)

    -- BEGIN
    example (H : ∀₀ x ∈ A, P x) (x : X) (H1 : x ∈ A) : P x := H H1
    -- END

The expression ``maps_to f A B`` asserts that ``f`` maps elements of the
set ``A`` to the set ``B``:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variables (A : set X) (B : set Y)
    variable (f : X → Y)

    example (H : ∀₀ x ∈ A, f x ∈ B) : maps_to f A B := H

The expression ``inj_on f A`` asserts that ``f`` is injective on ``A``:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variable (A : set X)
    variable (f : X → Y)

    -- BEGIN
    example (H : ∀ x₁ x₂, x₁ ∈ A → x₂ ∈ A → f x₁ = f x₂ → x₁ = x₂) : 
      inj_on f A := H
    -- END

The variables ``x₁`` and ``x₂`` are marked implicit in the definition of
``inj_on``, so that the hypothesis is applied as follows:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variable (A : set X)
    variable (f : X → Y)

    -- BEGIN
    example (Hinj : inj_on f A) (x₁ x₂ : X) (H1 : x₁ ∈ A) (H2 : x₂ ∈ A)
      (H : f x₁ = f x₂) : x₁ = x₂ :=
    Hinj H1 H2 H
    -- END

The expression ``surj_on f A B`` asserts that, viewed as a function
defined on elements of ``A``, the function ``f`` is surjective onto the
set ``B``:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variable (A : set X)
    variable (f : X → Y)

    -- BEGIN
    example (H : ∀ x₁ x₂, x₁ ∈ A → x₂ ∈ A → f x₁ = f x₂ → x₁ = x₂) : 
      inj_on f A := H
    -- END

It is synonymous with the assertion that ``B`` is a subset of the image
of ``A``, which is written ``f ' A``, or, equivalently, ``image f A``:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variables (A  : set X) (B : set Y)
    variable (f : X → Y)

    -- BEGIN
    example (H : B ⊆ f ' A) : surj_on f A B := H
    -- END

With these notions in hand, we can prove that the composition of
injective functions is injective. The proof is similar to the one above,
though now we have to be more careful to relativize claims to ``A`` and
``B``:

.. code:: lean

    import data.set
    open set function

    variables X Y Z : Type
    variables (A : set X) (B : set Y)
    variables (f : X → Y) (g : Y → Z)

    -- BEGIN
    theorem inj_on_comp (fAB : maps_to f A B) (Hg : inj_on g B) (Hf: inj_on f A) :
      inj_on (g ∘ f) A :=
    take x1 x2 : X,
    assume x1A : x1 ∈ A,
    assume x2A : x2 ∈ A,
    have  fx1B : f x1 ∈ B, from fAB x1A,
    have  fx2B : f x2 ∈ B, from fAB x2A,
    assume  H1 : g (f x1) = g (f x2),
    have    H2 : f x1 = f x2, from Hg fx1B fx2B H1,
    show x1 = x2, from Hf x1A x2A H2
    -- END

We can similarly prove that the composition of surjective functions is
surjective:

.. code:: lean

    import data.set
    open set function

    variables X Y Z : Type
    variables (A : set X) (B : set Y) (C : set Z)
    variables (f : X → Y) (g : Y → Z)

    -- BEGIN
    theorem surj_on_comp (Hg : surj_on g B C) (Hf: surj_on f A B) :
      surj_on (g ∘ f) A C :=
    take z,
    assume zc : z ∈ C,
    obtain y (H1 : y ∈ B ∧ g y = z), from Hg zc,
    obtain x (H2 : x ∈ A ∧ f x = y), from Hf (and.left H1),
    show ∃x, x ∈ A ∧ g (f x) = z, from
      exists.intro x
        (and.intro
          (and.left H2)
          (calc
            g (f x) = g y : {and.right H2}
                ... = z   : and.right H1))
    -- END

The following shows that the image of a union is the union of images:

.. code:: lean

    import data.set
    open set function

    variables X Y : Type
    variables (A₁ A₂ : set X)
    variable (f : X → Y)

    -- BEGIN
    theorem image_union : f ' (A₁ ∪ A₂) =f ' A₁ ∪ f ' A₂ :=
    ext (take y, iff.intro
      (assume H : y ∈ image f (A₁ ∪ A₂),
        obtain x [(xA₁A₂ : x ∈ A₁ ∪ A₂) (fxy : f x = y)], from H,
        or.elim xA₁A₂
          (assume xA₁, or.inl (mem_image xA₁ fxy))
          (assume xA₂, or.inr (mem_image xA₂ fxy)))
      (assume H : y ∈ image f A₁ ∪ image f A₂,
        or.elim H
          (assume yifA₁ : y ∈ image f A₁,
            obtain x [(xA₁ : x ∈ A₁) (fxy : f x = y)], from yifA₁,
            mem_image (or.inl xA₁) fxy)
          (assume yifA₂ : y ∈ image f A₂,
            obtain x [(xA₂ : x ∈ A₂) (fxy : f x = y)], from yifA₂,
            mem_image (or.inr xA₂) fxy)))
    -- END

Exercises
---------

#. Fill in the ``sorry``'s in the last three proofs below.

   .. code:: lean

       import data.int
       open function int algebra

       definition f (x : ℤ) : ℤ := x + 3
       definition g (x : ℤ) : ℤ := -x
       definition h (x : ℤ) : ℤ := 2 * x + 3

       example : injective f :=
       take x1 x2,
       assume H1 : x1 + 3 = x2 + 3,   -- Lean knows this is the same as f x1 = f x2
       show x1 = x2, from eq_of_add_eq_add_right H1

       example : surjective f :=
       take y,
       have H1 : f (y - 3) = y, from calc
         f (y - 3) = (y - 3) + 3 : rfl
               ... = y           : sub_add_cancel,
       show ∃ x, f x = y, from exists.intro (y - 3) H1

       example (x y : ℤ) (H : 2 * x = 2 * y) : x = y :=
       have H1 : 2 ≠ (0 : ℤ), from dec_trivial,  -- this tells Lean to figure it out itself
       show x = y, from eq_of_mul_eq_mul_left H1 H

       example (x : ℤ) : -(-x) = x := neg_neg x

       example (A B : Type) (u : A → B) (v : B → A) (H : left_inverse u v) :
         ∀ x, u (v x) = x :=
       H

       example (A B : Type) (u : A → B) (v : B → A) (H : left_inverse u v) :
         right_inverse v u :=
       H

       -- fill in the sorry's in the following proofs

       example : injective h :=
       sorry

       example : surjective g :=
       sorry

       example (A B : Type) (u : A → B) (v1 : B → A) (v2 : B → A)
         (H1 : left_inverse v1 u) (H2 : right_inverse v2 u) : v1 = v2 :=
       funext
         (take x,
           calc
             v1 x = v1 (u (v2 x)) : sorry
              ... = v2 x          : sorry)

#. Fill in the ``sorry`` in the proof below.

   .. code:: lean

       import data.set
       open function set

       variables X Y : Type
       variable  f : X → Y
       variables A B : set X

       example : f ' (A ∪ B) = f ' A ∪ f ' B :=
       eq_of_subset_of_subset
         (take y,
           assume H1 : y ∈ f ' (A ∪ B),
           obtain x [(H2 : x ∈ A ∪ B) (H3 : f x = y)], from H1,
           or.elim H2
             (assume H4 : x ∈ A,
               have H5 : y ∈ f ' A, from mem_image H4 H3,
               show y ∈ f ' A ∪ f 'B, from or.inl H5)
             (assume H4 : x ∈ B,
               have H5 : y ∈ f ' B, from mem_image H4 H3,
               show y ∈ f ' A ∪ f ' B, from or.inr H5))
         (take y,
           assume H2 : y ∈ f ' A ∪ f ' B,
           or.elim H2
             (assume H3 : y ∈ f ' A,
               obtain x [(H4 : x ∈ A) (H5 : f x = y)], from H3,
               have H6 : x ∈ A ∪ B, from or.inl H4,
               show y ∈ f ' (A ∪ B), from mem_image H6 H5)
             (assume H3 : y ∈ f ' B,
               obtain x [(H4 : x ∈ B) (H5 : f x = y)], from H3,
               have H6 : x ∈ A ∪ B, from or.inr H4,
               show y ∈ f ' (A ∪ B), from mem_image H6 H5))

       -- remember, x ∈ A ∩ B is the same as x ∈ A ∧ x ∈ B
       example (x : X) (H1 : x ∈ A) (H2 : x ∈ B) : x ∈ A ∩ B :=
       and.intro H1 H2

       example (x : X) (H1 : x ∈ A ∩ B) : x ∈ A :=
       and.left H1

       -- Fill in the proof below.
       -- (It should take about 8 lines.)

       example : f ' (A ∩ B) ⊆ f ' A ∩ f ' B :=
       take y,
       assume H1 : y ∈ f ' (A ∩ B),
       show y ∈ f ' A ∩ f ' B, from sorry
