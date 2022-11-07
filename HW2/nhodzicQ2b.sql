use nhodzichw2q2;
SET FOREIGN_KEY_CHECKS=0;

truncate customers;
insert into customers values (1, "nedim", "customer", "cool street", "515-123-4567");
insert into customers values (2, "hodzic", "customer", "cool street", "515-123-1442");
insert into customers values (3, "bob", "customer", "cool street", "515-190-4314");
insert into customers values (4, "bill", "customer", "cool street", "634-003-1337");

truncate product_types;
insert into product_types values ("toy");
insert into product_types values ("food");
insert into product_types values ("electronic");
insert into product_types values ("office");

truncate products;
insert into products values (1, 15, "legos", 15.99, "toy");
insert into products values (2, 4, "stuffed animal", 30.50, "toy");
insert into products values (3, 3, "laptop", 700.99, "electronic");
insert into products values (4, 17, "apples", 2.50, "food");

truncate employees;
insert into employees values (1, "street avenue", "sam", "smith", "515-745-9173", 12);
insert into employees values (2, "welch avenue", "jake", "jones", "515-731-0034", 1);
insert into employees values (3, "lincoln way", "sally", "smith", "431-041-5812", 1);
insert into employees values (4, "duff avenue", "anna", "butler", "505-657-5012", 1);
insert into employees values (5, "moretensen rd", "travis", "madison", "831-841-9461", 1);
insert into employees values (6, "lincoln way", "jacob", "smith", "515-515-5151", 10);
insert into employees values (7, "moretensen rd", "nedim", "hodzic", "555-124-9041", 10);
insert into employees values (8, "lincoln way", "nick", "thomas", "469-351-6731", 10);
insert into employees values (9, "lincoln way", "elmin", "didic", "751-561-6613", 11);
insert into employees values (10, "state street", "dallen", "hecker", "894-125-5631", 12);
insert into employees values (11, "state street", "neil", "liang", "582-556-6261", 12);
insert into employees values (12, "800 street", "zajim", "hodzic", "515-731-9531", null);

truncate hourly_workers;
insert into hourly_workers values (2, 24.00, 40, "toy");
insert into hourly_workers values (3, 25.00, 30, "toy");
insert into hourly_workers values (4, 50.00, 15, "electronic");
insert into hourly_workers values (5, 75.15, 60, "food");

truncate fulltime_workers;
insert into fulltime_workers values (6, "100,000", "senior dev");
insert into fulltime_workers values (7, "150,000", "plumber");
insert into fulltime_workers values (8, "2,000", "intern");
insert into fulltime_workers values (9, "18,000", "new dev");

truncate managers;
insert into managers values (1, "200,000", 5);
insert into managers values (10, "300,000", 4);
insert into managers values (11, "150,000", 3);
insert into managers values (12, "5,000,000", 20);

truncate suppliers;
insert into suppliers values ("walmart", "walmart road");
insert into suppliers values ("target", "target street");
insert into suppliers values ("amazon", "amazon way");
insert into suppliers values ("best buy", "best avenue");

truncate ingredients;
insert into ingredients values (1, "plastic");
insert into ingredients values (2, "red dye");
insert into ingredients values (3, "apple");
insert into ingredients values (4, "cloth");

truncate purchase;
insert into purchase values (1, 3, 1);
insert into purchase values (1, 4, 10);
insert into purchase values (2, 1, 1);
insert into purchase values (3, 1, 2);

truncate make;
insert into make values (2, 1);
insert into make values (3, 2);
insert into make values (4, 3);
insert into make values (2, 2);

truncate bought_from;
insert into bought_from values (1, 1, "walmart", 100, 0.09, "2022-05-25");
insert into bought_from values (1, 2, "walmart", 50, 3.09, "2021-03-12");
insert into bought_from values (2, 4, "amazon", 300, 6.09, "2022-08-01");
insert into bought_from values (4, 3, "best buy", 75, 8.09, "2019-01-04");