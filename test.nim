import tables

var ta: Table[int, Table[int, string]]

ta[1] = initTable[int, string]()

echo ta[1] == initTable[int, string]()

echo 2 * 4