# SQL manage company

## Create database

```SQL
drop database if exists company_db;
create database company_db;
use company_db;
```

## Create tables

### Drop tables if exists before create new

```SQL
drop table if exists assignment;
drop table if exists relatives;
drop table if exists staff;
drop table if exists project;
drop table if exists department;
```

### Create tables

Table `staffs`'s description:
| Field         | Type         | Null | Key | Default | Extra          |
| ------------- | ------------ | ---- | --- | ------- | -------------- |
| id            | bigint       | NO   | PRI | NULL    | auto_increment |
| name          | varchar(255) | NO   |     | NULL    |                |
| birthday      | date         | NO   |     | NULL    |                |
| address       | varchar(255) | NO   |     | NULL    |                |
| gender        | varchar(7)   | NO   |     | NULL    |                |
| salary        | int          | NO   |     | NULL    |                |
| department_id | varchar(255) | NO   |     | NULL    |                |

Table `relatives`'s description:
| Field    | Type         | Null | Key | Default | Extra          |
| -------- | ------------ | ---- | --- | ------- | -------------- |
| id       | bigint       | NO   | PRI | NULL    | auto_increment |
| staff_id | bigint       | NO   | MUL | NULL    |                |
| name     | varchar(255) | NO   |     | NULL    |                |
| gender   | varchar(7)   | NO   |     | NULL    |                |
| birthday | date         | NO   |     | NULL    |                |
| relation | varchar(255) | NO   |     | NULL    |                |

Table `departments`'s description:
| Field    | Type         | Null | Key | Default | Extra          |
| -------- | ------------ | ---- | --- | ------- | -------------- |
| id       | bigint       | NO   | PRI | NULL    | auto_increment |
| location | varchar(255) | NO   |     | NULL    |                |

Table `projects`'s description:
| Field    | Type         | Null | Key | Default | Extra          |
| -------- | ------------ | ---- | --- | ------- | -------------- |
| id       | bigint       | NO   | PRI | NULL    | auto_increment |
| name     | varchar(255) | NO   |     | NULL    |                |
| location | varchar(255) | NO   |     | NULL    |                |
| dep_id   | bigint       | NO   | MUL | NULL    |                |

Table `assignments`'s description:
| Field      | Type   | Null | Key | Default | Extra |
| ---------- | ------ | ---- | --- | ------- | ----- |
| staff_id   | bigint | NO   | PRI | NULL    |       |
| project_id | bigint | NO   | PRI | NULL    |       |
| days       | int    | NO   |     | NULL    |       |

## Insert data to tables

Table `staffs`'s data:
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 20000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |

Table `relatives`'s data:
| id  | staff_id | name               | gender | birthday   | relation |
| --- | -------- | ------------------ | ------ | ---------- | -------- |
| 1   | 1        | Nguyen Thi Yen Nhu | Female | 2001-09-26 | Spouse   |
| 2   | 1        | Le Cong Phuoc      | Male   | 1960-05-01 | Father   |
| 3   | 1        | Phan Thi Anh Tho   | Male   | 1968-04-02 | Mother   |
| 4   | 2        | Le Cong Minh Khoi  | Male   | 2001-08-28 | Spouse   |
| 5   | 3        | Do Dao Thien An    | Female | 2002-05-12 | Cousin   |

Table `apartments`'s data:
| id  | location   |
| --- | ---------- |
| 1   | District 7 |
| 2   | Nha Be     |
| 3   | District 5 |
| 4   | District 8 |
| 5   | Go Vap     |

Table `projects'`'s data:
| id  | name                      | location    | dep_id |
| --- | ------------------------- | ----------- | ------ |
| 1   | Sql Final                 | Ho Chi Minh | 1      |
| 2   | Probability And Statistic | Ho Chi Minh | 5      |
| 3   | Discrete Structure        | Ho Chi Minh | 1      |
| 4   | Marxism                   | Long An     | 2      |
| 5   | English                   | Long An     | 3      |

Table `assignments'`'s data:
| staff_id | project_id | days |
| -------- | ---------- | ---- |
| 1        | 1          | 14   |
| 1        | 3          | 14   |
| 2        | 1          | 14   |
| 2        | 5          | 7    |
| 4        | 2          | 14   |

## Select data from tables

List of the project with the most staffs:
| id  | name      | location     | dep_id | total_staffs |
| --- | --------- | ------------ | ------ | ------------ |
| 1   | Sql Final | Ho Chi Minh1 | 1      | 2            |

Lists all staffs and project codes that the staff is involved in, if the staff hasn't joined any projects, the Project Code column is empty (null):
| id  | name               | birthday   | address     | gender | salary   | department_id | project_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- | ---------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             | 1          |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             | 3          |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             | 1          |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             | 5          |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 20000000 | 5             | Null       |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             | 2          |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             | Null       |

## Create functions

### Function that returns the number of projects an staff has participated in. Given staff id

```SQL
create function num_projects_participated (id bigint) 
returns int 
begin
    declare num int;
    set num = (
        select count(*)
        from assignment
        where id = id
    );
    return num;
end
```

Select number of projects that staff Le Cong Minh Khoi has participated in:

```SQL
select num_projects_participated(1);
```

Result:
| num_projects_participated(1) |
| ---------------------------- |
5

## Create procedures

### Procedure that returns a list of: staff id, staff name, staff"s relative name, total number of projects participated, total time spent participating

```SQL
create procedure staff_info ()
begin
    select staff.id, staff.name, relatives.name, a.num_projects, a.num_days_spent
    from staff
        left outer join relatives on staff.id = relatives.staff_id
        left outer join (
            select staff.id, count(assignment.project_id) num_projects, sum(assignment.days) num_days_spent
            from staff
            inner join assignment on assignment.staff_id = staff.id
            inner join project on project.id = assignment.project_id
            group by staff.id
        ) a on a.id = staff.id
    order by a.num_projects desc, a.num_days_spent;
end 
```

Result when call procedure `staff_info`:
| id  | name               | name               | num_projects | num_days_spent |
| --- | ------------------ | ------------------ | ------------ | -------------- |
| 1   | Le Cong Minh Khoi  | Nguyen Thi Yen Nhu | 2            | 28             |
| 1   | Le Cong Minh Khoi  | Le Cong Phuoc      | 2            | 28             |
| 1   | Le Cong Minh Khoi  | Phan Thi Anh Tho   | 2            | 28             |
| 2   | Nguyen Thi Yen Nhu | Le Cong Minh Khoi  | 2            | 21             |
| 3   | Do Dao Truc Quyen  | Do Dao Thien An    | Null         | Null           |
| 4   | Nguyen Duc Trong   | Null               | 1            | 14             |
| 5   | Phu Huu Chi Trung  | Null               | Null         | Null           |

### Procedure add staff if department exists, else raise error

```SQL
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
                from department
                where id = department_id) then
        insert into staff (name, birthday, address, gender, salary, department_id)
        values (name, birthday, address, gender, salary, department_id);
    else
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department not found';
    end if;
end
```

Table `staffs` before insert new staff:
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 20000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |

Add staff with procedure `add_staff`

```SQL
call add_staff ("Le Tuong Vy", "2001-04-30", "Binh Thanh", "Female", 20000000, 4);
call add_staff ("Hoang Hao Hiep", "2001-08-21", "Binh Phuoc", "Male", 24000000, 6);
```

As expected, there no department have id 6 so it will raise error

```SQL
call add_staff ("Hoang Hao Hiep", "2001-08-21", "Binh Phuoc", "Male", 24000000, 6)
Error Code: 1644. Department not found
```

Table `staffs` after execute procedure

| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 20000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |
| 6   | Le Tuong Vy        | 2001-04-30 | Binh Thanh  | Female | 20000000 | 4             |

### Procedure increase salary based on number of relatives

Increase 20.000.000 if this staff have equal or more than 3 relatives, 10.000.000 for staff have at least 1 relative, else 0

```SQL
create procedure increase_salary ()
begin
    drop table if exists temp_table;
    CREATE TEMPORARY TABLE temp_table (id bigint,
                                        total_relative int);

    insert into temp_table (id, total_relative)
        select
            staff.id, count(relatives.name) total_relative
        from staff
        inner join relatives on relatives.staff_id = staff.id
        group by staff.id;

    update staff set salary = salary + 20000000 
    where exists (
        select id
        from temp_table a
        where a.total_relative >= 3 and staff.id = a.id
    );

    update staff set salary = salary + 10000000 
    where exists (
        select id
        from temp_table a
        where a.total_relative > 0 and a.total_relative < 3 and staff.id = a.id
    );
end
```

Table `staffs` before execute procedure
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 30000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 25000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 20000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |
| 6   | Le Tuong Vy        | 2001-04-30 | Binh Thanh  | Female | 20000000 | 4             |

Table `staffs` after execute procedure
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 50000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 35000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 30000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |
| 6   | Le Tuong Vy        | 2001-04-30 | Binh Thanh  | Female | 20000000 | 4             |

## Create triggers

### Prevent delete staff if they have relatives

```SQL
create trigger remove_staff before delete on staff
for each row
begin
    if exists (select *
                from relatives
                where staff_id = old.id) then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Staff can't be deleted because he/she has relatives";
    end if;
end
```

Table `staffs` before deleting staff with trigger
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 50000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 35000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 30000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 5   | Phu Huu Chi Trung  | 1990-06-18 | Ninh Thuan  | Male   | 25000000 | 1             |
| 6   | Le Tuong Vy        | 2001-04-30 | Binh Thanh  | Female | 20000000 | 4             |

Execute triggers

```SQL
delete from staff where id = 5;
delete from staff where id = 3;
```

Raise error if this staff has relatives and try don't delete

```SQL
delete from staff where id = 3
Error Code: 1644. Staff can't be deleted because he/she has relatives
```

Table `staffs` after deleting staff with trigger
| id  | name               | birthday   | address     | gender | salary   | department_id |
| --- | ------------------ | ---------- | ----------- | ------ | -------- | ------------- |
| 1   | Le Cong Minh Khoi  | 2001-08-28 | Long An     | Male   | 50000000 | 1             |
| 2   | Nguyen Thi Yen Nhu | 2001-09-26 | Long An     | Female | 35000000 | 2             |
| 3   | Do Dao Truc Quyen  | 2001-12-09 | Ho Chi Minh | Female | 30000000 | 5             |
| 4   | Nguyen Duc Trong   | 2001-05-02 | Ho Chi Minh | Male   | 29000000 | 4             |
| 6   | Le Tuong Vy        | 2001-04-30 | Binh Thanh  | Female | 20000000 | 4             |

### Only staffs >= 30 years old can participate in the project for 100 days or more

```SQL
create trigger nomore30100 before insert on assignment 
for each row
begin
    if not ((select datediff(day, birthday, getdate())/365
        from staff
        where id = id) >= 30 or days < 100) then
        insert into assignment
        values(id, project_id, days);
    else 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "only accept for people who is over 30 for 100 days project";
    end if;
end
```
