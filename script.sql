-- * drop database if exist and create a new one
drop database if exists company_db;
create database company_db;
use company_db;


-- * drop tables if exist
drop table if exists assignments;
drop table if exists relatives;
drop table if exists staffs;
drop table if exists projects;
drop table if exists departments;


-- * create tables
CREATE TABLE staffs (
    id BIGINT AUTO_INCREMENT NOT NULL,
    name varchar(255) NOT NULL,
    birthday DATE NOT NULL,
    address varchar(255) NOT NULL,
    gender varchar(7) NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY (id),
    department_id varchar(255) NOT NULL
);

CREATE TABLE relatives (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    staff_id BIGINT NOT NULL,
    name varchar(255) NOT NULL,
    gender varchar(7) NOT NULL,
    birthday DATE NOT NULL,
    relation varchar(255) NOT NULL,
    FOREIGN KEY (staff_id)
        REFERENCES staffs (id)
);

CREATE TABLE departments (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    location varchar(255) NOT NULL
);

CREATE TABLE projects (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name varchar(255) NOT NULL,
    location varchar(255) NOT NULL,
    dep_id BIGINT NOT NULL,
    FOREIGN KEY (dep_id)
        REFERENCES departments (id)
);

CREATE TABLE assignments (
    staff_id BIGINT NOT NULL,
    project_id BIGINT NOT NULL,
    days INT NOT NULL,
    PRIMARY KEY (staff_id , project_id),
    FOREIGN KEY (staff_id)
        REFERENCES staffs (id)
);


-- * insert data
insert into departments (location)
values
    ("District 7"),
    ("Nha Be"),
    ("District 5"),
    ("District 8"),
    ("Go Vap");
    
insert into staffs (name, birthday, address, gender, salary, department_id)
values
    ("Le Cong Minh Khoi", "2001-08-28", "Long An", "Male", "30000000", 1),
    ("Nguyen Thi Yen Nhu" , "2001-09-26", "Long An", "Female", "25000000", 2),
    ("Do Dao Truc Quyen", "2001-12-9", "Ho Chi Minh", "Female", "20000000", 5),
    ("Nguyen Duc Trong", "2001-05-02", "Ho Chi Minh" , "Male", "29000000", 4),
    ("Phu Huu Chi Trung", "1990-06-18", "Ninh Thuan", "Male", "25000000", 1);

insert into relatives (staff_id, name, gender, birthday, relation)
values
    (1, "Nguyen Thi Yen Nhu", "Female", "2001-09-26", "Spouse"),
    (1, "Le Cong Phuoc", "Male", "1960-05-01", "Father"),
    (1, "Phan Thi Anh Tho", "Male", "1968-04-02", "Mother" ),
    (2, "Le Cong Minh Khoi", "Male", "2001-08-28", "Spouse" ),
    (3, "Do Dao Thien An" , "Female", "2002-05-12", "Cousin");

insert into projects (name, location, dep_id)
values
    ("Sql Final", "Ho Chi Minh", 1) ,
    ("Probability And Statistic", "Ho Chi Minh", 5) ,
    ("Discrete Structure" , "Ho Chi Minh", 1),
    ("Marxism", "Long An", 2),
    ("English", "Long An", 3);

insert into assignments (staff_id, project_id, days)
values
    (1, 1, 14),
    (2, 5, 7),
    (1, 3, 14),
    (2, 1, 14),
    (4, 2, 14);


-- * select data
-- List of the projects with the most employees
SELECT 
    projects.*, a.total_staffs
FROM
    projects
INNER JOIN
    (SELECT 
        project_id, COUNT(staff_id) total_staffs
    FROM
        assignments
    GROUP BY project_id
    ORDER BY total_staffs DESC
    LIMIT 1) a 
ON a.project_id = projects.id;

-- Lists all staffs and projects codes that the staffs is involved in, if the staffs hasn't joined any projects, the projects Code column is empty (null).
SELECT 
    staffs.*, assignments.project_id
FROM
    staffs
        LEFT OUTER JOIN
    assignments ON assignments.staff_id = staffs.id;


-- * function
-- drop functions if exists
drop function if exists num_projects_participated;
drop function if exists staff_info;

-- function that returns the number of projects an staffs has participated in. Given: Function with an input is staffs id
DELIMITER //
create function num_projects_participated (id bigint) 
returns int 
begin
    declare num int;
    set num = (
		select count(*)
        from assignments
        where id = id
    );
    return num;
end // 
DELIMITER ;
-- call function
select num_projects_participated(1);


-- * procedures
-- drop procedures if exists
drop procedure if exists add_staff;
drop procedure if exists increase_salary;

-- procedure that returns a list of: staffs id, staffs name, staffs"s relative name, total number of projects participated, total time spent participating
-- sort: num_of_projects desc, total_time_spent asc
DELIMITER //
create procedure staff_info ()
begin
    select staffs.id, staffs.name, relatives.name, a.num_projects, a.num_days_spent
    from staffs
        left outer join relatives on staffs.id = relatives.staff_id
        left outer join (
			select staffs.id, count(assignments.project_id) num_projects, sum(assignments.days) num_days_spent
			from staffs
            inner join assignments on assignments.staff_id = staffs.id
            inner join projects on projects.id = assignments.project_id
			group by staffs.id
		) a on a.id = staffs.id
    order by a.num_projects desc, a.num_days_spent;
end 
//
DELIMITER ;
-- call procedure
call staff_info();

-- procedure add staffs if departments exists, else raise error
DELIMITER //
create procedure add_staff
    (
    name varchar(255),
    birthday datetime,
    address varchar(255),
    gender varchar(7),
    salary int,
    department_id varchar(255)
    )
begin
    if exists (select *
				from departments
				where id = department_id) then
        insert into staffs (name, birthday, address, gender, salary, department_id)
		values (name, birthday, address, gender, salary, department_id);
    else
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'departments not found';
	end if;
end //
DELIMITER ;
-- execute procedure
-- Expectation: staffs Le Tuong Vy wi be added, Hoang Hao Hiep won't be because no departments has id = 6
call add_staff ("Le Tuong Vy", "2001-04-30", "Binh Thanh", "Female", 20000000, 4);
call add_staff ("Hoang Hao Hiep", "2001-08-21", "Binh Phuoc", "Male", 24000000, 6);
select * from staffs;

-- procedure increase salary based on number of relatives
DELIMITER //
create procedure increase_salary ()
begin
	drop table if exists temp_table;
    CREATE TEMPORARY TABLE temp_table (id bigint,
									   total_relative int);

    insert into temp_table (id, total_relative)
		select
			staffs.id, count(relatives.name) total_relative
		from staffs
		inner join relatives on relatives.staff_id = staffs.id
		group by staffs.id;

    update staffs set salary = salary + 20000000 
    where exists (
		select id
		from temp_table a
		where a.total_relative >= 3 and staffs.id = a.id
	);

    update staffs set salary = salary + 10000000 
    where exists (
		select id
		from temp_table a
		where a.total_relative > 0 and a.total_relative < 3 and staffs.id = a.id
    );
end //
DELIMITER ;
-- execute procedure
select * from staffs;
call increase_salary();
select * from staffs;


-- * triggers
-- drop triggers if exists
drop trigger if exists remove_staff;
drop trigger if exists nomore30100 ;

-- trigger prevent delete staffs if they have relatives
DELIMITER //
create trigger remove_staff before delete on staffs
for each row
begin
	if exists (select *
				from relatives
				where staff_id = old.id) then
	   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'staffs can\'t be deleted because he/she has relatives';
    end if;
end //
DELIMITER ;
-- execute trigger
-- expectation: staffs 3 won't be delete and staffs 5 will be
select * from staffs;
delete from staffs where id = 5;
delete from staffs where id = 3;
select * from staffs;

-- Add data to the assignments table according to the following constraints: only staffs >= 30 years old can participate in the projects for 100 days or more
DELIMITER //
create trigger nomore30100 before insert on assignments 
for each row
begin
	if not ((select datediff(day, birthday, getdate())/365
			from staffs
			where id = id) >= 30 or days < 100) then
		insert into assignments
		values(id, project_id, days);
    else 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "only accept for people who is over 30 for 100 days projects";
    end if;
end //
DELIMITER ;