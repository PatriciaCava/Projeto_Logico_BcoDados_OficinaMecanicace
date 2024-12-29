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
        constraint unique_CPF_Client unique (CPF_Client)      
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
        RiscosCar boolean default 0,
        DescriptionCar varchar(255),
        constraint unique_PlacaCar unique (PlacaCar),
        constraint unique_ChassiCar unique (ChassiCar),
        constraint fk_car_client foreign key (Clients_idClient) references Clients(idClient)
);

alter table car auto_increment=1;

-- Criar tabela Equipe
create table team(
		idTeam int auto_increment primary key,
        NameTeam varchar(50) not null
);

alter table team auto_increment=1;

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
		idNumberOS int auto_increment primary key,
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

 ALTER TABLE car
        MODIFY COLUMN RiscosCar BOOLEAN DEFAULT 0;

-------------------------------------------------------
-- Etapa 2) Verificação e ajustes nas tabelas criadas
-- comando para visualizar uma tabela específica já criada:
desc clients;
desc car;
desc Team;
desc mechanic;
desc orders;
desc parts;
desc labor;
desc payment;
desc os_parts;
desc os_labor;

---------------------------------------
-- Etapa 3) inserir dados nas tabelas criadas
use mechanic;

insert into clients (FnameClient, LnameClient, CPF_Client, AddressClient, PhoneClient, EmailClient)
		values ('João', 'Menezes', '23545698503', 'R.11, 2020 - CPS', '11956234852', null),
			   ('Aline', 'Claridez', '23575398503', 'R.750, 3 - CPS', '11965231456', 'alcla@kol.com'),
               ('Antonio', 'Martins', '23951238503', 'R.1150, 85 - CPS', '11965484852', null),
			   ('Tati', 'Alves', '26924898503', 'R.5750, 153 - CPS', '11965295236', 'taal@kol.com'),
			   ('Tião', 'Solene', '852145698', 'R.95412, 30 - CPS', '11979864136', 'ts@ts.com.br');
               
insert into car (Clients_idClient, PlacaCar, ChassiCar, ModeloCar, FabricanteCar, AnoCar, KMCAr, CorCar, RiscosCar, DescriptionCar)
		values ('1', 'xfv1593', '15d9f6g875h35jk3l', 'Gol', 'WV', '2020/2021', '75000', 'Branco', '0', null), 
			   ('2', 'plj1263', '15d9f6g8h5j9djk3l', 'Palio', 'Fiat', '2023/2023', '45000', 'Branco', '0', null), 
               ('3', 'pzv2893', '1w9gh47875h35jk3l', 'HB20', 'Hyndai', '2022/2023', '25000', 'Cinza', '1', 'risco no parachoque trazeiro, segundo a proprietária foi no portão de sua garagem'),
			   ('4', 'qyd3269', '15d9f6g8h5jj9t3g5', 'Palio', 'Fiat', '2019/2019', '145000', 'Preto', '0', null);
        
insert into Team (NameTeam)
		values  ('Motor'),
				('Freio e Amortecedor'),
                 ('Balancemaneto e alinhamento'),
                ('Ar Condicionado'),
                ('Eletrônica');
                          
insert into mechanic (Team_idTeam, NameMechanic, CPF_Mechanic, AddressMechanic, PhoneMechanic, DateHiring, StatusMechanic, SpecialtyMechanic, Certification)
		values (1,'Filipe Silva', '98536412975', 'R.11, 2020 - CPS', '11956234852', '2023-02-02', default, 'Motor', null),
			   (4, 'Aline Moraes', '96214822675', 'R.750, 3 - CPS', '11965231456', '2023-02-05', default, 'Ar Condicionado', null),
               (2, 'Antonio Figueira', '75986321465', 'R.1150, 85 - CPS', '11965484852','2023-02-04', default, 'Freio e Amortecedor', null),
			   (5, 'Tati Simão', '31354971437', 'R.5750, 153 - CPS', '11965295236', '2023-02-07', default, 'Eletrônica', null),
			   (3, 'Tião Gonçalves', '13652489632', 'R.95412, 30 - CPS', '11979864136', '2023-02-10', default, 'Balancemaneto e alinhamento', null);
        
insert into orders (Car_idCar, Team_idTeam, DescriptionOrder, StatusOrder, DateIssue, ValueTotal, DataCompleted)		
		values (1, 5, 'Injeção Eletronica', default, '2024-12-12', '750.00', '2024-12-13'),
			   (3, 3, 'Balanceamento e alinhamento',  default, '2024-10-12', '250.00', '2024-10-12'),
			   (2, 2, 'Troca Amortecedor dianteiro e Balanceamento e alinhamento cortesia', default, '2024-12-10', '1600.00', '2024-12-13');
			          
insert into parts(DescriptionParts, ValueParts)
		values ('Injeção Eletrônica', '300.00'),
               ('Amortecedor dianteiro', '1300.00'),
               ('Freio dianteiro', '1500.00'),
               ('filtro ar condicionado', '300.00');
        
insert into labor(DescriptionLabor, ValueReferenceLabor)
		values ('Troca Injeção Eletrônica', '300.00'),
               ('regulagem Injeção Eletrônica', '150.00'),
               ('Troca Amortecedor dianteiro', '300.00'),
               ('Balanceamento e Alinhamento', '250.00'),
               ('Troca filtro ar condicionado', '150.00'),
               ('Limpeza ar condicionado', '150.00'),
               ('Freio dianteiro', '1500.00');
        
insert into payment(Orders_idNumberOS, ValueTotalPaid, TypePayment, AuthorizationCode, StatusPayment, DatePayment, DateRefund )
		values (1, '600.00', 'Cartão de Débito', '15874gf165', 'Pago', '2024-12-13', null),
               (2, '250.00', default, '15074gf1k5', 'Pago', '2024-10-12', null),
               (3, '1600.00', 'Cartão de Crédito parcelado 10 vezes sem juros', '2l074gf1k59', 'Pago', '2024-12-13', null);
        
insert into os_parts(Parts_idParts, Orders_idNumberOS, QuantParts, PriceTotalParts)
		values (1,1,1,'300.00'),
               (2,2,1,'1300.00');
        
insert into os_labor(Labor_idLabor, Orders_idNumberOS, PriceLabor)
		values (1, 1, '300.00'),
               (4, 2, '250.00'),
               (3, 3, '300.00');
        
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

-- 3) Mostrar todos os dados dos clientes com os seus pedidos
select * from clients c, orders o 
		 where c.idClient = o.Car_idCar;

-- 4) Verificar os pedidos com status por cliente (nome e sobrenome)
select FnameClient, LnameClient, idNumberOS, StatusOrder 
		from clients c, orders o 
        where c.idClient = o.Car_idCar;

-- 5) Concatenar o nome e sobrenome ordernado pelo número da OS, incluindo seu status
select concat(FnameClient, ' ', LnameClient) as Client, idNumberOS as Request, StatusOrder as Status 
		from clients c, orders o 
        where c.idClient = o.Car_idCar;

-- 6) Verificar quantos pedidos por cliente
select concat(FnameClient, ' ', LnameClient) as client, count(*)
       from clients c, orders o
       where c.idClient = o.Car_idCar
     group by idClient;

-- 7) Verificar todos os clientes cadastrados e seus pedidos, recuperar todos os clientes com ou sem pedidos realizados
select * from clients 
		 left outer join orders on idClient = idNumberOS;

-- 8) Verificar quantidade total de pedidos por cliente
select c.idClient, c.FnameClient, count(*) as Number_of_Order
		from clients c
		inner join orders o on c.idClient = o.Car_idCar
	  group by c.idClient, c.FnameClient;

-- 9) Verificar a quantidade de pedidos por cliente, recuperar todos os clientes com ou sem pedidos realizados
select c.FnameClient, c.LnameClient, count(o.idNumberOS) as TotalPedidos
		from Clients c
		left join Orders o on c.idClient = o.Car_idCar
	  group by c.idClient, c.FnameClient, c.LnameClient;
    
-- 10) Verificar o valor total de pedidos por cliente
select c.idClient, c.FnameClient, sum(o.ValueTotal) as TotalOrderValue
		from clients c
		inner join orders o on c.idClient = o.Car_idCar
	  group by c.idClient, c.FnameClient;
      
-- 11) Recuperar Nomes e edereços de todos os clientes
select FnameClient, AddressClient
	from clients;

-- 12) Recuperar os pedidos emitidos após novembro de 2024
select * from orders
	where DateIssue > '2024-11-01';
    
-- 13) Verificar total de pedidos de dezembro de 2024
select count(*) as Orders_December_2024
		from orders
		where year(DateIssue) = 2024 and month(DateIssue) = 12;

-- 14) Verificar qual é o valor total pago por cada pedido, incluindo um imposto de 10% 
select idNumberOS, ValueTotal, round(ValueTotal * 1.10) as ValueWithTax
		from orders;
    
-- 15) Verificar qual é o valor da mão de obra recebido por cada pedido, excluindo um imposto de 10% 
select idOS_Labor, PriceLabor, round(PriceLabor / 1.10, 2) as ValueWithoutTax
	from OS_Labor;

-- 16) Verificar quais são os mecânicos ordenados pela data de contratação mais recente
select NameMechanic, DateHiring
	from mechanic
	order by DateHiring desc;
    
-- 17) Verificar quais são os pedidos e seus respectivos mecânicos
select o.idNumberOS, o.DescriptionOrder, m.NameMechanic
	from orders o
	inner join mechanic m on o.Team_idTeam = m.Team_idTeam;
    
-- 18) Verificar quais clientes têm mais de 2 pedidos
select c.idClient, c.FnameClient, count(o.idNumberOS) as Number_of_Orders
		from clients c
		inner join orders o on c.idClient = o.Car_idCar
	group by c.idClient, c.FnameClient
	having count(o.idNumberOS) > 2;
    
-- 19) Verificar detalhes dos pedidos pelo nome do cliente: descrição do pedido, data e valor
select c.FnameClient, o.DescriptionOrder, o.DateIssue, o.ValueTotal
		from clients c
		inner join orders o on c.idClient = o.Car_idCar;
    
-- 20) Verificar qual é a média de valor total dos pedidos por mês em 2024
select month(DateIssue) as month, round(avg(ValueTotal), 2) as AverageOrderValue
		from orders
		where year(DateIssue) = 2024
	group by month(DateIssue);
    
-- 21) Verificar quais os pedidos que foram pagos com Cartão de Crédito
select o.idNumberOS, o.DescriptionOrder, p.TypePayment
		from orders o
		inner join payment p on o.idNumberOS = p.Orders_idNumberOS
		where p.TypePayment like '%Cartão de Crédito%';

-- 22) Verificar quais os pedidos que foram pagos com PIX e seus respectivos valores pagos
select o.idNumberOS, o.DescriptionOrder, p.TypePayment, p.ValueTotalPaid
	from orders o
	inner join payment p on o.idNumberOS = p.Orders_idNumberOS
	where p.TypePayment like '%Pix%';

-- 22) verificar o total de pagamentos por tipo de pagamento
select TypePayment, sum(ValueTotalPaid) as TotalPaid
		from payment
	 group by TypePayment;