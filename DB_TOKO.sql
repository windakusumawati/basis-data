/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     30/03/2023 14:30:37                          */
/*==============================================================*/


/*==============================================================*/
/* Table: BARANG                                                */
/*==============================================================*/
create or replace table BARANG 
(
   ID_BARANG            integer                        not null,
   ID_SUPPLIER          integer                        null,
   NAMA_BARANG          varchar(20)                    null,
   HARGA_BELI           decimal                        null,
   HARGA_JUAL           decimal                        null,
   STOCK_BARANG         integer                        null,
   STATUS_BARANG        smallint                       null,
   constraint PK_BARANG primary key clustered (ID_BARANG)
);

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create or replace table CUSTOMER 
(
   ID_CUSTOMER          integer                        not null,
   NAMA_CUSTOMER        varchar(40)                    null,
   NO_KTP               long varchar                   null,
   TELP_CUSTOMER        varchar(13)                    null,
   ALAMAT_CUSTOMER      varchar(100)                   null,
   POIN                 integer                        null,
   STATUS_CUSTOMER      smallint                       null,
   constraint PK_CUSTOMER primary key clustered (ID_CUSTOMER)
);

/*==============================================================*/
/* Table: DETAIL_PEMBELIAN                                      */
/*==============================================================*/
create or replace table DETAIL_PEMBELIAN 
(
   ID_TRX_PEMB          integer                        not null,
   ID_BARANG            integer                        not null,
   QTY_DETAIL_PEMB      integer                        null,
   constraint PK_DETAIL_PEMBELIAN primary key clustered (ID_TRX_PEMB, ID_BARANG)
);

/*==============================================================*/
/* Table: DETAIL_PENJUALAN                                      */
/*==============================================================*/
create or replace table DETAIL_PENJUALAN 
(
   ID_TRX_PENJ          integer                        not null,
   ID_BARANG            integer                        not null,
   QTY_DEATAIL_PENJ     integer                        null,
   constraint PK_DETAIL_PENJUALAN primary key clustered (ID_TRX_PENJ, ID_BARANG)
);

/*==============================================================*/
/* Table: KASIR                                                 */
/*==============================================================*/
create or replace table KASIR 
(
   ID_KASIR             integer                        not null,
   NAMA_KASIR           varchar(40)                    null,
   TELP_KASIR           varchar(13)                    null,
   ALAMAT_KASIR         varchar(100)                   null,
   STATUS_KASIR         smallint                       null,
   constraint PK_KASIR primary key clustered (ID_KASIR)
);

/*==============================================================*/
/* Table: SUPPLIER                                              */
/*==============================================================*/
create or replace table SUPPLIER 
(
   ID_SUPPLIER          integer                        not null,
   NAMA_SUPPLIER        varchar(40)                    null,
   ALAMAT_SUPPLIER      varchar(100)                   null,
   CP                   varchar(40)                    null,
   TELP_SUPPLIER        varchar(13)                    null,
   STATUS_SUPPLIER      smallint                       null,
   constraint PK_SUPPLIER primary key clustered (ID_SUPPLIER)
);

/*==============================================================*/
/* Table: TRX_PEMBELIAN                                         */
/*==============================================================*/
create or replace table TRX_PEMBELIAN 
(
   ID_TRX_PEMB          integer                        not null,
   ID_KASIR             integer                        null,
   TGL_TRX_PEMB         timestamp                      null,
   QTY_PEMB             integer                        null,
   TOTAL_PEMB           decimal                        null,
   constraint PK_TRX_PEMBELIAN primary key clustered (ID_TRX_PEMB)
);

/*==============================================================*/
/* Table: TRX_PENJUALAN                                         */
/*==============================================================*/
create or replace table TRX_PENJUALAN 
(
   ID_TRX_PENJ          integer                        not null,
   ID_CUSTOMER          integer                        null,
   ID_KASIR             integer                        null,
   TGL_TRX_PENJ         timestamp                      null,
   QTY_PENJ             integer                        null,
   TOTAL_PENJ           decimal                        null,
   DISC                 decimal                        null,
   TOTAL_BAYAR          decimal                        null,
   constraint PK_TRX_PENJUALAN primary key clustered (ID_TRX_PENJ)
);

alter table BARANG
   add constraint FK_BARANG_RELATIONS_SUPPLIER foreign key (ID_SUPPLIER)
      references SUPPLIER (ID_SUPPLIER)
      on update restrict
      on delete restrict;

alter table DETAIL_PEMBELIAN
   add constraint FK_DETAIL_P_RELATIONS_TRX_PEMB foreign key (ID_TRX_PEMB)
      references TRX_PEMBELIAN (ID_TRX_PEMB)
      on update restrict
      on delete restrict;

alter table DETAIL_PEMBELIAN
   add constraint FK_DETAIL_P_RELATIONS_BARANG foreign key (ID_BARANG)
      references BARANG (ID_BARANG)
      on update restrict
      on delete restrict;

alter table DETAIL_PENJUALAN
   add constraint FK_DETAIL_P_RELATIONS_TRX_PENJ foreign key (ID_TRX_PENJ)
      references TRX_PENJUALAN (ID_TRX_PENJ)
      on update restrict
      on delete restrict;

alter table DETAIL_PENJUALAN
   add constraint FK_DETAIL_P_RELATIONS_BARANG foreign key (ID_BARANG)
      references BARANG (ID_BARANG)
      on update restrict
      on delete restrict;

alter table TRX_PEMBELIAN
   add constraint FK_TRX_PEMB_RELATIONS_KASIR foreign key (ID_KASIR)
      references KASIR (ID_KASIR)
      on update restrict
      on delete restrict;

alter table TRX_PENJUALAN
   add constraint FK_TRX_PENJ_RELATIONS_CUSTOMER foreign key (ID_CUSTOMER)
      references CUSTOMER (ID_CUSTOMER)
      on update restrict
      on delete restrict;

alter table TRX_PENJUALAN
   add constraint FK_TRX_PENJ_RELATIONS_KASIR foreign key (ID_KASIR)
      references KASIR (ID_KASIR)
      on update restrict
      on delete restrict;

