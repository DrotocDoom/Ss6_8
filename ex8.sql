

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE orderinfo(
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount NUMERIC(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

SELECT
    c.name,
    sum(o.total_amount) total_spending
FROM customer c
INNER JOIN orderinfo o on c.id = o.customer_id
GROUP BY c.id
ORDER BY total_spending DESC;



SELECT
    c.name,
    SUM(o.total_amount) AS total_spending
FROM customer c
         JOIN orderinfo o
              ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_spending)
    FROM (
             SELECT SUM(total_amount) AS customer_spending
             FROM orderinfo
             GROUP BY customer_id
         ) t
);

SELECT
    c.id,
    c.name
FROM customer c
         LEFT JOIN orderinfo o
ON c.id = o.customer_id
WHERE o.id IS NULL;

SELECT
    c.name,
    SUM(o.total_amount) AS total_spending
FROM customer c
JOIN orderinfo o
              ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_amount) = (
    SELECT AVG(customer_spending)
    FROM (
             SELECT SUM(total_amount) AS customer_spending
             FROM orderinfo
             GROUP BY customer_id
         ) t
);
