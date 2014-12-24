-- wipe db for clean build
drop table if exists resource;
drop table if exists section;
drop table if exists enum_section_type;
drop table if exists enum_resource_type;
drop table if exists verb_plan_map;
drop table if exists verb;
drop table if exists plan;
drop table if exists proc_standard;
drop view if exists tek_summary_6;
drop view if exists tek_summary_7;
drop table if exists tek_summary;
drop table if exists tek;
drop table if exists tek_parent;
drop table if exists grade;

-- tek parent
create table tek_parent (
    id int(10) unsigned not null auto_increment,
    section tinyint not null,
    topic varchar(60) not null,
    grade tinyint not null,
    content text not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- tek parent data
insert into tek_parent (section, topic, grade, content) values 
    (2, 'Number and operations', 6, 'The student applies mathematical process standards to represent and use rational numbers in a variety of forms. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (3, 'Number and operations', 6, 'The student applies mathematical process standards to represent addition, subtraction, multiplication, and division while solving problems and justifying solutions. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (4, 'Proportionality', 6, 'The student applies mathematical process standards to develop an understanding of proportional relationships in problem situations. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (5, 'Proportionality', 6, 'The student applies mathematical process standards to solve problems involving proportional relationships. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (6, 'Expressions, equations, and relationships', 6, 'The student applies mathematical process standards to use multiple representations to describe algebraic relationships. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (7, 'Expressions, equations, and relationships', 6, 'The student applies mathematical process standards to develop concepts of expressions and equations. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (8, 'Expressions, equations, and relationships', 6, 'The student applies mathematical process standards to use geometry to represent relationships and solve problems. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (9, 'Expressions, equations, and relationships', 6, 'The student applies mathematical process standards to use equations and inequalities to represent situations. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (10, 'Expressions, equations, and relationships', 6, 'The student applies mathematical process standards to use equations and inequalities to solve problems. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (11, 'Measurement and data', 6, 'The student applies mathematical process standards to use coordinate geometry to identify locations on a plane. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (12, 'Measurement and data', 6, 'The student applies mathematical process standards to use numerical or graphical representations to analyze problems. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (13, 'Measurement and data', 6, 'The student applies mathematical process standards to use numerical or graphical representations to solve problems. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (14, 'Personal financial literacy', 6, 'The student applies mathematical process standards to develop an economic way of thinking and problem solving useful in one\’s life as a knowledgeable consumer and investor. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (2, 'Number and operations', 7, 'The student applies mathematical process standards to represent and use rational numbers in a variety of forms. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (3, 'Number and operations', 7, 'The student applies mathematical process standards to add, subtract, multiply, and divide while solving problems and justifying solutions. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (4, 'Proportionality', 7, 'The student applies mathematical process standards to represent and solve problems involving proportional relationships. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (5, 'Proportionality', 7, 'The student applies mathematical process standards to use geometry to describe or solve problems involving proportional relationships. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (6, 'Proportionality', 7, 'The student applies mathematical process standards to use probability and statistics to describe or solve problems involving proportional relationships. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (7, 'Expressions, equations, and relationships', 7, 'The student applies mathematical process standards to represent linear relationships using multiple representations. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (9, 'Expressions, equations, and relationships', 7, 'The student applies mathematical process standards to solve geometric problems. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (10, 'Expressions, equations, and relationships', 7, 'The student applies mathematical process standards to use one-variable equations and inequalities to represent situations. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (11, 'Expressions, equations, and relationships', 7, 'The student applies mathematical process standards to solve one-variable equations and inequalities. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (12, 'Measurement and data', 7, 'The student applies mathematical process standards to use statistical representations to analyze data. The student is expected to');
insert into tek_parent (section, topic, grade, content) values 
    (13, 'Personal financial literacy', 7, 'The student applies mathematical process standards to develop an economic way of thinking and problem solving useful in one\’s life as a knowledgeable consumer and investor. The student is expected to');


-- tek
create table tek (
    id int(10) unsigned not null auto_increment,
    tek_parent_id int(10) unsigned not null,
    alpha varchar(4) not null,
    standard varchar(4) not null,
    content varchar(255) not null,
    primary key (id),
    KEY FK_tek_tek_parent (tek_parent_id),
    constraint FK_tek_tek_parent foreign key (tek_parent_id) references tek_parent (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- tek data
insert into tek (tek_parent_id, alpha, standard, content) values 
    (1, 'A', 'S', 'classify whole numbers, integers, and rational numbers using a visual representation such as a Venn diagram to describe relationships between sets of numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (1, 'B', 'S', 'identify a number, its opposite, and its absolute value');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (1, 'C', 'S', 'locate, compare, and order integers and rational numbers using a number line');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (1, 'D', 'R', 'order a set of rational numbers arising from mathematical and real- world contexts');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (1, 'E', 'S', 'extend representations for division to include fraction notation such as a/b represents the same number as a ÷ b where b ≠ 0');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'C', 'S', 'give examples of ratios as multiplicative comparisons of two quantities describing the same attribute');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'D', 'S', 'give examples of rates as the comparison by division of two quantities having different attributes, including rates as quotients');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'E', 'S', 'represent ratios and percents with concrete models, fractions, and decimals');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'F', 'S', 'represent benchmark fractions and percents such as 1%, 10%, 25%, 33 1/3%, and multiples of these values using 10 by 10 grids, strip diagrams, number lines, and numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'G', 'R', 'generate equivalent forms of fractions, decimals, and percents using real-world problems, including problems that involve money');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (4, 'C', 'S', 'use equivalent fractions, decimals, and percents to show equal parts of the same whole');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (6, 'A', 'R', 'generate equivalent numerical expressions using order of operations, including whole number exponents, and prime factorization');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (6, 'B', 'S', 'distinguish between expressions and equations verbally, numerically, and algebraically');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (6, 'C', 'S', 'determine if two expressions are equivalent using concrete models, pictorial models, and algebraic representations');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (6, 'D', 'R', 'generate equivalent expressions using the properties of operations: inverse, identity, commutative, associative, and distributive properties');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (2, 'A', 'S', 'recognize that dividing by a rational number and multiplying by its reciprocal result in equivalent values');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (2, 'B', 'S', 'determine, with and without computation, whether a quantity is increased or decreased when multiplied by a fraction, including values greater than or less than one');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (2, 'C', 'S', 'represent integer operations with concrete models and connect the actions with the models to standardized algorithms');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (2, 'D', 'R', 'add, subtract, multiply, and divide integers fluently');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (2, 'E', 'R', 'multiply and divide positive rational numbers fluently');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'A', 'S', 'compare two rules verbally, numerically, graphically, and symbolically in the form of y = ax or y = x + a in order to differentiate between additive and multiplicative relationships');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'B', 'R', 'apply qualitative and quantitative reasoning to solve prediction and comparison of real-world problems involving ratios and rates');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (4, 'A', 'S', 'represent mathematical and real-world problems involving ratios and rates using scale factors, tables, graphs, and proportions');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (4, 'B', 'R', 'solve real-world problems to find the whole given a part and the percent, to find the part given the whole and the percent, and to find the percent given the part and the whole, including the use of concrete and pictorial models');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (5, 'A', 'S', 'identify independent and dependent quantities from tables and graphs');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (5, 'B', 'S', 'write an equation that represents the relationship between independent and dependent quantities from a table');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (5, 'C', 'R', 'represent a given situation using verbal descriptions, tables, graphs, and equations in the form y = kx or y = x + b');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (8, 'A', 'S', 'write one-variable, one-step equations and inequalities to represent constraints or conditions within problems');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (8, 'B', 'S', 'represent solutions for one-variable, one-step equations and inequalities on number lines');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (8, 'C', 'S', 'write corresponding real-world problems given one-variable, one- step equations or inequalities');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (9, 'A', 'R', 'model and solve one-variable, one-step equations and inequalities that represent problems, including geometric concepts');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (9, 'B', 'S', 'determine if the given value(s) make(s) one-variable, one-step equations or inequalities true');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (3, 'H', 'R', 'convert units within a measurement system, including the use of proportions and unit rates');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (7, 'A', 'S', 'extend previous knowledge of triangles and their properties to include the sum of angles of a triangle, the relationship between the lengths of sides and measures of angles in a triangle, and determining when three lengths form a triangle');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (7, 'B', 'S', 'model area formulas for parallelograms, trapezoids, and triangles by decomposing and rearranging parts of these shapes');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (7, 'C', 'S', 'write equations that represent problems related to the area of rectangles, parallelograms, trapezoids, and triangles and volume of right rectangular prisms where dimensions are positive rational numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (7, 'D', 'R', 'determine solutions for problems involving the area of rectangles, parallelograms, trapezoids, and triangles and volume of right rectangular prisms where dimensions are positive rational numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (10, 'A', 'R', 'graph points in all four quadrants using ordered pairs of rational numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (11, 'A', 'S', 'represent numeric data graphically, including dot plots, stem-and- leaf plots, histograms, and box plots');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (11, 'B', 'S', 'use the graphical representation of numeric data to describe the center, spread, and shape of the data distribution');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (11, 'C', 'R', 'summarize numeric data with numerical summaries, including the mean and median (measures of center) and the range and interquartile range (IQR) (measures of spread), and use these summaries to describe the center, spread, and shape of the data distribution');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (11, 'D', 'R', 'summarize categorical data with numerical and graphical summaries, including the mode, the percent of values in each category (relative frequency table), and the percent bar graph, and use these summaries to describe the data distribution');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (12, 'A', 'R', 'interpret numeric data summarized in dot plots, stem-and-leaf plots, histograms, and box plots');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (12, 'B', 'S', 'distinguish between situations that yield data with and without variability');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'A', 'S', 'compare the features and costs of a checking account and a debit card offered by different local financial institutions');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'B', 'S', 'distinguish between debit cards and credit cards');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'C', 'S', 'balance a check register that includes deposits, withdrawals, and transfers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'E', 'S', 'describe the information in a credit report and how long it is retained');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'F', 'S', 'describe the value of credit reports to borrowers and to lenders');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'G', 'S', 'explain various methods to pay for college, including through savings, grants, scholarships, student loans, and work-study');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (13, 'H', 'S', 'compare the annual salary of several occupations requiring various levels of post-secondary education or vocational training and calculate the effects of the different annual salaries on lifetime income');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (14, 'A', 'S', 'extend previous knowledge of sets and subsets using a visual representation to describe relationships between sets of rational numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'A', 'S', 'represent sample spaces for simple and compound events using lists and tree diagrams');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'C', 'S', 'make predictions and determine solutions using experimental data for simple and compound events');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'D', 'S', 'make predictions and determine solutions using theoretical probability for simple and compound events');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'E', 'S', 'find the probabilities of a simple event and its complement and describe the relationship between the two');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'H', 'R', 'solve problems using qualitative and quantitative predictions and comparisons from simple experiments');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'I', 'R', 'determine experimental and theoretical probabilities related to simple and compound events using data and sample spaces');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (15, 'A', 'S', 'add, subtract, multiply, and divide rational numbers fluently');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (15, 'B', 'R', 'apply and extend previous understandings of operations to solve problems using addition, subtraction, multiplication, and division of rational numbers');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (16, 'A', 'R', 'represent constant rates of change in mathematical and real-world problems given pictorial, tabular, verbal, numeric, graphical, and algebraic representations, including d = rt');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (16, 'B', 'S', 'calculate unit rates from rates in mathematical and real-world problems');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (16, 'C', 'S', 'determine the constant of proportionality (k = y/x) within mathematical and real-world problems');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (16, 'D', 'R', 'solve problems involving ratios, rates, and percents, including multi- step problems involving percent increase and percent decrease, and financial literacy problems');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (19, 'A', 'R', 'represent linear relationships using verbal descriptions, tables, graphs, and equations that simplify to the form y = mx + b');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (21, 'A', 'S', 'write one-variable, two-step equations and inequalities to represent constraints or conditions within problems');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (21, 'B', 'S', 'represent solutions for one-variable, two-step equations and inequalities on number lines');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (21, 'C', 'S', 'write a corresponding real-world problem given a one-variable, two- step equation or inequality');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (22, 'A', 'R', 'model and solve one-variable, two-step equations and inequalities');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (22, 'B', 'S', 'determine if the given value(s) make(s) one-variable, two-step equations and inequalities true');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (16, 'E', 'S', 'convert between measurement systems, including the use of proportions and the use of unit rates');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (17, 'A', 'S', 'generalize the critical attributes of similarity, including ratios within and between similar shapes');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (17, 'B', 'S', 'describe pi as the ratio of the circumference of a circle to its diameter');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (17, 'C', 'R', 'solve mathematical and real-world problems involving similar shape and scale drawings');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (20, 'A', 'R', 'solve problems involving the volume of rectangular prisms, triangular prisms, rectangular pyramids, and triangular pyramids');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (20, 'B', 'R', 'determine the circumference and area of circles');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (20, 'C', 'R', 'determine the area of composite figures containing combinations of rectangles, squares, parallelograms, trapezoids, triangles, semicircles, and quarter circles');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (20, 'D', 'S', 'solve problems involving the lateral and total surface area of a rectangular prism, rectangular pyramid, triangular prism, and triangular pyramid by determining the area of the shape\’s net');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (22, 'C', 'S', 'write and solve equations using geometry concepts, including the sum of the angles in a triangle, and angle relationships');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (18, 'G', 'R', 'solve problems using data represented in bar graphs, dot plots, and circle graphs, including part-to-whole and part-to-part comparisons and equivalents');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (23, 'A', 'R', 'compare two groups of numeric data using comparative dot plots or box plots by comparing their shapes, centers, and spreads');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (23, 'B', 'S', 'use data from a random sample to make inferences about a population');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (23, 'C', 'S', 'compare two populations based on data in random samples from these populations, including informal comparative inferences about differences between the two populations');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'A', 'S', 'calculate the sales tax for a given purchase and calculate income tax for earned wages');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'B', 'S', 'identify the components of a personal budget, including income; planned savings for college, retirement, and emergencies; taxes; and fixed and variable expenses, and calculate what percentage each category comprises of the total budget');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'C', 'S', 'create and organize a financial assets and liabilities record and construct a net worth statement');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'D', 'S', 'use a family budget estimator to determine the minimum household budget and average hourly wage needed for a family to meet its basic needs in the student\’s city or another large city nearby');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'E', 'S', 'calculate and compare simple interest and compound interest earnings');
insert into tek (tek_parent_id, alpha, standard, content) values 
    (24, 'F', 'S', 'analyze and compare monetary incentives, including sales, rebates, and coupons');

-- tek_complete table: built from tek and tek_parent tables
create table tek_summary (
    id int(10) unsigned not null auto_increment primary key
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1
    select 
        concat(p.grade, '.', p.section, t.alpha, ' (', t.standard, ')') as label,
        concat(p.grade, '.', p.section, t.alpha) as tek,
        p.grade,
        t.standard,
        p.topic,
        p.content as 'ks',
        t.content as 'se'
        from tek t, tek_parent p 
        where 
        t.tek_parent_id=p.id
        order by p.grade, p.section, t.alpha;

-- tek_complete_6 VIEW
create view tek_summary_6 as
    select 
        t.id,
        concat(p.grade, '.', p.section, t.alpha, ' (', t.standard, ')') as label,
        concat(p.grade, '.', p.section, t.alpha) as tek,
        p.grade,
        t.standard,
        p.content as 'ks',
        t.content as 'se'
        from tek t, tek_parent p 
        where 
        t.tek_parent_id=p.id and
        p.grade = 6
        order by p.grade, p.section, t.alpha;

-- tek_complete_7 VIEW
create view tek_summary_7 as
    select 
        t.id,
        concat(p.grade, '.', p.section, t.alpha, ' (', t.standard, ')') as label,
        concat(p.grade, '.', p.section, t.alpha) as tek,
        p.grade,
        t.standard,
        p.content as 'ks',
        t.content as 'se'
        from tek t, tek_parent p 
        where 
        t.tek_parent_id=p.id and
        p.grade = 7
        order by p.grade, p.section, t.alpha;

-- Other tables

-- proc_standard
create table proc_standard (
    id int(10) unsigned not null auto_increment,
    grade tinyint not null,
    alpha varchar(4) not null,
    content text not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- grade
create table grade (
    id int(10) unsigned not null auto_increment,
    grade varchar(30) not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- plan
create table plan (
    id int(10) unsigned not null auto_increment,
    plan_d date not null,
    grade_id int(10) unsigned not null,
    tek_summary_id int(10) unsigned not null,
    proc_standard_id int(10) unsigned not null,
    create_d date not null,
    primary key (id),
    key FK_plan_grade (grade_id),
    key FK_plan_tek_summary (tek_summary_id),
    key FK_plan_proc_standard (proc_standard_id),
    constraint FK_plan_grade foreign key (grade_id) references grade (id),
    constraint FK_plan_tek_summary foreign key (tek_summary_id) references tek_summary (id),
    constraint FK_plan_proc_standard foreign key (proc_standard_id) references proc_standard (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- verb
create table verb (
    id int(10) unsigned not null auto_increment,
    verb varchar(60) not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- verb_plan_map
create table verb_plan_map (
    id int(10) unsigned not null auto_increment,
    verb_id int(10) unsigned not null,
    plan_id int(10) unsigned not null,
    primary key (id),
    key FK_verb_plan_map_verb (verb_id),
    key FK_verb_plan_map_plan (plan_id),
    constraint FK_verb_plan_map_verb foreign key (verb_id) references verb (id),
    constraint FK_verb_plan_map_plan foreign key (plan_id) references plan (id) on delete cascade
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- enum_resource_type
create table enum_resource_type (
    id int(10) unsigned not null auto_increment,
    type varchar(60) not null,
    label varchar(60) not null,
    sequence int(5) unsigned not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- enum_section_type
create table enum_section_type (
    id int(10) unsigned not null auto_increment,
    type varchar(60) not null,
    label varchar(60) not null,
    sequence int(5) unsigned not null,
    primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- resource
create table resource (
    id int(10) unsigned not null auto_increment,
    url varchar(255),
    plan_id int(10) unsigned not null,
    enum_resource_type_id int(10) unsigned not null,
    complete tinyint default 0,
    notes varchar(255),
    primary key (id),
    key FK_resource_plan (plan_id),
    key FK_resource_enum_resource_type (enum_resource_type_id),
    constraint FK_resource_plan foreign key (plan_id) references plan (id) on delete cascade,
    constraint FK_resource_enum_resource_type foreign key (enum_resource_type_id) references enum_resource_type (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- section
create table section (
    id int(10) unsigned not null auto_increment,
    plan_id int(10) unsigned not null,
    content text,
    enum_section_type_id int(10) unsigned not null,
    primary key (id),
    key FK_section_plan (plan_id),
    key FK_section_enum_section_type (enum_section_type_id),
    constraint FK_section_plan foreign key (plan_id) references plan (id) on delete cascade,
    constraint FK_section_enum_section_type foreign key (enum_section_type_id) references enum_section_type (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- data load

-- enum_section_type data
insert into enum_section_type (type, label, sequence) values ('academic_obj', 'Academic Objective', 1);
insert into enum_section_type (type, label, sequence) values ('vocabulary', 'Vocabulary for Language Objective', 2);
insert into enum_section_type (type, label, sequence) values ('essential_q', 'Essential Questions', 3);
insert into enum_section_type (type, label, sequence) values ('hook', 'Hook', 4);
insert into enum_section_type (type, label, sequence) values ('input_key', 'Input/Keypoints', 5);
insert into enum_section_type (type, label, sequence) values ('common_err', 'Common Errors', 6);
insert into enum_section_type (type, label, sequence) values ('closure', 'Closure', 7);
insert into enum_section_type (type, label, sequence) values ('boot_camp', 'Boot Camp', 8);

-- enum_resource_type data
insert into enum_resource_type (type, label, sequence) values ('model', 'Model', 1);
insert into enum_resource_type (type, label, sequence) values ('guided_practice', 'Guided Practice', 2);
insert into enum_resource_type (type, label, sequence) values ('check_understand', 'Check For Understanding', 3);
insert into enum_resource_type (type, label, sequence) values ('indy_practice', 'Independent Practice', 4);
insert into enum_resource_type (type, label, sequence) values ('exit_ticket', 'Exit Ticket', 5);
insert into enum_resource_type (type, label, sequence) values ('flipchart', 'Flipchart', 6);
insert into enum_resource_type (type, label, sequence) values ('guided_notes', 'Guided Notes', 7);
insert into enum_resource_type (type, label, sequence) values ('homework', 'Homework', 8);
insert into enum_resource_type (type, label, sequence) values ('homework_key', 'Homework Key', 9);

-- verb data
insert into verb (verb) values ('Classify');
insert into verb (verb) values ('Identify');
insert into verb (verb) values ('Locate');
insert into verb (verb) values ('Compare');
insert into verb (verb) values ('Order');
insert into verb (verb) values ('Represent');
insert into verb (verb) values ('Generate');
insert into verb (verb) values ('Use');
insert into verb (verb) values ('Distinguish');
insert into verb (verb) values ('Determine');
insert into verb (verb) values ('Recognize');
insert into verb (verb) values ('Justify');
insert into verb (verb) values ('Apply');
insert into verb (verb) values ('Model');
insert into verb (verb) values ('Write');
insert into verb (verb) values ('Solve');
insert into verb (verb) values ('Graph');
insert into verb (verb) values ('Convert');
insert into verb (verb) values ('Interpret');
insert into verb (verb) values ('Summarize');
insert into verb (verb) values ('Describe');
insert into verb (verb) values ('Develop');

-- ps data
insert into proc_standard (grade, alpha, content) values (6, 'A', 'apply mathematics to problems arising in everyday life, society, and the workplace');
insert into proc_standard (grade, alpha, content) values (6, 'B', 'use a problem-solving model that incorporates analyzing given information, formulating a plan or strategy, determining a solution, justifying the solution, and evaluating the problem-solving process and the reasonableness of the solution');
insert into proc_standard (grade, alpha, content) values (6, 'C', 'select tools, including real objects, manipulatives, paper and pencil, and technology as appropriate, and techniques, including mental math, estimation, and number sense as appropriate, to solve problems');
insert into proc_standard (grade, alpha, content) values (6, 'D', 'communicate mathematical ideas, reasoning, and their implications using multiple representations, including symbols, diagrams, graphs, and language as appropriate');
insert into proc_standard (grade, alpha, content) values (6, 'E', 'create and use representations to organize, record, and communicate mathematical ideas');
insert into proc_standard (grade, alpha, content) values (6, 'F', 'analyze mathematical relationships to connect and communicate mathematical ideas');
insert into proc_standard (grade, alpha, content) values (6, 'G', 'display, explain, and justify mathematical ideas and arguments using precise mathematical language in written or oral communication');

-- grade
insert into grade (grade) values ('6th Academic');
insert into grade (grade) values ('6th Pre AP');

