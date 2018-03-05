.. _axiomatic_foundations:

Axiomatic Foundations
=====================

In this final chapter, our story comes full circle. We started our journey with symbolic logic, using the propositional connectives to model logical terms like "and," "or," "not," and "implies." To that we added the quantifiers and function and relation symbols of first-order logic. From there, we moved to sets, functions, and relations, which are ubiquitous in modern mathematics; the natural numbers and induction; and then topics such as number theory, combinatorics, the real numbers, and the infinite. Here we return to symbolic logic, and see how it can be used to provide a formal foundation for all of mathematics.

Specifically, we will consider an axiomatic framework known as *Zermelo-Fraenkel set theory*, which was introduced early in the twentieth century. In the set-theoretic view of mathematics, every mathematical object is a set. The axioms assert the existence of sets with various properties. From the collection of all sets, we carve out the usual inhabitants of the mathematical universe, not just the various number systems we have considered, but also pairs, finite sequences, relations, functions, and so on. This provides us with an idealized foundation for everything we have done since :numref:`Chapter %s <sets>`.

At the end of this chapter, we will briefly describe another axiomatic framework, *dependent type theory*, which is the one used by Lean. We will see that it provides an alternative perspective on mathematical objects and constructions, but one which is nonetheless inter-interpretable with the set-theoretic point of view.

.. _basic_axioms_for_sets:

Basic Axioms for Sets
---------------------

The axioms of set theory are expressed in first-order logic, for a language with a single binary relation symbol, :math:`\mathord{\in}`. We think of the entire mathematical universe as consisting of nothing but sets; if :math:`x` and :math:`y` are sets, we can express that :math:`x` is an element of :math:`y` by writing :math:`x \in y`. The first axiom says that two sets are equal if and only if they have the same elements.

.. math::

    \text{Extensionality:} \;\; \forall x, y \; (x = y \leftrightarrow \forall z (z \in x \leftrightarrow z \in y))

The next axiom tells us that there is at least one interesting set in the universe, namely, the set with no element.

.. math::

    \text{Empty set:} \;\; \exists x \; \forall y \; y \notin x

Here, of course, :math:`x \notin y` abbreviates :math:`\neg (x \in y)`. By the axiom of extensionality, the set asserted to exist by this axiom is unique: in other words, if :math:`x_1` and :math:`x_2` each have no elements, then, vacuously, any element is in one if and only if it is in the other, so :math:`x_1 = x_2`. This justifies using the word *the* in the phrase *the empty set*. Given this fact, it should seem harmless to introduce a new symbol, :math:`\emptyset`, to denote the set matching that description. Indeed, one can show that this is case: in a precise sense, such expansions to a first-order language can be viewed as nothing more than a convenient manner of expression, and statements in the bigger language can be translated to the original language in a way that justifies all the expected inferences. We will not go into the details here, and, rather, take this fact for granted. Using the new symbol, the empty set axiom tells us the empty set satisfies the property :math:`\forall y \; y \notin \emptyset`.

The third axiom tells us that given two sets :math:`x` and :math:`y`, we can form a new set :math:`z` whose elements are exactly :math:`x` and :math:`y`.

.. math::

    \text{Pairing:} \;\; \forall x, y \; \exists z \; \forall w \; (w \in z \leftrightarrow w = x \vee w = y)

There is a stealth usage of this axiom lurking nearby. The axiom does not require that :math:`x` and :math:`y` are different, so, for example, we can take them both to be the empty set. This tells us that the set :math:`\{ \emptyset \}`, whose only element is the empty set, exists. More generally, the axiom tells us that for any :math:`x`, we have the set :math:`\{ x \}` whose only element is :math:`x`, and for any :math:`x` and :math:`y`, we have :math:`\{x, y\}`, as described above. Once again, the axiom of extensionality tells us that the sets meeting these descriptions are unique, so it is fair to use the corresponding notation. We are now off and running! We now have all of the following sets, and more:

.. math::

    \emptyset, \;\; \{ \emptyset \}, \; \; \{ \{ \emptyset \} \}, \;\; \{ \emptyset, \{ \emptyset \} \}, \;\; \{ \{ \{ \emptyset \} \} \}, \;\; \ldots

Still, we can never form a set with more than two elements in this way. To that end, it would be reasonable to add an axiom that asserts for every :math:`x` and :math:`y`, the set :math:`x \cup y` exists. But we can do better. Remember that if :math:`x` is any set, :math:`\bigcup x` denotes the union of all the sets in :math:`x`. In other words, for any set :math:`z`, :math:`z` is an element of :math:`\bigcup x` if and only if :math:`z` is in :math:`w` for some set :math:`w` in :math:`x`. The following axiom asserts that this set exists.

.. math::

    \text{Union:} \;\; \forall x \; \exists y \; \forall z \; (z \in y \leftrightarrow \exists w \; (w \in x \wedge z \in w))

Once again, this justifies the use of the :math:`\bigcup` notation. We get the ordinary binary union using this axiom together with pairing, since we have :math:`x \cup y = \bigcup \{ x, y \}`.

At this stage, it will be useful to invoke some additional notation that was first introduced in our informal presentation of sets. If :math:`A` is any first-order formula in the language of set theory, :math:`\forall x \in y \; A` abbreviates :math:`\forall x \; (x \in y \rightarrow A)` and :math:`\exists x \in y \; A` abbreviates :math:`\exists x \; (x \in y \wedge A)`, relativizing the quantifiers as described in :numref:`relativization_and_sorts`. The expression :math:`x \subseteq y` abbreviates :math:`\forall z \in x \; (z \in y)`, as you would expect.

The next axiom asserts that for every set :math:`x`, the power set, :math:`\mathcal{P}(x)` exists. 

.. math::

    \text{Power Set:} \;\; \forall x \; \exists y \; \forall z \; (z \in y \leftrightarrow z \subseteq x)

We have begun to populate the universe with basic set constructions. It is the next axiom, however, that gives set theory its remarkable flexibility. Properly speaking, it is not a single axiom, but a *schema*, an infinite family of axioms given by a single template. The schema is meant to justify set-builder notation :math:`\{ w \mid \ldots \}` that was ubiquitous in :numref:`Chapter %s <sets>`. The first question we need to address is what we are allowed to write in place of the ellipsis. In our informal presentation of set theory, we said that one can define a set using any property, but that only prompts the question here as to what counts as a "property." Axiomatic set theory provides a simple but powerful answer: we can use any first-order formula in the language of set theory.

Another concern centers around Russell's paradox, as discussed in :numref:`elementary_set_theory`. Any theory that allows us to define the set :math:`\{ w \mid w \notin w \}` is inconsistent, since if we call this set :math:`z`, we can show :math:`z \in z` if and only if :math:`z \notin z`, which is a contradiction. Once again, set theory offers a simple and elegant solution: for any formula :math:`A(z)` and set :math:`y`, we can instead form the set :math:`\{ w \in y \mid A(w) \}`, consisting of the elements of :math:`y` that satisfy :math:`A`. In other words, we have to first use the other axioms of set theory to form a set :math:`y` that is big enough to include all the elements that we want to consider, and then use the formula :math:`A` to pick out the ones we want.

The axiom schema we want is called *separation*, because we use it to separate the elements we want from those in a bigger collection.

.. math::

    \text{Separation:} \;\; \forall x_1, x_2, \ldots, x_n, y \; \exists z \; \forall w \; (w \in z \leftrightarrow w \in y \wedge A(w,x_1, x_2, \ldots, x_n))

Here, :math:`A` can be any formula, and the list of variables :math:`x_1, \ldots, x_n` that are shown indicate that the formula :math:`A` can have some parameters, in which case the set we form depends on these values. For example, in ordinary mathematics, given a number :math:`m` we can form the set :math:`\{ n \in \mathbb{N} \mid \mathit{prime}(n) \wedge n > m\}`. In this example, the description involves :math:`m` and :math:`n`, and the set so defined depends on :math:`m`.

We could use the separation axiom to simplify the previous axioms. For example, as long as we know that *any* set :math:`x` exists, we can define the empty set as :math:`\{ y \in x \mid \bot \}`. Similarly, in the pairing axiom, it is enough to assert that there is a set that contains :math:`x` and :math:`y` as elements, because then we can use separation to carve out the set whose elements are exactly :math:`x` and :math:`y`.

These are only the first six axioms of set theory; we have four more to go. But these axioms alone provide a foundation for reasoning about sets, relations, and functions, as we did in :numref:`Chapter %s <sets>`, :numref:`Chapter %s <relations>`, and :numref:`Chapter %s <functions>`. For example, we have already defined the union operation, and we can define set intersection :math:`x \cap y` as :math:`\{ z \in x \cup y \mid z \in x \wedge z \in y \}`.  We cannot define arbitrary set complements; for example, the exercises ask you to show that in set theory we can prove that there is no set that contains all sets, and so the complement of the empty set does not exist. But given any two sets :math:`x` and :math:`y`, we can define their difference :math:`x \setminus y` as :math:`\{ z \in x \mid z \notin y \}`. The exercises below ask you to show that we can also define indexed unions and intersections, once we have developed the notion of a function.

We would like to define a binary relation between two sets :math:`x` and :math:`y` to be a subset of :math:`x \times y`, but we first have to define the cartesian product :math:`x \times y`. Remember that in :numref:`cartesian_product_and_power_set` we defined the ordered pair :math:`(u, v)` to be the set :math:`\{ \{ u \}, \{ u, v \} \}`. As a result, we can use the separation axiom to define

.. math::

    x \times y = \{ z \in \ldots \mid \exists u \in x \; \exists v \in y \; (z = (u, v)) \}

provided we can prove the existence of a set big enough to fill the "...." In the exercises below, we ask you to show that the set :math:`\mathcal P (\mathcal P (x \cup y))` contains all the relevant ordered pairs. A binary relation :math:`r` on :math:`x` and :math:`y` is then just a subset of :math:`x \times y`, where we interpret :math:`r(u, v)` as :math:`(u, v) \in r`. We can think of ordered triples from the sets :math:`x`, :math:`y`, :math:`z` as elements of :math:`x \times (y \times z)` and so on. This gives us ternary relations, four-place relations, and so on.

Now we can say that a function :math:`f : x \to y` is really a binary relation satisfying :math:`\forall u \in x \; \exists! v \in y \; f(u, v)`, and we write :math:`f(u) = v` when :math:`v` is the unique element satisfying :math:`f(u, v)`. A function :math:`f` taking arguments from sets :math:`x`, :math:`y`, and :math:`z` and returning an element of `w` can be interpreted as a function :math:`f : x \times y \times z \to w`, and so on.

With sets, relations, and functions, we have the basic infrastructure we need to do mathematics. All we are missing at this point are some interesting sets and structures to work with. For example, it would be nice to have a set of natural numbers, :math:`\mathbb{N}`, with all the properties we expect it to have. So let us turn to that next.


The Axiom of Infinity
---------------------

With the axioms we have so far, we can form lots of finite sets, starting with :math:`\emptyset` and iterating pairing, union, powerset, and separation constructions. This will give us sets like

.. math::

    \emptyset, \{ \emptyset \}, \{ \{ \emptyset \} \}, \{ \emptyset, \{ \emptyset \} \}, \{ \{ \{ \emptyset \} \} \}, \ldots

But the axioms so far do not allow us to define sets that are more interesting than these. In particular, none of the axioms gives us an infinite set. So we need a further axiom to tell us that such a set exists.

Remember that in :numref:`Chapter %s <the_natural_numbers_and_induction>` we characterized the natural numbers as a set with a distinguished element, :math:`0`, and an injective operation :math:`\mathit{succ}`, satisfying the principles of induction and recursive definition. In set theory, everything is a set, so if we want to represent the natural numbers in that framework, we need to identify them with particular sets. There is a natural choice for :math:`0`, namely, the empty set, :math:`\emptyset`. For a successor operation, we will use the function :math:`\mathit{succ}` defined by :math:`\mathit{succ}(x) = x \cup \{ x \}`. The choice is a bit of a hack; the best justification for the definition is that it works. With this definition, the first few natural numbers are as follows:

.. math::

    0 = \emptyset, \;\; 1 = \{ \emptyset \}, \;\; 2 = \{ \emptyset, \{ \emptyset \} \}, \;\; 3 = \{ \emptyset, \{ \emptyset \}, \{ \emptyset, \{ \emptyset \} \} \}, \;\; \ldots

It is more perspicuous to write them as follows:

.. math::

    0 = \emptyset, \;\; 1 = \{ 0 \}, \;\; 2 = \{ 0, 1 \}, \;\; 3 = \{ 0, 1, 2 \}, \;\; 4 = \{ 0, 1, 2, 3 \}, \;\; \ldots

In general, :math:`n+1` is represented by the set :math:`\{ 0, 1, \ldots, n \}`, in which case, :math:`m \in n` is the same as :math:`m < n`. This is just an incidental property of our encoding, but it is a rather charming one.

Recall from :numref:`Chapter %s <the_natural_numbers_and_induction>` that we can characterize the set of natural numbers as follows:

- There is an element :math:`0 \in \mathbb{N}` and there is an injective function :math:`\mathit{succ} : \mathbb{N} \to \mathbb{N}`, with the additional property that :math:`\mathit{succ}(x) \ne 0` for any :math:`x` in :math:`\mathbb{N}`.

- The set :math:`\mathbb{N}` satisfies the principle of induction: if :math:`x` is a subset of :math:`\mathbb{N}` that contains :math:`0` and is closed under :math:`\mathit{succ}` (that is, whenever :math:`z` is in :math:`\mathbb{N}`, so is :math:`\mathit{succ}`), then :math:`x = \mathbb{N}`.

We have already settled on the definitions of :math:`0` and :math:`\mathit{succ}`, but we don't yet have any set that contains the first and is closed under applying the second. The axiom of infinity asserts precisely that there exists such a set.

.. math::

    \text{Infinity:} \;\; \exists x \; (\emptyset \in x \wedge \forall y \; (y \in x \rightarrow y \cup \{ y \} \in x))

Say a set :math:`x` is *inductive* if it satisfies the property after the existential quantifier, namely, that it contains the empty set and is closed under our successor operation. Notice that the set of natural numbers, which we are still trying to define formally, has this property. The axiom of infinity asserts the existence of *some* inductive set, but not necessarily the natural numbers themselves; an inductive set can have other things in it as well. In a sense, the principle of induction says that the natural numbers is the *smallest* inductive set. So we need a way to separate that set from the one asserted to exist by the axiom of infinity.

Let :math:`x` be any inductive set, as asserted to exist by the axiom of infinity. Let

.. math::

    y = \bigcap \{ z \subseteq x \mid \mbox{$z$ is inductive} \}.

Here :math:`z \subseteq x` can also be written :math:`z \in \mathcal P(x)`, so the inside set exists by the separation axiom. According to this definition, :math:`y` is the intersection of every inductive subset of :math:`x`, so an element :math:`w` is in :math:`y` if and only if :math:`w` is in every inductive subset of :math:`x`. We claim that :math:`y` itself is inductive. First, we have :math:`\emptyset \in y`, since the empty set is an element of every inductive set. Next, suppose :math:`w` is in :math:`y`. Then :math:`w` is in every inductive subset of :math:`x`. But since every inductive set is closed under successor, :math:`\mathit{succ}(w)` is in every inductive subset of :math:`x`. So :math:`\mathit{succ}(w)` is in the intersection of all inductive subsets of :math:`x` --- which is :math:`y`!

It quickly follows that :math:`y` is a subset of *every* inductive set. To see this, suppose that :math:`z` is inductive. You can check that :math:`z \cap x` is inductive, and thus :math:`y \subseteq z \cap x \subseteq z`.

The more interesting point is that :math:`y` also satisfies the principle of induction. To see this, suppose :math:`u \subseteq y` contains the empty set and is closed under :math:`\mathit{succ}`. Then :math:`u` is inductive, and since :math:`y` is a subset of every inductive set, we have :math:`y \subseteq u`. Since we assumed :math:`u \subseteq y`, we have :math:`u = y`, which is what we want.

To summarize, then, we have proved the existence of a set that contains :math:`0` and is closed under a successor operation and satisfies the induction axiom. Moreover, there is only one such set: if :math:`y_1` and :math:`y_2` both have this property, then so does :math:`y_1 \cap y_2`, and by the induction principle, this intersection has to be equal to both :math:`y_1` and :math:`y_2`, in which case :math:`y_1` and :math:`y_2` are equal. It then makes sense to call the unique set with these properties the *natural numbers*, and denote it by the symbol :math:`\mathbb{N}`.

There is only one piece of the puzzle missing. It is clear from the definition that :math:`0` is not the successor of any number, but it is not clear that the successor function is injective. We can prove that by first noticing that the natural numbers, as we have defined them, have a peculiar property: if :math:`z` is a natural number, :math:`y` is an element of :math:`z`, and :math:`x` is an element of :math:`y`, then :math:`x` is an element of :math:`z`. This says exactly that the :math:`\in` relation is transitive on natural numbers, which is not surprising, since we have noted that :math:`\in` on the natural numbers, under our representation, coincides with :math:`<`. To prove this claim formally, say that a set :math:`z` is *transitive* if it has the property just mentioned, namely, that every element of an element of :math:`z` is an element of `z`. This is equivalent to saying that for every :math:`y \in z`, we have :math:`y \subseteq z`. 

----

**Lemma.** Every natural number is transitive.

**Proof.** By induction on the natural numbers. Clearly, :math:`\emptyset` is transitive. Suppose :math:`x` is transitive, and suppose :math:`y \in \mathit{succ}(x)` and :math:`z \in y`. Since :math:`\mathit{succ}(x) = x \cup \{ x \}`, we have :math:`y \in x` or :math:`y \in \{x\}`. If :math:`y \in x`, then by the inductive hypothesis, we have :math:`z \in x`, and hence :math:`z \in \mathit{succ}(x)`. Otherwise, we have :math:`y \in \{ x \}`, and so :math:`y = x`. In that case, again we have :math:`z \in x`, and hence :math:`z \in \mathit{succ}(x)`.

----

The next lemma shows that, on transitive sets, union acts like the predecessor operation.

----

**Lemma.** If :math:`x` is transitive, then :math:`\bigcup \mathit{succ}(x) = x`.

**Proof**. Suppose :math:`y` is in :math:`\bigcup \mathit{succ}(x) = \bigcup (x \cup \{ x \})`. Then either :math:`y \in z` for some :math:`z \in x`, or :math:`y \in x`. In the first case, also have :math:`y \in x`, since :math:`x` is transitive.

Conversely, suppose :math:`y` is in :math:`x`. Then :math:`y` is in :math:`\bigcup \mathit{succ}(x)`, since we have :math:`x \in \mathit{succ}(x)`.

**Theorem.** :math:`\mathit{succ}` is injective on :math:`\mathbb{N}`.

**Proof.** Suppose :math:`x` and :math:`y` are in :math:`\mathbb{N}`, and :math:`\mathit{succ}(x) = \mathit{succ}(y)`. Then :math:`x` and :math:`y` are both transitive, and we have :math:`x = \bigcup \mathit{succ}(x) = \bigcup \mathit{succ}(y) = y`.

----

With that, we are off and running. Although we will not present the details here, using the principle of induction we can justify the principle of recursive definition. We can then go on to define the basic operations of arithmetic and derive their properties, as done in :numref:`Chapter %s <the_natural_numbers_and_induction>`. We can go on to define the integers, the rational numbers, and the real numbers, as described in Chapter :numref:`Chapter %s <the_real_numbers>`, and to develop subjects like number theory and combinatorics, as described in Chapters :numref:`Chapter %s <elementary_number_theory>` and :numref:`Chapter %s <combinatorics>`. In fact, it seems that any reasonable branch of mathematics can be developed formally on the basis of axiomatic set theory. There are pitfalls, for example, having to do with large collections: for example, just as it is inconsistent to postulate the existence of a set of all sets, in the same way, there is no collection of all partial orders, or all groups. So when interpreting some mathematical claims, care has to be taken in some cases to restrict to sufficiently large collections of such objects. But this rarely amounts to more than careful bookkeeping, and it is a remarkable fact that, for the most part, the axioms of set theory are flexible and powerful enough to justify most ordinary mathematical constructions.

.. _the_remaining_axioms:

The Remaining Axioms
--------------------

The seven axioms we have seen are quite powerful, and suffice to represent large portions of mathematics. We discuss the remaining axioms of Zermelo-Fraenkel set theory here.

So far, none of the axioms we have seen rule out the possibility that a set :math:`x` can be an element of itself, that is, that we can have :math:`x \in x`. The following axiom precludes that.

.. math::

    \text{Foundation} \;\; \forall x \; (\exists y \; y \in x \to \exists y \in x \; \forall z \in x \; z \notin y)))

The axiom says that if :math:`x` is a nonempty set, there is an element :math:`y` of :math:`x` with the property that no element of :math:`y` is again an element of :math:`x`. This implies we cannot have a descending chain of sets, each one an element of the one before:

.. math::

    x_1 \ni x_2 \ni x_3 \ni \ldots

If we apply the axiom of foundation to the set :math:`\{x_1, x_2, x_3, \ldots\}`, we find that some element :math:`x_i` does not contain any others, which is only possible if the sequence has terminated with :math:`x_i`. In other words, the axiom implies (and is in fact equivalent to) the statement that the elementhood relation is *well founded*, which explains the name.

The axioms listed in the previous section tell a story of how sets come to be: we start with the empty set, and keep applying constructions like power set, union, and separation, to build more sets. Set theorists often imagine the hierarchy of sets as forming a big V, with the empty set at the bottom and a set at any higher level comprising, as its elements, sets that appear in levels below. In a precise sense (which we will not spell out here), the axiom of foundation says that every set arises in such a way.

Now consider the following sequence of sets:

.. math::

    \mathbb{N}, \;\; \mathcal P(\mathbb{N}), \;\; \mathcal P(\mathcal P(\mathbb{N}), \;\; \mathcal P (\mathcal P (\mathcal P (\mathbb{N}))), \;\; \ldots

It is consistent with all the axioms we have seen so far that every set in the mathematical universe is an element of one of these. That still gives us a lot of sets, but, since we have described that sequence, we can just as well imagine a set that contains all of them:

.. math::

    \{ \mathbb{N}, \;\; \mathcal P(\mathbb{N}), \;\; \mathcal P(\mathcal P(\mathbb{N}), \;\; \mathcal P (\mathcal P (\mathcal P (\mathbb{N}))), \;\; \ldots \}.

The following axiom implies the existence of such a set. 

.. math::

    \text{Replacement:} \;\; \forall x, y_1, \ldots, y_n \;\; (\forall z \in x \; \exists ! w \; A(z, w, y_1, \ldots, y_n) \rightarrow \\
    \exists u \; \forall w \; (w \in u \leftrightarrow \exists z \in x \; A(z, w, y_1, \ldots, y_n)))

Like the axiom of separation, this axiom is really a schema, which is to say, a separate axiom for each formula :math:`A`. Here, too, the variables :math:`y_1, y_2, \ldots, y_n` are free variables that can occur in :math:`A`. To understand the axiom, it is easiest to think of them as parameters that are fixed in the background, and then ignore them. The axioms says that if, for every :math:`z` in :math:`x` there is a unique :math:`w` satisfying :math:`A(z,w)`, then there is a single set, :math:`u`, that consists of the :math:`w` values corresponding to every such :math:`z`. In other words, if you think of :math:`A` as a function whose domain is :math:`x`, the axiom asserts that the range of that function exists. In the example above, :math:`x` is the natural numbers, and :math:`A(z, w)` says that :math:`w` is the :math:`z`-fold iterate of the power set of the natural numbers.

The nine axioms we have listed so far comprise what is known as *Zermelo-Fraenkel Set Theory*. There is on additional axiom, the axiom of choice, which is usually listed separately for historical reasons: it was once considered controversial, and in the early days, mathematicians considered it important to keep track of whether the axiom was actually used in a proof. There are many equivalent formulations, but this one is one of the most straightforward.

.. math::

    \text{Choice:} \;\; \forall x \; (\emptyset \notin x \rightarrow \exists f : x \to \bigcup x \; \forall y \in x \; f(y) \in y)

The axiom says that for any collection :math:`x` of nonempty sets, there is a function :math:`f` that selects an element from each one. We used this axiom, informally, in :numref:`injective_surjective_and_bijective_functions` to show that every surjective function has a right inverse. In fact, this last statement can be shown to be equivalent to the axiom of choice on the basis of the other axioms. 

To summarize, then, the axioms of Zermelo-Fraenkel Set Theory with the axiom of choice are as follows:

#. Extensionality: 

    .. math:: 
    
        \forall x, y \; (x = y \leftrightarrow \forall z (z \in x \leftrightarrow z \in y))

#. Empty set: 

    .. math::
    
        \exists x \; \forall y \; y \notin x

#. Pairing:

    .. math::
    
        \forall x, y \; \exists z \; \forall w \; (w \in z \leftrightarrow w = x \vee w = y)

#. Union:

    .. math:: 
    
        \forall x \; \exists y \; \forall z \; (z \in y \leftrightarrow \exists w \; (w \in x \wedge z \in w))

#. Power set: 

    .. math::
    
        \forall x \; \exists y \; \forall z \; (z \in y \leftrightarrow z \subseteq y)

#. Separation:

    .. math::
    
        \forall x_1, x_2, \ldots, x_n, y \; \exists z \; \forall w \; (w \in z \leftrightarrow w \in y \wedge A(w,x_1, x_2, \ldots, x_n))

#. Infinity:

    .. math::
    
        \exists x \; (\emptyset \in x \wedge \forall y \; (y \in x \rightarrow y \cup \{ y \} \in x)

#. Foundation:

    .. math::
    
        \forall x \; (\exists y \; y \in x \to \exists y \in x \; \forall z \in x \; z \notin y)))

#. Replacement: 

    .. math::
    
        \forall x, y_1, \ldots, y_n \;\; (\forall z \in x \; \exists ! w \; A(z, w, y_1, \ldots, y_n) \rightarrow \\
        \exists u \; \forall w \; (w \in u \leftrightarrow \exists z \in x \; A(z, w, y_1, \ldots, y_n)))

#. Choice:

    .. math::
    
        \forall x \; (\emptyset \notin x \rightarrow \exists f : x \to \bigcup x \; \forall y \in x \; f(y) \in y)

Type Theory
-----------

As a foundation for mathematics, Zermelo-Fraenkel set theory is appealing. The underlying logic, first-order logic, provides the basic logical framework for quantifiers and the logical connectives. On top of that, the theory describes a single, intuitively natural concept, that of a set of elements. The axioms are plausible eminently reasonable. It is remarkable that virtually all of modern mathematics can be reduced to such simple terms.

There are other foundations on offer, however. These tend to be largely inter-interpretable with set theory. After all, set-theoretic language is now ubiquitous in everyday mathematics, so any reasonable foundation should be able to make sense of such language. On the other hand, we have already noted that set theory is remarkably expressive and robust, and so it should not be surprising that other foundational approaches can often be understood in set-theoretic terms.

This is, in particular, true of *dependent type theory*, which is the basis of the Lean theorem prover. The syntax of type theory is more complicated than that of set theory. In set theory, there is only one kind of object; officially, everything is a set. In contrast, in type theory, every well-formed expression in Lean has a *type*, and there is a rich vocabulary of defining types. 

In fact, Lean is based on a version of an axiomatic framework known as the *Calculus of Inductive Constructions*, which provides all of the following:

- A hierarchy of *type universes*, ``Type 0``, ``Type 1``, ``Type 2``, ... and a special type ``Prop``. The expression ``Type`` abbreviates ``Type 0``, and saying ``T : Type`` can be interpreted as saying that ``T`` is a datatype. The type ``Prop`` is the type of propositions.

- *Dependent function types* ``Π x : A, B x``. An element ``f`` of this type is a function which maps any element ``a`` of type ``A`` to an element ``f a`` of type ``B a``. The fact that the type of the output depends on the type of the input is what makes the function "dependent." In the case where the output type does not depend on the input, we have the simple function type ``A → B``.

- *Inductive types*, like the natural numbers, specified by *constructors*, like zero and successor. Each such type comes with principles of induction and recursion.

These constructions account for both the underlying logic of assertions (that is, the propositions) as well as the objects of the universe, which are elements of the ordinary types.

It is straightforward to interpret type theory in set theory, since we can view each type as a set. The type universes are simply large collections of sets, and dependent function types and inductive types can be explained in terms of set-theoretic constructions. We can view ``Prop`` as the set :math:`\{ \top, \bot \}` of truth values, just as we did when we described truth-table semantics for propositional logic.

Given this last fact, why not just use set theory instead of type theory for interactive theorem proving? Some interactive theorem provers do just that. But type theory has some advantages:

- The fact that the rules for forming expressions are so rigid makes it easier for the system to recognize typographical errors and provide useful feedback. In type theory, if ``f`` has type ``ℕ → ℕ`` it can be applied only to a natural number, and a theorem prover can flag an error if the argument has the wrong type. In set theory, anything can be applied to anything, whether or not doing so really makes sense.

- Again, because the rules for forming expressions are so rigid, the system can infer useful information from the components of an expression, whereas set theory would require us to make such information explicit. For example, with ``f`` as above, a theorem prover can infer that a variable ``x`` in ``f x`` should have type ``ℕ``, and that the resulting expression again has type ``ℕ``. In set theory, :math:`x \in \mathbb{N}` has to be stated as an explicit hypothesis, and :math:`f(x) \in \mathbb{N}` is then a theorem.

- By encoding propositions as certain kinds of types, we can use the same language for defining mathematical objects and writing mathematical proofs. For example, we can apply a function to an argument in the same way we apply a theorem to some hypotheses.

- Expressions in a sufficiently pure part of dependent type theory have a computational interpretation, so, for example, the logical framework tells us how to evaluate the factorial function, given its definition. In set theory, the computational interpretation is specified independently, after the fact.

These facts hark back to the separation of concerns that we raised in :numref:`Chapter %s <introduction>`: different axiomatic foundations provide different idealized descriptions of mathematical activity, and can be designed to serve different purposes. If you want a clean, simple theory that accounts for the vast majority of mathematical proof, set theory is hard to beat. If you are looking for a foundation that makes computation central or takes the notion of a function rather than a set as basic, various flavors of type theory have their charms. For interactive theorem proving, pragmatic issues regarding implementation and usability come into play. What is important to recognize is that what all these idealized descriptions have in common is that they are all designed to model important aspects of mathematical language and proof. Our goal here has been to help you reflect on those features of mathematical language and proof that give mathematics its special character, and to help you better understand how they work.



Exercises
---------

#. Use an argument similar Russell's paradox to show that there is no "set of all sets," that is, there is no set that contains every other set as an element.

#. Suppose :math:`x` is a nonempty set, say, containing an element :math:`y`. Use the axiom of separation to show that the set :math:`\bigcap x` exists. (Remember that something is an element of :math:`\bigcap x` if it is an element of every element of :math:`x`.)

#. Justify the claim in :numref:`basic_axioms_for_sets` that every element of :math:`x \times y` is an element of :math:`\mathcal P (\mathcal P (x \cup y))`.

#. Given a set :math:`x` and a function :math:`A : x \to y`, use the axioms of set theory to prove the existence of :math:`\bigcup_{i \in x} A(i)`.

