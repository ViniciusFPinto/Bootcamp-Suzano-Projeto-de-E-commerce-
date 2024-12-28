-- Criação de Banco de Dados para o Cenário de E-Comerce
create database ecomerce;
use ecomerce;

-- Criar Tabelas

-- Criar Tabelas Pedido

CREATE TABLE IF NOT EXISTS Pedido(
  ID_Pedido INT auto_increment,
  Data DATETIME,
  Status VARCHAR(100) NOT NULL DEFAULT 'Em Processamento',
  Descricao VARCHAR(100) NULL,
  Tipo_Frete FLOAT NOT NULL,
  Tipo_Pagamento VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_Pedido)
  );
ALTER TABLE Pedido CHANGE Staus Status VARCHAR(100) NOT NULL DEFAULT 'Em Processamento';
  
  
-- Criar tabela Cliente

CREATE TABLE IF NOT EXISTS Cliente(
	ID_Cliente INT auto_increment,
	Nome VARCHAR(45) NOT NULL,
	Tipo VARCHAR(45) NOT NULL DEFAULT 'CPF',
	CPF_CNPJ VARCHAR(14) NOT NULL,
	Endereco VARCHAR(150) NULL,
	Pedido_ID_Pedido INT NOT NULL,
	PRIMARY KEY (ID_Cliente),
	FOREIGN KEY (Pedido_ID_Pedido) REFERENCES Pedido(ID_Pedido)
	);
	CREATE UNIQUE INDEX CPF_CNPJ_UNIQUE ON Cliente (CPF_CNPJ ASC);
    
  
-- Criar a Tabela Produto
  
CREATE TABLE IF NOT EXISTS Produto( 
	ID_Produto INT auto_increment, 
    NomeProd VARCHAR(100) NOT NULL, 
    PrecoProd DECIMAL(10,2) NOT NULL, 
    Descricao VARCHAR(200) NULL, 
    Categoria VARCHAR(45) NOT NULL, 
    PRIMARY KEY (ID_Produto)
    );
    
    
-- Criar a Tabela Estoque 
    
	CREATE TABLE IF NOT EXISTS Estoque( 
		ID_Estoque INT NOT NULL, 
        Local VARCHAR(45) NOT NULL, 
        PRIMARY KEY (ID_Estoque)
        );
        
	
-- Criar Tabela Fornecedor 
	CREATE TABLE IF NOT EXISTS Fornecedor(
		ID_Fornecedor INT NOT NULL, 
        Razao_Social VARCHAR(100) NOT NULL, 
        CNPJ VARCHAR(45) NOT NULL, PRIMARY KEY (ID_Fornecedor)
        );
	CREATE UNIQUE INDEX CNPJ_UNIQUE ON Fornecedor (CNPJ ASC); 
	CREATE UNIQUE INDEX Razao_Social_UNIQUE ON Fornecedor (Razao_Social ASC);
  
  
-- Criar Tabela Produto por Estoque
  
	CREATE TABLE IF NOT EXISTS Produto_por_Estoque(
		Produto_ID_Produto INT NOT NULL, 
        Estoque_ID_Estoque INT NOT NULL, 
        Quantidade INT NOT NULL DEFAULT 0, 
        PRIMARY KEY (Produto_ID_Produto, Estoque_ID_Estoque), 
        FOREIGN KEY (Produto_ID_Produto) REFERENCES Produto(ID_Produto), 
        FOREIGN KEY (Estoque_ID_Estoque) REFERENCES Estoque(ID_Estoque)
        );
        

-- Criar Tabela Produto por Fornecedor

	CREATE TABLE IF NOT EXISTS Produto_por_Fornecedor(
		Fornecedor_ID_Fornecedor INT NOT NULL, 
        Produto_ID_Produto INT NOT NULL, 
        Quantidade INT NOT NULL DEFAULT 0, 
        PRIMARY KEY (Fornecedor_ID_Fornecedor, Produto_ID_Produto), 
        FOREIGN KEY (Fornecedor_ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor), 
        FOREIGN KEY (Produto_ID_Produto) REFERENCES Produto(ID_Produto)
        );
        
        
  -- Criar a Tabela Produto por Pedido
  
  CREATE TABLE IF NOT EXISTS Produto_por_Pedido(
	Pedido_ID_Pedido INT NOT NULL, 
    Produto_ID_Produto INT NOT NULL, 
    Quant_Prod INT NOT NULL DEFAULT 0, 
    Confirmacao_Pagamento VARCHAR(45) NOT NULL DEFAULT 'Em Processamento', 
    PRIMARY KEY (Pedido_ID_Pedido, Produto_ID_Produto), 
    FOREIGN KEY (Pedido_ID_Pedido) REFERENCES Pedido(ID_Pedido), 
    FOREIGN KEY (Produto_ID_Produto) REFERENCES Produto(ID_Produto)
    );
  

  -- Criar Tabela Entrega
  
  CREATE TABLE IF NOT EXISTS Entrega(
  ID_Entrega INT AUTO_INCREMENT,
  Codigo_de_Rastreio VARCHAR(45) NOT NULL,
  Status_da_Entrega VARCHAR(45) NOT NULL DEFAULT 'Em Processamento',
  Produto_por_Pedido_Pedido_ID_Pedido INT NOT NULL,
  Produto_por_Pedido_Produto_ID_Produto INT NOT NULL,
  PRIMARY KEY (ID_Entrega),
  FOREIGN KEY (Produto_por_Pedido_Pedido_ID_Pedido) REFERENCES Produto_por_Pedido(Pedido_ID_Pedido),
  FOREIGN KEY (Produto_por_Pedido_Produto_ID_Produto) REFERENCES Produto_por_Pedido(Produto_ID_Produto)
  );
  
  
-- Criar Tabela Vendedor Terceiro
  
CREATE TABLE IF NOT EXISTS Terceiro_Vendedor( 
	ID_Vendedor INT NOT NULL, Razao_Social VARCHAR(45) NOT NULL, 
	CNPJ VARCHAR(45) NOT NULL, 
	Endereco VARCHAR(45) NULL, 
	PRIMARY KEY (ID_Vendedor)
    );
    CREATE UNIQUE INDEX Razao_Social_UNIQUE ON Terceiro_Vendedor (Razao_Social ASC);
    CREATE UNIQUE INDEX CNPJ_UNIQUE ON Terceiro_Vendedor (CNPJ ASC);
    
    
-- Criar Tabela Produto por Vendedor Terceiro

CREATE TABLE IF NOT EXISTS Produto_por_Vendedor_Terceiro( 
	Terceiro_Vendedor_ID_Vendedor INT NOT NULL, 
    Produto_ID_Produto INT NOT NULL, Quantidade INT NOT NULL DEFAULT 0, 
    PRIMARY KEY (Terceiro_Vendedor_ID_Vendedor, Produto_ID_Produto), 
    FOREIGN KEY (Terceiro_Vendedor_ID_Vendedor) REFERENCES Terceiro_Vendedor(ID_Vendedor), 
    FOREIGN KEY (Produto_ID_Produto) REFERENCES Produto(ID_Produto)
    );
  
  
  
  -- Inserir dados na tabela Pedido
INSERT INTO Pedido (Data, Staus, Descricao, Tipo_Frete, Tipo_Pagamento) VALUES
('2024-12-01 10:00:00', 'Concluído', 'Pedido de natal', 15.50, 'Cartão de Crédito'),
('2024-12-05 14:30:00', 'Em Processamento', 'Pedido de aniversário', 20.00, 'Boleto');


-- Inserir dados na tabela Produto
INSERT INTO Produto (ID_Produto, NomeProd, PrecoProd, Descricao, Categoria) VALUES
(1, 'Notebook', 2500.00, 'Notebook com 16GB RAM', 'Eletrônicos'),
(2, 'Smartphone', 1500.00, 'Smartphone com 64GB de armazenamento', 'Eletrônicos');

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (ID_Cliente, Nome, Tipo, CPF_CNPJ, Endereco, Pedido_ID_Pedido) VALUES
(1, 'João Silva', 'CPF', '12345678901', 'Rua A, 123', 1),
(2, 'Maria Souza', 'CNPJ', '12345678000199', 'Av. B, 456', 2);

-- Inserir dados na tabela Estoque
INSERT INTO Estoque (ID_Estoque, Local) VALUES
(1, 'Armazém Central'),
(2, 'Armazém Leste');

-- Inserir dados na tabela Fornecedor
INSERT INTO Fornecedor (ID_Fornecedor, Razao_Social, CNPJ) VALUES
(1, 'Tech Supply', '12345678000101'),
(2, 'Mobile Distribuidora', '98765432000111');

-- Inserir dados na tabela Produto_por_Estoque
INSERT INTO Produto_por_Estoque (Produto_ID_Produto, Estoque_ID_Estoque, Quantidade) VALUES
(1, 1, 50),
(2, 2, 30);

-- Inserir dados na tabela Produto_por_Fornecedor
INSERT INTO Produto_por_Fornecedor (Fornecedor_ID_Fornecedor, Produto_ID_Produto, Quantidade) VALUES
(1, 1, 100),
(2, 2, 200);

-- Inserir dados na tabela Produto_por_Pedido
INSERT INTO Produto_por_Pedido (Pedido_ID_Pedido, Produto_ID_Produto, Quant_Prod, Confirmacao_Pagamento) VALUES
(1, 1, 1, 'Pago'),
(2, 2, 2, 'Em Processamento');

-- Inserir dados na tabela Entrega
INSERT INTO Entrega (Codigo_de_Rastreio, Status_da_Entrega, Produto_por_Pedido_Pedido_ID_Pedido, Produto_por_Pedido_Produto_ID_Produto) VALUES
('ABC123', 'Em Processamento', 1, 1),
('XYZ456', 'Enviado', 2, 2);

-- Inserir dados na tabela Terceiro_Vendedor
INSERT INTO Terceiro_Vendedor (ID_Vendedor, Razao_Social, CNPJ, Endereco) VALUES
(1, 'EletroShop', '22233344000155', 'Rua C, 789'),
(2, 'GadgetHouse', '33344455000166', 'Av. D, 987');

-- Inserir dados na tabela Produto_por_Vendedor_Terceiro
INSERT INTO Produto_por_Vendedor_Terceiro (Terceiro_Vendedor_ID_Vendedor, Produto_ID_Produto, Quantidade) VALUES
(1, 1, 20),
(2, 2, 50);

-- Inserir dados na tabela Pedido
INSERT INTO Pedido (Data, Status, Descricao, Tipo_Frete, Tipo_Pagamento) VALUES
('2024-12-01 10:00:00', 'Concluído', 'Pedido de natal', 15.50, 'Cartão de Crédito'),
('2024-12-05 14:30:00', 'Em Processamento', 'Pedido de aniversário', 20.00, 'Boleto'),
('2024-12-10 09:15:00', 'Enviado', 'Pedido de black friday', 10.00, 'Cartão de Débito'),
('2024-12-15 16:45:00', 'Cancelado', 'Pedido de teste', 25.00, 'PayPal');

INSERT INTO Pedido (Data, Status, Descricao, Tipo_Frete, Tipo_Pagamento) VALUES
('2024-12-01 10:00:00', 'Concluído', 'Pedido de natal', 15.50, 'Cartão de Crédito'),
('2024-12-05 14:30:00', 'Em Processamento', 'Pedido de aniversário', 20.00, 'Boleto'),
('2024-12-10 09:15:00', 'Enviado', 'Pedido de black friday', 10.00, 'Cartão de Débito'),
('2024-12-15 16:45:00', 'Cancelado', 'Pedido de teste', 25.00, 'PayPal'),
('2024-12-20 12:00:00', 'Concluído', 'Pedido de final de ano', 18.00, 'Cartão de Crédito'),
('2024-12-25 18:30:00', 'Concluído', 'Pedido de natal 2', 15.00, 'Boleto'),
('2025-01-05 11:00:00', 'Em Processamento', 'Pedido de ano novo', 22.00, 'Cartão de Débito'),
('2025-01-10 17:45:00', 'Enviado', 'Pedido de janeiro', 12.50, 'PayPal'),
('2025-01-15 14:00:00', 'Concluído', 'Pedido de aniversário 2', 20.00, 'Cartão de Crédito'),
('2025-01-20 10:30:00', 'Cancelado', 'Pedido de teste 2', 30.00, 'Boleto');


-- Inserir dados na tabela Produto
INSERT INTO Produto (ID_Produto, NomeProd, PrecoProd, Descricao, Categoria) VALUES
(3, 'Notebook', 2500.00, 'Notebook com 16GB RAM', 'Eletrônicos'),
(4, 'Smartphone', 1500.00, 'Smartphone com 64GB de armazenamento', 'Eletrônicos'),
(5, 'Televisão', 3000.00, 'Smart TV 4K', 'Eletrônicos'),
(6, 'Tablet', 800.00, 'Tablet com 32GB de armazenamento', 'Eletrônicos');

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (ID_Cliente, Nome, Tipo, CPF_CNPJ, Endereco, Pedido_ID_Pedido) VALUES
(3, 'Carlos Pereira', 'CPF', '98765432109', 'Rua C, 789', 3),
(4, 'Ana Martins', 'CPF', '11122233344', 'Av. D, 987', 4),
(5, 'Pedro Oliveira', 'CPF', '22334455667', 'Rua E, 654', 1),
(6, 'Laura Nunes', 'CNPJ', '33445566000122', 'Av. F, 321', 2);


-- Inserir dados na tabela Cliente
INSERT INTO Cliente (Status, Nome, Tipo, CPF_CNPJ, Endereco, Pedido_ID_Pedido) VALUES
(7, 'João Carlos Santos', 'CPF', '12345678905', 'Rua A, 123', 1),
(8, 'Ana Maria Souza', 'CNPJ', '12345678000499', 'Av. B, 456', 2),
(9, 'Mariana Lima', 'CPF', '55667788900', 'Rua G, 888', 7),
(10, 'Lucas Mendes', 'CPF', '66778899011', 'Av. H, 999', 8),
(11, 'Fernanda Almeida', 'CPF', '77889900452', 'Rua I, 777', 9),
(12, 'Ricardo Souza', 'CPF', '88990011233', 'Av. J, 666', 10),
(13, 'Bianca Silva', 'CPF', '99001122349', 'Rua K, 555', 1),
(14, 'Thiago Melo', 'CPF', '00112233445', 'Av. L, 444', 2);


select * from Cliente;


-- Inserir dados na tabela Estoque
INSERT INTO Estoque (ID_Estoque, Local) VALUES
(4, 'Armazém Central'),
(5, 'Armazém Leste'),
(6, 'Armazém Norte');

-- Inserir dados na tabela Fornecedor
INSERT INTO Fornecedor (ID_Fornecedor, Razao_Social, CNPJ) VALUES
(3, 'Home Tech', '11223344000155'), 
(4, 'Super Tech', '55667788000199'), 
(5, 'Inova Supply', '66778899000122'), 
(6, 'Tech Solutions', '77889900000133');

select * from Fornecedor;


-- Adicionando verificação para evitar duplicação
INSERT IGNORE INTO Estoque (ID_Estoque, Local) VALUES
(1, 'Armazém Central'),
(2, 'Armazém Leste'),
(3, 'Armazém Norte');

-- Inserir ou atualizar o local do ID_Estoque 5 para Sul
INSERT INTO Estoque (ID_Estoque, Local) VALUES
(5, 'Sul')
ON DUPLICATE KEY UPDATE Local = 'Armazém Sul';

-- Inserir ou atualizar o local do ID_Estoque 6 para Oeste
INSERT INTO Estoque (ID_Estoque, Local) VALUES
(6, 'Norte')
ON DUPLICATE KEY UPDATE Local = 'Armazém Oeste';

-- Inserir ou atualizar o local do ID_Estoque 4 para Canto
INSERT INTO Estoque (ID_Estoque, Local) VALUES
(4, 'Central')
ON DUPLICATE KEY UPDATE Local = 'Armazém Oeste';


Select * From Estoque;



-- Inserir dados na tabela Produto_por_Estoque
INSERT INTO Produto_por_Estoque (Produto_ID_Produto, Estoque_ID_Estoque, Quantidade) VALUES
(3, 3, 20),
(4, 1, 10),
(2, 1, 15), 
(1, 2, 25),
(3, 1, 5),
(4, 2, 40);

select * from Produto_por_Estoque;

-- Inserir dados na tabela Produto_por_Fornecedor
INSERT INTO Produto_por_Fornecedor (Fornecedor_ID_Fornecedor, Produto_ID_Produto, Quantidade) VALUES
(3, 3, 150),
(1, 4, 50),
(2, 1, 75), 
(3, 2, 60), 
(1, 3, 90); 

select * from Produto_por_Fornecedor;

-- Inserir dados na tabela Produto_por_Pedido
INSERT INTO Produto_por_Pedido (Pedido_ID_Pedido, Produto_ID_Produto, Quant_Prod, Confirmacao_Pagamento) VALUES
(3, 1, 1, 'Pago'),
(4, 2, 2, 'Em Processamento'),
(5, 3, 1, 'Pago'),
(6, 4, 1, 'Cancelado');

-- Inserir dados na tabela Entrega
INSERT INTO Entrega (Codigo_de_Rastreio, Status_da_Entrega, Produto_por_Pedido_Pedido_ID_Pedido, Produto_por_Pedido_Produto_ID_Produto) VALUES
('ABC123', 'Em Processamento', 1, 1),
('XYZ456', 'Enviado', 2, 2),
('LMN789', 'Concluído', 3, 3),
('QWE123', 'Cancelado', 4, 4);

-- Inserir dados na tabela Terceiro_Vendedor
INSERT INTO Terceiro_Vendedor (ID_Vendedor, Razao_Social, CNPJ, Endereco) VALUES
(3, 'NiltonShop', '22233344002525', 'Rua W, 790'),
(4, 'LionStore', '33344455007723', 'Av. X, 988'),
(5, 'TechMart', '44455566000177', 'Rua E, 654');

Select * from Terceiro_Vendedor;

-- Inserir dados na tabela Produto_por_Vendedor_Terceiro
INSERT INTO Produto_por_Vendedor_Terceiro (Terceiro_Vendedor_ID_Vendedor, Produto_ID_Produto, Quantidade) VALUES
(3, 3, 30),
(1, 4, 10),
(2, 1, 15), 
(3, 2, 25), 
(1, 3, 35), 
(2, 4, 45);

Select * From Produto_por_Vendedor_Terceiro;


INSERT INTO Pedido (Data, Status, Descricao, Tipo_Frete, Tipo_Pagamento) VALUES
('2025-01-25 10:00:00', 'Concluído', 'Pedido de Carnaval', 20.00, 'Cartão de Crédito'),
('2025-01-30 14:30:00', 'Em Processamento', 'Pedido de Verão', 18.00, 'Boleto'),
('2025-02-05 09:15:00', 'Enviado', 'Pedido de liquidação', 12.00, 'Cartão de Débito'),
('2025-02-10 16:45:00', 'Cancelado', 'Pedido de teste 3', 28.00, 'PayPal');

INSERT INTO Produto (ID_Produto, NomeProd, PrecoProd, Descricao, Categoria) VALUES
(7, 'Câmera', 1200.00, 'Câmera digital 20MP', 'Eletrônicos'),
(8, 'Fone de Ouvido', 300.00, 'Fone de ouvido sem fio', 'Eletrônicos');


INSERT INTO Cliente (ID_Cliente, Nome, Tipo, CPF_CNPJ, Endereco, Pedido_ID_Pedido) VALUES
(15, 'Roberto Silva', 'CPF', '99887766554', 'Rua M, 123', 5),
(16, 'Juliana Lima', 'CPF', '88776655443', 'Av. N, 456', 6);

INSERT INTO Estoque (ID_Estoque, Local) VALUES
(7, 'Armazém Sul'),
(8, 'Armazém Oeste');

INSERT INTO Fornecedor (ID_Fornecedor, Razao_Social, CNPJ) VALUES
(7, 'Future Tech', '99887766000144'),
(8, 'Digital Supplies', '88776655000133');

INSERT INTO Produto_por_Estoque (Produto_ID_Produto, Estoque_ID_Estoque, Quantidade) VALUES
(5, 7, 40),
(6, 8, 50),
(7, 4, 60),
(8, 5, 30);

INSERT INTO Produto_por_Fornecedor (Fornecedor_ID_Fornecedor, Produto_ID_Produto, Quantidade) VALUES
(4, 5, 100),
(5, 6, 120),
(7, 7, 80),
(8, 8, 90);

INSERT INTO Produto_por_Pedido (Pedido_ID_Pedido, Produto_ID_Produto, Quant_Prod, Confirmacao_Pagamento) VALUES
(5, 5, 1, 'Pago'),
(6, 6, 2, 'Em Processamento'),
(7, 7, 3, 'Pago'),
(8, 8, 4, 'Cancelado');

INSERT INTO Entrega (Codigo_de_Rastreio, Status_da_Entrega, Produto_por_Pedido_Pedido_ID_Pedido, Produto_por_Pedido_Produto_ID_Produto) VALUES
('FGH789', 'Em Processamento', 5, 5),
('IJK123', 'Enviado', 6, 6),
('LMO456', 'Concluído', 7, 7),
('NOP789', 'Cancelado', 8, 8);

INSERT INTO Terceiro_Vendedor (ID_Vendedor, Razao_Social, CNPJ, Endereco) VALUES
(6, 'GadgetPro', '55566677000188', 'Rua Q, 432'),
(7, 'TechWorld', '66677788000199', 'Av. R, 123');

INSERT INTO Produto_por_Vendedor_Terceiro (Terceiro_Vendedor_ID_Vendedor, Produto_ID_Produto, Quantidade) VALUES
(3, 5, 20),
(4, 6, 50),
(6, 7, 30),
(7, 8, 40);



-- Pesquisas

-- Número de Pedidos Feitos por Cliente
SELECT Cliente.Nome, COUNT(Pedido.ID_Pedido) AS Total_Pedidos 
FROM Cliente 
JOIN Pedido ON Cliente.Pedido_ID_Pedido = Pedido.ID_Pedido 
GROUP BY Cliente.Nome;


-- Relação Entre Produto, Fornecedor e Estoque
SELECT Produto.NomeProd, Fornecedor.Razao_Social, Estoque.Local
FROM Produto
JOIN Produto_por_Fornecedor ON Produto.ID_Produto = Produto_por_Fornecedor.Produto_ID_Produto
JOIN Fornecedor ON Produto_por_Fornecedor.Fornecedor_ID_Fornecedor = Fornecedor.ID_Fornecedor
JOIN Produto_por_Estoque ON Produto.ID_Produto = Produto_por_Estoque.Produto_ID_Produto
JOIN Estoque ON Produto_por_Estoque.Estoque_ID_Estoque = Estoque.ID_Estoque;


-- Relação Entre Nomes dos Fornecedores e Nomes dos Produtos
SELECT Fornecedor.Razao_Social, Produto.NomeProd
FROM Fornecedor
JOIN Produto_por_Fornecedor ON Fornecedor.ID_Fornecedor = Produto_por_Fornecedor.Fornecedor_ID_Fornecedor
JOIN Produto ON Produto_por_Fornecedor.Produto_ID_Produto = Produto.ID_Produto;


-- Relação de Produtos Mais Vendidos e Suas Quantidades
SELECT Produto.NomeProd, SUM(Produto_por_Pedido.Quant_Prod) AS Quantidade_Vendida
FROM Produto
JOIN Produto_por_Pedido ON Produto.ID_Produto = Produto_por_Pedido.Produto_ID_Produto
GROUP BY Produto.NomeProd
ORDER BY Quantidade_Vendida DESC;


-- Estoques com Maior Quantidade de Produtos
SELECT Estoque.Local, SUM(Produto_por_Estoque.Quantidade) AS Total_Quantidade
FROM Estoque
JOIN Produto_por_Estoque ON Estoque.ID_Estoque = Produto_por_Estoque.Estoque_ID_Estoque
GROUP BY Estoque.Local
ORDER BY Total_Quantidade DESC;


-- Relação de Fornecedores e Número de Produtos Fornecidos
SELECT Fornecedor.Razao_Social, COUNT(Produto_por_Fornecedor.Produto_ID_Produto) AS Numero_Produtos
FROM Fornecedor
JOIN Produto_por_Fornecedor ON Fornecedor.ID_Fornecedor = Produto_por_Fornecedor.Fornecedor_ID_Fornecedor
GROUP BY Fornecedor.Razao_Social
ORDER BY Numero_Produtos DESC;

-- Relação de Entregas com Status e Quantidade de Produtos Entregues
SELECT Entrega.Status_da_Entrega, COUNT(Entrega.Codigo_de_Rastreio) AS Numero_Entregas, SUM(Produto_por_Pedido.Quant_Prod) AS Quantidade_Total
FROM Entrega
JOIN Produto_por_Pedido ON Entrega.Produto_por_Pedido_Pedido_ID_Pedido = Produto_por_Pedido.Pedido_ID_Pedido
AND Entrega.Produto_por_Pedido_Produto_ID_Produto = Produto_por_Pedido.Produto_ID_Produto
GROUP BY Entrega.Status_da_Entrega
ORDER BY Numero_Entregas DESC;


-- Relação de Vendedores e Quantidade de Produtos Vendidos
SELECT Terceiro_Vendedor.Razao_Social, SUM(Produto_por_Vendedor_Terceiro.Quantidade) AS Quantidade_Vendida
FROM Terceiro_Vendedor
JOIN Produto_por_Vendedor_Terceiro ON Terceiro_Vendedor.ID_Vendedor = Produto_por_Vendedor_Terceiro.Terceiro_Vendedor_ID_Vendedor
GROUP BY Terceiro_Vendedor.Razao_Social
ORDER BY Quantidade_Vendida DESC;
  