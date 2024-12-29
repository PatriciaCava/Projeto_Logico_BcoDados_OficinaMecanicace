-- Etapa 1) criação do banco de dados para o cenário de Oficina Mecânica
create database mechanic;
use mechanic;

-- criar tabela Cliente
create table clients(
		idClient int auto_increment primary key,
        FnameClient varchar(20) not null,
        LnameClient varchar(50) not null,
        CPF_Client varchar(11) not null,
        AddressClient varchar(200) not null,
        PhoneClient char(11) not null,
        EmailClient varchar(50),        
        constraint unique_Doc_Client unique (Doc_Client)      
);

alter table clients auto_increment=1;

-- criar tabela Carro
create table car(
		idcar  int auto_increment primary key,
        Clients_idClient int, 
        PlacaCar char(7) not null,
        ChassiCar char(17) not null,
        ModeloCar varchar(100) not null,
        FabricanteCar varchar(100) not null,
        AnoCar  varchar(10) not null,
        KMCar varchar(6) not null, 
        CorCar varchar(50),
        RiscosCar bool default True,
        DescriptionCar varchar(255),
        constraint unique_PlacaCar unique (PlacaCar),
        constraint unique_ChassiCar unique (ChassiCar),
        constraint fk_car_client foreign key (Clients_idClient) references Clients(idClient)
);

alter table car auto_increment=1;

-- criar tabela Mecânicos
create table mechanic(
		idMechanic int auto_increment primary key,
        Team_idTeam int not null,
        NameMechanic varchar(100) not null,
        CPF_Mechanic varchar(11) not null,
        AddressMechanic varchar(200) not null,
        PhoneMechanic char(11) not null,
        DateHiring date not null,
        StatusMechanic enum('Ativo', 'Férias', 'Inativo') default 'Ativo',
        SpecialtyMechanic varchar(50),
        Certification varchar(100),
        constraint unique_CPF_Mechanic unique (CPF_Mechanic),
        constraint fk_mechanic_team foreign key (Team_idTeam) references Team(idTeam)
);

alter table mechanic auto_increment=1;

-- Criar tabela Ordem de Serviço
create table orders(
		idOrder int auto_increment primary key,
        Car_idCar int not null,
        Team_idTeam int not null,
        DescriptionOrder  varchar(255) not null,
        StatusOrder enum('Aberta', 'Cancelada', 'Aprovada', 'Em Execução', 'Concluída') default 'Aberta',
        DateIssue date not null,
        ValueTotal float not null,
        DataCompleted date not null,
		constraint fk_order_client foreign key (Car_idCar) references Car(idCar),
        constraint fk_order_team foreign key (Team_idTeam) references Team(idTeam) 
				on update cascade
);

alter table orders auto_increment=1;

-- Criar tabela Equipe
create table team(
		idTeam int auto_increment primary key,
        NameTeam varchar(50) not null,
        constraint fk_order_team foreign key (Team_idTeam) references Team(idTeam) 
);

alter table team auto_increment=1;

-- Criar tabela Peças
create table parts(
		idParts int auto_increment primary key,
        DescriptionParts varchar(255) not null,
        ValueParts float
);

alter table parts auto_increment=1;

-- Criar tabela OS_Peças
create table OS_Parts(
		idOS_Parts int auto_increment primary key,
        Parts_idParts int not null, 
        Orders_idNumberOS int not null,
        QuantParts int not null,
        PriceTotalParts float,
        constraint fk_OsParts_parts foreign key (Parts_idParts) references Parts(idParts),
        constraint fk_OsParts_OS foreign key (Orders_idNumberOS) references Orders(idNumberOS)
);

alter table OS_Parts auto_increment=1;

-- Criar tabela MãoDeObra
create table labor(
		idLabor int auto_increment primary key,
        DescriptionLabor varchar(255) not null,
        ValueReferenceLabor float
);

alter table labor auto_increment=1;

-- Criar tabela OS_MãoDeObra
create table OS_Labor(
		idOS_Labor int auto_increment primary key,
        Labor_idLabor int not null, 
        Orders_idNumberOS int not null,
        PriceLabor float,
        constraint fk_OsLabor_labor foreign key (Labor_idLabor) references Labor(idLabor),
        constraint fk_OsLabor_OS foreign key (Orders_idNumberOS) references Orders(idNumberOS)
);

alter table OS_Labor auto_increment=1;

-- Criar tabela Pagamento
create table payment(
		idPayment int auto_increment primary key,
        Orders_idNumberOS int not null,
        ValueTotalPaid  float not null,
        TypePayment enum('PIX', 'Cartão de Débito', 'Cartão de Crédito à vista', 'Cartão de Crédito parcelado 10 vezes sem juros') default 'PIX',
		AuthorizationCode varchar(50) unique not null,
        StatusPayment enum('Pendente', 'Pago', 'Estornado'),
        DatePayment datetime,
        DateRefund datetime,
        constraint fk_payment_order foreign key (Orders_idNumberOS) references Orders(idNumberOS)
);     

alter table payment auto_increment=1;

-------------------------------------------------------
-- Etapa 2) Verificação e ajustes nas tabelas criadas
-- comando para visualizar uma tabela específica já criada:
desc clients;
desc car;
desc mechanic;
desc Orders;
desc Team;
desc parts;
desc labor;
desc payment;
desc os_parts;
desc os_labor;

---------------------------------------
-- Etapa 3) inserir dados nas tabelas criadas
use mechanic;

insert into clients (FnameClient, LnameClient, TypeClient, DocClient, BillingAddressClient, DeliveryAddressClient, PhoneClient, EmailClient)
		values ('João', 'Menezes', 'Pessoa Física', '23545698503', 'R.11, 2020 - CPS', 'R.11, 2020 - CPS', '11956234852', null),
			   ('Aline', 'Claridez', 'Pessoa Jurídica', '23545698503012', 'R.750, 3 - CPS', 'R.8520, 350 - CPS', '11965231456', 'alcla@kol.com'),
			   ('Tião', 'Solene', 'Pessoa Física', '852145698', 'R.95412, 30 - CPS', 'R.95412, 30 - CPS', '11979864136', 'ts@ts.com.br');
               
insert into car ()
		values ();
        
insert into mechanic ()
		values ();
        
insert into Orders ()
		values ();
			  
insert into Team ()
		values ();
        
insert into parts()
		values ();
        
insert into labor()
		values ();
        
insert into payment()
		values ();
        
insert into os_parts()
		values ();
        
insert into os_labor()
		values ();
        
-----------------------------------------------------------------
-- Etapa 4)  Verificação e ajustes nos dados inseridos
-- comando para verificar dados na tabela
SELECT * FROM clients;
SELECT * FROM car;
SELECT * FROM mechanic;
SELECT * FROM orders;
SELECT * FROM Team;
SELECT * FROM parts;
SELECT * FROM labor;
SELECT * FROM payment;
SELECT * FROM os_parts; 
SELECT * FROM os_labor; 

------------------------------------------------------
-- Etapa 5) Queries 

-- 1) Verificar total de clientes cadastrados
select count(*) from clients;

-- 2) Verificar total de pedidos cadastrados
select count(*) from orders;

-- 3) Mostrar todos os dados dos clientes e com os seus pedidos
select * from clients c, orders o where c.idClient = o.Clients_idClient;

-- 4) Especificar apenas alguns atributos dos clientes e seus pedidos
select FnameClient, LnameClient, idOrder, StatusOrder from clients c, orders o where c.idClient = o.Clients_idClient;

-- 5) Concatenar o nome e melhorar a visão dos atributos dos clientes e seus pedidos
select concat(FnameClient, ' ', LnameClient) as Client, idOrder as Request, StatusOrder as Status from clients c, orders o where c.idClient = o.Clients_idClient;

-- 6) Verificar quantos pedidos por cliente
SELECT CONCAT(FnameClient, ' ', LnameClient) AS Client, COUNT(*)
     FROM clients c, orders o
     WHERE c.idClient = o.Clients_idClient
   GROUP BY idClient;

-- 7) Verificar todos os clientes cadastrados e seus pedidos, recuperar todos os clientes com ou sem pedidos realizados
select * from clients left outer join orders on idClient = idOrder;

-- 8) Verificar quantidade total de pedidos por cliente
select c.idClient, FnameClient, count(*) as Number_of_Order from clients c 
		inner join orders o on c.idClient = o.Clients_idClient
		inner join productOrder p on p.Orders_idORder = o.idOrder
	group by idClient;

-- 9) Verificar a quantidade de pedidos por cliente, recuperar todos os clientes com ou sem pedidos realizados
SELECT c.FnameClient, c.LnameClient, COUNT(o.idOrder) AS TotalPedidos
		FROM Clients c
		LEFT JOIN Orders o ON c.idClient = o.Clients_idClient
	GROUP BY c.idClient, c.FnameClient, c.LnameClient;
