create table customer(

    custId int primary key auto_increment ,
    custName varchar(40) not null,
    custEmail varchar(40) not null ,
    custPassword varchar(30) not null,
    custUsername varchar(20),
    custAdress varchar(100),
    custCity varchar(20),
    custCountry varchar(20)

);


create table orders(
   ordId int primary key auto_increment ,
   ordDiscount numeric(7,2) not null ,
   ordTax numeric(7,2) not null,
   ordTotal numeric(7,2)not null,
   ordShipping numeric(7,2)not null,
   ordDate timestamp,
   ordShipDate timestamp,
    ordCustId int ,

   CONSTRAINT fk_order_product FOREIGN KEY(ordCustId)
        REFERENCES customer(custId)
);

create table orderItem(
    ordItemOrdId int,
    ordItemProdId int,
    ordItemQty smallint not null ,
    ordItemPrice numeric(7,2) not null ,
    ordItemDiscount numeric(7,2) not null ,
    ordItemTax numeric(7,2) not null,

    constraint pk_ordItem primary key(ordItemOrdId,ordItemProdId),
    constraint fk_orditem_prod foreign key(ordItemProdId) references product(prodId),
    constraint fk_orditem_ord foreign key(ordItemOrdId) references orders(ordId)
);


create table product(
    prodId int primary key auto_increment ,
    prodName varchar(40) not null,
    prodDescr varchar(60) ,
    prodLongDescr varchar(80),
    prodSize numeric,
    prodColor varchar(40),
    -- numaric because it can be used in math operations decimal will make it has more decimal points
    prodWeight numeric,
    -- we can use numaric(7,2)
    prodPrice numeric(7,2),
    -- it is better to use integer 0 or 1 rather than boolean
    availability bool,
    prodImageUrl  varchar(70),
    prodComments varchar(90),
    prodDiscount numeric(7,2),
    prodShipCost numeric(7,2),
    -- available products until now
    prodInHand smallint                  );


-- assosative entity for manay to many relationship
create table  productCategory(
    prodId int,
    catId int ,
    -- we may use boolean or numaric 0,1
    prodCatDefault char(1),
   constraint  fk_prod_prodcat foreign key (prodId) references product(prodId) ,
   constraint  fk_cat_prodcat foreign key (catId) references category(catId)    ,
   -- a given product is containd in only one category , that why i primary key is composite , also to reduce number of coulmns
   CONSTRAINT pk_prodCat primary key (prodId,catId)

                             );


create table category(
    catId int primary key auto_increment,
    catName varchar(40) not null,
    catDiscr varchar(80),
    catParentId int ,
    -- catParentId refers to catId
   constraint  fk_category_subcategory foreign key (catParentId) references category(catId),
);


create table salesHisory(
    CustomerNo CHAR(9),
    First CHAR(20) NOT NULL,
    Last CHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    ProductNo  CHAR(8),
    Description VARCHAR(50) NOT NULL,
    Price NUMERIC(5,2) NOT NULL CHECK(Price>= 0 and Price<999.99),
    SaleNo SMALLINT,
    SaleDate DATE NOT NULL,
    Qty INTEGER NOT NULL CHECK(Qty>0),
    Amount NUMERIC(6,2) NOT NULL CHECK(Amount >=0),
    PRIMARY KEY(SaleNo)
);