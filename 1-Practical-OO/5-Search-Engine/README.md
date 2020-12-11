# Search Engine

Implement a very simple full-text search engine on the included `products_small.json`.
Public link available for the candidate [here.json](https://storage.googleapis.com/pair-programming/search/products_small.json)
or [here.csv](https://storage.googleapis.com/pair-programming/search/products_small.csv).

The goal of a full-text search engine is to optimize lookups of items by string tokens,
often at the expense of pre-processing the data and using lots of memory (i.e. the same
data stored in multiple different ways).

**If using this problem for an experienced search engineer**, expect them to already know
and understand the concept of an 'inverted index'.

> An inverted index is essentially a map from each 'word' (also called a 'token')
> in the text back to the IDs of the items which contained that word.

A simple Ruby implementation of an inverted index (see the solutions directory
for a complete example):

```ruby
inverted_index = {}
[
  { id: 1, name: "aerodynamic steel keyboard" },
  { id: 2, name: "enormous steel bag" },
].each do |product|
  product[:name].split.each do |token|
    inverted_index[token] ||= []
    inverted_index[token] << product[:id]
  end
end

inverted_index["steel"]
# => [1, 2]

inverted_index["steel"] & inverted_index["bag"]
# => [1]
```

**If using this problem with someone who has not worked with search before**, you may let
them come up with their own solution. Common solutions are maps (like above) or tries (a.k.a. prefix trees).

The progressions for this challenge are:

1. Implement a simple and fast way to find all product names that match `keyboard` (note that we are only asking to match the product names and not other fields, such as material or description)
2. Implement `AND` conditions, e.g. `steel keyboard` should match only item names which contain **both** `steel` and `keyboard` somewhere (not necessarily in that order)
3. Implement `OR` conditions, e.g. `steel keyboard` should match item names `steel table` and `wooden keyboard` because they each contain one of our search terms
4. [stretch goal] Implement numeric range queries, e.g. `steel keyboard` that are priced between $40 and $70
5. [stretch goal alternative] Implement TF-IDF scoring. This could be an alternative to (4), or in addition to. This would most likely only be relevant for people already familiar with search.
6. [stretch goal alternative] Search another field, and optionally score higher
   if it matches more than one field.

For especially (4) there are many approaches. In my solution I've chosen to use a different
data-structure for the text and numeric indexes, and then intersecting them.
Some candidates may choose to index the integers as a string by e.g.
representing `43` and `40` as `4*` and then do a filter when you've narrowed it
down. Both are perfectly valid, and there may be others too.

During a session, you can ask follow-up questions like:

- What data structure did you choose for the product list? Why?
- How would you design this differently if you knew there would be a million products?
- What happens when we want to add, update, or delete a product in the list?
- What if we wanted to also search other fields, such as material, color, and description?
- In this problem, we returned all the matches, but did not put them in any special order. How do you think search engines might tackle ordering the results?
