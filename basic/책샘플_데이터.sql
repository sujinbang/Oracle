-- userTBL 데이터
insert into userTBL values ('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');

insert into userTBL values ('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
insert into userTBL values ('KKH', '김경호', 1971, '전남', '011', '33333333', 177, '2007-7-7');
insert into userTBL values ('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
insert into userTBL values ('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
insert into userTBL values ('LJB', '임재범', 1963, '서울', '011', '66666666', 182, '2009-9-9');
insert into userTBL values ('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5');
insert into userTBL values ('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
insert into userTBL values ('JKW', '조관우', 1965, '경기', '011', '99999999', 172, '2010-10-10');
insert into userTBL values ('BBK', '바비킴', 1973, '서울', '011', '00000000', 176, '2013-5-5');

COMMIT;

-- buyTBL 데이터
create sequence idSeq;
insert into buyTBL values (idSeq.nextval, 'KBS', '운동화', NULL, 30, 2);

insert into buyTBL values (idSeq.nextval, 'KBS', '노트북', '전자', 1000, 1);
insert into buyTBL values (idSeq.nextval, 'JYP', '모니터', '전자', 200, 1);
insert into buyTBL values (idSeq.nextval, 'BBK', '모니터', '전자', 200, 5);
insert into buyTBL values (idSeq.nextval, 'KBS', '청바지', '의류', 50, 3);
insert into buyTBL values (idSeq.nextval, 'BBK', '메모리', '전자', 80, 10);
insert into buyTBL values (idSeq.nextval, 'SSK', '책', '서적', 15, 5);
insert into buyTBL values (idSeq.nextval, 'EJW', '책', '서적', 15, 2);
insert into buyTBL values (idSeq.nextval, 'EJW', '청바지', '의류', 50, 1);
insert into buyTBL values (idSeq.nextval, 'BBK', '운동화', NULL, 30, 2);
insert into buyTBL values (idSeq.nextval, 'EJW', '책', '서적', 15, 1);
insert into buyTBL values (idSeq.nextval, 'BBK', '운동화', NULL, 30, 2);

COMMIT;