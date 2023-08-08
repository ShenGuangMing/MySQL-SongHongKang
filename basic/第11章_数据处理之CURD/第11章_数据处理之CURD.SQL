COMMIT;
SET AUTOCOMMIT = false;

UPDATE employees
set last_name = 'SGMing'
WHERE employee_id = 100;

ROLLBACK;

SELECT *
FROM employees
WHERE employee_id = 100;
