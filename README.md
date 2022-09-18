# Desafio3-SQL
-- DIO: bootcamp database experience- desafio 3: Construindo seu primeiro projeto lógico de banco de dados

# Quanto aos refinamentos:
Criei duas novas tabelas:
- payments
- deliveries

# Quanto às queries:
Algumas das perguntas que podes fazer para embasar as queries SQL:

## 1. Quantos pedidos foram feitos por cada cliente?
#### devolve número de pedidos por cliente --
##### SELECT c.idClient, Pnome, COUNT(*) AS numbers_of_orders FROM clients c INNER JOIN orders o ON c.idClient = o.idOrderClient
#####                    GROUP BY idClient;

![1stQuestion](https://github.com/geosidnei/Desafio3-SQL/blob/main/1stQuestion.png)


## 2. Algum vendedor também é fornecedor?
##### SELECT s.SocialName, COUNT(*) AS Vendor_is_Supplier FROM supplier s INNER JOIN vendor v ON s.SocialName = v.socialName
#####                    GROUP BY idSupplier;
###### --Empty set (0,00 sec)--

## 3. Relação de produtos de fornecedores e de estoques;
##### SELECT CONCAT (Pnome,' --> ',SocialName,' --> ', idProdStorage) AS Produtos_Fornecedores_Estoque FROM product p, supplier s, productStorage ps  where ##### p.idProduct = s.idSupplier = ps.idProdStorage;

![3rdQuestion](https://github.com/geosidnei/Desafio3-SQL/blob/main/3rdQuestion.png)


## 4.Relação de nomes dos fornecedores e de nomes dos produtos;
##### SELECT CONCAT (SocialName,' --> ', Pnome) AS Fornecedores_Produtos FROM supplier s, product p where p.idProduct = s.idSupplier;

![4thQuestion](https://github.com/geosidnei/Desafio3-SQL/blob/main/4thQuestion.png)

## 5. order by --
##### SELECT * FROM clients
#####      ORDER BY Sobrenome;

![5thQuestion](https://github.com/geosidnei/Desafio3-SQL/blob/main/5thQuestion.png)
## 6-- having --

##### SELECT idProdStorage, quantity, count(*)
#####      From productStorage
#####      WHERE quantity >=100
#####      GROUP BY idProdStorage
#####      HAVING COUNT(*) >=1
#####      ORDER BY quantity;
![6thQuestion](https://github.com/geosidnei/Desafio3-SQL/blob/main/6thQuestion.png)
