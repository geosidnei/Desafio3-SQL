-- Banco de dados E-commerce [desafop 3] --

--ctrl+alt+t
--sudo mysql
--senha do usuário

CREATE DATABASE ecommerce;

-- USE ecommerce;
  
-- TABLE clients --


CREATE TABLE clients(
      idClient INT AUTO_INCREMENT PRIMARY KEY,
      Pnome VARCHAR(12),
      Miniciais CHAR(3),
      Sobrenome VARCHAR(20),
      CPF CHAR(11) NOT NULL,
      Endereco VARCHAR(45),
      CEP CHAR(8) NOT NULL,
      Telefone CHAR(12) NOT NULL,
      CONSTRAINT unique_cpf_client UNIQUE (CPF)      
);

mysql> select * from clients;
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
| idClient | Pnome   | Miniciais | Sobrenome | CPF         | Endereco                                     | CEP      | Telefone    |
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
|        7 | Marta   | M         | Silva     | 12345678912 | R. Silva Prata, 29 - Lebom - Frioburgo       | 20000003 | 21999777456 |
|        8 | Mateus  | O         | Pimentel  | 98765432101 | R. da Alameda, 289 - Centro - Frioburgo      | 20000001 | 21999777555 |
|        9 | Ricardo | F         | Silva     | 45678912321 | Av. das Vinhas, 1009 - Centro - Frioburgo    | 20000001 | 21999775776 |
|       10 | Julia   | S         | França    | 78912345699 | R. das Laranjeiras, 862 - Centro - Frioburgo | 20000001 | 21999888775 |
|       11 | Roberta | G         | Assis     | 98745612303 | Av. Köller, 190 - Centro - Frioburgo         | 20000001 | 21999775890 |
|       12 | Izabela | Z         | Diaz      | 12332177511 | Av. do Kaiser, 3220 - Lebom - Frioburgo      | 20000003 | 21969966969 |
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
6 rows in set (0,00 sec)


--Query OK, 0 rows affected (2,72 sec)

ALTER TABLE clients auto_increment=1;

-- TABLE produto --
-- SIZE (palavra reservada) trocado por dimensios --

CREATE TABLE product(
      idProduct INT AUTO_INCREMENT PRIMARY KEY,
      Pnome VARCHAR(30) NOT NULL,
      classification_kids BOOL DEFAULT FALSE,
      category ENUM ('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
      avaliation FLOAT DEFAULT 0,
      dimensions VARCHAR(10)
 );

ALTER TABLE product (Pnome VARCHAR(30));

mysql> select * from product;
+-----------+------------+---------------------+-------------+------------+------------+
| idProduct | Pnome      | classification_kids | category    | avaliation | dimensions |
+-----------+------------+---------------------+-------------+------------+------------+
|         1 | Fones ouv. |                   0 | Eletrônico  |          4 | NULL       |
|         2 | Barbie E.  |                   1 | Brinquedos  |          3 | NULL       |
|         3 | Body P.    |                   1 | Vestuário   |          5 | NULL       |
|         4 | Microf. V2 |                   0 | Eletrônico  |          4 | NULL       |
|         5 | Sofá-cama  |                   0 | Móveis      |          3 | 3X57X80    |
|         6 | Farofa Ma. |                   0 | Alimentos   |          5 | NULL       |
|         7 | Fire Stck  |                   0 | Eletrônico  |          2 | NULL       |
+-----------+------------+---------------------+-------------+------------+------------+
7 rows in set (0,00 sec)


-- TABLE pagamentos ---
-- Este foi meu refinamento e a liguei à tabela clients --
CREATE TABLE payments(
      idPayment INT,
      typePayment ENUM('Boleto', 'Crédito', 'PIX') DEFAULT 'Crédito',
      limitAvailable FLOAT, 
      CONSTRAINT fk_payments_client FOREIGN KEY(idPayment) REFERENCES clients(idClient)
      );
Empty set (0,00 sec)
-- Query OK, 0 rows affected (3,35 sec)--

-- TABLE pedidos --
CREATE TABLE orders(
      idOrder INT AUTO_INCREMENT PRIMARY KEY,
      idOrderClient INT,
      orderStatus ENUM('Cancelado', 'Confirmado', 'Processando') DEFAULT 'Processando',      
      orderDescription VARCHAR(255),      
      freight FLOAT DEFAULT 10,
      paymentCash bool DEFAULT false,
      CONSTRAINT fk_orders_client FOREIGN KEY(idOrderClient) REFERENCES clients(idClient)
);

+---------+---------------+-------------+------------------+---------+-------------+
| idOrder | idOrderClient | orderStatus | orderDescription | freight | paymentCash |
+---------+---------------+-------------+------------------+---------+-------------+
|       7 |             9 | Confirmado  | NULL             |    NULL |           1 |
|       8 |            10 | NULL        | site             |     150 |           0 |
|       9 |             7 | Processando | aplicativo       |    NULL |           1 |
|      10 |             8 | Processando | aplicativo       |      50 |           0 |
|      11 |             9 | Confirmado  | NULL             |    NULL |           1 |
|      12 |            10 | Processando | site             |     150 |           0 |
|      13 |             8 | Processando | NULL             |    NULL |        NULL |
+---------+---------------+-------------+------------------+---------+-------------+
7 rows in set (0,00 sec)


ALTER TABLE orders auto_increment=1;

-- a professora Juliana e eu tentamos escrever boolean mas nem o workbench e nem o mysql cli deixaram e trocaram por tinyint-
-- e o que é tinyint? É pequeno inteiro e booleano é um pequeno inteiro -
-- true é 1 e false é 0 e é o que está escrito na linha paymentoCash - 
 
-- TABLE ESTOQUE --
CREATE TABLE productStorage(
      idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
      storageLocation VARCHAR(255),
      quantity INT DEFAULT 0      
);
--Query OK, 0 rows affected (2,98 sec)

ALTER TABLE productStorage auto_increment=1;

+---------------+-----------------+----------+
| idProdStorage | storageLocation | quantity |
+---------------+-----------------+----------+
|             1 | RJ              |     1000 |
|             2 | RJ              |      500 |
|             3 | SP              |       10 |
|             4 | SP              |      100 |
|             5 | SP              |       10 |
|             6 | DF              |       60 |
+---------------+-----------------+----------+
6 rows in set (0,00 sec)

-- TABLE FORNECEDOR --
CREATE TABLE supplier(
      idSupplier INT AUTO_INCREMENT PRIMARY KEY,
      SocialName VARCHAR(45) NOT NULL,
      CNPJ CHAR(14) NOT NULL,
      Telefone VARCHAR(12) NOT NULL,
      CONSTRAINT unique_supplier UNIQUE(CNPJ)       
);

+------------+----------------+----------------+-------------+
| idSupplier | SocialName     | CNPJ           | Telefone    |
+------------+----------------+----------------+-------------+
|          1 | Almeida & Sons | 12345678901234 | 21987788323 |
|          2 | Eletrosilva    | 43210987654321 | 21999777546 |
|          3 | EletroWilma    | 97745677902222 | 21974987927 |
+------------+----------------+----------------+-------------+
3 rows in set (0,00 sec)
--Query OK, 0 rows affected (3,65 sec)

ALTER TABLE supplier auto_increment=1;

-- TABLE VENDEDOR --
-- AQUI TROQUEI SELLER POR VENDOR --
-- VENDOR SERVE PARA FORNECEDOR E PARA VENDEDOR --
CREATE TABLE vendor(
      idVendor INT AUTO_INCREMENT PRIMARY KEY,
      socialName VARCHAR(45) NOT NULL,
      abstName VARCHAR(45),
      cnpj CHAR(14),
      cpf CHAR(11),
      endereço VARCHAR(45),
      telefone VARCHAR(12) NOT NULL,
      CONSTRAINT unique_socialname_vendor UNIQUE(socialName),
      CONSTRAINT unique_cnpj_vendor UNIQUE(cnpj),
      CONSTRAINT unique_cpf_vendor UNIQUE(cpf)              
);

--Query OK, 0 rows affected (3,95 sec)--

ALTER TABLE vendor auto_increment=1;

+----------+-----------------+----------+----------------+-------------+----------------+-------------+
| idVendor | socialName      | abstName | cnpj           | cpf         | endereço       | telefone    |
+----------+-----------------+----------+----------------+-------------+----------------+-------------+
|        1 | ElekTechTronics | NULL     | 12345678900034 | NULL        | RJ-RJ          | 21996669966 |
|        2 | Pedro Butikis   | NULL     | NULL           | 12332178904 | Petrópolis-RJ  | 21997677975 |
|        3 | Kinderwelten    | NULL     | 41734978123456 | NULL        | FrioBurgo-RJ   | 21997878943 |
+----------+-----------------+----------+----------------+-------------+----------------+-------------+
3 rows in set (0,01 sec)

-- TABLE productVendor --
CREATE TABLE productVendor(
      idPvendor INT,
      idPproduct INT,
      prodQuantity INT DEFAULT 1,
      PRIMARY KEY (idPvendor, idPproduct),
      CONSTRAINT fk_product_vendor foreign key (idPvendor) REFERENCES vendor(idVendor),  
      CONSTRAINT fk_product_product foreign key (idPproduct) REFERENCES product(idProduct)
);

+-----------+------------+--------------+
| idPvendor | idPproduct | prodQuantity |
+-----------+------------+--------------+
|         1 |          6 |           80 |
|         2 |          7 |           10 |
+-----------+------------+--------------+
2 rows in set (0,00 sec)

-- TABLE productOrder --
CREATE TABLE productOrder(
      idPOproduct INT,
      idPOorder INT,
      poQuantity INT DEFAULT 1,
      poStatus enum('Disponível', 'Sem Estoque') DEFAULT 'Disponível',
      PRIMARY KEY (idPOproduct, idPOorder),
      CONSTRAINT fk_productorder_vendor foreign key (idPOproduct) REFERENCES product(idProduct),  
      CONSTRAINT fk_productorder_product foreign key (idPOorder) REFERENCES orders(idOrder)
);
-- Query OK, 0 rows affected (3,30 sec)
-------------+-----------+------------+----------+
| idPOproduct | idPOorder | poQuantity | poStatus |
+-------------+-----------+------------+----------+
|           1 |         9 |          2 | NULL     |
|           2 |        10 |          1 | NULL     |
|           3 |        11 |          1 | NULL     |
+-------------+-----------+------------+----------+
3 rows in set (0,00 sec)


-- TABLE storageLocation-
CREATE TABLE storageLocation(
      idLproduct INT,
      idLstorage INT, 
      location VARCHAR(255) NOT NULL,
      PRIMARY KEY (idLproduct, idLstorage),
      CONSTRAINT fk_storage_location_product foreign key (idLproduct) REFERENCES product(idProduct),
      CONSTRAINT fk_storage_location_storage foreign key (idLstorage) REFERENCES productStorage(idProdStorage)
);
      
-- Query OK, 0 rows affected (3,57 sec)
+------------+------------+----------+
| idLproduct | idLstorage | location |
+------------+------------+----------+
|          1 |          2 | RJ       |
|          2 |          6 | GO       |
+------------+------------+----------+
2 rows in set (0,00 sec)

-- TABLE productSupplier --
CREATE TABLE productSupplier(
      idPsSupplier INT,
      idPsProduct INT,
      quantity INT NOT NULL,
      PRIMARY KEY (idPsSupplier, idPsProduct),
      CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) references supplier(idSupplier),
      CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) references product(idProduct)
);
--Query OK, 0 rows affected (2,73 sec)
+--------------+-------------+----------+
| idPsSupplier | idPsProduct | quantity |
+--------------+-------------+----------+
|            1 |           1 |      500 |
|            1 |           2 |      400 |
|            2 |           4 |      633 |
|            2 |           5 |       10 |
|            3 |           3 |        5 |
+--------------+-------------+----------+
5 rows in set (0,00 sec)


-- TABLE ENTREGAS --
CREATE TABLE deliveries(
      trackingCode INT(10),
      deliveryStatus ENUM ('Em separação','Em transporte', 'Entregue'),
      CONSTRAINT fk_deliveries_trackingcode FOREIGN KEY (trackingCode) references product(IdProduct),
      CONSTRAINT fk_deliveries_deliverystatus FOREIGN KEY (trackingCode) references clients(idClient)
);
--2 rows in set (0,01 sec)--
Empty set (0,00 sec)

mysql> show tables;
+---------------------+
| Tables_in_ecommerce |
+---------------------+
| clients             |
| deliveries          |
| orders              |
| payments            |
| product             |
| productOrder        |
| productStorage      |
| productSupplier     |
| productVendor       |
| storageLocation     |
| supplier            |
| vendor              |
+---------------------+
12 rows in set (0,00 sec)

--Banco de dados criado às 11:44 de 18 de setembro de 2022--
-- Observação: uso linux baseado em ubuntu -- 
-- Como não consegui conectar o workbench ao mysql, fiz assim:
-- 1. abri o editor de texto xed e salvei com extensão .sql
-- 2. copiei as tabelas para o mysql cli e implementei --
-- 3. quando dava erro, revisava o texto do editor de texto e tentava de novo até implementar a tabela.

