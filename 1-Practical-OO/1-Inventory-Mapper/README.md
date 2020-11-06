# Inventory Mapper

## Description

It's time to count inventory in our store so we can account for the unsold products of the past month. Products in our store are made up of parts. Each product part has a unique identifier (part ID). The part ID is always a single alpha-numeric character. Some products are only made up of one part, while others require multiple parts to be considered complete.

Parts are never shared between products. They can only belong to at most 1 product.

### Shelf:

**_Each unit is considered complete_**

- **Full unit**: part ID = `"a"`

### Stool:

**_For a stool to be complete, it requires 1 top and 3 legs_**

- **Top**: part ID = `"b"`
- **Legs**: part ID = `"c"`

### Table:

**_For a table to be complete, it requires 1 top and 4 legs_**

- **Top**: part ID = `"d"`
- **Legs**: part ID = `"e"`

## Behaviour

Your mission: create a function that maps the quantity of each complete product.

The input should be a string of part IDs (no commas or any other separator characters. Eg: `"abcde"`
The output should show a list of quantities for each complete product. It's OK to have left over parts if they cannot form a complete product. Unrecognized parts (not belonging to a product) are also OK to ignore.

Your solution should work for any length and combination of part IDs.

## Input/Output Expectations

Here is a list of input/output examples:

```
"abccc" => {"Shelf" : 1, "Stool": 1, "Table": 0}
"beceadee" => {"Shelf" : 1, "Stool": 0, "Table": 1}
"eebeedebaceeceedeceacee" => {"Shelf" : 2, "Stool": 1, "Table": 2}
"zabc" => {"Shelf" : 1, "Stool" : 0, "Table" : 0}
"deeedeee" => {"Shelf" : 0, "Stool" : 0, "Table" : 1}
```
