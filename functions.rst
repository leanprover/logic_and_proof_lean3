.. _functions:

Functions
=========

In the late nineteenth century, developments in a number of branches of mathematics pushed towards a uniform treatment of sets, functions, and relations. We have already considered sets and relations. In this chapter, we consider functions and their properties.

A function, :math:`f`, is ordinary understood as a mapping from a domain :math:`X` to another domain :math:`Y`. In set-theoretic foundations, :math:`X` and :math:`Y` are arbitrary sets. We have seen that in a type-based system like Lean, it is natural to distinguish between types and subsets of a type. In other words, we can consider a type ``X`` of elements, and a set ``A`` of elements of that type. Thus, in the type-theoretic formulation, it is natural to consider functions between types ``X`` and ``Y``, and consider their behavior with respect to subsets of ``X`` and ``Y``.

In everyday mathematics, however, set-theoretic language is common, and most mathematicians think of a function as a map between sets. When discussing functions from a mathematical standpoint, therefore, we will also adopt this language, and later switch to the type-theoretic representation when we talk about formalization in Lean.

The Function Concept
--------------------

If :math:`X` and :math:`Y` are any sets, we write :math:`f : X \to Y` to express the fact that :math:`f` is a function from :math:`X` to :math:`Y`. This means that :math:`f` assigns a value :math:`f(x)` in :math:`Y` to every element :math:`x` of :math:`X`. The set :math:`X` is called the *domain* of :math:`f`, and the set :math:`Y` is called the *codomain*. (Some authors use the word "range" for the codomain, but today it is more common to use the word "range" for what we call the *image* of :math:`A` below. We will avoid the ambiguity by avoiding the word range altogether.)

The simplest way to define a function is to give its value at every :math:`x` with an explicit expression. For example, we can write any of the following:

-  Let :math:`f : \mathbb{N} \to \mathbb{N}` be the function defined by :math:`f(n) = n + 1`.
-  Let :math:`g : \mathbb{R} \to \mathbb{R}` be the function defined by :math:`g(x) = x^2`.
-  Let :math:`h : \mathbb{N} \to \mathbb{N}` be the function defined by :math:`h(n) = n^2`.
-  Let :math:`k : \mathbb{N} \to \{0, 1\}` be the function defined by

   .. math::

       k(n) =
         \left\{\begin{array}{ll}
           0 & \mbox{if $n$ is even} \\
           1 & \mbox{if $n$ is odd.}
         \end{array}\right.
       
The ability to define functions using an explicit expression raises the foundational question as to what counts as legitimate "expression." For the moment, let us set that question aside, and simply note that modern mathematics is comfortable with all kinds of exotic definitions. For example, we can define a function :math:`f : \mathbb{R} \to \{0, 1\}` by

.. math::

   f(x) =
     \left\{\begin{array}{ll}
       0 & \mbox{if $x$ is rational} \\
       1 & \mbox{if $x$ is irrational.}
     \end{array}\right.

This is at odds with a view of functions as objects that are computable in some sense. It is not at all clear what it means to be presented with a real number as input, let alone whether it is possible to determine, algorithmically, whether such a number is rational or not. We will return to such issues in a later chapter.

Notice that the choice of the variables :math:`x` and :math:`n` in the definitions above are arbitrary. They are bound variables in that the functions being defined do not depend on :math:`x` or :math:`n`. The values remain the same under renaming, just as the truth values of "for every :math:`x`, :math:`P(x)`" and "for every :math:`y`, :math:`P(y)`" are the same. Given an expression :math:`e(x)` that depends on the variable :math:`x`, logicians often use the notation :math:`\lambda x \; e(x)` to denote the function that maps :math:`x` to :math:`e(x)`. This is called "lambda notation," for the obvious reason, and it is often quite handy. Instead of saying "let :math:`f` be the function defined by :math:`f(x) = x+1`," we can say "let :math:`f = \lambda \; x (x + 1)`." This is *not* common mathematical notation, and it is best to avoid it unless you are talking to logicians or computer scientists. We will see, however, that lambda notation is built in to Lean.

For any set :math:`X`, we can define a function :math:`i_X(x)` by the equation :math:`i_X(x) = x`. This function is called the *identity function*. More interestingly, let :math:`f : X \to Y` and :math:`g : Y \to Z`. We can define a new function :math:`k : X \to Z` by :math:`k(x) = g(f(x))`. The function :math:`k` is called *the composition of* :math:`f` *and* :math:`g` or :math:`f` *composed with* :math:`g` and it is written :math:`g \circ f`. The order is somewhat confusing; you just have to keep in mind that to evaluate the expression :math:`g(f(x))` you first evaluate :math:`f` on input :math:`x`, and then evaluate :math:`g`.

We think of two functions :math:`f, g : X \to Y` as being equal, or the same function, when for they have the same values on every input; in other words, for every :math:`x` in :math:`X`, :math:`f(x) = g(x)`. For example, if :math:`f, g : \mathbb{R} \to \mathbb{R}` are defined by :math:`f(x) = x + 1` and :math:`g(x) = 1 + x`, then :math:`f = g`. Notice that the statement that two functions are equal is a universal statement (that is, for the form "for every :math:`x`, ...").

----

**Proposition.** For every :math:`f : X \to Y`, :math:`f \circ i_X = f` and :math:`i_Y \circ f = f`.

**Proof.** Let :math:`x` be any element of :math:`X`. Then :math:`(f \circ i_X)(x) = f(i_X(x)) = f(x)`, and :math:`(i_Y \circ f)(x) = i_Y(f(x)) = x`.

----

Suppose :math:`f : X \to Y` and :math:`g : Y \to X` satisfy :math:`g \circ f = i_X`. Remember that this means that :math:`g(f(x)) = x` for every :math:`x` in :math:`X`. In that case, :math:`g` is said to be a *left inverse* to :math:`f`, and :math:`f` is said to be a *right inverse* to :math:`g`. Here are some examples:

-  Define :math:`f, g : \mathbb{R} \to \mathbb{R}` by :math:`f(x) = x + 1` and :math:`g(x) = x - 1`. Then :math:`g` is both a left and a right inverse to :math:`f`, and vice-versa.
-  Write :math:`\mathbb{R}^{\geq 0}` to denote the nonnegative reals. Define :math:`f : \mathbb{R} \to \mathbb{R}^{\geq 0}` by :math:`f(x) = x^2`, and define :math:`g : \mathbb{R}^{\geq 0} \to \mathbb{R}` by :math:`g(x) = \sqrt x`. Then :math:`f(g(x)) = (\sqrt x)^2 = x` for every :math:`x` in the domain of :math:`g`, so :math:`f` is a left inverse to :math:`g`, and :math:`g` is a right inverse to :math:`f`. On the other hand, :math:`g(f(x)) = \sqrt{x^2} = | x |`, which is not the same as :math:`x` when :math:`x` is negative. So :math:`g` is not a left inverse to :math:`f`, and :math:`f` is not a right inverse to :math:`g`.

The following fact is not at all obvious, even though the proof is short:

----

**Proposition.** Suppose :math:`f : X \to Y` has a left inverse, :math:`h`, and a right inverse, :math:`k`. Then :math:`h = k`.

**Proof.** Let :math:`y` be any element in :math:`Y`. The idea is to compute :math:`h(f(k(y))` in two different ways. Since :math:`h` is a left inverse to :math:`f`, we have :math:`h(f(k(y))) = k(y)`. On the other hand, since :math:`k` is a right inverse to :math:`f`, :math:`f(k(y)) = y`, and so :math:`h(f(k(y)) = h(y)`. So :math:`k(y) = h(y)`.

----

If :math:`g` is both a right and left inverse to :math:`f`, we say that :math:`g` is simply the inverse of :math:`f`. A function :math:`f` may have more than one left or right inverse (we leave it to you to cook up examples), but it can have at most one inverse.

----

**Proposition.** Suppose :math:`g_1, g_2 : Y \to X` are both inverses to :math:`f`. Then :math:`g_1 = g_2`.

**Proof.** This follows from the previous proposition, since (say) :math:`g_1` is a left inverse to :math:`f`, and :math:`g_2` is a right inverse.

----

When :math:`f` has an inverse, :math:`g`, this justifies calling :math:`g` *the* inverse to :math:`f`, and writing :math:`f^{-1}` to denote :math:`g`. Notice that if :math:`f^{-1}` is an inverse to :math:`f`, then :math:`f` is an inverse to :math:`f^{-1}`. So if :math:`f` has an inverse, then so does :math:`f^{-1}`, and :math:`(f^{-1})^{-1} = f`. For any set :math:`A`, clearly we have :math:`i_X^{-1} = i_X`.

----

**Proposition.** Suppose :math:`f : X \to Y` and :math:`g : Y \to Z`. If :math:`h : Y \to X` is a left inverse to :math:`f` and :math:`k : Z \to Y` is a left inverse to :math:`g`, then :math:`h \circ k` is a left inverse to :math:`g \circ f`.

**Proof.** For every :math:`x` in :math:`X`,

.. math::

   (h \circ k) \circ (g \circ f) (x) = h(k(g(f(x)))) = h(f(x)) = x.

**Corollary.** The previous proposition holds with "left" replaced by "right."

**Proof.** Switch the role of :math:`f` with :math:`h` and :math:`g` with :math:`k` in the previous proposition.

**Corollary.** If :math:`f : X \to Y` and :math:`g : Y \to Z` both have inverses, then :math:`(f \circ g)^{-1} = g^{-1} \circ f^{-1}`.

----

.. _injective_surjective_and_bijective_functions:

Injective, Surjective, and Bijective Functions
----------------------------------------------

A function :math:`f : X \to Y` is said to be *injective*, or an *injection*, or *one-one*, if given any :math:`x_1` and :math:`x_2` in :math:`A`, if :math:`f(x_1) = f(x_2)`, then :math:`x_1 = x_2`. Notice that the conclusion is equivalent to its contrapositive: if :math:`x_1 \neq x_2`, then :math:`f(x_1) \neq f(x_2)`. So :math:`f` is injective if it maps distinct element of :math:`X` to distinct elements of :math:`Y`.

A function :math:`f : X \to Y` is said to be *surjective*, or a *surjection*, or *onto*, if for every element :math:`y` of :math:`Y`, there is an :math:`x` in :math:`X` such that :math:`f(x) = y`. In other words, :math:`f` is surjective if every element in the codomain is the value of :math:`f` at some element in the domain.

A function :math:`f : X \to Y` is said to be *bijective*, or a *bijection*, or a *one-to-one correspondence*, if it is both injective and surjective. Intuitively, if there is a bijection between :math:`X` and :math:`Y`, then :math:`X` and :math:`Y` have the same size, since :math:`f` makes each element of :math:`X` correspond to exactly one element of :math:`Y` and vice-versa. For example, it makes sense to interpret the statement that there were four Beatles as the statement that there is a bijection between the set :math:`\{1, 2, 3, 4\}` and the set :math:`\{ \text{John, Paul, George, Ringo} \}`. If we claimed that there were *five* Beatles, as evidenced by the function :math:`f` which assigns 1 to John, 2 to Paul, 3 to George, 4 to Ringo, and 5 to John, you should object that we double-counted John---that is, :math:`f` is not injective. If we claimed there were only three Beatles, as evidenced by the function :math:`f` which assigns 1 to John, 2 to Paul, and 3 to George, you should object that we left out poor Ringo---that is, :math:`f` is not surjective.

The next two propositions show that these notions can be cast in terms of the existence of inverses.

----

**Proposition.** Let :math:`f : X \to Y`.

-  If :math:`f` has a left inverse, then :math:`f` is injective.
-  If :math:`f` has a right inverse, then :math:`f` is surjective.
-  If :math:`f` has an inverse, then it is :math:`f` bijective.

**Proof.** For the first claim, suppose :math:`f` has a left inverse :math:`g`, and suppose :math:`f(x_1) = f(x_2)`. Then :math:`g(f(x_1)) = g(f(x_2))`, and so :math:`x_1 = x_2`.

For the second claim, suppose :math:`f` has a right inverse :math:`h`. Let :math:`y` be any element of :math:`Y`, and let :math:`x = g(y)`. Then :math:`f(x) = f(g(y)) = y`.

The third claim follows from the first two.

----

The following proposition is more interesting, because it requires us to define new functions, given hypotheses on :math:`f`.

----

**Proposition.** Let :math:`f : X \to Y`.

-  If :math:`X` is nonempty and :math:`f` is injective, then :math:`f` has a left inverse.
-  If :math:`f` is surjective, then :math:`f` has a right inverse.
-  If :math:`f` if bijective, then it has an inverse.

**Proof.** For the first claim, let :math:`\hat x` be any element of :math:`X`, and suppose :math:`f` is injective. Define :math:`g : Y \to X` by setting :math:`g(y)` equal to any :math:`x` such that :math:`f(x) = y`, if there is one, and :math:`\hat x` otherwise. Now, suppose :math:`g(f(x)) = x'`. By the definition of :math:`g`, :math:`x'` has to have the property that :math:`f(x) = f(x')`. Since :math:`f` is injective, :math:`x = x'`, so :math:`g(f(x)) = x`.

For the second claim, because :math:`f` is surjective, we know that for every :math:`y` in :math:`Y` there is any :math:`x` such that :math:`f(x) = y`. Define :math:`h : B \to A` by again setting :math:`h(y)` equal to any such :math:`x`. (In contrast to the previous paragraph, here we know that such an :math:`x` exists, but it might not be unique.) Then, by the definition of :math:`h`, we have :math:`f(h(y)) = y`.

----

Notice that the definition of :math:`g` in the first part of the proof requires the function to "decide" whether there is an :math:`x` in :math:`X` such that :math:`f(x) = y`. There is nothing mathematically dubious about this definition, but in many situations, this cannot be done *algorithmically*; in other words, :math:`g` might not be computable from the data. More interestingly, the definition of :math:`h` in the second part of the proof requires the function to "choose" a suitable value of :math:`x` from among potentially many candidates. We will see in :numref:`the_remaining_axioms` that this is a version of the *axiom of choice*. In the early twentieth century, the use of the axiom of choice in mathematics was hotly debated, but today it is commonplace.

Using these equivalences and the results in the previous section, we can prove the following:

----

**Proposition.** Let :math:`f : X \to B` and :math:`g : Y \to Z`.

-  If :math:`f` and :math:`g` are injective, then so is :math:`g \circ f`.
-  If :math:`f` and :math:`g` are surjective, then so is :math:`g \circ f`.

**Proof.** If :math:`f` and :math:`g` are injective, then they have left inverses :math:`h` and :math:`k`, respectively, in which case :math:`h \circ k` is a left inverse to :math:`g \circ f`. The second statement is proved similarly.

----

We can prove these two statements, however, without mentioning inverses at all. We leave that to you as an exercise.

Notice that the expression :math:`f(n) = 2 n` can be used to define infinitely many functions with domain :math:`\mathbb{N}`, such as:

-  a function :math:`f : \mathbb{N} \to \mathbb{N}`
-  a function :math:`f : \mathbb{N} \to \mathbb{R}`
-  a function :math:`f: \mathbb{N} \to \{ n \mid n \text{ is even} \}`

Only the third one is surjective. Thus a specification of the function's codomain as well as the domain is essential to making sense of whether a function is surjective.

Functions and Subsets of the Domain
-----------------------------------

Suppose :math:`f` is a function from :math:`X` to :math:`Y`. We may wish to reason about the behavior of :math:`f` on some subset :math:`A` of :math:`X`. For example, we can say that :math:`f` *is injective on* :math:`A` if for every :math:`x_1` and :math:`x_2` in :math:`A`, if :math:`f(x_1) = f(x_2)`, then :math:`x_1 = x_2`.

If :math:`f` is a function from :math:`X` to :math:`Y` and :math:`A` is a subset of :math:`X`, we write :math:`f[A]` to denote the *image of* :math:`f` *on* :math:`A`, defined by

.. math::

   f[A] = \{ y \in Y \mid y = f(x) \; \mbox{for some $x$ in $A$} \}.

In words, :math:`f[A]` is the set of elements of :math:`Y` that are "hit" by elements of :math:`A` under the mapping :math:`f`. Notice that there is an implicit existential quantifier here, so that reasoning about images invariably involves the corresponding rules.

----

**Proposition.** Suppose :math:`f : X \to Y`, and :math:`A` is a subset of :math:`X`. Then for any :math:`x` in :math:`A`, :math:`f(x)` is in :math:`f[A]`.

**Proof.** By definition, :math:`f(x)` is in :math:`f[A]` if and only if there is some :math:`x'` in :math:`A` such that :math:`f(x') = f(x)`. But that holds for :math:`x' = x`.

**Proposition.** Suppose :math:`f : X \to Y` and :math:`g : Y \to Z`. Let :math:`A` be a subset of :math:`X`. Then

.. math::

   (g \circ f)[A] = g[f[A]].

**Proof.** Suppose :math:`z` is in :math:`(g \circ f)[A]`. Then for some :math:`x \in A`, :math:`z = (g \circ f)(x) = g(f(x))`. By the previous proposition, :math:`f(x)` is in :math:`f[A]`. Again by the previous proposition, :math:`g(f(x))` is in :math:`g[f[A]]`.

Conversely, suppose :math:`z` is in :math:`g[f[A]]`. Then there is a :math:`y` in :math:`f[A]` such that :math:`f(y) = z`, and since :math:`y` is in :math:`f[D]`, there is an :math:`x` in :math:`A` such that :math:`f(x) = y`. But then :math:`(g \circ f)(x) = g(f(x)) = g(y) = z`, so :math:`z` is in :math:`(g \circ f)[A]`.

----

Notice that if :math:`f` is a function from :math:`X` to :math:`Y`, then :math:`f` is surjective if and only if :math:`f[X] = Y`. So the previous proposition is a generalization of the fact that the composition of surjective functions is surjective.

Suppose :math:`f` is a function from :math:`X` to :math:`Y`, and :math:`A` is a subset of :math:`X`. We can *view* :math:`f` as a function from :math:`A` to :math:`Y`, by simply ignoring the behavior of :math:`f` on elements outside of :math:`A`. Properly speaking, this is another function, denoted :math:`f \upharpoonright A` and called "the restriction of :math:`f` to :math:`A`." In other words, given :math:`f : X \to Y` and :math:`A \subseteq X`, :math:`f \upharpoonright A : A \to Y` is the function defined by :math:`(f \upharpoonright A)(x) = x` for every :math:`x` in :math:`A`. Notice that now ":math:`f` is injective on :math:`A`" means simply that the restriction of :math:`f` to :math:`A` is injective.

There is another important operation on functions, known as the *preimage*. If :math:`f : X \to Y` and :math:`B \subseteq Y`, then the *preimage of* :math:`B` *under* :math:`f`, denoted :math:`f^{-1}[B]`, is defined by

.. math::

   f^{-1}[B] = \{ x \in X \mid f(x) \in B \},

that is, the set of elements of :math:`X` that get mapped into :math:`B`. Notice that this makes sense even if :math:`f` does not have an inverse; for a given :math:`y` in :math:`B`, there may be no :math:`x`'s with the property :math:`f(x) \in B`, or there may be many. If :math:`f` has an inverse, :math:`f^{-1}`, then for every :math:`y` in :math:`B` there is exactly one :math:`x \in X` with the property :math:`f(x) \in B`, in which case, :math:`f^{-1}[B]` means the same thing whether you interpret it as the image of :math:`B` under :math:`f^{-1}` or the preimage of :math:`B` under :math:`f`.

----

**Proposition.** Suppose :math:`f : X \to Y` and :math:`g : Y \to Z`. Let :math:`C` be a subset of :math:`Z`. Then

.. math::

   (g \circ f)^{-1}[C] = f^{-1}[g^{-1}[C]].

**Proof.** For any :math:`y` in :math:`C`, :math:`y` is in :math:`(g \circ f)^{-1}[C]` if and only if :math:`g(f(y))` is in :math:`C`. This, in turn, happens if and only if :math:`f(y)` is in :math:`g^{-1}[C]`, which in turn happens if and only if :math:`y` is in :math:`f^{-1}[g^{-1}[C]]`.

----

Here we give a long list of facts properties of images and preimages. Here, :math:`f` denotes an arbitrary function from :math:`X` to :math:`Y`, :math:`A, A_1, A_2, \ldots` denote arbitrary subsets of :math:`X`, and :math:`B, B_1, B_2, \ldots` denote arbitrary subsets of :math:`Y`.

-  :math:`A \subseteq f^{-1}[f[A]]`, and if :math:`f` is injective, :math:`A = f^{-1}[f[A]]`.
-  :math:`f[f^{-1}[B]] \subseteq B`, and if :math:`f` is surjective, :math:`B = f[f^{-1}[B]]`.
-  If :math:`A_1 \subseteq A_2`, then :math:`f[A_1] \subseteq f[A_2]`.
-  If :math:`B_1 \subseteq B_2`, then :math:`f^{-1}[B_1] \subseteq f^{-1}[B_2]`.
-  :math:`f[A_1 \cup A_2] = f[A_1] \cup f[A_2]`.
-  :math:`f^{-1}[B_1 \cup B_2] = f^{-1}[B_1] \cup f^{-1}[B_2]`.
-  :math:`f[A_1 \cap A_2] \subseteq f[A_1] \cap f[A_2]`, and if :math:`f` is injective, :math:`f[A_1 \cap A_2] = f[A_1] \cap f[A_2]`.
-  :math:`f^{-1}[B_1 \cap B_2] = f^{-1}[B_1] \cap f^{-1}[B_2]`.
-  :math:`f[A] \setminus f[B] \subseteq f[A \setminus B]`.
-  :math:`f^{-1}[A] \setminus f^{-1}[B] \subseteq f[A \setminus B]`.
-  :math:`f[A] \cap B = f[A \cap f^{-1}[B]]`.
-  :math:`f[A] \cup B \supseteq f[A \cup f^{-1}[B]]`.
-  :math:`A \cap f^{-1}[B] \subseteq f^{-1}[f[A] \cap B]`.
-  :math:`A \cup f^{-1}[B] \subseteq f^{-1}[f[A] \cup B]`.

Proving identities like this is typically a matter of unfolding definitions and using basic logical inferences. Here is an example.

----

**Proposition.** Let :math:`X` and :math:`Y` be sets, :math:`f : X \to Y`, :math:`A \subseteq X`, and :math:`B \subseteq Y`. Then :math:`f[A] \cap B = f[A \cap f^{-1}[B]]`.

**Proof.** Suppose :math:`y \in f[A] \cap B`. Then :math:`y \in B`, and for some :math:`x \in A`, :math:`f(x) = y`. But this means that :math:`x` is in :math:`f^{-1}[B]`, and so :math:`x \in A \cap f^{-1}[B]`. Since :math:`f(x) = y`, we have :math:`y \in f[A \cap f^{-1}[B]]`, as needed.

Conversely, suppose :math:`y \in f[A \cap f^{-1}[B]]`. Then for some :math:`x \in A \cap f^{-1}[B]`, we have :math:`f(x) = y`. For this :math:`x`, have :math:`x \in A` and :math:`f(x) \in B`. Since :math:`f(x) = y`, we have :math:`y \in B`, and since :math:`x \in A`, we also have :math:`y \in f[A]`, as required.

----

.. _functions_and_relations:

Functions and Relations
-----------------------

A binary relation :math:`R(x,y)` on :math:`A` and :math:`B` is *functional* if for every :math:`x` in :math:`A` there exists a unique :math:`y` in :math:`B` such that :math:`R(x,y)`. If :math:`R` is a functional relation, we can define a function :math:`f_R : X \to B` by setting :math:`f_R(x)` to be equal to the unique :math:`y` in :math:`B` such that :math:`R(x,y)`. Conversely, it is not hard to see that if :math:`f : X \to B` is any function, the relation :math:`R_f(x, y)` defined by :math:`f(x) = y` is a functional relation. The relation :math:`R_f(x,y)` is known as the *graph* of :math:`f`.

It is not hard to check that functions and relations travel in pairs: if :math:`f` is the function associated with a functional relation :math:`R`, then :math:`R` is the functional relation associated the function :math:`f`, and vice-versa. In set-theoretic foundations, a function is often defined to be a functional relation. Conversely, we have seen that in type-theoretic foundations like the one adopted by Lean, relations are often defined to be certain types of functions. We will discuss these matters later on, and in the meanwhile only remark that in everyday mathematical practice, the foundational details are not so important; what is important is simply that every function has a graph, and that any functional relation can be used to define a corresponding function.

So far, we have been focusing on functions that take a single argument. We can also consider functions :math:`f(x, y)` or :math:`g(x, y, z)` that take multiple arguments. For example, the addition function :math:`f(x, y) = x + y` on the integers takes two integers and returns an integer. Remember, we can consider binary functions, ternary functions, and so on, and the number of arguments to a function is called its "arity." One easy way to make sense of functions with multiple arguments is to think of them as unary functions from a cartesian product. We can think of a function :math:`f` which takes two arguments, one in :math:`A` and one in :math:`B`, and returns an argument in :math:`C` as a unary function from :math:`A \times B` to :math:`C`, whereby :math:`f(a, b)` abbreviates :math:`f((a, b))`. We have seen that in dependent type theory (and in Lean) it is more convenient to think of such a function :math:`f` as a function which takes an element of :math:`A` and returns a function from :math:`B \to C`, so that :math:`f(a, b)` abbreviates :math:`(f(a))(b)`. Such a function :math:`f` maps :math:`A` to :math:`B \to C`, where :math:`B \to C` is the set of functions from :math:`B` to :math:`C`.

We will return to these different ways of modeling functions of higher arity later on, when we consider set-theoretic and type-theoretic foundations. One again, we remark that in ordinary mathematics, the foundational details do not matter much. The two choices above are inter-translatable, and sanction the same principles for reasoning about functions informally.

In mathematics, we often also consider the notion of a *partial function* from :math:`X` to :math:`Y`, which is really a function from some subset of :math:`X` to :math:`Y`. The fact that :math:`f` is a partial function from :math:`X` to :math:`Y` is sometimes written :math:`f : X \nrightarrow Y`, which should be interpreted as saying that :math:`f : A \to Y` for some subset :math:`A` of :math:`Y`. Intuitively, we think of :math:`f` as a function from :math:`X \to Y` which is simply "undefined" at some of its inputs; for example, we can think of :math:`f : \mathbb{R} \nrightarrow \mathbb{R}` defined by :math:`f(x) = 1 / x`, which is undefined at :math:`x = 0`, so that in reality :math:`f : \mathbb{R} \setminus \{ 0 \} \to R`. The set :math:`A` is sometimes called the *domain of* :math:`f`, in which case, there is no good name for :math:`X`; others continue to call :math:`X` the domain, and refer to :math:`A` as the *domain of definition*. To indicate that a function :math:`f` is defined at :math:`x`, that is, that :math:`x` is in the domain of definition of :math:`f`, we sometimes write :math:`f(x) \downarrow`. If :math:`f` and :math:`g` are two partial functions from :math:`X` to :math:`Y`, we write :math:`f(x) \simeq g(x)` to mean that either :math:`f` and :math:`g` are both defined at :math:`x` and have the same value, or are both undefined at :math:`x`. Notions of injectivity, surjectivity, and composition are extended to partial functions, generally as you would expect them to be.

In terms of relations, a partial function :math:`f` corresponds to a relation :math:`R_f(x,y)` such that for every :math:`x` there is at most one :math:`y` such that :math:`R_f(x,y)` holds. Mathematicians also sometimes consider *multifunctions* from :math:`X` to :math:`Y`, which correspond to relations :math:`R_f(x,y)` such that for every :math:`x` in :math:`X`, there is *at least* one :math:`y` such that :math:`R_f(x,y)` holds. There may be many such :math:`y`; you can think of these as functions which have more than one output value. If you think about it for a moment, you will see that a *partial multifunction* is essentially nothing more than an arbitrary relation.

Exercises
---------

#. Let :math:`f` be any function from :math:`X` to :math:`Y`, and let :math:`g` be any function from :math:`Y` to :math:`Z`.

   -  Show that if :math:`g \circ f` is injective, then :math:`f` is injective.
   -  Give an example of functions :math:`f` and :math:`g` as above, such that that :math:`g \circ f` is injective, but :math:`g` is not injective.
   -  Show that if :math:`g \circ f` is injective and :math:`f` is surjective, then :math:`g` is injective.

#. Let :math:`f` and :math:`g` be as in the last problem. Suppose :math:`g \circ f` is surjective.

   -  Is :math:`f` necessarily surjective? Either prove that it is, or give a counterexample.
   -  Is :math:`g` necessarily surjective? Either prove that it is, or give a counterexample.

#. A function :math:`f` from :math:`\mathbb{R}` to :math:`\mathbb{R}` is said to be
   *strictly increasing* if whenever :math:`x_1 < x_2`, :math:`f(x_1) < f(x_2)`.

   -  Show that if :math:`f : \mathbb{R} \to \mathbb{R}` is strictly increasing, then it is injective (and hence it has a left inverse).
   -  Show that if :math:`f : \mathbb{R} \to \mathbb{R}` is strictly increasing, and :math:`g` is a right inverse to :math:`f`, then :math:`g` is
      strictly increasing.

#. Let :math:`f : X \to Y` be any function, and let :math:`A` and :math:`B` be subsets of :math:`X`. Show that :math:`f [A \cup B] = f[A] \cup f[B]`.

#. Let :math:`f: X \to Y` be any function, and let :math:`A` and :math:`B` be any subsets of :math:`X`. Show :math:`f[A] \setminus f[B] \subseteq f[A \setminus B]`.

#. Define notions of composition and inverse for binary relations that generalize the notions for functions.
