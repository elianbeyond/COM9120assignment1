-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS admin CASCADE;
CREATE TABLE admin (
                       "login_name" varchar  NOT NULL,
                       "email" varchar ,
                       "password" varchar  NOT NULL,
                       "address" varchar ,
                       "full_name" varchar ,
                       "remuneration" int4
)
;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO admin VALUES ('elian2', '814846181@qq.com', '123456', 'home', 'Bingxuan Cao', 3000);

-- ----------------------------
-- Table structure for close_price
-- ----------------------------
DROP TABLE IF EXISTS close_price CASCADE;
CREATE TABLE close_price (
                             "code" varchar  NOT NULL,
                             "date" date NOT NULL,
                             "closingprice" numeric NOT NULL
)
;

-- ----------------------------
-- Records of close_price
-- ----------------------------
INSERT INTO close_price VALUES ('1', '2022-09-16', 300);

------------------------------
-- Table structure for customer
-- ----------------------------

DROP TABLE IF EXISTS customer CASCADE;
CREATE TABLE customer (
                          "login_name" varchar  NOT NULL,
                          "email" varchar ,
                          "password" varchar  NOT NULL,
                          "address" varchar ,
                          "full_name" varchar ,
                          "mobile_number" varchar ,
                          "cash_balance" int4
)
;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO customer VALUES ('elian', '814846181@qq.com', '123456', 'home', 'Bingxuan Cao', '15197730857', 2000);

-- ----------------------------
-- Table structure for deposit_transaction
-- ----------------------------
DROP TABLE IF EXISTS deposit_transaction CASCADE;
CREATE TABLE deposit_transaction (
                                     "transaction_id" int4,
                                     "money" numeric NOT NULL
)
;

-- ----------------------------
-- Records of deposit_transaction
-- ----------------------------
INSERT INTO deposit_transaction VALUES (1, 500000);

-- ----------------------------
-- Table structure for etf
-- ----------------------------
DROP TABLE IF EXISTS etf CASCADE;
CREATE TABLE etf (
  "code" varchar  NOT NULL,
  "category" varchar  NOT NULL,
  "name" varchar  NOT NULL,
  "description" text  NOT NULL,
  "minimum_investment_amount" numeric NOT NULL,
  "first_established_date" date NOT NULL,
  "total_number_of_units_outstanding" int4 NOT NULL
)
;

-- ----------------------------
-- Records of etf
-- ----------------------------
INSERT INTO etf VALUES ('1', 'Australian Equity Index', 'abc', 'temp', 2000, '2022-09-01', 100);

-- ----------------------------
-- Table structure for regular_investment
-- ----------------------------
DROP TABLE IF EXISTS regular_investment CASCADE;
CREATE TABLE regular_investment (
  "money" float8,
  "code" varchar,
  "start" date,
  "frequency" varchar ,
  "login_name" varchar 
)
;

-- ----------------------------
-- Records of regular_investment
-- ----------------------------
INSERT INTO regular_investment VALUES (5000, '1', '2022-09-15', 'two weeks', 'elian');


-- ----------------------------
-- Table structure for trade
-- ----------------------------
DROP TYPE  IF EXISTS types CASCADE;
CREATE TYPE types AS ENUM ('Buy', 'Sell', 'Deposit');

DROP TABLE IF EXISTS trade CASCADE;
CREATE TABLE trade (
  "login_name" varchar ,
  "type" types,
    "transaction_id" int4
    )
;

-- ----------------------------
-- Records of trade
-- ----------------------------

INSERT INTO trade VALUES ('elian', 'Buy', 2);

    -- ----------------------------
-- Table structure for trade_transaction
-- ----------------------------
    DROP TABLE IF EXISTS trade_transaction CASCADE;
    CREATE TABLE trade_transaction (
                                       "transaction_id" int4,
                                       "code" varchar ,
                                       "type" varchar  NOT NULL,
                                       "brokerage_fee" numeric,
                                       "final_amount" numeric,
                                       "etf_price" numeric,
                                       "etf_number" numeric
                                   )
    ;

    -- ----------------------------
-- Records of trade_transaction
-- ----------------------------
    INSERT INTO trade_transaction VALUES (2, '1', 'Buy', 30, 3000, 300, 10);

    -- ----------------------------
-- Table structure for transaction_history
-- ----------------------------
    DROP TABLE IF EXISTS transaction_history CASCADE;
    CREATE TABLE transaction_history (
    "transaction_id" SERIAL,
    "date" date
    )
    ;

    -- ----------------------------
-- Records of transaction_history
-- ----------------------------
    INSERT INTO transaction_history VALUES (1, '2022-09-14');
    INSERT INTO transaction_history VALUES (2, '2022-09-16');

    -- ----------------------------
-- Primary Key structure for table admin
-- ----------------------------
    ALTER TABLE admin ADD CONSTRAINT "admin_pkey" PRIMARY KEY ("login_name");

    -- ----------------------------
-- Primary Key structure for table close_price
-- ----------------------------
    ALTER TABLE close_price ADD CONSTRAINT "closeprice_pkey" PRIMARY KEY ("code", "date");

    -- ----------------------------
-- Primary Key structure for table customer
-- ----------------------------
    ALTER TABLE customer ADD CONSTRAINT "customer_pkey" PRIMARY KEY ("login_name");

    -- ----------------------------
-- Checks structure for table etf
-- ----------------------------
    ALTER TABLE etf ADD CONSTRAINT "check_category" CHECK (category::text = ANY (ARRAY['Global Equity Index'::character varying::text, 'Global Equity Sectors'::character varying::text, 'Australian Equity Index'::character varying::text, 'Bonds'::character varying::text, 'Fixed Income'::character varying::text, 'Commodity'::character varying::text, 'Sustainable'::character varying::text, 'Currency'::character varying::text]));

    -- ----------------------------
-- Primary Key structure for table etf
-- ----------------------------
    ALTER TABLE etf ADD CONSTRAINT "etf_pkey" PRIMARY KEY ("code");

    -- ----------------------------
-- Primary Key structure for table transaction_history
-- ----------------------------
    ALTER TABLE transaction_history ADD CONSTRAINT "transactionhistory_pkey" PRIMARY KEY ("transaction_id");

    -- ----------------------------
-- Foreign Keys structure for table close_price
-- ----------------------------
    ALTER TABLE close_price ADD CONSTRAINT "closeprice_code_fkey" FOREIGN KEY ("code") REFERENCES etf ("code") ON DELETE CASCADE ON UPDATE NO ACTION;

    -- ----------------------------
-- Foreign Keys structure for table deposit_transaction
-- ----------------------------
    ALTER TABLE deposit_transaction ADD CONSTRAINT "deposittransaction_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES transaction_history ("transaction_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

    -- ----------------------------
-- Foreign Keys structure for table regular_investment
-- ----------------------------
    ALTER TABLE regular_investment ADD CONSTRAINT "regularinvestment_login_name_fkey" FOREIGN KEY ("login_name") REFERENCES customer ("login_name") ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE regular_investment ADD CONSTRAINT "regularinvestment_code_fkey" FOREIGN KEY ("code") REFERENCES etf ("code") ON DELETE CASCADE ON UPDATE CASCADE;

    -- ----------------------------
-- Foreign Keys structure for table trade
-- ----------------------------
ALTER TABLE trade ADD CONSTRAINT "trade_login_name_fkey" FOREIGN KEY ("login_name") REFERENCES customer ("login_name") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE trade ADD CONSTRAINT "trade_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES transaction_history ("transaction_id") ON DELETE CASCADE ON UPDATE CASCADE;

    -- ----------------------------
-- Foreign Keys structure for table trade_transaction
-- ----------------------------
    ALTER TABLE trade_transaction ADD CONSTRAINT "tradetransaction_code_fkey" FOREIGN KEY ("code") REFERENCES etf ("code") ON DELETE NO ACTION ON UPDATE NO ACTION;
    ALTER TABLE trade_transaction ADD CONSTRAINT "tradetransaction_transaction_id_fkey" FOREIGN KEY ("transaction_id") REFERENCES transaction_history ("transaction_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
