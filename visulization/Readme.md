# output格式说明
output.txt 保存了一个矩阵，行数为路段数*2，分别用来表示该路段不同方向的流量。列数为路段数。元素值为流量值。
生成程序为 D:\Github\volume-prediction\src\main\java\Test\ReformatData.java

# reformatedData 数据说明
为了将数据用matlab可视化，需将流量值按照时间和路段编号分开。为了方便处理，将原数据导入数据库重新按照路段标号、时间、方向等字段进行排序并导出。

```sql
CREATE TABLE new_table (SELECT * FROM `g15_20170910` ORDER BY SegmentId, Direction,Time)
```