# Desafio3-SQL
-- DIO: bootcamp database experience- desafio 3: Construindo seu primeiro projeto lógico de banco de dados

# Quanto aos refinamentos:
Criei duas novas tabelas:
- payments
- deliveries

# Quanto às queries:
Algumas das perguntas que podes fazer para embasar as queries SQL:

## 1. Quantos pedidos foram feitos por cada cliente?
-- devolve número de pedidos por cliente --
SELECT c.idClient, Pnome, COUNT(*) AS numbers_of_orders FROM clients c INNER JOIN orders o ON c.idClient = o.idOrderClient
                    GROUP BY idClient;
+----------+---------+-------------------+
| idClient | Pnome   | numbers_of_orders |
+----------+---------+-------------------+
|        7 | Marta   |                 1 |
|        8 | Mateus  |                 2 |
|        9 | Ricardo |                 2 |
|       10 | Julia   |                 2 |
+----------+---------+-------------------+
-- 4 rows in set (0,00 sec)      

## 2. Algum vendedor também é fornecedor? --show
SELECT s.SocialName, COUNT(*) AS Vendor_is_Supplier FROM supplier s INNER JOIN vendor v ON s.SocialName = v.socialName
                    GROUP BY idSupplier;
--Empty set (0,00 sec)--

## 3. Relação de produtos de fornecedores e de estoques;
SELECT CONCAT (Pnome,' --> ',SocialName,' --> ', idProdStorage) AS Produtos_Fornecedores_Estoque FROM product p, supplier s, productStorage ps  where p.idProduct = s.idSupplier = ps.idProdStorage;
+-------------------------------------+
| Produtos_Fornecedores_Estoque       |
+-------------------------------------+
| Fones ouv. --> Almeida & Sons --> 1 |
| Barbie E. --> Eletrosilva --> 1     |
| Body P. --> EletroWilma --> 1       |
+-------------------------------------+
3 rows in set (0,00 sec)

## 4.Relação de nomes dos fornecedores e de nomes dos produtos;
SELECT CONCAT (SocialName,' --> ', Pnome) AS Fornecedores_Produtos FROM supplier s, product p where p.idProduct = s.idSupplier;
+-------------------------------+
| Fornecedores_Produtos         |
+-------------------------------+
| Almeida & Sons --> Fones ouv. |
| Eletrosilva --> Barbie E.     |
| EletroWilma --> Body P.       |
+-------------------------------+
3 rows in set (0,00 sec)


## 5. order by --
SELECT * FROM clients
      ORDER BY Sobrenome;
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
| idClient | Pnome   | Miniciais | Sobrenome | CPF         | Endereco                                     | CEP      | Telefone    |
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
|       11 | Roberta | G         | Assis     | 98745612303 | Av. Köller, 190 - Centro - Frioburgo         | 20000001 | 21999775890 |
|       12 | Izabela | Z         | Diaz      | 12332177511 | Av. do Kaiser, 3220 - Lebom - Frioburgo      | 20000003 | 21969966969 |
|       10 | Julia   | S         | França    | 78912345699 | R. das Laranjeiras, 862 - Centro - Frioburgo | 20000001 | 21999888775 |
|        8 | Mateus  | O         | Pimentel  | 98765432101 | R. da Alameda, 289 - Centro - Frioburgo      | 20000001 | 21999777555 |
|        7 | Marta   | M         | Silva     | 12345678912 | R. Silva Prata, 29 - Lebom - Frioburgo       | 20000003 | 21999777456 |
|        9 | Ricardo | F         | Silva     | 45678912321 | Av. das Vinhas, 1009 - Centro - Frioburgo    | 20000001 | 21999775776 |
+----------+---------+-----------+-----------+-------------+----------------------------------------------+----------+-------------+
6 rows in set (0,00 sec)


## 6-- having --

SELECT idProdStorage, quantity, count(*)
      From productStorage
      WHERE quantity >=100
      GROUP BY idProdStorage
      HAVING COUNT(*) >=1
      ORDER BY quantity;
+---------------+----------+----------+
| idProdStorage | quantity | count(*) |
+---------------+----------+----------+
|             4 |      100 |        1 |
|             2 |      500 |        1 |
|             1 |     1000 |        1 |
+---------------+----------+----------+
3 rows in set (0,00 sec)
