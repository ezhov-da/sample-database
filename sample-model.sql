ALTER TABLE IF EXISTS "ORDER"
  DROP CONSTRAINT IF EXISTS FK_ORDER_REFERENCE_CUSTOMER;

ALTER TABLE IF EXISTS "ORDER_ITEM"
  DROP CONSTRAINT IF EXISTS FK_ORDERITE_REFERENCE_ORDER;

ALTER TABLE IF EXISTS "ORDER_ITEM"
  DROP CONSTRAINT IF EXISTS FK_ORDERITE_REFERENCE_PRODUCT;

ALTER TABLE IF EXISTS "PRODUCT"
  DROP CONSTRAINT IF EXISTS FK_PRODUCT_REFERENCE_SUPPLIER;

DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS "ORDER";
DROP TABLE IF EXISTS "ORDER_ITEM";
DROP TABLE IF EXISTS "PRODUCT";
DROP TABLE IF EXISTS "SUPPLIER";

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
CREATE TABLE CUSTOMER (
  ID         INT IDENTITY,
  FIRST_NAME NVARCHAR(40) NOT NULL,
  LAST_NAME  NVARCHAR(40) NOT NULL,
  CITY       NVARCHAR(40) NULL,
  COUNTRY    NVARCHAR(40) NULL,
  PHONE      NVARCHAR(20) NULL,
  CONSTRAINT PK_CUSTOMER PRIMARY KEY (ID)
);

/*==============================================================*/
/* Index: IndexCustomerName                                     */
/*==============================================================*/
CREATE INDEX IndexCustomerName
  ON CUSTOMER (
    LAST_NAME ASC,
    FIRST_NAME ASC
  );

/*==============================================================*/
/* Table: "Order"                                               */
/*==============================================================*/
CREATE TABLE "ORDER" (
  Id           INT IDENTITY,
  ORDER_DATE   DATETIME       NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     DEFAULT getdate(),
  ORDER_NUMBER NVARCHAR(10)   NULL,
  CUSTOMER_ID  INT            NOT NULL,
  TOTAL_AMOUNT DECIMAL(12, 2) NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             DEFAULT 0,
  CONSTRAINT PK_ORDER PRIMARY KEY (Id)
);

/*==============================================================*/
/* Index: IndexOrderCustomerId                                  */
/*==============================================================*/
CREATE INDEX IndexOrderCustomerId
  ON "ORDER" (
    CUSTOMER_ID ASC
  );

/*==============================================================*/
/* Index: IndexOrderOrderDate                                   */
/*==============================================================*/
CREATE INDEX IndexOrderOrderDate
  ON "ORDER" (
    ORDER_DATE ASC
  );

/*==============================================================*/
/* Table: OrderItem                                             */
/*==============================================================*/
CREATE TABLE ORDER_ITEM (
  ID         INT IDENTITY,
  ORDER_ID   INT            NOT NULL,
  PRODUCT_ID INT            NOT NULL,
  UNIT_PRICE DECIMAL(12, 2) NOT NULL DEFAULT 0,
  QUANTITY   INT            NOT NULL DEFAULT 1,
  CONSTRAINT PK_ORDERITEM PRIMARY KEY (ID)
);

/*==============================================================*/
/* Index: IndexOrderItemOrderId                                 */
/*==============================================================*/
CREATE INDEX IndexOrderItemOrderId
  ON ORDER_ITEM (
    ORDER_ID ASC
  );

/*==============================================================*/
/* Index: IndexOrderItemProductId                               */
/*==============================================================*/
CREATE INDEX IndexOrderItemProductId
  ON ORDER_ITEM (
    PRODUCT_ID ASC
  );

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
CREATE TABLE PRODUCT (
  ID              INT IDENTITY,
  PRODUCT_NAME    NVARCHAR(50)   NOT NULL,
  SUPPLIER_ID     INT            NOT NULL,
  UNIT_PRICE      DECIMAL(12, 2) NULL        DEFAULT 0,
  PACKAGE         NVARCHAR(30)   NULL,
  IS_DISCONTINUED BIT            NOT NULL    DEFAULT 0,
  CONSTRAINT PK_PRODUCT PRIMARY KEY (ID)
);

/*==============================================================*/
/* Index: IndexProductSupplierId                                */
/*==============================================================*/
CREATE INDEX IndexProductSupplierId
  ON PRODUCT (
    SUPPLIER_ID ASC
  );

/*==============================================================*/
/* Index: IndexProductName                                      */
/*==============================================================*/
CREATE INDEX IndexProductName
  ON PRODUCT (
    PRODUCT_NAME ASC
  );

/*==============================================================*/
/* Table: Supplier                                              */
/*==============================================================*/
CREATE TABLE SUPPLIER (
  ID            INT IDENTITY,
  COMPANY_NAME  NVARCHAR(40) NOT NULL,
  CONTACT_NAME  NVARCHAR(50) NULL,
  CONTACT_TITLE NVARCHAR(40) NULL,
  CITY          NVARCHAR(40) NULL,
  COUNTRY       NVARCHAR(40) NULL,
  PHONE         NVARCHAR(30) NULL,
  FAX           NVARCHAR(30) NULL,
  CONSTRAINT PK_SUPPLIER PRIMARY KEY (ID)
);

/*==============================================================*/
/* Index: IndexSupplierName                                     */
/*==============================================================*/
CREATE INDEX IndexSupplierName
  ON SUPPLIER (
    COMPANY_NAME ASC
  );

/*==============================================================*/
/* Index: IndexSupplierCountry                                  */
/*==============================================================*/
CREATE INDEX IndexSupplierCountry
  ON SUPPLIER (
    COUNTRY ASC
  );

ALTER TABLE "ORDER"
  ADD CONSTRAINT FK_ORDER_REFERENCE_CUSTOMER FOREIGN KEY (CUSTOMER_ID)
REFERENCES CUSTOMER (ID);

ALTER TABLE ORDER_ITEM
  ADD CONSTRAINT FK_ORDERITE_REFERENCE_ORDER FOREIGN KEY (ORDER_ID)
REFERENCES "ORDER" (ID);

ALTER TABLE ORDER_ITEM
  ADD CONSTRAINT FK_ORDERITE_REFERENCE_PRODUCT FOREIGN KEY (PRODUCT_ID)
REFERENCES PRODUCT (ID);

ALTER TABLE PRODUCT
  ADD CONSTRAINT FK_PRODUCT_REFERENCE_SUPPLIER FOREIGN KEY (SUPPLIER_ID)
REFERENCES SUPPLIER (ID);
