-- Data Analysis Queries

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
-- employees: emp_no, last_name, first_name, sex
-- salaries: emp_no, salary
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
	inner join salaries as s
	on e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- employees: first_name, last_name, hire_date
-- filter: 1986
select first_name, last_name, hire_date
from employees as e
where extract (year from hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- dept_manager: dept_no, emp_no
-- departments: dept_no, dept_name
-- employees: emp_no, last_name, first_name
select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from dept_manager as dm
	inner join departments as d
	on dm.dept_no = d.dept_no
		inner join employees as e
		on dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
-- dept_emp: emp_no, dept_no
-- employees: emp_no, last_name, first_name
-- departments: dept_no, dept_name
CREATE VIEW emps_depts as
select de.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
from dept_emp as de
	inner join employees as e
	on de.emp_no = e.emp_no
		inner join departments as d
		on de.dept_no = d.dept_no;

-- 5. List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
-- employees: first_name, last_name, sex
-- filter: Hercules, B
select first_name, last_name, sex
from employees
where (first_name = 'Hercules') and (last_name like 'B%');

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
-- view emps_depts: emp_no, last_name, first_name, dept_name
-- filter: Sales
select emp_no, last_name, first_name, dept_name
from emps_depts
where dept_name = 'Sales';
	
-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- view emp_depts: emp_no, last_name, first_name, dept_name
-- filter: Sales and Development
select emp_no, last_name, first_name, dept_name
from emps_depts
where dept_name in ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
-- employees: last_name
-- count frequency
select last_name, count (last_name) as frequency
from employees
group by last_name
order by frequency desc;