SET STATISTICS TIME ON;
 WITH Subordinates AS (
   SELECT
    c.id AS id,
    c.name AS name,
    s.name AS sub_name,
    s.id AS sub_id,
    0 AS sub_level
  FROM
    collaborators c
  JOIN
    subdivisions s ON c.subdivision_id = s.id
  WHERE
    c.id = 710253

  UNION ALL

  SELECT
    c.id AS id,
    c.name AS name,
    s.name AS sub_name,
    s.id AS sub_id,
    Subordinates.sub_level + 1 AS sub_level
  FROM
    collaborators c
  JOIN
    subdivisions s ON c.subdivision_id = s.id
  JOIN
    Subordinates ON s.parent_id = Subordinates.sub_id
  WHERE
    c.age < 40
    AND s.id NOT IN (100055, 100059)
)

 SELECT 
  Subordinates.id,
  Subordinates.name,
  Subordinates.sub_name,
  Subordinates.sub_id,
  Subordinates.sub_level,
  COUNT(*) AS colls_count
FROM
  Subordinates
GROUP BY
  Subordinates.id,
  Subordinates.name,
  Subordinates.sub_name,
  Subordinates.sub_id,
  Subordinates.sub_level
ORDER BY
  Subordinates.sub_level;
 SET STATISTICS TIME OFF;
