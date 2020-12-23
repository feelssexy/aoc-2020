import tables

var ta: Table[int, Table[int, string]]

ta[1] = initTable[int, string]()

echo ta[1] == initTable[int, string]()

echo 2 * 4

#echo {"a": 1, "b": 2, "a", 3}.toOpenArray

let a = @[("a", 1), ("b", 2), ("a", 3)]
echo typeof a