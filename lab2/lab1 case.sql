SELECT baskets.id,
       CASE WHEN id = 1 THEN 'one'
            WHEN id = 2 THEN 'two'
            ELSE 'other'
       END
    FROM baskets;