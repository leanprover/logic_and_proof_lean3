.. _relations:

Relations
=========

In :numref:`Chapter %s <first_order_logic>` we discussed the notion of a *relation symbol* in first-order logic, and in :numref:`Chapter %s <semantics_of_first_order_logic>` we saw how to interpret such a symbol in a model. In mathematics, we are generally interested in different sorts of relationships between mathematical objects, and so the notion of a relation is ubiquitous. In this chapter, we will consider some common kinds of relations.

In some axiomatic foundations, the notion of a relation is taken to be primitive, but in axiomatic set theory, a relation is taken to be a set of tuples of the corresponding arity. For example, we can take a binary relation on :math:`A` to be a subset of :math:`A \times A`, where :math:`R(a, b)` means that :math:`(a, b) \in R`. The foundational definition is generally irrelevant to everyday mathematical practice; what is important is simply that we can write expressions like :math:`R(a, b)`, and that they are true or false, depending on the values of :math:`a` and :math:`b`. In mathematics, we often use *infix* notation, writing :math:`a R b` instead of :math:`R(a, b)`.

.. _order_relations:

Order Relations
---------------

We will start with a class of important binary relations in mathematics, namely, *partial orders*.

----

**Definition.** A binary relation :math:`\leq` on a domain :math:`A` is a *partial order* if it has the following three properties:

- *reflexivity*: :math:`a \leq a`, for every :math:`a` in :math:`A`
- *transitivity*: if :math:`a \leq b` and :math:`b \leq c`, then :math:`a \leq c`, for every :math:`a`, :math:`b`, and :math:`c` in :math:`A`
- *antisymmetry*: if :math:`a \leq b` and :math:`b \leq a` then :math:`a = b`, for every :math:`a` and :math:`b` in :math:`A`

----

Notice the compact way of introducing the symbol :math:`\leq` in the statement of the definition, and the fact that :math:`\leq` is written as an infix symbol. Notice also that even though the relation is written with the symbol :math:`\leq`, it is the only symbol occurring in the definition; mathematical practice favors natural language to describe its properties.

You now know enough, however, to recognize the universal quantifiers that are present in the three clauses. In symbolic logic, we would write them as follows:

- :math:`\forall a \; (a \leq a)`
- :math:`\forall a, b, c \; (a \leq b \wedge b \leq c \to a \leq c)`
- :math:`\forall a, b \; (a \leq b \wedge b \leq a \to a = b)`

Here the variables :math:`a`, :math:`b`, and :math:`c` implicitly range over the domain :math:`A`.

The use of the symbol :math:`\leq` is meant to be suggestive, and, indeed, the following are all examples of partial orders:

-  :math:`\leq` on the natural numbers
-  :math:`\leq` on the integers
-  :math:`\leq` on the rational numbers
-  :math:`\leq` on the real numbers

But keep in mind that :math:`\leq` is only a symbol; it can have unexpected interpretations as well. For example, all of the following are also partial orders:

-  :math:`\geq` on the natural numbers
-  :math:`\geq` on the integers
-  :math:`\geq` on the rational numbers
-  :math:`\geq` on the real numbers

These are not fully representative of the class of partial orders, in that they all have an additional property:

----

**Definition.** A partial order :math:`\leq` on a domain :math:`A` is a *total order* (also called a *linear order*) if it also has the following property:

-  for every :math:`a` and :math:`b` in :math:`A`, either :math:`a \leq b` or :math:`b \leq a`

----

You can check these these are two examples of partial orders that are not total orders:

-  the divides relation, :math:`x \mid y`, on the integers
-  the subset relation, :math:`x \subseteq y`, on sets of elements of some domain :math:`A`

On the integers, we also have the strict order relation, :math:`<`, which is not a partial order, since it is not reflexive. It is, rather, an instance of a *strict partial order*:

----

**Definition.** A binary relation :math:`<` on a domain :math:`A` is a *strict partial order* if it satisfies the following:

-  *irreflexivity*: :math:`a \nless a` for every :math:`a` in :math:`A`
-  *transitivity*: :math:`a < b` and :math:`b < c` implies :math:`a < c`, for every :math:`a`, :math:`b`, and :math:`c` in :math:`A`

A strict partial order is a *strict total order* (or *strict linear order*) if, in addition, we have the following property:

-  *trichotomy*: :math:`a < b`, :math:`a = b`, or :math:`a > b` for every :math:`a` and :math:`b` in :math:`A`

----

Here, :math:`b \nless a` means, of course, that it is not the case that :math:`a < b`, and :math:`a > b` is alternative notation for :math:`b < a`. To distinguish an ordinary partial order from a strict one, an ordinary partial order is sometimes called a *weak* partial order.

----

**Proposition**. A strict partial order :math:`<` on :math:`A` is *asymmetric*: for every :math:`a` and :math:`b`, :math:`a < b` implies :math:`b \nless a`.

**Proof**. Suppose :math:`a < b` and :math:`b < a`. Then, by transitivity, :math:`a < a`, contradicting irreflexivity.

----

On the integers, there are precise relationships between :math:`<` and :math:`\leq`: :math:`x \leq y` if and only if :math:`x < y` or :math:`x = y`, and :math:`x < y` if and only if :math:`x \leq y` and :math:`x \neq y`. This illustrates a more general phenomenon.

----

**Theorem.** Suppose :math:`\leq` is a partial order on a domain :math:`A`. Define :math:`a < b` to mean that :math:`a \leq b` and :math:`a \neq b`. Then :math:`<` is a strict partial order. Moreover, if :math:`\leq` is total, so is :math:`<`.

**Theorem.** Suppose :math:`<` is a strict partial order on a domain :math:`A`. Define :math:`a \leq b` to mean :math:`a < b` or :math:`a = b`. Then :math:`\leq` is a partial order. Moreover, if :math:`<` is total, so is :math:`\leq`.

----

We will prove the first here, and leave the second as an exercise. This proof is a nice illustration of how universal quantification, equality, and propositional reasoning are combined in a mathematical argument.

----

**Proof**. Suppose :math:`\leq` is a partial order on :math:`A`, and :math:`<` be defined as in the statement of the theorem. Irreflexivity is immediate, since :math:`a < a` implies :math:`a \neq a`, which is a contradiction.

To show transitivity, suppose :math:`a < b` and :math:`b < c`. Then we have :math:`a \leq b`, :math:`b \leq c`, :math:`a \neq b`, and :math:`b \neq c`. By the transitivity of :math:`\leq`, we have :math:`a \leq c`. To show :math:`a < c`, we only have to show :math:`a \neq c`. So suppose :math:`a = c`. then, from the hypotheses, we have :math:`c < b` and :math:`b < c`, violating asymmetry. So :math:`a \neq c`, as required.

To establish the last claim in the theorem, suppose :math:`\leq` is total, and let :math:`a` and :math:`b` be any elements of :math:`A`. We need to show that :math:`a < b`, :math:`a = b`, or :math:`a > b`. If :math:`a = b`, we are done, so we can assume :math:`a \neq b`. Since :math:`\leq` is total, we have :math:`a \leq b` or :math:`a \leq b`. Since :math:`a \neq b`, in the first case we have :math:`a < b`, and in the second case, we have :math:`a > b`.

----

More on Orderings
-----------------

Let :math:`\leq` be a partial order on a domain, :math:`A`, and let :math:`<` be the associated strict order, as defined in the last section. It is possible to show that if we go in the other direction, and define :math:`\leq'` to be the partial order associated to :math:`<`, then :math:`\leq` and :math:`\leq'` are the same, which is to say, for every :math:`a` and :math:`b` in :math:`A`, :math:`a \leq b` if and only if :math:`a \leq' b`. So we can think of every partial order as really being a pair, consisting of a weak partial order and an associated strict one. In other words, we can assume that :math:`x < y` holds if and only if :math:`x \leq y` and :math:`x \neq y`, and we can assume :math:`x \leq y` holds if and only if :math:`x < y` or :math:`x = y`.

We will henceforth adopt this convention. Given a partial order :math:`\leq` and the associated strict order :math:`<`, we leave it to you to show that if :math:`x \leq y` and :math:`y < z`, then :math:`x < z`, and, similarly, if :math:`x < y` and :math:`y \leq z`, then :math:`x < z`.

Consider the natural numbers with the less-than-or-equal relation. It has a least element, :math:`0`. We can express the fact that :math:`0` is the least element in at least two ways:

-  :math:`0` is less than or equal to every natural number.
-  There is no natural number that is less than :math:`0`.

In symbolic logic, we could formalize these statements as follows:

-  :math:`\forall x \; (0 \leq x)`
-  :math:`\forall x \; (x \nless 0)`

Using the existential quantifier, we could render the second statement more faithfully as follows:

-  :math:`\neg \exists x \; (x < 0)`

Notice that this more faithful statement is equivalent to the original, using deMorgan's laws for quantifiers.

Are the two statements above equivalent? Say an element :math:`y` is *minimum* for a partial order if it is less than or equal to any other element, that is, if it takes the place of 0 in the first statement. Say that an element :math:`y` is *minimal* for a partial order if no element is less than it, that is, if it takes the place of 0 in the second statement. Two facts are immediate.

----

**Theorem.** Any minimum element is minimal.

**Proof.** Suppose :math:`x` is minimum for :math:`\leq`. We need to show that :math:`x` is minimal, that is, for every :math:`y`, it is not the case that :math:`y < x`. Suppose :math:`y < x`. Since :math:`x` is minimum, we have :math:`x \leq y`. From :math:`y < x` and :math:`x \leq y`, we have :math:`y < y`, contradicting the irreflexivity of :math:`<`.

**Theorem.** If a partial order :math:`\leq` has a minimum element, it is unique.

**Proof.** Suppose :math:`x_1` and :math:`x_2` are both minimum. Then :math:`x_1 \leq x_2` and :math:`x_2 \leq x_1`. By antisymmetry, :math:`x_1 = x_2`.

----

Notice that we have interpreted the second theorem as the statement that if :math:`x_1` and :math:`x_2` are both minimum, then :math:`x_1 = x_2`. Indeed, this is exactly what we mean when we say that something is "unique." When a partial order has a minimum element :math:`x`, uniqueness is what justifies calling :math:`x` *the* minimum element. Such an :math:`x` is also called the *least* element or the *smallest* element, and the terms are generally interchangeable.

The converse to the second theorem -- that is, the statement that every minimal element is minimum -- is false. As an example, consider the nonempty subsets of the set :math:`\{ 1, 2 \}` with the subset relation. In other words, consider the collection of sets :math:`\{ 1 \}`, :math:`\{ 2 \}`, and :math:`\{1, 2\}`, where :math:`\{ 1 \} \subseteq \{1, 2\}`, :math:`\{ 2 \} \subseteq \{1, 2\}`, and, of course, every element is a subset of itself. Then you can check that :math:`\{1\}` and :math:`\{2\}` are each minimal, but neither is minimum. (One can also exhibit such a partial order by drawing a diagram, with dots labeled :math:`a`, :math:`b`, :math:`c`, etc., and upwards edges between elements to indicate that one is less than or equal to the other.)

Notice that the statement "a minimal element of a partial order is not necessarily minimum" makes an "existential" assertion: it says that there is a partial order :math:`\leq`, and an element :math:`x` of the domain, such that :math:`x` is minimal but not minimum. For a fixed partial order :math:`\leq`, we can express the assertion that such an :math:`x` exists as follows:

.. math::

   \exists x \; (\forall y \; (y \nless x) \wedge \forall y \; (x \leq y))

The assertion that there exists a domain :math:`A`, and a partial order :math:`\leq` on that domain :math:`A`, is more dramatic: it is a "higher order" existential assertion. But symbolic logic provides us with the means to make assertions like these as well, as we will see later on.

We can consider other properties of orders. An order is said to be *dense* if between any two distinct elements, there is another element. More precisely, an order is dense if, whenever :math:`x < y`, there is an element :math:`z` satisfying :math:`x < z` and :math:`z < y`. For example, the rational numbers are dense with the usual :math:`\leq` ordering, but not the integers. Saying that an order is dense is another example of an implicit use of existential quantification.

.. _equivalence_relations_and_equality:

Equivalence Relations and Equality
----------------------------------

In ordinary mathematical language, an *equivalence relation* is defined as follows.

----

**Definition**. A binary relation :math:`\equiv` on some domain :math:`A` is said to be an *equivalence relation* if it is reflexive, symmetric, and transitive. In other words, :math:`\equiv` is an equivalent relation if it satisfies these three properties:

-  *reflexivity*: :math:`a \equiv a`, for every :math:`a` in :math:`A`
-  *symmetry*: if :math:`a \equiv b`, then :math:`b \equiv a`, for every :math:`a` and :math:`b` in :math:`A`
-  *transitivity*: if :math:`a \equiv b` and :math:`b \equiv c`, then :math:`a \equiv c`, for every :math:`a`, :math:`b`, and :math:`c` in :math:`A`

----

We leave it to you to think about how you could write these statements in first-order logic. (Note the similarity to the rules for a partial order.) We will also leave you with an exercise: by a careful choice of how to instantiate the quantifiers, you can actually prove the three properties above from the following two:

-  :math:`\forall a \; (a \equiv a)`
-  :math:`\forall {a, b, c} \; (a \equiv b \wedge c \equiv b \to a \equiv c)`

Try to verify this using natural deduction or Lean.

These three properties alone are not strong enough to characterize equality. You should check that the following informal examples are all instances of equivalence relations:

-  the relation on days on the calendar, given by ":math:`x` and :math:`y` fall on the same day of the week"
-  the relation on people currently alive on the planet, given by ":math:`x` and :math:`y` have the same age"
-  the relation on people currently alive on the planet, given by ":math:`x` and :math:`y` have the same birthday"
-  the relation on cities in the United States, given by ":math:`x` and :math:`y` are in the same state"

Here are two common mathematical examples:

-  the relation on lines in a plane, given by ":math:`x` and :math:`y` are parallel"
-  for any fixed natural number :math:`m \geq 0`, the relation on natural numbers, given by ":math:`x` is congruent to :math:`y` modulo :math:`m`" (see :numref:`Chapter %s <elementary_number_theory>`) 

Here, we say that :math:`x` is congruent to :math:`y` modulo :math:`m` if they leave the same remainder when divided by :math:`m`. Soon, you will be able to prove rigorously that this is equivalent to saying that :math:`x - y` is divisible by :math:`m`.

Consider the equivalence relation on citizens of the United States, given by ":math:`x` and :math:`y` have the same age." There are some properties that respect that equivalence. For example, suppose I tell you that John and Susan have the same age, and I also tell you that John is old enough to vote. Then you can rightly infer that Susan is old enough to vote. On the other hand, if I tell you nothing more than the facts that John and Susan have the same age and John lives in South Dakota, you cannot infer that Susan lives in South Dakota. This little example illustrates what is special about the *equality* relation: if two things are equal, then they have exactly the same properties.

Let :math:`A` be a set and let :math:`\equiv` be an equivalence relation on :math:`A`. There is an important mathematical construction known as forming the *quotient* of :math:`A` under the equivalence relation. For every element :math:`a` in :math:`A`, let :math:`[a]` be the set of elements :math:`\{ c \mid c \equiv a \}`, that is, the set of elements of :math:`A` that are equivalent to :math:`a`. We call :math:`[a]` the equivalence class of :math:`A`. The set :math:`A / \mathord{\equiv}`, the *quotient of* :math:`A` *by* :math:`\equiv`, is defined to be the set :math:`\{ [a] : a \in A \}`, that is, the set of all the equivalence classes of elements in :math:`A`. The exercises below as you to show that if :math:`[a]` and :math:`[b]` are elements of such a quotient, then :math:`[a] = [b]` if and only if :math:`a \equiv b`.

The motivation is as follows. Equivalence tries to capture a weak notion of equality: if two elements of :math:`A` are equivalent, they are not necessarily the same, but they are similar in some way. Equivalence classes collect similar objects together, essentially glomming them into new objects.  Thus :math:`A / \mathord{\equiv}` is a version of the set :math:`A` where similar elements have been compressed into a single element. For example, given the equivalence relation :math:`\equiv` of congruence modulo 5 on the integers, :math:`\mathbb{N} / \mathord{\equiv}` is the set :math:`\{ [0], [1], [2], [3], [4] \}`, where, for example, :math:`[0]` is the set of all multiples of 5.

Exercises
---------

#. Suppose :math:`<` is a strict partial order on a domain :math:`A`, and define :math:`a \leq b` to mean that :math:`a < b` or :math:`a = b`.

   - Show that :math:`\leq` is a partial order.
   - Show that if :math:`<` is moreover a strict total order, then :math:`\leq` is a total order.

   (Above we proved the analogous theorem going in the other direction.)

#. Suppose :math:`<` is a strict partial order on a domain :math:`A`. (In other words, it is transitive and asymmetric.) Suppose that :math:`\leq` is defined so that :math:`a \leq b` if and only if :math:`a < b` or :math:`a = b`. We saw in class that :math:`\leq` is a partial order on a domain :math:`A`, i.e.~it is reflexive, transitive, and antisymmetric.

   Prove that for every :math:`a` and :math:`b` in :math:`A`, we have :math:`a < b` iff :math:`a \leq b` and :math:`a \neq b`, using the facts above.

#. An *ordered graph* is a collection of vertices (points), along with a collection of arrows between vertices. For each pair of vertices, there is at most one arrow between them: in other words, every pair of vertices is either unconnected, or one vertex is "directed" toward the other. Note that it is possible to have an arrow from a vertex to itself.

   Define a relation :math:`\leq` on the set of vertices, such that for two vertices :math:`a` and :math:`b`, :math:`a \leq b` means that there is an arrow from :math:`a` pointing to :math:`b`.

   On an arbitrary graph, is :math:`\leq` a partial order, a strict partial order, a total order, a strict total order, or none of the above? If possible, give examples of graphs where :math:`\leq` fails to have these properties.

#. Let :math:`\equiv` be an equivalence relation on a set :math:`A`. For every element :math:`a` in :math:`A`, let :math:`[a]` be the equivalence class of :math:`a`: that is, the set of elements :math:`\{ c \mid c \equiv a \}`. Show that for every :math:`a` and :math:`b`, :math:`[a] = [b]` if and only if :math:`a \equiv b`.

   (Hints and notes:

   -  Remember that since you are proving an \`\`if and only if'' statement, there are two directions to prove.
   -  Since that :math:`[a]` and :math:`[b]` are sets, :math:`[a] = [b]` means that for every element :math:`c`, :math:`c` is in :math:`[a]` if and only if :math:`c` is in :math:`[b]`.
   -  By definition, an element :math:`c` is in :math:`[a]` if and only if :math:`c \equiv a`. In particular, :math:`a` is in :math:`[a]`.)

#. Let the relation :math:`\sim` on the natural numbers :math:`\mathbb{B}` be defined as follows: if :math:`n` is even, then :math:`n \sim n+1`, and if :math:`n` is odd, then :math:`n \sim n-1`. Furthermore, for every :math:`n`, :math:`n \sim n`. Show that :math:`\sim` is an equivalence relation. What is the equivalence class of the number 5? Describe the set of equivalence classes :math:`\{ [n] \mid n \in \mathbb{N} \}`.

#. Show that the relation on lines in the plane, given by ":math:`l_1` and :math:`l_2` are parallel," is an equivalence relation. What is the equivalence class of the x-axis? Describe the set of equivalence classes :math:`\{ [l] \mid l\text{ is a line in the plane} \}`.

#. A binary relation :math:`\leq` on a domain :math:`A` is said to be a *preorder* it is is reflexive and transitive. This is weaker than saying it is a partial order; we have removed the requirement that the relation is asymmetric. An example is the ordering on people currently alive on the planet defined by setting :math:`x \leq y` if and only if :math:`x` 's birth date is earlier than :math:`y` 's. Asymmetry fails, because different people can be born on the same day. But, prove that the following theorem holds:

   .. TODO: set off

   **Theorem.** Let :math:`\leq` be a preorder on a domain :math:`A`. Define the relation :math:`\equiv`, where :math:`x \equiv y` holds if and only if :math:`x \leq y` and :math:`y \leq x`. Then :math:`\equiv` is an equivalence relation on :math:`A`.



