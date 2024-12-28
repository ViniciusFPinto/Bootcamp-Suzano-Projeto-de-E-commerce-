# Bootcamp-Suzano-Projeto-de-E-commerce-
Bem-vindo ao repositório do Projeto de E-commerce, desenvolvido como parte do Bootcamp de Análise de Dados com Power BI oferecido pela Suzano e Dio. Este projeto tem como objetivo modelar um cenário de e-commerce utilizando um Diagrama de Entidade-Relacionamento (DER) e implementá-lo no MySQL Workbench.

# E-commerce Database Project

## O que o projeto faz
Este projeto implementa um banco de dados para um sistema de e-commerce. O esquema lógico inclui tabelas para gerenciar pedidos, produtos, clientes, estoques, fornecedores, entregas e vendedores terceirizados. O objetivo é fornecer uma estrutura robusta para armazenar e consultar dados relacionados às operações de e-commerce.

## Por que o projeto é útil
- **Organização:** Estrutura clara e eficiente para armazenar dados essenciais de e-commerce.
- **Consultas Avançadas:** Possibilidade de realizar consultas SQL complexas para obter insights valiosos.
- **Escalabilidade:** O esquema pode ser facilmente expandido conforme as necessidades do negócio crescem.
- **Integração:** Suporte para gerenciar relacionamentos entre diferentes entidades do sistema (clientes, pedidos, produtos, etc.).

## Como os usuários podem começar a usar o projeto
1. **Configuração do Banco de Dados:**
   - Crie um novo banco de dados no seu sistema de gerenciamento de banco de dados (ex: MySQL, PostgreSQL).
   - Importe o esquema do banco de dados fornecido no arquivo `schema.sql`.

2. **Inserção de Dados:**
   - Use os scripts de inserção de dados fornecidos para popular as tabelas com dados de exemplo.

3. **Execução de Consultas:**
   - Utilize as consultas SQL complexas incluídas neste README para explorar os dados e obter insights.

## Onde os usuários podem obter ajuda com seu projeto
- **Documentação Oficial:** Consulte a documentação oficial do seu sistema de gerenciamento de banco de dados.
- **Comunidade Online:** Participe de fóruns e comunidades online como Stack Overflow para discutir e resolver dúvidas.
- **Contactar Contribuidores:** Entre em contato com os mantenedores do projeto para suporte e orientação.

## Quem mantém e contribui com o projeto
- **Nome do Mantenedor:** [Seu Nome]
- **E-mail:** [Seu E-mail]
- **Contribuidores:** [Lista de Contribuidores]

## Estrutura das Tabelas

### Tabela `Pedido`
Armazena informações sobre os pedidos realizados no sistema.
- `ID_Pedido` (INT): Identificador único do pedido.
- `Data` (DATETIME): Data e hora do pedido.
- `Status` (VARCHAR): Status do pedido (ex: 'Concluído', 'Em Processamento').
- `Descricao` (VARCHAR): Descrição do pedido.
- `Tipo_Frete` (FLOAT): Tipo de frete aplicado ao pedido.
- `Tipo_Pagamento` (VARCHAR): Método de pagamento utilizado.

### Tabela `Produto`
Armazena informações sobre os produtos disponíveis no sistema.
- `ID_Produto` (INT): Identificador único do produto.
- `NomeProd` (VARCHAR): Nome do produto.
- `PrecoProd` (DECIMAL): Preço do produto.
- `Descricao` (VARCHAR): Descrição do produto.
- `Categoria` (VARCHAR): Categoria do produto.

### Tabela `Cliente`
Armazena informações sobre os clientes do sistema.
- `ID_Cliente` (INT): Identificador único do cliente.
- `Nome` (VARCHAR): Nome do cliente.
- `Tipo` (VARCHAR): Tipo do cliente (ex: 'CPF', 'CNPJ').
- `CPF_CNPJ` (VARCHAR): Número do CPF ou CNPJ.
- `Endereco` (VARCHAR): Endereço do cliente.
- `Pedido_ID_Pedido` (INT): Referência ao pedido realizado pelo cliente.

### Tabela `Estoque`
Armazena informações sobre os estoques do sistema.
- `ID_Estoque` (INT): Identificador único do estoque.
- `Local` (VARCHAR): Localização do estoque.

### Tabela `Fornecedor`
Armazena informações sobre os fornecedores do sistema.
- `ID_Fornecedor` (INT): Identificador único do fornecedor.
- `Razao_Social` (VARCHAR): Razão social do fornecedor.
- `CNPJ` (VARCHAR): Número do CNPJ do fornecedor.

### Tabela `Produto_por_Estoque`
Relaciona produtos aos estoques, indicando a quantidade disponível.
- `Produto_ID_Produto` (INT): Referência ao produto.
- `Estoque_ID_Estoque` (INT): Referência ao estoque.
- `Quantidade` (INT): Quantidade do produto no estoque.

### Tabela `Produto_por_Fornecedor`
Relaciona produtos aos fornecedores, indicando a quantidade fornecida.
- `Fornecedor_ID_Fornecedor` (INT): Referência ao fornecedor.
- `Produto_ID_Produto` (INT): Referência ao produto.
- `Quantidade` (INT): Quantidade do produto fornecido.

### Tabela `Produto_por_Pedido`
Relaciona produtos aos pedidos, indicando a quantidade e a confirmação de pagamento.
- `Pedido_ID_Pedido` (INT): Referência ao pedido.
- `Produto_ID_Produto` (INT): Referência ao produto.
- `Quant_Prod` (INT): Quantidade do produto no pedido.
- `Confirmacao_Pagamento` (VARCHAR): Status de confirmação do pagamento.

### Tabela `Entrega`
Armazena informações sobre as entregas dos pedidos.
- `Codigo_de_Rastreio` (VARCHAR): Código de rastreio da entrega.
- `Status_da_Entrega` (VARCHAR): Status da entrega (ex: 'Em Processamento', 'Enviado', 'Concluído', 'Cancelado').
- `Produto_por_Pedido_Pedido_ID_Pedido` (INT): Referência ao pedido na tabela `Produto_por_Pedido`.
- `Produto_por_Pedido_Produto_ID_Produto` (INT): Referência ao produto na tabela `Produto_por_Pedido`.

### Tabela `Terceiro_Vendedor`
Armazena informações sobre os vendedores terceirizados do sistema.
- `ID_Vendedor` (INT): Identificador único do vendedor terceirizado.
- `Razao_Social` (VARCHAR): Razão social do vendedor.
- `CNPJ` (VARCHAR): Número do CNPJ do vendedor.
- `Endereco` (VARCHAR): Endereço do vendedor.

### Tabela `Produto_por_Vendedor_Terceiro`
Relaciona produtos aos vendedores terceirizados, indicando a quantidade vendida.
- `Terceiro_Vendedor_ID_Vendedor` (INT): Referência ao vendedor terceirizado.
- `Produto_ID_Produto` (INT): Referência ao produto.
- `Quantidade` (INT): Quantidade do produto vendido.

## Consultas SQL Complexas

```sql

### Total de Pedidos por Cliente e Valor Total dos Pedidos
SELECT Cliente.Nome, COUNT(Pedido.ID_Pedido) AS Total_Pedidos, SUM(Produto.PrecoProd * Produto_por_Pedido.Quant_Prod) AS Valor_Total_Pedidos
FROM Cliente
JOIN Pedido ON Cliente.Pedido_ID_Pedido = Pedido.ID_Pedido
JOIN Produto_por_Pedido ON Pedido.ID_Pedido = Produto_por_Pedido.Pedido_ID_Pedido
JOIN Produto ON Produto_por_Pedido.Produto_ID_Produto = Produto.ID_Produto
GROUP BY Cliente.Nome
ORDER BY Valor_Total_Pedidos DESC;

### Produtos Mais Vendidos e Quantidade Vendida
SELECT Produto.NomeProd, SUM(Produto_por_Pedido.Quant_Prod) AS Quantidade_Vendida
FROM Produto
JOIN Produto_por_Pedido ON Produto.ID_Produto = Produto_por_Pedido.Produto_ID_Produto
GROUP BY Produto.NomeProd
ORDER BY Quantidade_Vendida DESC;

### Pedidos por Status e Valor Total
SELECT Pedido.Status, COUNT(Pedido.ID_Pedido) AS Total_Pedidos, SUM(Produto.PrecoProd * Produto_por_Pedido.Quant_Prod) AS Valor_Total
FROM Pedido
JOIN Produto_por_Pedido ON Pedido.ID_Pedido = Produto_por_Pedido.Pedido_ID_Pedido
JOIN Produto ON Produto_por_Pedido.Produto_ID_Produto = Produto.ID_Produto
GROUP BY Pedido.Status;

### Estoques com Maior Quantidade de Produtos
SELECT Estoque.Local, SUM(Produto_por_Estoque.Quantidade) AS Total_Quantidade
FROM Estoque
JOIN Produto_por_Estoque ON Estoque.ID_Estoque = Produto_por_Estoque.Estoque_ID_Estoque
GROUP BY Estoque.Local
ORDER BY Total_Quantidade DESC;

### Fornecedores e Número de Produtos Fornecidos
SELECT Fornecedor.Razao_Social, COUNT(Produto_por_Fornecedor.Produto_ID_Produto) AS Numero_Produtos
FROM Fornecedor
JOIN Produto_por_Fornecedor ON Fornecedor.ID_Fornecedor = Produto_por_Fornecedor.Fornecedor_ID_Fornecedor
GROUP BY Fornecedor.Razao_Social
ORDER BY Numero_Produtos DESC;

### Entregas com Status e Quantidade de Produtos Entregues
SELECT Entrega.Status_da_Entrega, COUNT(Entrega.Codigo_de_Rastreio) AS Numero_Entregas, SUM(Produto_por_Pedido.Quant_Prod) AS Quantidade_Total
FROM Entrega
JOIN Produto_por_Pedido ON Entrega.Produto_por_Pedido_Pedido_ID_Pedido = Produto_por_Pedido.Pedido_ID_Pedido
AND Entrega.Produto_por_Pedido_Produto_ID_Produto = Produto_por_Pedido.Produto_ID_Produto
GROUP BY Entrega.Status_da_Entrega
ORDER BY Numero_Entregas DESC;

### Vendedores e Quantidade de Produtos Vendidos
SELECT Terceiro_Vendedor.Razao_Social, SUM(Produto_por_Vendedor_Terceiro.Quantidade) AS Quantidade_Vendida
FROM Terceiro_Vendedor
JOIN Produto_por_Vendedor_Terceiro ON Terceiro_Vendedor.ID_Vendedor = Produto_por_Vendedor_Terceiro.Terceiro_Vendedor_ID_Vendedor
GROUP BY Terceiro_Vendedor.Razao_Social
ORDER BY Quantidade_Vendida DESC;

