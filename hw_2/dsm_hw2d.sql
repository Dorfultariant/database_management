CREATE TABLE Orders
(
  orderid        INT          NOT NULL,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      TIMESTAMP     NOT NULL,
  requireddate   TIMESTAMP     NOT NULL,
  shippeddate    TIMESTAMP     ,
  shipperid      INT          NOT NULL,
  freight        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_freight DEFAULT(0),
  shipname       VARCHAR(40) NOT NULL,
  shipaddress    VARCHAR(60) NOT NULL,
  shipcity       VARCHAR(15) NOT NULL,
  shipregion     VARCHAR(15) NULL,
  shippostalcode VARCHAR(10) NULL,
  shipcountry    VARCHAR(15) NOT NULL
) PARTITION BY RANGE (orderdate) ;

CREATE TABLE orders_1 PARTITION OF Orders FOR VALUES FROM ('2006-07-03 00:00:00.000') TO ('2007-02-05 00:00:00.000') PARTITION BY LIST (shipcountry);
CREATE TABLE orders_2 PARTITION OF Orders FOR VALUES FROM ('2007-02-05 00:00:00.000') TO ('2007-08-19 00:00:00.000');
CREATE TABLE orders_3 PARTITION OF Orders FOR VALUES FROM ('2007-08-19 00:00:00.000') TO ('2008-01-23 00:00:00.000');
CREATE TABLE orders_4 PARTITION OF Orders FOR VALUES FROM ('2008-01-23 00:00:00.000') TO ('2008-05-07 00:00:00.000');
CREATE TABLE orders_default PARTITION OF Orders DEFAULT;
--ALTER TABLE orders_3 ADD CONSTRAINT freight_check CHECK (freight > 50::money);
--ALTER TABLE orders_4 ADD CONSTRAINT date_check CHECK (shippeddate is not null);
CREATE TABLE orders_1_usa_uk PARTITION OF orders_1 FOR VALUES IN ('UK','USA');
CREATE TABLE orders_1_ger_fin PARTITION OF orders_1 FOR VALUES IN ('Finland','Germany');
