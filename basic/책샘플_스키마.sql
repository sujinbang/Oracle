CREATE TABLE userTBL -- 회원
(
    userID char(8) not null  primary key,
    userName nvarchar2(10) not null,
    birthYear number(4) not null,
    addr nchar(2) not null,
    mobile1 char(3),
    mobile2 char(8),
    height number(3),
    mDate date
);

create table buyTBL -- 구매
(
    idNum number(8) not null primary key,
    userID char(8) not null,
    prodName nchar(6) not null,
    groupName nchar(4),
    price number(8) not null,
    amount number(3) not null,
    FOREIGN key (userID) REFERENCES userTBL(userID)
);