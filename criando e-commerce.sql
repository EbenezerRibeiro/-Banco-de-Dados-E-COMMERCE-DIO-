-- criação de bando de dados para o cenario de E-commerce
create database ecommerce;

use ecommerce;

-- Criar tabelas cliente
create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Address varchar(30),
constraint unique_cpf_clients unique (CPF)

);

-- Criar tabela produto
create table product(
idProduct int auto_increment primary key,
Pname varchar(10) not null,
classification_kids bool default false,
category enum('Eletronico', 'vestimenta', 'Brinquedos', 'alimentos'),
Avaliação float default 0,
size varchar(10)
);

-- Criar tabela pedido
create table orders(
idOrder int auto_increment primary key,
idOrderClient int,  
orderStatus enum('Cancelado', 'confirmado', 'Em processamento') default 'Em processamento',
orderDescription varchar(255),
sendValue float default 10,
constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- Tabela pagamento
create table payments(
idClient int ,
id_payment int,
typePayment enum('Boleto', 'Cartão', 'Dois Cartoes', 'PIX'),
limitAvailable float,
primary key(idClient, id_payment)
);

-- Tabela estoque
create table productStorage(
idProdStorage int auto_increment primary key,
storageLocation varchar (255),
quantity int default 0
);

-- tabela fornecedor
create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique(CNPJ)
);

-- Tabela vendedor
create table seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255),
CNPJ char(15),
CPF char(9),
location varchar(255),
contact char(11) not null,
constraint unique_cnpj_seller unique(CNPJ),
constraint unique_cpf_seller unique(CPF)
); 

-- Tabela produto-vendedor
create table productSeller(
 idPseller int,
 idProduct int,
 prodQuanty int default 1,
 primary key (idPseller, idProduct),
 constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
 constraint fk_procuct_product foreign key (idProduct) references product(idProduct)
);

-- Tabela produto-pedido
create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references product(idPrduct),
constraint fk_procuctorder_product foreign key (idPOorder) references orders(idOrder)
);

-- tabela armazenamento/estoque
create table storageLocation(
idLproduct int,
idLstorage int,
Location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references prosuct(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);