-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-08-2017 a las 20:15:46
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `northwind`
--
CREATE DATABASE IF NOT EXISTS `northwind` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `northwind`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProInsertarClientes` (IN `id` VARCHAR(20), IN `nombre` VARCHAR(80), IN `contacto` VARCHAR(80), OUT `mensaje` VARCHAR(80), OUT `numregistros` INT)  begin
		declare contador int;
        set autocommit = 0;
        insert into customers2(CustomerID,CompanyName,ContactName) values (id,nombre,contacto);
        if nombre = 'Guillermo' then
			rollback;
            set mensaje = 'Nombre no permitido';
		else
			commit;
            select count(*) into contador from customers2;
            set mensaje = concat('cliente insertado');
            set numregistros = contador;
            
		end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProInsert_Orderdetails` (IN `idVenta` INT, `idProducto` INT, `cantidad` INT, OUT `msj` INT)  begin
	declare aux int;
    set autocommit = 0;
	insert into orderdetails(OrderID,ProductID,Quantity) values (idVenta,idProducto,cantidad);
    select UnitsInStock into aux from products where ProductID = idProducto;
    
    update products
    set  UnitsInStock = (aux - cantidad)
    where ProductID = idProducto;
    
    if (aux - cantidad) < 0 then
		rollback;
        set msj = 0;
	else
		commit;
        set msj = 1;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProInsert_Orders` (IN `idCliente` VARCHAR(20), `idEmpleado` INT, OUT `idVenta` INT)  begin
	if exists (select *from customers where CustomerID = idCliente) and exists (select *from employees where EmployeeID = idEmpleado) then
		insert into orders(OrderID,CustomerID,EmployeeID) values ('',idCliente,idEmpleado);
		select max(OrderID) into idVenta from orders;
	else
		set idVenta = -1;
	end if;
end$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `FunContarClientes` () RETURNS INT(11) BEGIN
		declare salida int;
        select count(*) into salida from customers2;
        return salida;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(15) NOT NULL,
  `Description` longtext,
  `Picture` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`CategoryID`, `CategoryName`, `Description`, `Picture`) VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales', NULL),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings', NULL),
(3, 'Confections', 'Desserts, candies, and sweet breads', NULL),
(4, 'Dairy Products', 'Cheeses', NULL),
(5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal', NULL),
(6, 'Meat/Poultry', 'Prepared meats', NULL),
(7, 'Produce', 'Dried fruit and bean curd', NULL),
(8, 'Seafood', 'Seaweed and fish', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customercustomerdemo`
--

CREATE TABLE `customercustomerdemo` (
  `CustomerID` char(5) NOT NULL,
  `CustomerTypeID` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customerdemographics`
--

CREATE TABLE `customerdemographics` (
  `CustomerTypeID` char(10) NOT NULL,
  `CustomerDesc` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `CustomerID` char(5) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) DEFAULT NULL,
  `ContactTitle` varchar(30) DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`CustomerID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`) VALUES
('aaa', 'jwenhf', NULL, NULL, NULL, 'jdshfj', NULL, NULL, NULL, NULL, NULL),
('ABC', 'rodofilms', NULL, NULL, NULL, 'valparrancho', NULL, NULL, NULL, NULL, NULL),
('ABC2', 'Rodofilms', NULL, NULL, NULL, 'Germany', NULL, NULL, NULL, NULL, NULL),
('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany', '030-0074321', '030-0076545'),
('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constituci?n 2222', 'M?xico D.F.', '', '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745'),
('ANTON', 'Antonio Moreno Taquer?a', 'Antonio Moreno', 'Owner', 'Mataderos  2312', 'M?xico D.F.', '', '05023', 'Mexico', '(5) 555-3932', ''),
('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', '', 'WA1 1DP', 'UK', '(171) 555-7788', '(171) 555-6750'),
('BERGS', 'Berglunds snabbk?p', 'Christina Berglund', 'Order Administrator', 'Berguvsv?gen  8', 'Lule?', '', 'S-958 22', 'Sweden', '0921-12 34 65', '0921-12 34 67'),
('BLAUS', 'Blauer See Delikatessen', 'Hanna Moos', 'Sales Representative', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany', '0621-08460', '0621-08924'),
('BLONP', 'Blondesddsl p?re et fils', 'Fr?d?rique Citeaux', 'Marketing Manager', '24, place Kl?ber', 'Strasbourg', '', '67000', 'France', '88.60.15.31', '88.60.15.32'),
('BOLID', 'B?lido Comidas preparadas', 'Mart?n Sommer', 'Owner', 'C/ Araquil, 67', 'Madrid', '', '28023', 'Spain', '(91) 555 22 82', '(91) 555 91 99'),
('BONAP', 'Bon app''', 'Laurence Lebihan', 'Owner', '12, rue des Bouchers', 'Marseille', '', '13008', 'France', '91.24.45.40', '91.24.45.41'),
('BOTTM', 'Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Accounting Manager', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada', '(604) 555-4729', '(604) 555-3745'),
('BSBEV', 'B''s Beverages', 'Victoria Ashworth', 'Sales Representative', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK', '(171) 555-1212', ''),
('CACTU', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Sales Agent', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina', '(1) 135-5555', '(1) 135-4892'),
('CENTC', 'Centro comercial Moctezuma', 'Francisco Chang', 'Marketing Manager', 'Sierras de Granada 9993', 'M?xico D.F.', '', '05022', 'Mexico', '(5) 555-3392', '(5) 555-7293'),
('CHOPS', 'Chop-suey Chinese', 'Yang Wang', 'Owner', 'Hauptstr. 29', 'Bern', '', '3012', 'Switzerland', '0452-076545', ''),
('COMMI', 'Com?rcio Mineiro', 'Pedro Afonso', 'Sales Associate', 'Av. dos Lus?adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil', '(11) 555-7647', ''),
('CONSH', 'Consolidated Holdings', 'Elizabeth Brown', 'Sales Representative', 'Berkeley Gardens 12  Brewery', 'London', '', 'WX1 6LT', 'UK', '(171) 555-2282', '(171) 555-9199'),
('DRACD', 'Drachenblut Delikatessen', 'Sven Ottlieb', 'Order Administrator', 'Walserweg 21', 'Aachen', '', '52066', 'Germany', '0241-039123', '0241-059428'),
('DUMON', 'Du monde entier', 'Janine Labrune', 'Owner', '67, rue des Cinquante Otages', 'Nantes', '', '44000', 'France', '40.67.88.88', '40.67.89.89'),
('EASTC', 'Eastern Connection', 'Ann Devon', 'Sales Agent', '35 King George', 'London', '', 'WX3 6FW', 'UK', '(171) 555-0297', '(171) 555-3373'),
('ERNSH', 'Ernst Handel', 'Roland Mendel', 'Sales Manager', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria', '7675-3425', '7675-3426'),
('FAMIA', 'Familia Arquibaldo', 'Aria Cruz', 'Marketing Assistant', 'Rua Or?s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil', '(11) 555-9857', ''),
('FISSA', 'FISSA Fabrica Inter. Salchichas S.A.', 'Diego Roel', 'Accounting Manager', 'C/ Moralzarzal, 86', 'Madrid', '', '28034', 'Spain', '(91) 555 94 44', '(91) 555 55 93'),
('FOLIG', 'Folies gourmandes', 'Martine Ranc?', 'Assistant Sales Agent', '184, chauss?e de Tournai', 'Lille', '', '59000', 'France', '20.16.10.16', '20.16.10.17'),
('FOLKO', 'Folk och f? HB', 'Maria Larsson', 'Owner', '?kergatan 24', 'Br?cke', '', 'S-844 67', 'Sweden', '0695-34 67 21', ''),
('FRANK', 'Frankenversand', 'Peter Franken', 'Marketing Manager', 'Berliner Platz 43', 'M?nchen', '', '80805', 'Germany', '089-0877310', '089-0877451'),
('FRANR', 'France restauration', 'Carine Schmitt', 'Marketing Manager', '54, rue Royale', 'Nantes', '', '44000', 'France', '40.32.21.21', '40.32.21.20'),
('FRANS', 'Franchi S.p.A.', 'Paolo Accorti', 'Sales Representative', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy', '011-4988260', '011-4988261'),
('FURIB', 'Furia Bacalhau e Frutos do Mar', 'Lino Rodriguez', 'Sales Manager', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal', '(1) 354-2534', '(1) 354-2535'),
('GALED', 'Galer?a del gastr?nomo', 'Eduardo Saavedra', 'Marketing Manager', 'Rambla de Catalu?a, 23', 'Barcelona', '', '08022', 'Spain', '(93) 203 4560', '(93) 203 4561'),
('GODOS', 'Godos Cocina T?pica', 'Jos? Pedro Freyre', 'Sales Manager', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain', '(95) 555 82 82', ''),
('GOURL', 'Gourmet Lanchonetes', 'Andr? Fonseca', 'Sales Associate', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil', '(11) 555-9482', ''),
('GREAL', 'Great Lakes Food Market', 'Howard Snyder', 'Marketing Manager', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA', '(503) 555-7555', ''),
('GROSR', 'GROSELLA-Restaurante', 'Manuel Pereira', 'Owner', '5? Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela', '(2) 283-2951', '(2) 283-3397'),
('HANAR', 'Hanari Carnes', 'Mario Pontes', 'Accounting Manager', 'Rua do Pa?o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil', '(21) 555-0091', '(21) 555-8765'),
('HILAA', 'HILARION-Abastos', 'Carlos Hern?ndez', 'Sales Representative', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist?bal', 'T?chira', '5022', 'Venezuela', '(5) 555-1340', '(5) 555-1948'),
('HUNGC', 'Hungry Coyote Import Store', 'Yoshi Latimer', 'Sales Representative', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA', '(503) 555-6874', '(503) 555-2376'),
('HUNGO', 'Hungry Owl All-Night Grocers', 'Patricia McKenna', 'Sales Associate', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland', '2967 542', '2967 3333'),
('ISLAT', 'Island Trading', 'Helen Bennett', 'Marketing Manager', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK', '(198) 555-8888', ''),
('KOENE', 'K?niglich Essen', 'Philip Cramer', 'Sales Associate', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany', '0555-09876', ''),
('LACOR', 'La corne d''abondance', 'Daniel Tonini', 'Sales Representative', '67, avenue de l''Europe', 'Versailles', '', '78000', 'France', '30.59.84.10', '30.59.85.11'),
('LAMAI', 'La maison d''Asie', 'Annette Roulet', 'Sales Manager', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France', '61.77.61.10', '61.77.61.11'),
('LAUGB', 'Laughing Bacchus Wine Cellars', 'Yoshi Tannamuri', 'Marketing Assistant', '1900 Oak St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada', '(604) 555-3392', '(604) 555-7293'),
('LAZYK', 'Lazy K Kountry Store', 'John Steel', 'Marketing Manager', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA', '(509) 555-7969', '(509) 555-6221'),
('LEHMS', 'Lehmanns Marktstand', 'Renate Messner', 'Sales Representative', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany', '069-0245984', '069-0245874'),
('LETSS', 'Let''s Stop N Shop', 'Jaime Yorres', 'Owner', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA', '(415) 555-5938', ''),
('LILAS', 'LILA-Supermercado', 'Carlos Gonz?lez', 'Accounting Manager', 'Carrera 52 con Ave. Bol?var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela', '(9) 331-6954', '(9) 331-7256'),
('LINOD', 'LINO-Delicateses', 'Felipe Izquierdo', 'Owner', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela', '(8) 34-56-12', '(8) 34-93-93'),
('LONEP', 'Lonesome Pine Restaurant', 'Fran Wilson', 'Sales Manager', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA', '(503) 555-9573', '(503) 555-9646'),
('MAGAA', 'Magazzini Alimentari Riuniti', 'Giovanni Rovelli', 'Marketing Manager', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy', '035-640230', '035-640231'),
('MAISD', 'Maison Dewey', 'Catherine Dewey', 'Sales Agent', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium', '(02) 201 24 67', '(02) 201 24 68'),
('MEREP', 'M?re Paillarde', 'Jean Fresni?re', 'Marketing Assistant', '43 rue St. Laurent', 'Montr?al', 'Qu?bec', 'H1J 1C3', 'Canada', '(514) 555-8054', '(514) 555-8055'),
('MORGK', 'Morgenstern Gesundkost', 'Alexander Feuer', 'Marketing Assistant', 'Heerstr. 22', 'Leipzig', '', '04179', 'Germany', '0342-023176', ''),
('NORTS', 'North/South', 'Simon Crowther', 'Sales Associate', 'South House 300 Queensbridge', 'London', '', 'SW7 1RZ', 'UK', '(171) 555-7733', '(171) 555-2530'),
('OCEAN', 'Oc?ano Atl?ntico Ltda.', 'Yvonne Moncada', 'Sales Agent', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina', '(1) 135-5333', '(1) 135-5535'),
('OLDWO', 'Old World Delicatessen', 'Rene Phillips', 'Sales Representative', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA', '(907) 555-7584', '(907) 555-2880'),
('OTTIK', 'Ottilies K?seladen', 'Henriette Pfalzheim', 'Owner', 'Mehrheimerstr. 369', 'K?ln', '', '50739', 'Germany', '0221-0644327', '0221-0765721'),
('PARIS', 'Paris sp?cialit?s', 'Marie Bertrand', 'Owner', '265, boulevard Charonne', 'Paris', '', '75012', 'France', '(1) 42.34.22.66', '(1) 42.34.22.77'),
('PERIC', 'Pericles Comidas cl?sicas', 'Guillermo Fern?ndez', 'Sales Representative', 'Calle Dr. Jorge Cash 321', 'M?xico D.F.', '', '05033', 'Mexico', '(5) 552-3745', '(5) 545-3745'),
('PICCO', 'Piccolo und mehr', 'Georg Pipps', 'Sales Manager', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria', '6562-9722', '6562-9723'),
('PRINI', 'Princesa Isabel Vinhos', 'Isabel de Castro', 'Sales Representative', 'Estrada da sa?de n. 58', 'Lisboa', '', '1756', 'Portugal', '(1) 356-5634', ''),
('QUEDE', 'Que Del?cia', 'Bernardo Batista', 'Accounting Manager', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil', '(21) 555-4252', '(21) 555-4545'),
('QUEEN', 'Queen Cozinha', 'L?cia Carvalho', 'Marketing Assistant', 'Alameda dos Can?rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil', '(11) 555-1189', ''),
('QUICK', 'QUICK-Stop', 'Horst Kloss', 'Accounting Manager', 'Taucherstra?e 10', 'Cunewalde', '', '01307', 'Germany', '0372-035188', ''),
('RANCH', 'Rancho grande', 'Sergio Guti?rrez', 'Sales Representative', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina', '(1) 123-5555', '(1) 123-5556'),
('RATTC', 'Rattlesnake Canyon Grocery', 'Paula Wilson', 'Assistant Sales Representative', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA', '(505) 555-5939', '(505) 555-3620'),
('REGGC', 'Reggiani Caseifici', 'Maurizio Moroni', 'Sales Associate', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy', '0522-556721', '0522-556722'),
('RICAR', 'Ricardo Adocicados', 'Janete Limeira', 'Assistant Sales Agent', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil', '(21) 555-3412', ''),
('RICSU', 'Richter Supermarkt', 'Michael Holz', 'Sales Manager', 'Grenzacherweg 237', 'Gen?ve', '', '1203', 'Switzerland', '0897-034214', ''),
('ROMEY', 'Romero y tomillo', 'Alejandra Camino', 'Accounting Manager', 'Gran V?a, 1', 'Madrid', '', '28001', 'Spain', '(91) 745 6200', '(91) 745 6210'),
('SANTG', 'Sant? Gourmet', 'Jonas Bergulfsen', 'Owner', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway', '07-98 92 35', '07-98 92 47'),
('SAVEA', 'Save-a-lot Markets', 'Jose Pavarotti', 'Sales Representative', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA', '(208) 555-8097', ''),
('SEVES', 'Seven Seas Imports', 'Hari Kumar', 'Sales Manager', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK', '(171) 555-1717', '(171) 555-5646'),
('SIMOB', 'Simons bistro', 'Jytte Petersen', 'Owner', 'Vinb?ltet 34', 'Kobenhavn', '', '1734', 'Denmark', '31 12 34 56', '31 13 35 57'),
('SPECD', 'Sp?cialit?s du monde', 'Dominique Perrier', 'Marketing Manager', '25, rue Lauriston', 'Paris', '', '75016', 'France', '(1) 47.55.60.10', '(1) 47.55.60.20'),
('SPLIR', 'Split Rail Beer & Ale', 'Art Braunschweiger', 'Sales Manager', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA', '(307) 555-4680', '(307) 555-6525'),
('SUPRD', 'Supr?mes d?lices', 'Pascale Cartrain', 'Accounting Manager', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium', '(071) 23 67 22 20', '(071) 23 67 22 21'),
('THEBI', 'The Big Cheese', 'Liz Nixon', 'Marketing Manager', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA', '(503) 555-3612', ''),
('THECR', 'The Cracker Box', 'Liu Wong', 'Marketing Assistant', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA', '(406) 555-5834', '(406) 555-8083'),
('TOMSP', 'Toms Spezialit?ten', 'Karin Josephs', 'Marketing Manager', 'Luisenstr. 48', 'M?nster', '', '44087', 'Germany', '0251-031259', '0251-035695'),
('TORTU', 'Tortuga Restaurante', 'Miguel Angel Paolino', 'Owner', 'Avda. Azteca 123', 'M?xico D.F.', '', '05033', 'Mexico', '(5) 555-2933', ''),
('TRADH', 'Tradi??o Hipermercados', 'Anabela Domingues', 'Sales Representative', 'Av. In?s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil', '(11) 555-2167', '(11) 555-2168'),
('TRAIH', 'Trail''s Head Gourmet Provisioners', 'Helvetius Nagy', 'Sales Associate', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA', '(206) 555-8257', '(206) 555-2174'),
('VAFFE', 'Vaffeljernet', 'Palle Ibsen', 'Sales Manager', 'Smagsloget 45', '?rhus', '', '8200', 'Denmark', '86 21 32 43', '86 22 33 44'),
('VICTE', 'Victuailles en stock', 'Mary Saveley', 'Sales Agent', '2, rue du Commerce', 'Lyon', '', '69004', 'France', '78.32.54.86', '78.32.54.87'),
('VINET', 'Vins et alcools Chevalier', 'Paul Henriot', 'Accounting Manager', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France', '26.47.15.10', '26.47.15.11'),
('WANDK', 'Die Wandernde Kuh', 'Rita M?ller', 'Sales Representative', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany', '0711-020361', '0711-035428'),
('WARTH', 'Wartian Herkku', 'Pirkko Koskitalo', 'Accounting Manager', 'Torikatu 38', 'Oulu', '', '90110', 'Finland', '981-443655', '981-443655'),
('WELLI', 'Wellington Importadora', 'Paula Parente', 'Sales Manager', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil', '(14) 555-8122', ''),
('WHITC', 'White Clover Markets', 'Karl Jablonski', 'Owner', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', 'USA', '(206) 555-4112', '(206) 555-4115'),
('WILMK', 'Wilman Kala', 'Matti Karttunen', 'Owner/Marketing Assistant', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland', '90-224 8858', '90-224 8858'),
('WOLZA', 'Wolski  Zajazd', 'Zbyszek Piestrzeniewicz', 'Owner', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland', '(26) 642-7012', '(26) 642-7012'),
('wwwe', 'rodofilms', NULL, NULL, NULL, 'Germany', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers2`
--

CREATE TABLE `customers2` (
  `CustomerID` char(5) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) DEFAULT NULL,
  `ContactTitle` varchar(30) DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `customers2`
--

INSERT INTO `customers2` (`CustomerID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`) VALUES
('1223', 'sabritas', 'goku', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('123', 'sabritas', 'goku', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('3262', 'sdf', 'dvs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('55', 'xzf', 'c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('55s', 'Guillermod', 'c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('787', 'rod', 'e', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('991', 'kasd', 'saf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('999', 'kasd', 'saf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('bills', 'jajaja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('freez', 'Toeil_Animation', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('sdefs', 'Guillermonk', 'goku', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('sfs', 'Guillermonk', 'goku', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `FirstName` varchar(10) NOT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `TitleOfCourtesy` varchar(25) DEFAULT NULL,
  `BirthDate` datetime DEFAULT NULL,
  `HireDate` datetime DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL,
  `HomePhone` varchar(24) DEFAULT NULL,
  `Extension` varchar(4) DEFAULT NULL,
  `Photo` longblob,
  `Notes` longtext,
  `ReportsTo` int(11) DEFAULT NULL,
  `PhotoPath` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`EmployeeID`, `LastName`, `FirstName`, `Title`, `TitleOfCourtesy`, `BirthDate`, `HireDate`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `HomePhone`, `Extension`, `Photo`, `Notes`, `ReportsTo`, `PhotoPath`) VALUES
(1, 'Davolio', 'Nancy', 'Sales Representative', 'Ms.', '1948-12-08 00:00:00', '1992-05-01 00:00:00', '507 - 20th Ave. E.\r\nApt. 2A', 'Seattle', 'WA', '98122', 'USA', '(206) 555-9857', '5467', NULL, 'Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.', 2, 'http://accweb/emmployees/davolio.bmp'),
(2, 'Fuller', 'Andrew', 'Vice President, Sales', 'Dr.', '1952-02-19 00:00:00', '1992-08-14 00:00:00', '908 W. Capital Way', 'Tacoma', 'WA', '98401', 'USA', '(206) 555-9482', '3457', NULL, 'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.', NULL, 'http://accweb/emmployees/fuller.bmp'),
(3, 'Leverling', 'Janet', 'Sales Representative', 'Ms.', '1963-08-30 00:00:00', '1992-04-01 00:00:00', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '98033', 'USA', '(206) 555-3412', '3355', NULL, 'Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.', 2, 'http://accweb/emmployees/leverling.bmp'),
(4, 'Peacock', 'Margaret', 'Sales Representative', 'Mrs.', '1937-09-19 00:00:00', '1993-05-03 00:00:00', '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 'USA', '(206) 555-8122', '5176', NULL, 'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.', 2, 'http://accweb/emmployees/peacock.bmp'),
(5, 'Buchanan', 'Steven', 'Sales Manager', 'Mr.', '1955-03-04 00:00:00', '1993-10-17 00:00:00', '14 Garrett Hill', 'London', '', 'SW1 8JR', 'UK', '(71) 555-4848', '3453', NULL, 'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.', 2, 'http://accweb/emmployees/buchanan.bmp'),
(6, 'Suyama', 'Michael', 'Sales Representative', 'Mr.', '1963-07-02 00:00:00', '1993-10-17 00:00:00', 'Coventry House\r\nMiner Rd.', 'London', '', 'EC2 7JR', 'UK', '(71) 555-7773', '428', NULL, 'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 5, 'http://accweb/emmployees/davolio.bmp'),
(7, 'King', 'Robert', 'Sales Representative', 'Mr.', '1960-05-29 00:00:00', '1994-01-02 00:00:00', 'Edgeham Hollow\r\nWinchester Way', 'London', '', 'RG1 9SP', 'UK', '(71) 555-5598', '465', NULL, 'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.', 5, 'http://accweb/emmployees/davolio.bmp'),
(8, 'Callahan', 'Laura', 'Inside Sales Coordinator', 'Ms.', '1958-01-09 00:00:00', '1994-03-05 00:00:00', '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 'USA', '(206) 555-1189', '2344', NULL, 'Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.', 2, 'http://accweb/emmployees/davolio.bmp'),
(9, 'Dodsworth', 'Anne', 'Sales Representative', 'Ms.', '1966-01-27 00:00:00', '1994-11-15 00:00:00', '7 Houndstooth Rd.', 'London', '', 'WG2 7LT', 'UK', '(71) 555-4444', '452', NULL, 'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5, 'http://accweb/emmployees/davolio.bmp');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employeeterritories`
--

CREATE TABLE `employeeterritories` (
  `EmployeeID` int(11) NOT NULL,
  `TerritoryID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `employeeterritories`
--

INSERT INTO `employeeterritories` (`EmployeeID`, `TerritoryID`) VALUES
(1, '19713'),
(1, '6897'),
(2, '1581'),
(2, '1730'),
(2, '1833'),
(2, '2116'),
(2, '2139'),
(2, '2184'),
(2, '40222'),
(3, '30346'),
(3, '31406'),
(3, '32859'),
(3, '33607'),
(4, '20852'),
(4, '27403'),
(4, '27511'),
(5, '10019'),
(5, '10038'),
(5, '11747'),
(5, '14450'),
(5, '2903'),
(5, '7960'),
(5, '8837'),
(6, '85014'),
(6, '85251'),
(6, '98004'),
(6, '98052'),
(6, '98104'),
(7, '60179'),
(7, '60601'),
(7, '80202'),
(7, '80909'),
(7, '90405'),
(7, '94025'),
(7, '94105'),
(7, '95008'),
(7, '95054'),
(7, '95060'),
(8, '19428'),
(8, '44122'),
(8, '45839'),
(8, '53404'),
(9, '3049'),
(9, '3801'),
(9, '48075'),
(9, '48084'),
(9, '48304'),
(9, '55113'),
(9, '55439');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orderdetails`
--

CREATE TABLE `orderdetails` (
  `OrderID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `UnitPrice` double NOT NULL DEFAULT '0',
  `Quantity` smallint(6) NOT NULL DEFAULT '0',
  `Discount` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `orderdetails`
--

INSERT INTO `orderdetails` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES
(10248, 11, 14, 12, 0),
(10248, 42, 9.8, 10, 0),
(10248, 72, 34.8, 5, 0),
(10249, 14, 18.6, 9, 0),
(10249, 51, 42.4, 40, 0),
(10250, 41, 7.7, 10, 0),
(10250, 51, 42.4, 35, 0.15000001),
(10250, 65, 16.8, 15, 0.15000001),
(10251, 22, 16.8, 6, 0.05),
(10251, 57, 15.6, 15, 0.05),
(10251, 65, 16.8, 20, 0),
(10252, 20, 64.8, 40, 0.05),
(10252, 33, 2, 25, 0.05),
(10252, 60, 27.2, 40, 0),
(10253, 31, 10, 20, 0),
(10253, 39, 14.4, 42, 0),
(10253, 49, 16, 40, 0),
(10254, 24, 3.6, 15, 0.15000001),
(10254, 55, 19.2, 21, 0.15000001),
(10254, 74, 8, 21, 0),
(10255, 2, 15.2, 20, 0),
(10255, 16, 13.9, 35, 0),
(10255, 36, 15.2, 25, 0),
(10255, 59, 44, 30, 0),
(10256, 53, 26.2, 15, 0),
(10256, 77, 10.4, 12, 0),
(10257, 27, 35.1, 25, 0),
(10257, 39, 14.4, 6, 0),
(10257, 77, 10.4, 15, 0),
(10258, 2, 15.2, 50, 0.2),
(10258, 5, 17, 65, 0.2),
(10258, 32, 25.6, 6, 0.2),
(10259, 21, 8, 10, 0),
(10259, 37, 20.8, 1, 0),
(10260, 41, 7.7, 16, 0.25),
(10260, 57, 15.6, 50, 0),
(10260, 62, 39.4, 15, 0.25),
(10260, 70, 12, 21, 0.25),
(10261, 21, 8, 20, 0),
(10261, 35, 14.4, 20, 0),
(10262, 5, 17, 12, 0.2),
(10262, 7, 24, 15, 0),
(10262, 56, 30.4, 2, 0),
(10263, 16, 13.9, 60, 0.25),
(10263, 24, 3.6, 28, 0),
(10263, 30, 20.7, 60, 0.25),
(10263, 74, 8, 36, 0.25),
(10264, 2, 15.2, 35, 0),
(10264, 41, 7.7, 25, 0.15000001),
(10265, 17, 31.2, 30, 0),
(10265, 70, 12, 20, 0),
(10266, 12, 30.4, 12, 0.05),
(10267, 40, 14.7, 50, 0),
(10267, 59, 44, 70, 0.15000001),
(10267, 76, 14.4, 15, 0.15000001),
(10268, 29, 99, 10, 0),
(10268, 72, 27.8, 4, 0),
(10269, 33, 2, 60, 0.05),
(10269, 72, 27.8, 20, 0.05),
(10270, 36, 15.2, 30, 0),
(10270, 43, 36.8, 25, 0),
(10271, 33, 2, 24, 0),
(10272, 20, 64.8, 6, 0),
(10272, 31, 10, 40, 0),
(10272, 72, 27.8, 24, 0),
(10273, 10, 24.8, 24, 0.05),
(10273, 31, 10, 15, 0.05),
(10273, 33, 2, 20, 0),
(10273, 40, 14.7, 60, 0.05),
(10273, 76, 14.4, 33, 0.05),
(10274, 71, 17.2, 20, 0),
(10274, 72, 27.8, 7, 0),
(10275, 24, 3.6, 12, 0.05),
(10275, 59, 44, 6, 0.05),
(10276, 10, 24.8, 15, 0),
(10276, 13, 4.8, 10, 0),
(10277, 28, 36.4, 20, 0),
(10277, 62, 39.4, 12, 0),
(10278, 44, 15.5, 16, 0),
(10278, 59, 44, 15, 0),
(10278, 63, 35.1, 8, 0),
(10278, 73, 12, 25, 0),
(10279, 17, 31.2, 15, 0.25),
(10280, 24, 3.6, 12, 0),
(10280, 55, 19.2, 20, 0),
(10280, 75, 6.2, 30, 0),
(10281, 19, 7.3, 1, 0),
(10281, 24, 3.6, 6, 0),
(10281, 35, 14.4, 4, 0),
(10282, 30, 20.7, 6, 0),
(10282, 57, 15.6, 2, 0),
(10283, 15, 12.4, 20, 0),
(10283, 19, 7.3, 18, 0),
(10283, 60, 27.2, 35, 0),
(10283, 72, 27.8, 3, 0),
(10284, 27, 35.1, 15, 0.25),
(10284, 44, 15.5, 21, 0),
(10284, 60, 27.2, 20, 0.25),
(10284, 67, 11.2, 5, 0.25),
(10285, 1, 14.4, 45, 0.2),
(10285, 40, 14.7, 40, 0.2),
(10285, 53, 26.2, 36, 0.2),
(10286, 35, 14.4, 100, 0),
(10286, 62, 39.4, 40, 0),
(10287, 16, 13.9, 40, 0.15000001),
(10287, 34, 11.2, 20, 0),
(10287, 46, 9.6, 15, 0.15000001),
(10288, 54, 5.9, 10, 0.1),
(10288, 68, 10, 3, 0.1),
(10289, 3, 8, 30, 0),
(10289, 64, 26.6, 9, 0),
(10290, 5, 17, 20, 0),
(10290, 29, 99, 15, 0),
(10290, 49, 16, 15, 0),
(10290, 77, 10.4, 10, 0),
(10291, 13, 4.8, 20, 0.1),
(10291, 44, 15.5, 24, 0.1),
(10291, 51, 42.4, 2, 0.1),
(10292, 20, 64.8, 20, 0),
(10293, 18, 50, 12, 0),
(10293, 24, 3.6, 10, 0),
(10293, 63, 35.1, 5, 0),
(10293, 75, 6.2, 6, 0),
(10294, 1, 14.4, 18, 0),
(10294, 17, 31.2, 15, 0),
(10294, 43, 36.8, 15, 0),
(10294, 60, 27.2, 21, 0),
(10294, 75, 6.2, 6, 0),
(10295, 56, 30.4, 4, 0),
(10296, 11, 16.8, 12, 0),
(10296, 16, 13.9, 30, 0),
(10296, 69, 28.8, 15, 0),
(10297, 39, 14.4, 60, 0),
(10297, 72, 27.8, 20, 0),
(10298, 2, 15.2, 40, 0),
(10298, 36, 15.2, 40, 0.25),
(10298, 59, 44, 30, 0.25),
(10298, 62, 39.4, 15, 0),
(10299, 19, 7.3, 15, 0),
(10299, 70, 12, 20, 0),
(10300, 66, 13.6, 30, 0),
(10300, 68, 10, 20, 0),
(10301, 40, 14.7, 10, 0),
(10301, 56, 30.4, 20, 0),
(10302, 17, 31.2, 40, 0),
(10302, 28, 36.4, 28, 0),
(10302, 43, 36.8, 12, 0),
(10303, 40, 14.7, 40, 0.1),
(10303, 65, 16.8, 30, 0.1),
(10303, 68, 10, 15, 0.1),
(10304, 49, 16, 30, 0),
(10304, 59, 44, 10, 0),
(10304, 71, 17.2, 2, 0),
(10305, 18, 50, 25, 0.1),
(10305, 29, 99, 25, 0.1),
(10305, 39, 14.4, 30, 0.1),
(10306, 30, 20.7, 10, 0),
(10306, 53, 26.2, 10, 0),
(10306, 54, 5.9, 5, 0),
(10307, 62, 39.4, 10, 0),
(10307, 68, 10, 3, 0),
(10308, 69, 28.8, 1, 0),
(10308, 70, 12, 5, 0),
(10309, 4, 17.6, 20, 0),
(10309, 6, 20, 30, 0),
(10309, 42, 11.2, 2, 0),
(10309, 43, 36.8, 20, 0),
(10309, 71, 17.2, 3, 0),
(10310, 16, 13.9, 10, 0),
(10310, 62, 39.4, 5, 0),
(10311, 42, 11.2, 6, 0),
(10311, 69, 28.8, 7, 0),
(10312, 28, 36.4, 4, 0),
(10312, 43, 36.8, 24, 0),
(10312, 53, 26.2, 20, 0),
(10312, 75, 6.2, 10, 0),
(10313, 36, 15.2, 12, 0),
(10314, 32, 25.6, 40, 0.1),
(10314, 58, 10.6, 30, 0.1),
(10314, 62, 39.4, 25, 0.1),
(10315, 34, 11.2, 14, 0),
(10315, 70, 12, 30, 0),
(10316, 41, 7.7, 10, 0),
(10316, 62, 39.4, 70, 0),
(10317, 1, 14.4, 20, 0),
(10318, 41, 7.7, 20, 0),
(10318, 76, 14.4, 6, 0),
(10319, 17, 31.2, 8, 0),
(10319, 28, 36.4, 14, 0),
(10319, 76, 14.4, 30, 0),
(10320, 71, 17.2, 30, 0),
(10321, 35, 14.4, 10, 0),
(10322, 52, 5.6, 20, 0),
(10323, 15, 12.4, 5, 0),
(10323, 25, 11.2, 4, 0),
(10323, 39, 14.4, 4, 0),
(10324, 16, 13.9, 21, 0.15000001),
(10324, 35, 14.4, 70, 0.15000001),
(10324, 46, 9.6, 30, 0),
(10324, 59, 44, 40, 0.15000001),
(10324, 63, 35.1, 80, 0.15000001),
(10325, 6, 20, 6, 0),
(10325, 13, 4.8, 12, 0),
(10325, 14, 18.6, 9, 0),
(10325, 31, 10, 4, 0),
(10325, 72, 27.8, 40, 0),
(10326, 4, 17.6, 24, 0),
(10326, 57, 15.6, 16, 0),
(10326, 75, 6.2, 50, 0),
(10327, 2, 15.2, 25, 0.2),
(10327, 11, 16.8, 50, 0.2),
(10327, 30, 20.7, 35, 0.2),
(10327, 58, 10.6, 30, 0.2),
(10328, 59, 44, 9, 0),
(10328, 65, 16.8, 40, 0),
(10328, 68, 10, 10, 0),
(10329, 19, 7.3, 10, 0.05),
(10329, 30, 20.7, 8, 0.05),
(10329, 38, 210.8, 20, 0.05),
(10329, 56, 30.4, 12, 0.05),
(10330, 26, 24.9, 50, 0.15000001),
(10330, 72, 27.8, 25, 0.15000001),
(10331, 54, 5.9, 15, 0),
(10332, 18, 50, 40, 0.2),
(10332, 42, 11.2, 10, 0.2),
(10332, 47, 7.6, 16, 0.2),
(10333, 14, 18.6, 10, 0),
(10333, 21, 8, 10, 0.1),
(10333, 71, 17.2, 40, 0.1),
(10334, 52, 5.6, 8, 0),
(10334, 68, 10, 10, 0),
(10335, 2, 15.2, 7, 0.2),
(10335, 31, 10, 25, 0.2),
(10335, 32, 25.6, 6, 0.2),
(10335, 51, 42.4, 48, 0.2),
(10336, 4, 17.6, 18, 0.1),
(10337, 23, 7.2, 40, 0),
(10337, 26, 24.9, 24, 0),
(10337, 36, 15.2, 20, 0),
(10337, 37, 20.8, 28, 0),
(10337, 72, 27.8, 25, 0),
(10338, 17, 31.2, 20, 0),
(10338, 30, 20.7, 15, 0),
(10339, 4, 17.6, 10, 0),
(10339, 17, 31.2, 70, 0.05),
(10339, 62, 39.4, 28, 0),
(10340, 18, 50, 20, 0.05),
(10340, 41, 7.7, 12, 0.05),
(10340, 43, 36.8, 40, 0.05),
(10341, 33, 2, 8, 0),
(10341, 59, 44, 9, 0.15000001),
(10342, 2, 15.2, 24, 0.2),
(10342, 31, 10, 56, 0.2),
(10342, 36, 15.2, 40, 0.2),
(10342, 55, 19.2, 40, 0.2),
(10343, 64, 26.6, 50, 0),
(10343, 68, 10, 4, 0.05),
(10343, 76, 14.4, 15, 0),
(10344, 4, 17.6, 35, 0),
(10344, 8, 32, 70, 0.25),
(10345, 8, 32, 70, 0),
(10345, 19, 7.3, 80, 0),
(10345, 42, 11.2, 9, 0),
(10346, 17, 31.2, 36, 0.1),
(10346, 56, 30.4, 20, 0),
(10347, 25, 11.2, 10, 0),
(10347, 39, 14.4, 50, 0.15000001),
(10347, 40, 14.7, 4, 0),
(10347, 75, 6.2, 6, 0.15000001),
(10348, 1, 14.4, 15, 0.15000001),
(10348, 23, 7.2, 25, 0),
(10349, 54, 5.9, 24, 0),
(10350, 50, 13, 15, 0.1),
(10350, 69, 28.8, 18, 0.1),
(10351, 38, 210.8, 20, 0.05),
(10351, 41, 7.7, 13, 0),
(10351, 44, 15.5, 77, 0.05),
(10351, 65, 16.8, 10, 0.05),
(10352, 24, 3.6, 10, 0),
(10352, 54, 5.9, 20, 0.15000001),
(10353, 11, 16.8, 12, 0.2),
(10353, 38, 210.8, 50, 0.2),
(10354, 1, 14.4, 12, 0),
(10354, 29, 99, 4, 0),
(10355, 24, 3.6, 25, 0),
(10355, 57, 15.6, 25, 0),
(10356, 31, 10, 30, 0),
(10356, 55, 19.2, 12, 0),
(10356, 69, 28.8, 20, 0),
(10357, 10, 24.8, 30, 0.2),
(10357, 26, 24.9, 16, 0),
(10357, 60, 27.2, 8, 0.2),
(10358, 24, 3.6, 10, 0.05),
(10358, 34, 11.2, 10, 0.05),
(10358, 36, 15.2, 20, 0.05),
(10359, 16, 13.9, 56, 0.05),
(10359, 31, 10, 70, 0.05),
(10359, 60, 27.2, 80, 0.05),
(10360, 28, 36.4, 30, 0),
(10360, 29, 99, 35, 0),
(10360, 38, 210.8, 10, 0),
(10360, 49, 16, 35, 0),
(10360, 54, 5.9, 28, 0),
(10361, 39, 14.4, 54, 0.1),
(10361, 60, 27.2, 55, 0.1),
(10362, 25, 11.2, 50, 0),
(10362, 51, 42.4, 20, 0),
(10362, 54, 5.9, 24, 0),
(10363, 31, 10, 20, 0),
(10363, 75, 6.2, 12, 0),
(10363, 76, 14.4, 12, 0),
(10364, 10, 654654, 54, 456456),
(10364, 69, 28.8, 30, 0),
(10364, 71, 17.2, 5, 0),
(10365, 11, 16.8, 24, 0),
(10366, 65, 16.8, 5, 0),
(10366, 77, 10.4, 5, 0),
(10367, 34, 11.2, 36, 0),
(10367, 54, 5.9, 18, 0),
(10367, 65, 16.8, 15, 0),
(10367, 77, 10.4, 7, 0),
(10368, 21, 8, 5, 0.1),
(10368, 28, 36.4, 13, 0.1),
(10368, 57, 15.6, 25, 0),
(10368, 64, 26.6, 35, 0.1),
(10369, 29, 99, 20, 0),
(10369, 56, 30.4, 18, 0.25),
(10370, 1, 14.4, 15, 0.15000001),
(10370, 64, 26.6, 30, 0),
(10370, 74, 8, 20, 0.15000001),
(10371, 36, 15.2, 6, 0.2),
(10372, 20, 64.8, 12, 0.25),
(10372, 38, 210.8, 40, 0.25),
(10372, 60, 27.2, 70, 0.25),
(10372, 72, 27.8, 42, 0.25),
(10373, 58, 10.6, 80, 0.2),
(10373, 71, 17.2, 50, 0.2),
(10374, 31, 10, 30, 0),
(10374, 58, 10.6, 15, 0),
(10375, 14, 18.6, 15, 0),
(10375, 54, 5.9, 10, 0),
(10376, 31, 10, 42, 0.05),
(10377, 28, 36.4, 20, 0.15000001),
(10377, 39, 14.4, 20, 0.15000001),
(10378, 71, 17.2, 6, 0),
(10379, 41, 7.7, 8, 0.1),
(10379, 63, 35.1, 16, 0.1),
(10379, 65, 16.8, 20, 0.1),
(10380, 30, 20.7, 18, 0.1),
(10380, 53, 26.2, 20, 0.1),
(10380, 60, 27.2, 6, 0.1),
(10380, 70, 12, 30, 0),
(10381, 74, 8, 14, 0),
(10382, 5, 17, 32, 0),
(10382, 18, 50, 9, 0),
(10382, 29, 99, 14, 0),
(10382, 33, 2, 60, 0),
(10382, 74, 8, 50, 0),
(10383, 13, 4.8, 20, 0),
(10383, 50, 13, 15, 0),
(10383, 56, 30.4, 20, 0),
(10384, 20, 64.8, 28, 0),
(10384, 60, 27.2, 15, 0),
(10385, 7, 24, 10, 0.2),
(10385, 60, 27.2, 20, 0.2),
(10385, 68, 10, 8, 0.2),
(10386, 24, 3.6, 15, 0),
(10386, 34, 11.2, 10, 0),
(10387, 24, 3.6, 15, 0),
(10387, 28, 36.4, 6, 0),
(10387, 59, 44, 12, 0),
(10387, 71, 17.2, 15, 0),
(10388, 45, 7.6, 15, 0.2),
(10388, 52, 5.6, 20, 0.2),
(10388, 53, 26.2, 40, 0),
(10389, 10, 24.8, 16, 0),
(10389, 55, 19.2, 15, 0),
(10389, 62, 39.4, 20, 0),
(10389, 70, 12, 30, 0),
(10390, 31, 10, 60, 0.1),
(10390, 35, 14.4, 40, 0.1),
(10390, 46, 9.6, 45, 0),
(10390, 72, 27.8, 24, 0.1),
(10391, 13, 4.8, 18, 0),
(10392, 69, 28.8, 50, 0),
(10393, 2, 15.2, 25, 0.25),
(10393, 14, 18.6, 42, 0.25),
(10393, 25, 11.2, 7, 0.25),
(10393, 26, 24.9, 70, 0.25),
(10393, 31, 10, 32, 0),
(10394, 13, 4.8, 10, 0),
(10394, 62, 39.4, 10, 0),
(10395, 46, 9.6, 28, 0.1),
(10395, 53, 26.2, 70, 0.1),
(10395, 69, 28.8, 8, 0),
(10396, 23, 7.2, 40, 0),
(10396, 71, 17.2, 60, 0),
(10396, 72, 27.8, 21, 0),
(10397, 21, 8, 10, 0.15000001),
(10397, 51, 42.4, 18, 0.15000001),
(10398, 35, 14.4, 30, 0),
(10398, 55, 19.2, 120, 0.1),
(10399, 68, 10, 60, 0),
(10399, 71, 17.2, 30, 0),
(10399, 76, 14.4, 35, 0),
(10399, 77, 10.4, 14, 0),
(10400, 29, 99, 21, 0),
(10400, 35, 14.4, 35, 0),
(10400, 49, 16, 30, 0),
(10401, 30, 20.7, 18, 0),
(10401, 56, 30.4, 70, 0),
(10401, 65, 16.8, 20, 0),
(10401, 71, 17.2, 60, 0),
(10402, 23, 7.2, 60, 0),
(10402, 63, 35.1, 65, 0),
(10403, 16, 13.9, 21, 0.15000001),
(10403, 48, 10.2, 70, 0.15000001),
(10404, 26, 24.9, 30, 0.05),
(10404, 42, 11.2, 40, 0.05),
(10404, 49, 16, 30, 0.05),
(10405, 3, 8, 50, 0),
(10406, 1, 14.4, 10, 0),
(10406, 21, 8, 30, 0.1),
(10406, 28, 36.4, 42, 0.1),
(10406, 36, 15.2, 5, 0.1),
(10406, 40, 14.7, 2, 0.1),
(10407, 11, 16.8, 30, 0),
(10407, 69, 28.8, 15, 0),
(10407, 71, 17.2, 15, 0),
(10408, 37, 20.8, 10, 0),
(10408, 54, 5.9, 6, 0),
(10408, 62, 39.4, 35, 0),
(10409, 14, 18.6, 12, 0),
(10409, 21, 8, 12, 0),
(10410, 33, 2, 49, 0),
(10410, 59, 44, 16, 0),
(10411, 41, 7.7, 25, 0.2),
(10411, 44, 15.5, 40, 0.2),
(10411, 59, 44, 9, 0.2),
(10412, 14, 18.6, 20, 0.1),
(10413, 1, 14.4, 24, 0),
(10413, 62, 39.4, 40, 0),
(10413, 76, 14.4, 14, 0),
(10414, 19, 7.3, 18, 0.05),
(10414, 33, 2, 50, 0),
(10415, 17, 31.2, 2, 0),
(10415, 33, 2, 20, 0),
(10416, 19, 7.3, 20, 0),
(10416, 53, 26.2, 10, 0),
(10416, 57, 15.6, 20, 0),
(10417, 38, 210.8, 50, 0),
(10417, 46, 9.6, 2, 0.25),
(10417, 68, 10, 36, 0.25),
(10417, 77, 10.4, 35, 0),
(10418, 2, 15.2, 60, 0),
(10418, 47, 7.6, 55, 0),
(10418, 61, 22.8, 16, 0),
(10418, 74, 8, 15, 0),
(10419, 60, 27.2, 60, 0.05),
(10419, 69, 28.8, 20, 0.05),
(10420, 9, 77.6, 20, 0.1),
(10420, 13, 4.8, 2, 0.1),
(10420, 70, 12, 8, 0.1),
(10420, 73, 12, 20, 0.1),
(10421, 19, 7.3, 4, 0.15000001),
(10421, 26, 24.9, 30, 0),
(10421, 53, 26.2, 15, 0.15000001),
(10421, 77, 10.4, 10, 0.15000001),
(10422, 26, 24.9, 2, 0),
(10423, 31, 10, 14, 0),
(10423, 59, 44, 20, 0),
(10424, 35, 14.4, 60, 0.2),
(10424, 38, 210.8, 49, 0.2),
(10424, 68, 10, 30, 0.2),
(10425, 55, 19.2, 10, 0.25),
(10425, 76, 14.4, 20, 0.25),
(10426, 56, 30.4, 5, 0),
(10426, 64, 26.6, 7, 0),
(10427, 14, 18.6, 35, 0),
(10428, 46, 9.6, 20, 0),
(10429, 50, 13, 40, 0),
(10429, 63, 35.1, 35, 0.25),
(10430, 17, 31.2, 45, 0.2),
(10430, 21, 8, 50, 0),
(10430, 56, 30.4, 30, 0),
(10430, 59, 44, 70, 0.2),
(10431, 17, 31.2, 50, 0.25),
(10431, 40, 14.7, 50, 0.25),
(10431, 47, 7.6, 30, 0.25),
(10432, 26, 24.9, 10, 0),
(10432, 54, 5.9, 40, 0),
(10433, 56, 30.4, 28, 0),
(10434, 11, 16.8, 6, 0),
(10434, 76, 14.4, 18, 0.15000001),
(10435, 2, 15.2, 10, 0),
(10435, 22, 16.8, 12, 0),
(10435, 72, 27.8, 10, 0),
(10436, 46, 9.6, 5, 0),
(10436, 56, 30.4, 40, 0.1),
(10436, 64, 26.6, 30, 0.1),
(10436, 75, 6.2, 24, 0.1),
(10437, 53, 26.2, 15, 0),
(10438, 19, 7.3, 15, 0.2),
(10438, 34, 11.2, 20, 0.2),
(10438, 57, 15.6, 15, 0.2),
(10439, 12, 30.4, 15, 0),
(10439, 16, 13.9, 16, 0),
(10439, 64, 26.6, 6, 0),
(10439, 74, 8, 30, 0),
(10440, 2, 15.2, 45, 0.15000001),
(10440, 16, 13.9, 49, 0.15000001),
(10440, 29, 99, 24, 0.15000001),
(10440, 61, 22.8, 90, 0.15000001),
(10441, 27, 35.1, 50, 0),
(10442, 11, 16.8, 30, 0),
(10442, 54, 5.9, 80, 0),
(10442, 66, 13.6, 60, 0),
(10443, 11, 16.8, 6, 0.2),
(10443, 28, 36.4, 12, 0),
(10444, 17, 31.2, 10, 0),
(10444, 26, 24.9, 15, 0),
(10444, 35, 14.4, 8, 0),
(10444, 41, 7.7, 30, 0),
(10445, 39, 14.4, 6, 0),
(10445, 54, 5.9, 15, 0),
(10446, 19, 7.3, 12, 0.1),
(10446, 24, 3.6, 20, 0.1),
(10446, 31, 10, 3, 0.1),
(10446, 52, 5.6, 15, 0.1),
(10447, 19, 7.3, 40, 0),
(10447, 65, 16.8, 35, 0),
(10447, 71, 17.2, 2, 0),
(10448, 26, 24.9, 6, 0),
(10448, 40, 14.7, 20, 0),
(10449, 10, 24.8, 14, 0),
(10449, 52, 5.6, 20, 0),
(10449, 62, 39.4, 35, 0),
(10450, 10, 24.8, 20, 0.2),
(10450, 54, 5.9, 6, 0.2),
(10451, 55, 19.2, 120, 0.1),
(10451, 64, 26.6, 35, 0.1),
(10451, 65, 16.8, 28, 0.1),
(10451, 77, 10.4, 55, 0.1),
(10452, 28, 36.4, 15, 0),
(10452, 44, 15.5, 100, 0.05),
(10453, 48, 10.2, 15, 0.1),
(10453, 70, 12, 25, 0.1),
(10454, 16, 13.9, 20, 0.2),
(10454, 33, 2, 20, 0.2),
(10454, 46, 9.6, 10, 0.2),
(10455, 39, 14.4, 20, 0),
(10455, 53, 26.2, 50, 0),
(10455, 61, 22.8, 25, 0),
(10455, 71, 17.2, 30, 0),
(10456, 21, 8, 40, 0.15000001),
(10456, 49, 16, 21, 0.15000001),
(10457, 59, 44, 36, 0),
(10458, 26, 24.9, 30, 0),
(10458, 28, 36.4, 30, 0),
(10458, 43, 36.8, 20, 0),
(10458, 56, 30.4, 15, 0),
(10458, 71, 17.2, 50, 0),
(10459, 7, 24, 16, 0.05),
(10459, 46, 9.6, 20, 0.05),
(10459, 72, 27.8, 40, 0),
(10460, 68, 10, 21, 0.25),
(10460, 75, 6.2, 4, 0.25),
(10461, 21, 8, 40, 0.25),
(10461, 30, 20.7, 28, 0.25),
(10461, 55, 19.2, 60, 0.25),
(10462, 13, 4.8, 1, 0),
(10462, 23, 7.2, 21, 0),
(10463, 19, 7.3, 21, 0),
(10463, 42, 11.2, 50, 0),
(10464, 4, 17.6, 16, 0.2),
(10464, 43, 36.8, 3, 0),
(10464, 56, 30.4, 30, 0.2),
(10464, 60, 27.2, 20, 0),
(10465, 24, 3.6, 25, 0),
(10465, 29, 99, 18, 0.1),
(10465, 40, 14.7, 20, 0),
(10465, 45, 7.6, 30, 0.1),
(10465, 50, 13, 25, 0),
(10466, 11, 16.8, 10, 0),
(10466, 46, 9.6, 5, 0),
(10467, 24, 3.6, 28, 0),
(10467, 25, 11.2, 12, 0),
(10468, 30, 20.7, 8, 0),
(10468, 43, 36.8, 15, 0),
(10469, 2, 15.2, 40, 0.15000001),
(10469, 16, 13.9, 35, 0.15000001),
(10469, 44, 15.5, 2, 0.15000001),
(10470, 18, 50, 30, 0),
(10470, 23, 7.2, 15, 0),
(10470, 64, 26.6, 8, 0),
(10471, 7, 24, 30, 0),
(10471, 56, 30.4, 20, 0),
(10472, 24, 3.6, 80, 0.05),
(10472, 51, 42.4, 18, 0),
(10473, 33, 2, 12, 0),
(10473, 71, 17.2, 12, 0),
(10474, 14, 18.6, 12, 0),
(10474, 28, 36.4, 18, 0),
(10474, 40, 14.7, 21, 0),
(10474, 75, 6.2, 10, 0),
(10475, 31, 10, 35, 0.15000001),
(10475, 66, 13.6, 60, 0.15000001),
(10475, 76, 14.4, 42, 0.15000001),
(10476, 55, 19.2, 2, 0.05),
(10476, 70, 12, 12, 0),
(10477, 1, 14.4, 15, 0),
(10477, 21, 8, 21, 0.25),
(10477, 39, 14.4, 20, 0.25),
(10478, 10, 24.8, 20, 0.05),
(10479, 38, 210.8, 30, 0),
(10479, 53, 26.2, 28, 0),
(10479, 59, 44, 60, 0),
(10479, 64, 26.6, 30, 0),
(10480, 47, 7.6, 30, 0),
(10480, 59, 44, 12, 0),
(10481, 49, 16, 24, 0),
(10481, 60, 27.2, 40, 0),
(10482, 40, 14.7, 10, 0),
(10483, 34, 11.2, 35, 0.05),
(10483, 77, 10.4, 30, 0.05),
(10484, 21, 8, 14, 0),
(10484, 40, 14.7, 10, 0),
(10484, 51, 42.4, 3, 0),
(10485, 2, 15.2, 20, 0.1),
(10485, 3, 8, 20, 0.1),
(10485, 55, 19.2, 30, 0.1),
(10485, 70, 12, 60, 0.1),
(10486, 11, 16.8, 5, 0),
(10486, 51, 42.4, 25, 0),
(10486, 74, 8, 16, 0),
(10487, 19, 7.3, 5, 0),
(10487, 26, 24.9, 30, 0),
(10487, 54, 5.9, 24, 0.25),
(10488, 59, 44, 30, 0),
(10488, 73, 12, 20, 0.2),
(10489, 11, 16.8, 15, 0.25),
(10489, 16, 13.9, 18, 0),
(10490, 59, 44, 60, 0),
(10490, 68, 10, 30, 0),
(10490, 75, 6.2, 36, 0),
(10491, 44, 15.5, 15, 0.15000001),
(10491, 77, 10.4, 7, 0.15000001),
(10492, 25, 11.2, 60, 0.05),
(10492, 42, 11.2, 20, 0.05),
(10493, 65, 16.8, 15, 0.1),
(10493, 66, 13.6, 10, 0.1),
(10493, 69, 28.8, 10, 0.1),
(10494, 56, 30.4, 30, 0),
(10495, 23, 7.2, 10, 0),
(10495, 41, 7.7, 20, 0),
(10495, 77, 10.4, 5, 0),
(10496, 31, 10, 20, 0.05),
(10497, 56, 30.4, 14, 0),
(10497, 72, 27.8, 25, 0),
(10497, 77, 10.4, 25, 0),
(10498, 24, 4.5, 14, 0),
(10498, 40, 18.4, 5, 0),
(10498, 42, 14, 30, 0),
(10499, 28, 45.6, 20, 0),
(10499, 49, 20, 25, 0),
(10500, 15, 15.5, 12, 0.05),
(10500, 28, 45.6, 8, 0.05),
(10501, 54, 7.45, 20, 0),
(10502, 45, 9.5, 21, 0),
(10502, 53, 32.8, 6, 0),
(10502, 67, 14, 30, 0),
(10503, 14, 23.25, 70, 0),
(10503, 65, 21.05, 20, 0),
(10504, 2, 19, 12, 0),
(10504, 21, 10, 12, 0),
(10504, 53, 32.8, 10, 0),
(10504, 61, 28.5, 25, 0),
(10505, 62, 49.3, 3, 0),
(10506, 25, 14, 18, 0.1),
(10506, 70, 15, 14, 0.1),
(10507, 43, 46, 15, 0.15000001),
(10507, 48, 12.75, 15, 0.15000001),
(10508, 13, 6, 10, 0),
(10508, 39, 18, 10, 0),
(10509, 28, 45.6, 3, 0),
(10510, 29, 123.79, 36, 0),
(10510, 75, 7.75, 36, 0.1),
(10511, 4, 22, 50, 0.15000001),
(10511, 7, 30, 50, 0.15000001),
(10511, 8, 40, 10, 0.15000001),
(10512, 24, 4.5, 10, 0.15000001),
(10512, 46, 12, 9, 0.15000001),
(10512, 47, 9.5, 6, 0.15000001),
(10512, 60, 34, 12, 0.15000001),
(10513, 21, 10, 40, 0.2),
(10513, 32, 32, 50, 0.2),
(10513, 61, 28.5, 15, 0.2),
(10514, 20, 81, 39, 0),
(10514, 28, 45.6, 35, 0),
(10514, 56, 38, 70, 0),
(10514, 65, 21.05, 39, 0),
(10514, 75, 7.75, 50, 0),
(10515, 9, 97, 16, 0.15000001),
(10515, 16, 17.45, 50, 0),
(10515, 27, 43.9, 120, 0),
(10515, 33, 2.5, 16, 0.15000001),
(10515, 60, 34, 84, 0.15000001),
(10516, 18, 62.5, 25, 0.1),
(10516, 41, 9.65, 80, 0.1),
(10516, 42, 14, 20, 0),
(10517, 52, 7, 6, 0),
(10517, 59, 55, 4, 0),
(10517, 70, 15, 6, 0),
(10518, 24, 4.5, 5, 0),
(10518, 38, 263.5, 15, 0),
(10518, 44, 19.45, 9, 0),
(10519, 10, 31, 16, 0.05),
(10519, 56, 38, 40, 0),
(10519, 60, 34, 10, 0.05),
(10520, 24, 4.5, 8, 0),
(10520, 53, 32.8, 5, 0),
(10521, 35, 18, 3, 0),
(10521, 41, 9.65, 10, 0),
(10521, 68, 12.5, 6, 0),
(10522, 1, 18, 40, 0.2),
(10522, 8, 40, 24, 0),
(10522, 30, 25.89, 20, 0.2),
(10522, 40, 18.4, 25, 0.2),
(10523, 17, 39, 25, 0.1),
(10523, 20, 81, 15, 0.1),
(10523, 37, 26, 18, 0.1),
(10523, 41, 9.65, 6, 0.1),
(10524, 10, 31, 2, 0),
(10524, 30, 25.89, 10, 0),
(10524, 43, 46, 60, 0),
(10524, 54, 7.45, 15, 0),
(10525, 36, 19, 30, 0),
(10525, 40, 18.4, 15, 0.1),
(10526, 1, 18, 8, 0.15000001),
(10526, 13, 6, 10, 0),
(10526, 56, 38, 30, 0.15000001),
(10527, 4, 22, 50, 0.1),
(10527, 36, 19, 30, 0.1),
(10528, 11, 21, 3, 0),
(10528, 33, 2.5, 8, 0.2),
(10528, 72, 34.8, 9, 0),
(10529, 55, 24, 14, 0),
(10529, 68, 12.5, 20, 0),
(10529, 69, 36, 10, 0),
(10530, 17, 39, 40, 0),
(10530, 43, 46, 25, 0),
(10530, 61, 28.5, 20, 0),
(10530, 76, 18, 50, 0),
(10531, 59, 55, 2, 0),
(10532, 30, 25.89, 15, 0),
(10532, 66, 17, 24, 0),
(10533, 4, 22, 50, 0.05),
(10533, 72, 34.8, 24, 0),
(10533, 73, 15, 24, 0.05),
(10534, 30, 25.89, 10, 0),
(10534, 40, 18.4, 10, 0.2),
(10534, 54, 7.45, 10, 0.2),
(10535, 11, 21, 50, 0.1),
(10535, 40, 18.4, 10, 0.1),
(10535, 57, 19.5, 5, 0.1),
(10535, 59, 55, 15, 0.1),
(10536, 12, 38, 15, 0.25),
(10536, 31, 12.5, 20, 0),
(10536, 33, 2.5, 30, 0),
(10536, 60, 34, 35, 0.25),
(10537, 31, 12.5, 30, 0),
(10537, 51, 53, 6, 0),
(10537, 58, 13.25, 20, 0),
(10537, 72, 34.8, 21, 0),
(10537, 73, 15, 9, 0),
(10538, 70, 15, 7, 0),
(10538, 72, 34.8, 1, 0),
(10539, 13, 6, 8, 0),
(10539, 21, 10, 15, 0),
(10539, 33, 2.5, 15, 0),
(10539, 49, 20, 6, 0),
(10540, 3, 10, 60, 0),
(10540, 26, 31.23, 40, 0),
(10540, 38, 263.5, 30, 0),
(10540, 68, 12.5, 35, 0),
(10541, 24, 4.5, 35, 0.1),
(10541, 38, 263.5, 4, 0.1),
(10541, 65, 21.05, 36, 0.1),
(10541, 71, 21.5, 9, 0.1),
(10542, 11, 21, 15, 0.05),
(10542, 54, 7.45, 24, 0.05),
(10543, 12, 38, 30, 0.15000001),
(10543, 23, 9, 70, 0.15000001),
(10544, 28, 45.6, 7, 0),
(10544, 67, 14, 7, 0),
(10545, 11, 21, 10, 0),
(10546, 7, 30, 10, 0),
(10546, 35, 18, 30, 0),
(10546, 62, 49.3, 40, 0),
(10547, 32, 32, 24, 0.15000001),
(10547, 36, 19, 60, 0),
(10548, 34, 14, 10, 0.25),
(10548, 41, 9.65, 14, 0),
(10549, 31, 12.5, 55, 0.15000001),
(10549, 45, 9.5, 100, 0.15000001),
(10549, 51, 53, 48, 0.15000001),
(10550, 17, 39, 8, 0.1),
(10550, 19, 9.2, 10, 0),
(10550, 21, 10, 6, 0.1),
(10550, 61, 28.5, 10, 0.1),
(10551, 16, 17.45, 40, 0.15000001),
(10551, 35, 18, 20, 0.15000001),
(10551, 44, 19.45, 40, 0),
(10552, 69, 36, 18, 0),
(10552, 75, 7.75, 30, 0),
(10553, 11, 21, 15, 0),
(10553, 16, 17.45, 14, 0),
(10553, 22, 21, 24, 0),
(10553, 31, 12.5, 30, 0),
(10553, 35, 18, 6, 0),
(10554, 16, 17.45, 30, 0.05),
(10554, 23, 9, 20, 0.05),
(10554, 62, 49.3, 20, 0.05),
(10554, 77, 13, 10, 0.05),
(10555, 14, 23.25, 30, 0.2),
(10555, 19, 9.2, 35, 0.2),
(10555, 24, 4.5, 18, 0.2),
(10555, 51, 53, 20, 0.2),
(10555, 56, 38, 40, 0.2),
(10556, 72, 34.8, 24, 0),
(10557, 64, 33.25, 30, 0),
(10557, 75, 7.75, 20, 0),
(10558, 47, 9.5, 25, 0),
(10558, 51, 53, 20, 0),
(10558, 52, 7, 30, 0),
(10558, 53, 32.8, 18, 0),
(10558, 73, 15, 3, 0),
(10559, 41, 9.65, 12, 0.05),
(10559, 55, 24, 18, 0.05),
(10560, 30, 25.89, 20, 0),
(10560, 62, 49.3, 15, 0.25),
(10561, 44, 19.45, 10, 0),
(10561, 51, 53, 50, 0),
(10562, 33, 2.5, 20, 0.1),
(10562, 62, 49.3, 10, 0.1),
(10563, 36, 19, 25, 0),
(10563, 52, 7, 70, 0),
(10564, 17, 39, 16, 0.05),
(10564, 31, 12.5, 6, 0.05),
(10564, 55, 24, 25, 0.05),
(10565, 24, 4.5, 25, 0.1),
(10565, 64, 33.25, 18, 0.1),
(10566, 11, 21, 35, 0.15000001),
(10566, 18, 62.5, 18, 0.15000001),
(10566, 76, 18, 10, 0),
(10567, 31, 12.5, 60, 0.2),
(10567, 51, 53, 3, 0),
(10567, 59, 55, 40, 0.2),
(10568, 10, 31, 5, 0),
(10569, 31, 12.5, 35, 0.2),
(10569, 76, 18, 30, 0),
(10570, 11, 21, 15, 0.05),
(10570, 56, 38, 60, 0.05),
(10571, 14, 23.25, 11, 0.15000001),
(10571, 42, 14, 28, 0.15000001),
(10572, 16, 17.45, 12, 0.1),
(10572, 32, 32, 10, 0.1),
(10572, 40, 18.4, 50, 0),
(10572, 75, 7.75, 15, 0.1),
(10573, 17, 39, 18, 0),
(10573, 34, 14, 40, 0),
(10573, 53, 32.8, 25, 0),
(10574, 33, 2.5, 14, 0),
(10574, 40, 18.4, 2, 0),
(10574, 62, 49.3, 10, 0),
(10574, 64, 33.25, 6, 0),
(10575, 59, 55, 12, 0),
(10575, 63, 43.9, 6, 0),
(10575, 72, 34.8, 30, 0),
(10575, 76, 18, 10, 0),
(10576, 1, 18, 10, 0),
(10576, 31, 12.5, 20, 0),
(10576, 44, 19.45, 21, 0),
(10577, 39, 18, 10, 0),
(10577, 75, 7.75, 20, 0),
(10577, 77, 13, 18, 0),
(10578, 35, 18, 20, 0),
(10578, 57, 19.5, 6, 0),
(10579, 15, 15.5, 10, 0),
(10579, 75, 7.75, 21, 0),
(10580, 14, 23.25, 15, 0.05),
(10580, 41, 9.65, 9, 0.05),
(10580, 65, 21.05, 30, 0.05),
(10581, 75, 7.75, 50, 0.2),
(10582, 57, 19.5, 4, 0),
(10582, 76, 18, 14, 0),
(10583, 29, 123.79, 10, 0),
(10583, 60, 34, 24, 0.15000001),
(10583, 69, 36, 10, 0.15000001),
(10584, 31, 12.5, 50, 0.05),
(10585, 47, 9.5, 15, 0),
(10586, 52, 7, 4, 0.15000001),
(10587, 26, 31.23, 6, 0),
(10587, 35, 18, 20, 0),
(10587, 77, 13, 20, 0),
(10588, 18, 62.5, 40, 0.2),
(10588, 42, 14, 100, 0.2),
(10589, 35, 18, 4, 0),
(10590, 1, 18, 20, 0),
(10590, 77, 13, 60, 0.05),
(10591, 3, 10, 14, 0),
(10591, 7, 30, 10, 0),
(10591, 54, 7.45, 50, 0),
(10592, 15, 15.5, 25, 0.05),
(10592, 26, 31.23, 5, 0.05),
(10593, 20, 81, 21, 0.2),
(10593, 69, 36, 20, 0.2),
(10593, 76, 18, 4, 0.2),
(10594, 52, 7, 24, 0),
(10594, 58, 13.25, 30, 0),
(10595, 35, 18, 30, 0.25),
(10595, 61, 28.5, 120, 0.25),
(10595, 69, 36, 65, 0.25),
(10596, 56, 38, 5, 0.2),
(10596, 63, 43.9, 24, 0.2),
(10596, 75, 7.75, 30, 0.2),
(10597, 24, 4.5, 35, 0.2),
(10597, 57, 19.5, 20, 0),
(10597, 65, 21.05, 12, 0.2),
(10598, 27, 43.9, 50, 0),
(10598, 71, 21.5, 9, 0),
(10599, 62, 49.3, 10, 0),
(10600, 54, 7.45, 4, 0),
(10600, 73, 15, 30, 0),
(10601, 13, 6, 60, 0),
(10601, 59, 55, 35, 0),
(10602, 77, 13, 5, 0.25),
(10603, 22, 21, 48, 0),
(10603, 49, 20, 25, 0.05),
(10604, 48, 12.75, 6, 0.1),
(10604, 76, 18, 10, 0.1),
(10605, 16, 17.45, 30, 0.05),
(10605, 59, 55, 20, 0.05),
(10605, 60, 34, 70, 0.05),
(10605, 71, 21.5, 15, 0.05),
(10606, 4, 22, 20, 0.2),
(10606, 55, 24, 20, 0.2),
(10606, 62, 49.3, 10, 0.2),
(10607, 7, 30, 45, 0),
(10607, 17, 39, 100, 0),
(10607, 33, 2.5, 14, 0),
(10607, 40, 18.4, 42, 0),
(10607, 72, 34.8, 12, 0),
(10608, 56, 38, 28, 0),
(10609, 1, 18, 3, 0),
(10609, 10, 31, 10, 0),
(10609, 21, 10, 6, 0),
(10610, 36, 19, 21, 0.25),
(10611, 1, 18, 6, 0),
(10611, 2, 19, 10, 0),
(10611, 60, 34, 15, 0),
(10612, 10, 31, 70, 0),
(10612, 36, 19, 55, 0),
(10612, 49, 20, 18, 0),
(10612, 60, 34, 40, 0),
(10612, 76, 18, 80, 0),
(10613, 13, 6, 8, 0.1),
(10613, 75, 7.75, 40, 0),
(10614, 11, 21, 14, 0),
(10614, 21, 10, 8, 0),
(10614, 39, 18, 5, 0),
(10615, 55, 24, 5, 0),
(10616, 38, 263.5, 15, 0.05),
(10616, 56, 38, 14, 0),
(10616, 70, 15, 15, 0.05),
(10616, 71, 21.5, 15, 0.05),
(10617, 59, 55, 30, 0.15000001),
(10618, 6, 25, 70, 0),
(10618, 56, 38, 20, 0),
(10618, 68, 12.5, 15, 0),
(10619, 21, 10, 42, 0),
(10619, 22, 21, 40, 0),
(10620, 24, 4.5, 5, 0),
(10620, 52, 7, 5, 0),
(10621, 19, 9.2, 5, 0),
(10621, 23, 9, 10, 0),
(10621, 70, 15, 20, 0),
(10621, 71, 21.5, 15, 0),
(10622, 2, 19, 20, 0),
(10622, 68, 12.5, 18, 0.2),
(10623, 14, 23.25, 21, 0),
(10623, 19, 9.2, 15, 0.1),
(10623, 21, 10, 25, 0.1),
(10623, 24, 4.5, 3, 0),
(10623, 35, 18, 30, 0.1),
(10624, 28, 45.6, 10, 0),
(10624, 29, 123.79, 6, 0),
(10624, 44, 19.45, 10, 0),
(10625, 14, 23.25, 3, 0),
(10625, 42, 14, 5, 0),
(10625, 60, 34, 10, 0),
(10626, 53, 32.8, 12, 0),
(10626, 60, 34, 20, 0),
(10626, 71, 21.5, 20, 0),
(10627, 62, 49.3, 15, 0),
(10627, 73, 15, 35, 0.15000001),
(10628, 1, 18, 25, 0),
(10629, 29, 123.79, 20, 0),
(10629, 64, 33.25, 9, 0),
(10630, 55, 24, 12, 0.05),
(10630, 76, 18, 35, 0),
(10631, 75, 7.75, 8, 0.1),
(10632, 2, 19, 30, 0.05),
(10632, 33, 2.5, 20, 0.05),
(10633, 12, 38, 36, 0.15000001),
(10633, 13, 6, 13, 0.15000001),
(10633, 26, 31.23, 35, 0.15000001),
(10633, 62, 49.3, 80, 0.15000001),
(10634, 7, 30, 35, 0),
(10634, 18, 62.5, 50, 0),
(10634, 51, 53, 15, 0),
(10634, 75, 7.75, 2, 0),
(10635, 4, 22, 10, 0.1),
(10635, 5, 21.35, 15, 0.1),
(10635, 22, 21, 40, 0),
(10636, 4, 22, 25, 0),
(10636, 58, 13.25, 6, 0),
(10637, 11, 21, 10, 0),
(10637, 50, 16.25, 25, 0.05),
(10637, 56, 38, 60, 0.05),
(10638, 45, 9.5, 20, 0),
(10638, 65, 21.05, 21, 0),
(10638, 72, 34.8, 60, 0),
(10639, 18, 62.5, 8, 0),
(10640, 69, 36, 20, 0.25),
(10640, 70, 15, 15, 0.25),
(10641, 2, 19, 50, 0),
(10641, 40, 18.4, 60, 0),
(10642, 21, 10, 30, 0.2),
(10642, 61, 28.5, 20, 0.2),
(10643, 28, 45.6, 15, 0.25),
(10643, 39, 18, 21, 0.25),
(10643, 46, 12, 2, 0.25),
(10644, 18, 62.5, 4, 0.1),
(10644, 43, 46, 20, 0),
(10644, 46, 12, 21, 0.1),
(10645, 18, 62.5, 20, 0),
(10645, 36, 19, 15, 0),
(10646, 1, 18, 15, 0.25),
(10646, 10, 31, 18, 0.25),
(10646, 71, 21.5, 30, 0.25),
(10646, 77, 13, 35, 0.25),
(10647, 19, 9.2, 30, 0),
(10647, 39, 18, 20, 0),
(10648, 22, 21, 15, 0),
(10648, 24, 4.5, 15, 0.15000001),
(10649, 28, 45.6, 20, 0),
(10649, 72, 34.8, 15, 0),
(10650, 30, 25.89, 30, 0),
(10650, 53, 32.8, 25, 0.05),
(10650, 54, 7.45, 30, 0),
(10651, 19, 9.2, 12, 0.25),
(10651, 22, 21, 20, 0.25),
(10652, 30, 25.89, 2, 0.25),
(10652, 42, 14, 20, 0),
(10653, 16, 17.45, 30, 0.1),
(10653, 60, 34, 20, 0.1),
(10654, 4, 22, 12, 0.1),
(10654, 39, 18, 20, 0.1),
(10654, 54, 7.45, 6, 0.1),
(10655, 41, 9.65, 20, 0.2),
(10656, 14, 23.25, 3, 0.1),
(10656, 44, 19.45, 28, 0.1),
(10656, 47, 9.5, 6, 0.1),
(10657, 15, 15.5, 50, 0),
(10657, 41, 9.65, 24, 0),
(10657, 46, 12, 45, 0),
(10657, 47, 9.5, 10, 0),
(10657, 56, 38, 45, 0),
(10657, 60, 34, 30, 0),
(10658, 21, 10, 60, 0),
(10658, 40, 18.4, 70, 0.05),
(10658, 60, 34, 55, 0.05),
(10658, 77, 13, 70, 0.05),
(10659, 31, 12.5, 20, 0.05),
(10659, 40, 18.4, 24, 0.05),
(10659, 70, 15, 40, 0.05),
(10660, 20, 81, 21, 0),
(10661, 39, 18, 3, 0.2),
(10661, 58, 13.25, 49, 0.2),
(10662, 68, 12.5, 10, 0),
(10663, 40, 18.4, 30, 0.05),
(10663, 42, 14, 30, 0.05),
(10663, 51, 53, 20, 0.05),
(10664, 10, 31, 24, 0.15000001),
(10664, 56, 38, 12, 0.15000001),
(10664, 65, 21.05, 15, 0.15000001),
(10665, 51, 53, 20, 0),
(10665, 59, 55, 1, 0),
(10665, 76, 18, 10, 0),
(10666, 29, 123.79, 36, 0),
(10666, 65, 21.05, 10, 0),
(10667, 69, 36, 45, 0.2),
(10667, 71, 21.5, 14, 0.2),
(10668, 31, 12.5, 8, 0.1),
(10668, 55, 24, 4, 0.1),
(10668, 64, 33.25, 15, 0.1),
(10669, 36, 19, 30, 0),
(10670, 23, 9, 32, 0),
(10670, 46, 12, 60, 0),
(10670, 67, 14, 25, 0),
(10670, 73, 15, 50, 0),
(10670, 75, 7.75, 25, 0),
(10671, 16, 17.45, 10, 0),
(10671, 62, 49.3, 10, 0),
(10671, 65, 21.05, 12, 0),
(10672, 38, 263.5, 15, 0.1),
(10672, 71, 21.5, 12, 0),
(10673, 16, 17.45, 3, 0),
(10673, 42, 14, 6, 0),
(10673, 43, 46, 6, 0),
(10674, 23, 9, 5, 0),
(10675, 14, 23.25, 30, 0),
(10675, 53, 32.8, 10, 0),
(10675, 58, 13.25, 30, 0),
(10676, 10, 31, 2, 0),
(10676, 19, 9.2, 7, 0),
(10676, 44, 19.45, 21, 0),
(10677, 26, 31.23, 30, 0.15000001),
(10677, 33, 2.5, 8, 0.15000001),
(10678, 12, 38, 100, 0),
(10678, 33, 2.5, 30, 0),
(10678, 41, 9.65, 120, 0),
(10678, 54, 7.45, 30, 0),
(10679, 59, 55, 12, 0),
(10680, 16, 17.45, 50, 0.25),
(10680, 31, 12.5, 20, 0.25),
(10680, 42, 14, 40, 0.25),
(10681, 19, 9.2, 30, 0.1),
(10681, 21, 10, 12, 0.1),
(10681, 64, 33.25, 28, 0),
(10682, 33, 2.5, 30, 0),
(10682, 66, 17, 4, 0),
(10682, 75, 7.75, 30, 0),
(10683, 52, 7, 9, 0),
(10684, 40, 18.4, 20, 0),
(10684, 47, 9.5, 40, 0),
(10684, 60, 34, 30, 0),
(10685, 10, 31, 20, 0),
(10685, 41, 9.65, 4, 0),
(10685, 47, 9.5, 15, 0),
(10686, 17, 39, 30, 0.2),
(10686, 26, 31.23, 15, 0),
(10687, 9, 97, 50, 0.25),
(10687, 29, 123.79, 10, 0),
(10687, 36, 19, 6, 0.25),
(10688, 10, 31, 18, 0.1),
(10688, 28, 45.6, 60, 0.1),
(10688, 34, 14, 14, 0),
(10689, 1, 18, 35, 0.25),
(10690, 56, 38, 20, 0.25),
(10690, 77, 13, 30, 0.25),
(10691, 1, 18, 30, 0),
(10691, 29, 123.79, 40, 0),
(10691, 43, 46, 40, 0),
(10691, 44, 19.45, 24, 0),
(10691, 62, 49.3, 48, 0),
(10692, 63, 43.9, 20, 0),
(10693, 9, 97, 6, 0),
(10693, 54, 7.45, 60, 0.15000001),
(10693, 69, 36, 30, 0.15000001),
(10693, 73, 15, 15, 0.15000001),
(10694, 7, 30, 90, 0),
(10694, 59, 55, 25, 0),
(10694, 70, 15, 50, 0),
(10695, 8, 40, 10, 0),
(10695, 12, 38, 4, 0),
(10695, 24, 4.5, 20, 0),
(10696, 17, 39, 20, 0),
(10696, 46, 12, 18, 0),
(10697, 19, 9.2, 7, 0.25),
(10697, 35, 18, 9, 0.25),
(10697, 58, 13.25, 30, 0.25),
(10697, 70, 15, 30, 0.25),
(10698, 11, 21, 15, 0),
(10698, 17, 39, 8, 0.05),
(10698, 29, 123.79, 12, 0.05),
(10698, 65, 21.05, 65, 0.05),
(10698, 70, 15, 8, 0.05),
(10699, 47, 9.5, 12, 0),
(10700, 1, 18, 5, 0.2),
(10700, 34, 14, 12, 0.2),
(10700, 68, 12.5, 40, 0.2),
(10700, 71, 21.5, 60, 0.2),
(10701, 59, 55, 42, 0.15000001),
(10701, 71, 21.5, 20, 0.15000001),
(10701, 76, 18, 35, 0.15000001),
(10702, 3, 10, 6, 0),
(10702, 76, 18, 15, 0),
(10703, 2, 19, 5, 0),
(10703, 59, 55, 35, 0),
(10703, 73, 15, 35, 0),
(10704, 4, 22, 6, 0),
(10704, 24, 4.5, 35, 0),
(10704, 48, 12.75, 24, 0),
(10705, 31, 12.5, 20, 0),
(10705, 32, 32, 4, 0),
(10706, 16, 17.45, 20, 0),
(10706, 43, 46, 24, 0),
(10706, 59, 55, 8, 0),
(10707, 55, 24, 21, 0),
(10707, 57, 19.5, 40, 0),
(10707, 70, 15, 28, 0.15000001),
(10708, 5, 21.35, 4, 0),
(10708, 36, 19, 5, 0),
(10709, 8, 40, 40, 0),
(10709, 51, 53, 28, 0),
(10709, 60, 34, 10, 0),
(10710, 19, 9.2, 5, 0),
(10710, 47, 9.5, 5, 0),
(10711, 19, 9.2, 12, 0),
(10711, 41, 9.65, 42, 0),
(10711, 53, 32.8, 120, 0),
(10712, 53, 32.8, 3, 0.05),
(10712, 56, 38, 30, 0),
(10713, 10, 31, 18, 0),
(10713, 26, 31.23, 30, 0),
(10713, 45, 9.5, 110, 0),
(10713, 46, 12, 24, 0),
(10714, 2, 19, 30, 0.25),
(10714, 17, 39, 27, 0.25),
(10714, 47, 9.5, 50, 0.25),
(10714, 56, 38, 18, 0.25),
(10714, 58, 13.25, 12, 0.25),
(10715, 10, 31, 21, 0),
(10715, 71, 21.5, 30, 0),
(10716, 21, 10, 5, 0),
(10716, 51, 53, 7, 0),
(10716, 61, 28.5, 10, 0),
(10717, 21, 10, 32, 0.05),
(10717, 54, 7.45, 15, 0),
(10717, 69, 36, 25, 0.05),
(10718, 12, 38, 36, 0),
(10718, 16, 17.45, 20, 0),
(10718, 36, 19, 40, 0),
(10718, 62, 49.3, 20, 0),
(10719, 18, 62.5, 12, 0.25),
(10719, 30, 25.89, 3, 0.25),
(10719, 54, 7.45, 40, 0.25),
(10720, 35, 18, 21, 0),
(10720, 71, 21.5, 8, 0),
(10721, 44, 19.45, 50, 0.05),
(10722, 2, 19, 3, 0),
(10722, 31, 12.5, 50, 0),
(10722, 68, 12.5, 45, 0),
(10722, 75, 7.75, 42, 0),
(10723, 26, 31.23, 15, 0),
(10724, 10, 31, 16, 0),
(10724, 61, 28.5, 5, 0),
(10725, 41, 9.65, 12, 0),
(10725, 52, 7, 4, 0),
(10725, 55, 24, 6, 0),
(10726, 4, 22, 25, 0),
(10726, 11, 21, 5, 0),
(10727, 17, 39, 20, 0.05),
(10727, 56, 38, 10, 0.05),
(10727, 59, 55, 10, 0.05),
(10728, 30, 25.89, 15, 0),
(10728, 40, 18.4, 6, 0),
(10728, 55, 24, 12, 0),
(10728, 60, 34, 15, 0),
(10729, 1, 18, 50, 0),
(10729, 21, 10, 30, 0),
(10729, 50, 16.25, 40, 0),
(10730, 16, 17.45, 15, 0.05),
(10730, 31, 12.5, 3, 0.05),
(10730, 65, 21.05, 10, 0.05),
(10731, 21, 10, 40, 0.05),
(10731, 51, 53, 30, 0.05),
(10732, 76, 18, 20, 0),
(10733, 14, 23.25, 16, 0),
(10733, 28, 45.6, 20, 0),
(10733, 52, 7, 25, 0),
(10734, 6, 25, 30, 0),
(10734, 30, 25.89, 15, 0),
(10734, 76, 18, 20, 0),
(10735, 61, 28.5, 20, 0.1),
(10735, 77, 13, 2, 0.1),
(10736, 65, 21.05, 40, 0),
(10736, 75, 7.75, 20, 0),
(10737, 13, 6, 4, 0),
(10737, 41, 9.65, 12, 0),
(10738, 16, 17.45, 3, 0),
(10739, 36, 19, 6, 0),
(10739, 52, 7, 18, 0),
(10740, 28, 45.6, 5, 0.2),
(10740, 35, 18, 35, 0.2),
(10740, 45, 9.5, 40, 0.2),
(10740, 56, 38, 14, 0.2),
(10741, 2, 19, 15, 0.2),
(10742, 3, 10, 20, 0),
(10742, 60, 34, 50, 0),
(10742, 72, 34.8, 35, 0),
(10743, 46, 12, 28, 0.05),
(10744, 40, 18.4, 50, 0.2),
(10745, 18, 62.5, 24, 0),
(10745, 44, 19.45, 16, 0),
(10745, 59, 55, 45, 0),
(10745, 72, 34.8, 7, 0),
(10746, 13, 6, 6, 0),
(10746, 42, 14, 28, 0),
(10746, 62, 49.3, 9, 0),
(10746, 69, 36, 40, 0),
(10747, 31, 12.5, 8, 0),
(10747, 41, 9.65, 35, 0),
(10747, 63, 43.9, 9, 0),
(10747, 69, 36, 30, 0),
(10748, 23, 9, 44, 0),
(10748, 40, 18.4, 40, 0),
(10748, 56, 38, 28, 0),
(10749, 56, 38, 15, 0),
(10749, 59, 55, 6, 0),
(10749, 76, 18, 10, 0),
(10750, 14, 23.25, 5, 0.15000001),
(10750, 45, 9.5, 40, 0.15000001),
(10750, 59, 55, 25, 0.15000001),
(10751, 26, 31.23, 12, 0.1),
(10751, 30, 25.89, 30, 0),
(10751, 50, 16.25, 20, 0.1),
(10751, 73, 15, 15, 0),
(10752, 1, 18, 8, 0),
(10752, 69, 36, 3, 0),
(10753, 45, 9.5, 4, 0),
(10753, 74, 10, 5, 0),
(10754, 40, 18.4, 3, 0),
(10755, 47, 9.5, 30, 0.25),
(10755, 56, 38, 30, 0.25),
(10755, 57, 19.5, 14, 0.25),
(10755, 69, 36, 25, 0.25),
(10756, 18, 62.5, 21, 0.2),
(10756, 36, 19, 20, 0.2),
(10756, 68, 12.5, 6, 0.2),
(10756, 69, 36, 20, 0.2),
(10757, 34, 14, 30, 0),
(10757, 59, 55, 7, 0),
(10757, 62, 49.3, 30, 0),
(10757, 64, 33.25, 24, 0),
(10758, 26, 31.23, 20, 0),
(10758, 52, 7, 60, 0),
(10758, 70, 15, 40, 0),
(10759, 32, 32, 10, 0),
(10760, 25, 14, 12, 0.25),
(10760, 27, 43.9, 40, 0),
(10760, 43, 46, 30, 0.25),
(10761, 25, 14, 35, 0.25),
(10761, 75, 7.75, 18, 0),
(10762, 39, 18, 16, 0),
(10762, 47, 9.5, 30, 0),
(10762, 51, 53, 28, 0),
(10762, 56, 38, 60, 0),
(10763, 21, 10, 40, 0),
(10763, 22, 21, 6, 0),
(10763, 24, 4.5, 20, 0),
(10764, 3, 10, 20, 0.1),
(10764, 39, 18, 130, 0.1),
(10765, 65, 21.05, 80, 0.1),
(10766, 2, 19, 40, 0),
(10766, 7, 30, 35, 0),
(10766, 68, 12.5, 40, 0),
(10767, 42, 14, 2, 0),
(10768, 22, 21, 4, 0),
(10768, 31, 12.5, 50, 0),
(10768, 60, 34, 15, 0),
(10768, 71, 21.5, 12, 0),
(10769, 41, 9.65, 30, 0.05),
(10769, 52, 7, 15, 0.05),
(10769, 61, 28.5, 20, 0),
(10769, 62, 49.3, 15, 0),
(10770, 11, 21, 15, 0.25),
(10771, 71, 21.5, 16, 0),
(10772, 29, 123.79, 18, 0),
(10772, 59, 55, 25, 0),
(10773, 17, 39, 33, 0),
(10773, 31, 12.5, 70, 0.2),
(10773, 75, 7.75, 7, 0.2),
(10774, 31, 12.5, 2, 0.25),
(10774, 66, 17, 50, 0),
(10775, 10, 31, 6, 0),
(10775, 67, 14, 3, 0),
(10776, 31, 12.5, 16, 0.05),
(10776, 42, 14, 12, 0.05),
(10776, 45, 9.5, 27, 0.05),
(10776, 51, 53, 120, 0.05),
(10777, 42, 14, 20, 0.2),
(10778, 41, 9.65, 10, 0),
(10779, 16, 17.45, 20, 0),
(10779, 62, 49.3, 20, 0),
(10780, 70, 15, 35, 0),
(10780, 77, 13, 15, 0),
(10781, 54, 7.45, 3, 0.2),
(10781, 56, 38, 20, 0.2),
(10781, 74, 10, 35, 0),
(10782, 31, 12.5, 1, 0),
(10783, 31, 12.5, 10, 0),
(10783, 38, 263.5, 5, 0),
(10784, 36, 19, 30, 0),
(10784, 39, 18, 2, 0.15000001),
(10784, 72, 34.8, 30, 0.15000001),
(10785, 10, 31, 10, 0),
(10785, 75, 7.75, 10, 0),
(10786, 8, 40, 30, 0.2),
(10786, 30, 25.89, 15, 0.2),
(10786, 75, 7.75, 42, 0.2),
(10787, 2, 19, 15, 0.05),
(10787, 29, 123.79, 20, 0.05),
(10788, 19, 9.2, 50, 0.05),
(10788, 75, 7.75, 40, 0.05),
(10789, 18, 62.5, 30, 0),
(10789, 35, 18, 15, 0),
(10789, 63, 43.9, 30, 0),
(10789, 68, 12.5, 18, 0),
(10790, 7, 30, 3, 0.15000001),
(10790, 56, 38, 20, 0.15000001),
(10791, 29, 123.79, 14, 0.05),
(10791, 41, 9.65, 20, 0.05),
(10792, 2, 19, 10, 0),
(10792, 54, 7.45, 3, 0),
(10792, 68, 12.5, 15, 0),
(10793, 41, 9.65, 14, 0),
(10793, 52, 7, 8, 0),
(10794, 14, 23.25, 15, 0.2),
(10794, 54, 7.45, 6, 0.2),
(10795, 16, 17.45, 65, 0),
(10795, 17, 39, 35, 0.25),
(10796, 26, 31.23, 21, 0.2),
(10796, 44, 19.45, 10, 0),
(10796, 64, 33.25, 35, 0.2),
(10796, 69, 36, 24, 0.2),
(10797, 11, 21, 20, 0),
(10798, 62, 49.3, 2, 0),
(10798, 72, 34.8, 10, 0),
(10799, 13, 6, 20, 0.15000001),
(10799, 24, 4.5, 20, 0.15000001),
(10799, 59, 55, 25, 0),
(10800, 11, 21, 50, 0.1),
(10800, 51, 53, 10, 0.1),
(10800, 54, 7.45, 7, 0.1),
(10801, 17, 39, 40, 0.25),
(10801, 29, 123.79, 20, 0.25),
(10802, 30, 25.89, 25, 0.25),
(10802, 51, 53, 30, 0.25),
(10802, 55, 24, 60, 0.25),
(10802, 62, 49.3, 5, 0.25),
(10803, 19, 9.2, 24, 0.05),
(10803, 25, 14, 15, 0.05),
(10803, 59, 55, 15, 0.05),
(10804, 10, 31, 36, 0),
(10804, 28, 45.6, 24, 0),
(10804, 49, 20, 4, 0.15000001),
(10805, 34, 14, 10, 0),
(10805, 38, 263.5, 10, 0),
(10806, 2, 19, 20, 0.25),
(10806, 65, 21.05, 2, 0),
(10806, 74, 10, 15, 0.25),
(10807, 40, 18.4, 1, 0),
(10808, 56, 38, 20, 0.15000001),
(10808, 76, 18, 50, 0.15000001),
(10809, 52, 7, 20, 0),
(10810, 13, 6, 7, 0),
(10810, 25, 14, 5, 0),
(10810, 70, 15, 5, 0),
(10811, 19, 9.2, 15, 0),
(10811, 23, 9, 18, 0),
(10811, 40, 18.4, 30, 0),
(10812, 31, 12.5, 16, 0.1),
(10812, 72, 34.8, 40, 0.1),
(10812, 77, 13, 20, 0),
(10813, 2, 19, 12, 0.2),
(10813, 46, 12, 35, 0),
(10814, 41, 9.65, 20, 0),
(10814, 43, 46, 20, 0.15000001),
(10814, 48, 12.75, 8, 0.15000001),
(10814, 61, 28.5, 30, 0.15000001),
(10815, 33, 2.5, 16, 0),
(10816, 38, 263.5, 30, 0.05),
(10816, 62, 49.3, 20, 0.05),
(10817, 26, 31.23, 40, 0.15000001),
(10817, 38, 263.5, 30, 0),
(10817, 40, 18.4, 60, 0.15000001),
(10817, 62, 49.3, 25, 0.15000001),
(10818, 32, 32, 20, 0),
(10818, 41, 9.65, 20, 0),
(10819, 43, 46, 7, 0),
(10819, 75, 7.75, 20, 0),
(10820, 56, 38, 30, 0),
(10821, 35, 18, 20, 0),
(10821, 51, 53, 6, 0),
(10822, 62, 49.3, 3, 0),
(10822, 70, 15, 6, 0),
(10823, 11, 21, 20, 0.1),
(10823, 57, 19.5, 15, 0),
(10823, 59, 55, 40, 0.1),
(10823, 77, 13, 15, 0.1),
(10824, 41, 9.65, 12, 0),
(10824, 70, 15, 9, 0),
(10825, 26, 31.23, 12, 0),
(10825, 53, 32.8, 20, 0),
(10826, 31, 12.5, 35, 0),
(10826, 57, 19.5, 15, 0),
(10827, 10, 31, 15, 0),
(10827, 39, 18, 21, 0),
(10828, 20, 81, 5, 0),
(10828, 38, 263.5, 2, 0),
(10829, 2, 19, 10, 0),
(10829, 8, 40, 20, 0),
(10829, 13, 6, 10, 0),
(10829, 60, 34, 21, 0),
(10830, 6, 25, 6, 0),
(10830, 39, 18, 28, 0),
(10830, 60, 34, 30, 0),
(10830, 68, 12.5, 24, 0),
(10831, 19, 9.2, 2, 0),
(10831, 35, 18, 8, 0),
(10831, 38, 263.5, 8, 0),
(10831, 43, 46, 9, 0),
(10832, 13, 6, 3, 0.2),
(10832, 25, 14, 10, 0.2),
(10832, 44, 19.45, 16, 0.2),
(10832, 64, 33.25, 3, 0),
(10833, 7, 30, 20, 0.1),
(10833, 31, 12.5, 9, 0.1),
(10833, 53, 32.8, 9, 0.1),
(10834, 29, 123.79, 8, 0.05),
(10834, 30, 25.89, 20, 0.05),
(10835, 59, 55, 15, 0),
(10835, 77, 13, 2, 0.2),
(10836, 22, 21, 52, 0),
(10836, 35, 18, 6, 0),
(10836, 57, 19.5, 24, 0),
(10836, 60, 34, 60, 0),
(10836, 64, 33.25, 30, 0),
(10837, 13, 6, 6, 0),
(10837, 40, 18.4, 25, 0),
(10837, 47, 9.5, 40, 0.25),
(10837, 76, 18, 21, 0.25),
(10838, 1, 18, 4, 0.25),
(10838, 18, 62.5, 25, 0.25),
(10838, 36, 19, 50, 0.25),
(10839, 58, 13.25, 30, 0.1),
(10839, 72, 34.8, 15, 0.1),
(10840, 25, 14, 6, 0.2),
(10840, 39, 18, 10, 0.2),
(10841, 10, 31, 16, 0),
(10841, 56, 38, 30, 0),
(10841, 59, 55, 50, 0),
(10841, 77, 13, 15, 0),
(10842, 11, 21, 15, 0),
(10842, 43, 46, 5, 0),
(10842, 68, 12.5, 20, 0),
(10842, 70, 15, 12, 0),
(10843, 51, 53, 4, 0.25),
(10844, 22, 21, 35, 0),
(10845, 23, 9, 70, 0.1),
(10845, 35, 18, 25, 0.1),
(10845, 42, 14, 42, 0.1),
(10845, 58, 13.25, 60, 0.1),
(10845, 64, 33.25, 48, 0),
(10846, 4, 22, 21, 0),
(10846, 70, 15, 30, 0),
(10846, 74, 10, 20, 0),
(10847, 1, 18, 80, 0.2),
(10847, 19, 9.2, 12, 0.2),
(10847, 37, 26, 60, 0.2),
(10847, 45, 9.5, 36, 0.2),
(10847, 60, 34, 45, 0.2),
(10847, 71, 21.5, 55, 0.2),
(10848, 5, 21.35, 30, 0),
(10848, 9, 97, 3, 0),
(10849, 3, 10, 49, 0),
(10849, 26, 31.23, 18, 0.15000001),
(10850, 25, 14, 20, 0.15000001),
(10850, 33, 2.5, 4, 0.15000001),
(10850, 70, 15, 30, 0.15000001),
(10851, 2, 19, 5, 0.05),
(10851, 25, 14, 10, 0.05),
(10851, 57, 19.5, 10, 0.05),
(10851, 59, 55, 42, 0.05),
(10852, 2, 19, 15, 0),
(10852, 17, 39, 6, 0),
(10852, 62, 49.3, 50, 0),
(10853, 18, 62.5, 10, 0),
(10854, 10, 31, 100, 0.15000001),
(10854, 13, 6, 65, 0.15000001),
(10855, 16, 17.45, 50, 0),
(10855, 31, 12.5, 14, 0),
(10855, 56, 38, 24, 0),
(10855, 65, 21.05, 15, 0.15000001),
(10856, 2, 19, 20, 0),
(10856, 42, 14, 20, 0),
(10857, 3, 10, 30, 0),
(10857, 26, 31.23, 35, 0.25),
(10857, 29, 123.79, 10, 0.25),
(10858, 7, 30, 5, 0),
(10858, 27, 43.9, 10, 0),
(10858, 70, 15, 4, 0),
(10859, 24, 4.5, 40, 0.25),
(10859, 54, 7.45, 35, 0.25),
(10859, 64, 33.25, 30, 0.25),
(10860, 51, 53, 3, 0),
(10860, 76, 18, 20, 0),
(10861, 17, 39, 42, 0),
(10861, 18, 62.5, 20, 0),
(10861, 21, 10, 40, 0),
(10861, 33, 2.5, 35, 0),
(10861, 62, 49.3, 3, 0),
(10862, 11, 21, 25, 0),
(10862, 52, 7, 8, 0),
(10863, 1, 18, 20, 0.15000001),
(10863, 58, 13.25, 12, 0.15000001),
(10864, 35, 18, 4, 0),
(10864, 67, 14, 15, 0),
(10865, 38, 263.5, 60, 0.05),
(10865, 39, 18, 80, 0.05),
(10866, 2, 19, 21, 0.25),
(10866, 24, 4.5, 6, 0.25),
(10866, 30, 25.89, 40, 0.25),
(10867, 53, 32.8, 3, 0),
(10868, 26, 31.23, 20, 0),
(10868, 35, 18, 30, 0),
(10868, 49, 20, 42, 0.1),
(10869, 1, 18, 40, 0),
(10869, 11, 21, 10, 0),
(10869, 23, 9, 50, 0),
(10869, 68, 12.5, 20, 0),
(10870, 35, 18, 3, 0),
(10870, 51, 53, 2, 0),
(10871, 6, 25, 50, 0.05),
(10871, 16, 17.45, 12, 0.05),
(10871, 17, 39, 16, 0.05),
(10872, 55, 24, 10, 0.05),
(10872, 62, 49.3, 20, 0.05),
(10872, 64, 33.25, 15, 0.05),
(10872, 65, 21.05, 21, 0.05),
(10873, 21, 10, 20, 0),
(10873, 28, 45.6, 3, 0),
(10874, 10, 31, 10, 0),
(10875, 19, 9.2, 25, 0),
(10875, 47, 9.5, 21, 0.1),
(10875, 49, 20, 15, 0),
(10876, 46, 12, 21, 0),
(10876, 64, 33.25, 20, 0),
(10877, 16, 17.45, 30, 0.25),
(10877, 18, 62.5, 25, 0),
(10878, 20, 81, 20, 0.05),
(10879, 40, 18.4, 12, 0),
(10879, 65, 21.05, 10, 0),
(10879, 76, 18, 10, 0),
(10880, 23, 9, 30, 0.2),
(10880, 61, 28.5, 30, 0.2),
(10880, 70, 15, 50, 0.2),
(10881, 73, 15, 10, 0),
(10882, 42, 14, 25, 0),
(10882, 49, 20, 20, 0.15000001),
(10882, 54, 7.45, 32, 0.15000001),
(10883, 24, 4.5, 8, 0),
(10884, 21, 10, 40, 0.05),
(10884, 56, 38, 21, 0.05),
(10884, 65, 21.05, 12, 0.05),
(10885, 2, 19, 20, 0),
(10885, 24, 4.5, 12, 0),
(10885, 70, 15, 30, 0),
(10885, 77, 13, 25, 0),
(10886, 10, 31, 70, 0),
(10886, 31, 12.5, 35, 0),
(10886, 77, 13, 40, 0),
(10887, 25, 14, 5, 0),
(10888, 2, 19, 20, 0),
(10888, 68, 12.5, 18, 0),
(10889, 11, 21, 40, 0),
(10889, 38, 263.5, 40, 0),
(10890, 17, 39, 15, 0),
(10890, 34, 14, 10, 0),
(10890, 41, 9.65, 14, 0),
(10891, 30, 25.89, 15, 0.05),
(10892, 59, 55, 40, 0.05),
(10893, 8, 40, 30, 0),
(10893, 24, 4.5, 10, 0),
(10893, 29, 123.79, 24, 0),
(10893, 30, 25.89, 35, 0),
(10893, 36, 19, 20, 0),
(10894, 13, 6, 28, 0.05),
(10894, 69, 36, 50, 0.05),
(10894, 75, 7.75, 120, 0.05),
(10895, 24, 4.5, 110, 0),
(10895, 39, 18, 45, 0),
(10895, 40, 18.4, 91, 0),
(10895, 60, 34, 100, 0),
(10896, 45, 9.5, 15, 0),
(10896, 56, 38, 16, 0),
(10897, 29, 123.79, 80, 0),
(10897, 30, 25.89, 36, 0),
(10898, 13, 6, 5, 0),
(10899, 39, 18, 8, 0.15000001),
(10900, 70, 15, 3, 0.25),
(10901, 41, 9.65, 30, 0),
(10901, 71, 21.5, 30, 0),
(10902, 55, 24, 30, 0.15000001),
(10902, 62, 49.3, 6, 0.15000001),
(10903, 13, 6, 40, 0),
(10903, 65, 21.05, 21, 0),
(10903, 68, 12.5, 20, 0),
(10904, 58, 13.25, 15, 0),
(10904, 62, 49.3, 35, 0),
(10905, 1, 18, 20, 0.05),
(10906, 61, 28.5, 15, 0),
(10907, 75, 7.75, 14, 0),
(10908, 7, 30, 20, 0.05),
(10908, 52, 7, 14, 0.05),
(10909, 7, 30, 12, 0),
(10909, 16, 17.45, 15, 0),
(10909, 41, 9.65, 5, 0),
(10910, 19, 9.2, 12, 0),
(10910, 49, 20, 10, 0),
(10910, 61, 28.5, 5, 0),
(10911, 1, 18, 10, 0),
(10911, 17, 39, 12, 0),
(10911, 67, 14, 15, 0),
(10912, 11, 21, 40, 0.25),
(10912, 29, 123.79, 60, 0.25),
(10913, 4, 22, 30, 0.25),
(10913, 33, 2.5, 40, 0.25),
(10913, 58, 13.25, 15, 0),
(10914, 71, 21.5, 25, 0),
(10915, 17, 39, 10, 0),
(10915, 33, 2.5, 30, 0),
(10915, 54, 7.45, 10, 0),
(10916, 16, 17.45, 6, 0),
(10916, 32, 32, 6, 0),
(10916, 57, 19.5, 20, 0),
(10917, 30, 25.89, 1, 0),
(10917, 60, 34, 10, 0),
(10918, 1, 18, 60, 0.25),
(10918, 60, 34, 25, 0.25),
(10919, 16, 17.45, 24, 0),
(10919, 25, 14, 24, 0),
(10919, 40, 18.4, 20, 0),
(10920, 50, 16.25, 24, 0),
(10921, 35, 18, 10, 0),
(10921, 63, 43.9, 40, 0),
(10922, 17, 39, 15, 0),
(10922, 24, 4.5, 35, 0),
(10923, 42, 14, 10, 0.2),
(10923, 43, 46, 10, 0.2),
(10923, 67, 14, 24, 0.2),
(10924, 10, 31, 20, 0.1),
(10924, 28, 45.6, 30, 0.1),
(10924, 75, 7.75, 6, 0),
(10925, 36, 19, 25, 0.15000001),
(10925, 52, 7, 12, 0.15000001),
(10926, 11, 21, 2, 0),
(10926, 13, 6, 10, 0),
(10926, 19, 9.2, 7, 0),
(10926, 72, 34.8, 10, 0),
(10927, 20, 81, 5, 0),
(10927, 52, 7, 5, 0),
(10927, 76, 18, 20, 0),
(10928, 47, 9.5, 5, 0),
(10928, 76, 18, 5, 0),
(10929, 21, 10, 60, 0),
(10929, 75, 7.75, 49, 0),
(10929, 77, 13, 15, 0),
(10930, 21, 10, 36, 0),
(10930, 27, 43.9, 25, 0),
(10930, 55, 24, 25, 0.2),
(10930, 58, 13.25, 30, 0.2),
(10931, 13, 6, 42, 0.15000001),
(10931, 57, 19.5, 30, 0),
(10932, 16, 17.45, 30, 0.1),
(10932, 62, 49.3, 14, 0.1),
(10932, 72, 34.8, 16, 0),
(10932, 75, 7.75, 20, 0.1),
(10933, 53, 32.8, 2, 0),
(10933, 61, 28.5, 30, 0),
(10934, 6, 25, 20, 0),
(10935, 1, 18, 21, 0),
(10935, 18, 62.5, 4, 0.25),
(10935, 23, 9, 8, 0.25),
(10936, 36, 19, 30, 0.2),
(10937, 28, 45.6, 8, 0),
(10937, 34, 14, 20, 0),
(10938, 13, 6, 20, 0.25),
(10938, 43, 46, 24, 0.25),
(10938, 60, 34, 49, 0.25),
(10938, 71, 21.5, 35, 0.25),
(10939, 2, 19, 10, 0.15000001),
(10939, 67, 14, 40, 0.15000001),
(10940, 7, 30, 8, 0),
(10940, 13, 6, 20, 0),
(10941, 31, 12.5, 44, 0.25),
(10941, 62, 49.3, 30, 0.25),
(10941, 68, 12.5, 80, 0.25),
(10941, 72, 34.8, 50, 0),
(10942, 49, 20, 28, 0),
(10943, 13, 6, 15, 0),
(10943, 22, 21, 21, 0),
(10943, 46, 12, 15, 0),
(10944, 11, 21, 5, 0.25),
(10944, 44, 19.45, 18, 0.25),
(10944, 56, 38, 18, 0),
(10945, 13, 6, 20, 0),
(10945, 31, 12.5, 10, 0),
(10946, 10, 31, 25, 0),
(10946, 24, 4.5, 25, 0),
(10946, 77, 13, 40, 0),
(10947, 59, 55, 4, 0),
(10948, 50, 16.25, 9, 0),
(10948, 51, 53, 40, 0),
(10948, 55, 24, 4, 0),
(10949, 6, 25, 12, 0),
(10949, 10, 31, 30, 0),
(10949, 17, 39, 6, 0),
(10949, 62, 49.3, 60, 0),
(10950, 4, 22, 5, 0),
(10951, 33, 2.5, 15, 0.05),
(10951, 41, 9.65, 6, 0.05),
(10951, 75, 7.75, 50, 0.05),
(10952, 6, 25, 16, 0.05),
(10952, 28, 45.6, 2, 0),
(10953, 20, 81, 50, 0.05),
(10953, 31, 12.5, 50, 0.05),
(10954, 16, 17.45, 28, 0.15000001),
(10954, 31, 12.5, 25, 0.15000001),
(10954, 45, 9.5, 30, 0),
(10954, 60, 34, 24, 0.15000001),
(10955, 75, 7.75, 12, 0.2),
(10956, 21, 10, 12, 0),
(10956, 47, 9.5, 14, 0),
(10956, 51, 53, 8, 0),
(10957, 30, 25.89, 30, 0),
(10957, 35, 18, 40, 0),
(10957, 64, 33.25, 8, 0),
(10958, 5, 21.35, 20, 0),
(10958, 7, 30, 6, 0),
(10958, 72, 34.8, 5, 0),
(10959, 75, 7.75, 20, 0.15000001),
(10960, 24, 4.5, 10, 0.25),
(10960, 41, 9.65, 24, 0),
(10961, 52, 7, 6, 0.05),
(10961, 76, 18, 60, 0),
(10962, 7, 30, 45, 0),
(10962, 13, 6, 77, 0),
(10962, 53, 32.8, 20, 0),
(10962, 69, 36, 9, 0),
(10962, 76, 18, 44, 0),
(10963, 60, 34, 2, 0.15000001),
(10964, 18, 62.5, 6, 0),
(10964, 38, 263.5, 5, 0),
(10964, 69, 36, 10, 0),
(10965, 51, 53, 16, 0),
(10966, 37, 26, 8, 0),
(10966, 56, 38, 12, 0.15000001),
(10966, 62, 49.3, 12, 0.15000001),
(10967, 19, 9.2, 12, 0),
(10967, 49, 20, 40, 0),
(10968, 12, 38, 30, 0),
(10968, 24, 4.5, 30, 0),
(10968, 64, 33.25, 4, 0),
(10969, 46, 12, 9, 0),
(10970, 52, 7, 40, 0.2),
(10971, 29, 123.79, 14, 0),
(10972, 17, 39, 6, 0),
(10972, 33, 2.5, 7, 0),
(10973, 26, 31.23, 5, 0),
(10973, 41, 9.65, 6, 0),
(10973, 75, 7.75, 10, 0),
(10974, 63, 43.9, 10, 0),
(10975, 8, 40, 16, 0),
(10975, 75, 7.75, 10, 0),
(10976, 28, 45.6, 20, 0),
(10977, 39, 18, 30, 0),
(10977, 47, 9.5, 30, 0),
(10977, 51, 53, 10, 0),
(10977, 63, 43.9, 20, 0),
(10978, 8, 40, 20, 0.15000001),
(10978, 21, 10, 40, 0.15000001),
(10978, 40, 18.4, 10, 0),
(10978, 44, 19.45, 6, 0.15000001),
(10979, 7, 30, 18, 0),
(10979, 12, 38, 20, 0),
(10979, 24, 4.5, 80, 0),
(10979, 27, 43.9, 30, 0),
(10979, 31, 12.5, 24, 0),
(10979, 63, 43.9, 35, 0),
(10980, 75, 7.75, 40, 0.2),
(10981, 38, 263.5, 60, 0),
(10982, 7, 30, 20, 0),
(10982, 43, 46, 9, 0),
(10983, 13, 6, 84, 0.15000001),
(10983, 57, 19.5, 15, 0),
(10984, 16, 17.45, 55, 0),
(10984, 24, 4.5, 20, 0),
(10984, 36, 19, 40, 0),
(10985, 16, 17.45, 36, 0.1),
(10985, 18, 62.5, 8, 0.1),
(10985, 32, 32, 35, 0.1),
(10986, 11, 21, 30, 0),
(10986, 20, 81, 15, 0),
(10986, 76, 18, 10, 0),
(10986, 77, 13, 15, 0),
(10987, 7, 30, 60, 0),
(10987, 43, 46, 6, 0),
(10987, 72, 34.8, 20, 0),
(10988, 7, 30, 60, 0),
(10988, 62, 49.3, 40, 0.1),
(10989, 6, 25, 40, 0),
(10989, 11, 21, 15, 0),
(10989, 41, 9.65, 4, 0),
(10990, 21, 10, 65, 0),
(10990, 34, 14, 60, 0.15000001),
(10990, 55, 24, 65, 0.15000001),
(10990, 61, 28.5, 66, 0.15000001),
(10991, 2, 19, 50, 0.2),
(10991, 70, 15, 20, 0.2),
(10991, 76, 18, 90, 0.2),
(10992, 72, 34.8, 2, 0),
(10993, 29, 123.79, 50, 0.25),
(10993, 41, 9.65, 35, 0.25),
(10994, 59, 55, 18, 0.05),
(10995, 51, 53, 20, 0),
(10995, 60, 34, 4, 0),
(10996, 42, 14, 40, 0),
(10997, 32, 32, 50, 0),
(10997, 46, 12, 20, 0.25),
(10997, 52, 7, 20, 0.25),
(10998, 24, 4.5, 12, 0),
(10998, 61, 28.5, 7, 0),
(10998, 74, 10, 20, 0),
(10998, 75, 7.75, 30, 0),
(10999, 41, 9.65, 20, 0.05),
(10999, 51, 53, 15, 0.05),
(10999, 77, 13, 21, 0.05),
(11000, 4, 22, 25, 0.25),
(11000, 24, 4.5, 30, 0.25),
(11000, 77, 13, 30, 0),
(11001, 7, 30, 60, 0),
(11001, 22, 21, 25, 0),
(11001, 46, 12, 25, 0),
(11001, 55, 24, 6, 0),
(11002, 13, 6, 56, 0),
(11002, 35, 18, 15, 0.15000001),
(11002, 42, 14, 24, 0.15000001),
(11002, 55, 24, 40, 0),
(11003, 1, 18, 4, 0),
(11003, 40, 18.4, 10, 0),
(11003, 52, 7, 10, 0),
(11004, 26, 31.23, 6, 0),
(11004, 76, 18, 6, 0),
(11005, 1, 18, 2, 0),
(11005, 59, 55, 10, 0),
(11006, 1, 18, 8, 0),
(11006, 29, 123.79, 2, 0.25),
(11007, 8, 40, 30, 0),
(11007, 29, 123.79, 10, 0),
(11007, 42, 14, 14, 0),
(11008, 28, 45.6, 70, 0.05),
(11008, 34, 14, 90, 0.05),
(11008, 71, 21.5, 21, 0),
(11009, 24, 4.5, 12, 0),
(11009, 36, 19, 18, 0.25),
(11009, 60, 34, 9, 0),
(11010, 7, 30, 20, 0),
(11010, 24, 4.5, 10, 0),
(11011, 58, 13.25, 40, 0.05),
(11011, 71, 21.5, 20, 0),
(11012, 19, 9.2, 50, 0.05),
(11012, 60, 34, 36, 0.05),
(11012, 71, 21.5, 60, 0.05),
(11013, 23, 9, 10, 0),
(11013, 42, 14, 4, 0),
(11013, 45, 9.5, 20, 0),
(11013, 68, 12.5, 2, 0),
(11014, 41, 9.65, 28, 0.1),
(11015, 30, 25.89, 15, 0),
(11015, 77, 13, 18, 0),
(11016, 31, 12.5, 15, 0),
(11016, 36, 19, 16, 0),
(11017, 3, 10, 25, 0),
(11017, 59, 55, 110, 0),
(11017, 70, 15, 30, 0),
(11018, 12, 38, 20, 0),
(11018, 18, 62.5, 10, 0),
(11018, 56, 38, 5, 0),
(11019, 46, 12, 3, 0),
(11019, 49, 20, 2, 0),
(11020, 10, 31, 24, 0.15000001),
(11021, 2, 19, 11, 0.25),
(11021, 20, 81, 15, 0),
(11021, 26, 31.23, 63, 0),
(11021, 51, 53, 44, 0.25),
(11021, 72, 34.8, 35, 0),
(11022, 19, 9.2, 35, 0),
(11022, 69, 36, 30, 0),
(11023, 7, 30, 4, 0),
(11023, 43, 46, 30, 0),
(11024, 26, 31.23, 12, 0),
(11024, 33, 2.5, 30, 0),
(11024, 65, 21.05, 21, 0),
(11024, 71, 21.5, 50, 0),
(11025, 1, 18, 10, 0.1),
(11025, 13, 6, 20, 0.1),
(11026, 18, 62.5, 8, 0),
(11026, 51, 53, 10, 0),
(11027, 24, 4.5, 30, 0.25),
(11027, 62, 49.3, 21, 0.25),
(11028, 55, 24, 35, 0),
(11028, 59, 55, 24, 0),
(11029, 56, 38, 20, 0),
(11029, 63, 43.9, 12, 0),
(11030, 2, 19, 100, 0.25),
(11030, 5, 21.35, 70, 0),
(11030, 29, 123.79, 60, 0.25),
(11030, 59, 55, 100, 0.25),
(11031, 1, 18, 45, 0),
(11031, 13, 6, 80, 0),
(11031, 24, 4.5, 21, 0),
(11031, 64, 33.25, 20, 0),
(11031, 71, 21.5, 16, 0),
(11032, 36, 19, 35, 0),
(11032, 38, 263.5, 25, 0),
(11032, 59, 55, 30, 0),
(11033, 53, 32.8, 70, 0.1),
(11033, 69, 36, 36, 0.1),
(11034, 21, 10, 15, 0.1),
(11034, 44, 19.45, 12, 0),
(11034, 61, 28.5, 6, 0),
(11035, 1, 18, 10, 0),
(11035, 35, 18, 60, 0),
(11035, 42, 14, 30, 0),
(11035, 54, 7.45, 10, 0),
(11036, 13, 6, 7, 0),
(11036, 59, 55, 30, 0),
(11037, 70, 15, 4, 0),
(11038, 40, 18.4, 5, 0.2),
(11038, 52, 7, 2, 0),
(11038, 71, 21.5, 30, 0),
(11039, 28, 45.6, 20, 0),
(11039, 35, 18, 24, 0),
(11039, 49, 20, 60, 0),
(11039, 57, 19.5, 28, 0),
(11040, 21, 10, 20, 0),
(11041, 2, 19, 30, 0.2),
(11041, 63, 43.9, 30, 0),
(11042, 44, 19.45, 15, 0),
(11042, 61, 28.5, 4, 0),
(11043, 11, 21, 10, 0);
INSERT INTO `orderdetails` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES
(11044, 62, 49.3, 12, 0),
(11045, 33, 2.5, 15, 0),
(11045, 51, 53, 24, 0),
(11046, 12, 38, 20, 0.05),
(11046, 32, 32, 15, 0.05),
(11046, 35, 18, 18, 0.05),
(11047, 1, 18, 25, 0.25),
(11047, 5, 21.35, 30, 0.25),
(11048, 68, 12.5, 42, 0),
(11049, 2, 19, 10, 0.2),
(11049, 12, 38, 4, 0.2),
(11050, 76, 18, 50, 0.1),
(11051, 24, 4.5, 10, 0.2),
(11052, 43, 46, 30, 0.2),
(11052, 61, 28.5, 10, 0.2),
(11053, 18, 62.5, 35, 0.2),
(11053, 32, 32, 20, 0),
(11053, 64, 33.25, 25, 0.2),
(11054, 33, 2.5, 10, 0),
(11054, 67, 14, 20, 0),
(11055, 24, 4.5, 15, 0),
(11055, 25, 14, 15, 0),
(11055, 51, 53, 20, 0),
(11055, 57, 19.5, 20, 0),
(11056, 7, 30, 40, 0),
(11056, 55, 24, 35, 0),
(11056, 60, 34, 50, 0),
(11057, 70, 15, 3, 0),
(11058, 21, 10, 3, 0),
(11058, 60, 34, 21, 0),
(11058, 61, 28.5, 4, 0),
(11059, 13, 6, 30, 0),
(11059, 17, 39, 12, 0),
(11059, 60, 34, 35, 0),
(11060, 60, 34, 4, 0),
(11060, 77, 13, 10, 0),
(11061, 60, 34, 15, 0),
(11062, 53, 32.8, 10, 0.2),
(11062, 70, 15, 12, 0.2),
(11063, 34, 14, 30, 0),
(11063, 40, 18.4, 40, 0.1),
(11063, 41, 9.65, 30, 0.1),
(11064, 17, 39, 77, 0.1),
(11064, 41, 9.65, 12, 0),
(11064, 53, 32.8, 25, 0.1),
(11064, 55, 24, 4, 0.1),
(11064, 68, 12.5, 55, 0),
(11065, 30, 25.89, 4, 0.25),
(11065, 54, 7.45, 20, 0.25),
(11066, 16, 17.45, 3, 0),
(11066, 19, 9.2, 42, 0),
(11066, 34, 14, 35, 0),
(11067, 41, 9.65, 9, 0),
(11068, 28, 45.6, 8, 0.15000001),
(11068, 43, 46, 36, 0.15000001),
(11068, 77, 13, 28, 0.15000001),
(11069, 39, 18, 20, 0),
(11070, 1, 18, 40, 0.15000001),
(11070, 2, 19, 20, 0.15000001),
(11070, 16, 17.45, 30, 0.15000001),
(11070, 31, 12.5, 20, 0),
(11071, 7, 30, 15, 0.05),
(11071, 13, 6, 10, 0.05),
(11072, 2, 19, 8, 0),
(11072, 41, 9.65, 40, 0),
(11072, 50, 16.25, 22, 0),
(11072, 64, 33.25, 130, 0),
(11073, 11, 21, 10, 0),
(11073, 24, 4.5, 20, 0),
(11074, 16, 17.45, 14, 0.05),
(11075, 2, 19, 10, 0.15000001),
(11075, 46, 12, 30, 0.15000001),
(11075, 76, 18, 2, 0.15000001),
(11076, 6, 25, 20, 0.25),
(11076, 14, 23.25, 20, 0.25),
(11076, 19, 9.2, 10, 0.25),
(11077, 2, 19, 24, 0.2),
(11077, 3, 10, 4, 0),
(11077, 4, 22, 1, 0),
(11077, 6, 25, 1, 0.02),
(11077, 7, 30, 1, 0.05),
(11077, 8, 40, 2, 0.1),
(11077, 10, 31, 1, 0),
(11077, 12, 38, 2, 0.05),
(11077, 13, 6, 4, 0),
(11077, 14, 23.25, 1, 0.03),
(11077, 16, 17.45, 2, 0.03),
(11077, 20, 81, 1, 0.04),
(11077, 23, 9, 2, 0),
(11077, 32, 32, 1, 0),
(11077, 39, 18, 2, 0.05),
(11077, 41, 9.65, 3, 0),
(11077, 46, 12, 3, 0.02),
(11077, 52, 7, 2, 0),
(11077, 55, 24, 2, 0),
(11077, 60, 34, 2, 0.06),
(11077, 64, 33.25, 2, 0.03),
(11077, 66, 17, 1, 0),
(11077, 73, 15, 2, 0.01),
(11077, 75, 7.75, 4, 0),
(11077, 77, 13, 2, 0),
(11105, 77, 0, 2, 0),
(11106, 77, 0, 2, 0),
(11111, 76, 0, 2, 0),
(11113, 1, 0, 5, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` char(5) DEFAULT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `RequiredDate` datetime DEFAULT NULL,
  `ShippedDate` datetime DEFAULT NULL,
  `ShipVia` int(11) DEFAULT NULL,
  `Freight` double DEFAULT '0',
  `ShipName` varchar(40) DEFAULT NULL,
  `ShipAddress` varchar(60) DEFAULT NULL,
  `ShipCity` varchar(15) DEFAULT NULL,
  `ShipRegion` varchar(15) DEFAULT NULL,
  `ShipPostalCode` varchar(10) DEFAULT NULL,
  `ShipCountry` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES
(10248, 'VINET', 5, '1996-07-04 00:00:00', '1996-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France'),
(10249, 'TOMSP', 6, '1996-07-05 00:00:00', '1996-08-16 00:00:00', '1996-07-10 00:00:00', 1, 11.61, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10250, 'HANAR', 4, '1996-07-08 00:00:00', '1996-08-05 00:00:00', '1996-07-12 00:00:00', 2, 65.83, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10251, 'VICTE', 3, '1996-07-08 00:00:00', '1996-08-05 00:00:00', '1996-07-15 00:00:00', 1, 41.34, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10252, 'SUPRD', 4, '1996-07-09 00:00:00', '1996-08-06 00:00:00', '1996-07-11 00:00:00', 2, 51.3, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10253, 'HANAR', 3, '1996-07-10 00:00:00', '1996-07-24 00:00:00', '1996-07-16 00:00:00', 2, 58.17, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10254, 'CHOPS', 5, '1996-07-11 00:00:00', '1996-08-08 00:00:00', '1996-07-23 00:00:00', 2, 22.98, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10255, 'RICSU', 9, '1996-07-12 00:00:00', '1996-08-09 00:00:00', '1996-07-15 00:00:00', 3, 148.33, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10256, 'WELLI', 3, '1996-07-15 00:00:00', '1996-08-12 00:00:00', '1996-07-17 00:00:00', 2, 13.97, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10257, 'HILAA', 4, '1996-07-16 00:00:00', '1996-08-13 00:00:00', '1996-07-22 00:00:00', 3, 81.91, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10258, 'ERNSH', 1, '1996-07-17 00:00:00', '1996-08-14 00:00:00', '1996-07-23 00:00:00', 1, 140.51, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10259, 'CENTC', 4, '1996-07-18 00:00:00', '1996-08-15 00:00:00', '1996-07-25 00:00:00', 3, 3.25, 'Centro comercial Moctezuma', 'Sierras de Granada 9993', 'M�xico D.F.', '', '5022', 'Mexico'),
(10260, 'OTTIK', 4, '1996-07-19 00:00:00', '1996-08-16 00:00:00', '1996-07-29 00:00:00', 1, 55.09, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10261, 'QUEDE', 4, '1996-07-19 00:00:00', '1996-08-16 00:00:00', '1996-07-30 00:00:00', 2, 3.05, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10262, 'RATTC', 8, '1996-07-22 00:00:00', '1996-08-19 00:00:00', '1996-07-25 00:00:00', 3, 48.29, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10263, 'ERNSH', 9, '1996-07-23 00:00:00', '1996-08-20 00:00:00', '1996-07-31 00:00:00', 3, 146.06, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10264, 'FOLKO', 6, '1996-07-24 00:00:00', '1996-08-21 00:00:00', '1996-08-23 00:00:00', 3, 3.67, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10265, 'BLONP', 2, '1996-07-25 00:00:00', '1996-08-22 00:00:00', '1996-08-12 00:00:00', 1, 55.28, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10266, 'WARTH', 3, '1996-07-26 00:00:00', '1996-09-06 00:00:00', '1996-07-31 00:00:00', 3, 25.73, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10267, 'FRANK', 4, '1996-07-29 00:00:00', '1996-08-26 00:00:00', '1996-08-06 00:00:00', 1, 208.58, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10268, 'GROSR', 8, '1996-07-30 00:00:00', '1996-08-27 00:00:00', '1996-08-02 00:00:00', 3, 66.29, 'GROSELLA-Restaurante', '5� Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela'),
(10269, 'WHITC', 5, '1996-07-31 00:00:00', '1996-08-14 00:00:00', '1996-08-09 00:00:00', 1, 4.56, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10270, 'WARTH', 1, '1996-08-01 00:00:00', '1996-08-29 00:00:00', '1996-08-02 00:00:00', 1, 136.54, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10271, 'SPLIR', 6, '1996-08-01 00:00:00', '1996-08-29 00:00:00', '1996-08-30 00:00:00', 2, 4.54, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10272, 'RATTC', 6, '1996-08-02 00:00:00', '1996-08-30 00:00:00', '1996-08-06 00:00:00', 2, 98.03, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10273, 'QUICK', 3, '1996-08-05 00:00:00', '1996-09-02 00:00:00', '1996-08-12 00:00:00', 3, 76.07, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10274, 'VINET', 6, '1996-08-06 00:00:00', '1996-09-03 00:00:00', '1996-08-16 00:00:00', 1, 6.01, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France'),
(10275, 'MAGAA', 1, '1996-08-07 00:00:00', '1996-09-04 00:00:00', '1996-08-09 00:00:00', 1, 26.93, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10276, 'TORTU', 8, '1996-08-08 00:00:00', '1996-08-22 00:00:00', '1996-08-14 00:00:00', 3, 13.84, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10277, 'MORGK', 2, '1996-08-09 00:00:00', '1996-09-06 00:00:00', '1996-08-13 00:00:00', 3, 125.77, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', '', '4179', 'Germany'),
(10278, 'BERGS', 8, '1996-08-12 00:00:00', '1996-09-09 00:00:00', '1996-08-16 00:00:00', 2, 92.69, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10279, 'LEHMS', 8, '1996-08-13 00:00:00', '1996-09-10 00:00:00', '1996-08-16 00:00:00', 2, 25.83, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10280, 'BERGS', 2, '1996-08-14 00:00:00', '1996-09-11 00:00:00', '1996-09-12 00:00:00', 1, 8.98, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10281, 'ROMEY', 4, '1996-08-14 00:00:00', '1996-08-28 00:00:00', '1996-08-21 00:00:00', 1, 2.94, 'Romero y tomillo', 'Gran V�a, 1', 'Madrid', '', '28001', 'Spain'),
(10282, 'ROMEY', 4, '1996-08-15 00:00:00', '1996-09-12 00:00:00', '1996-08-21 00:00:00', 1, 12.69, 'Romero y tomillo', 'Gran V�a, 1', 'Madrid', '', '28001', 'Spain'),
(10283, 'LILAS', 3, '1996-08-16 00:00:00', '1996-09-13 00:00:00', '1996-08-23 00:00:00', 3, 84.81, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10284, 'LEHMS', 4, '1996-08-19 00:00:00', '1996-09-16 00:00:00', '1996-08-27 00:00:00', 1, 76.56, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10285, 'QUICK', 1, '1996-08-20 00:00:00', '1996-09-17 00:00:00', '1996-08-26 00:00:00', 2, 76.83, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10286, 'QUICK', 8, '1996-08-21 00:00:00', '1996-09-18 00:00:00', '1996-08-30 00:00:00', 3, 229.24, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10287, 'RICAR', 8, '1996-08-22 00:00:00', '1996-09-19 00:00:00', '1996-08-28 00:00:00', 3, 12.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10288, 'REGGC', 4, '1996-08-23 00:00:00', '1996-09-20 00:00:00', '1996-09-03 00:00:00', 1, 7.45, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10289, 'BSBEV', 7, '1996-08-26 00:00:00', '1996-09-23 00:00:00', '1996-08-28 00:00:00', 3, 22.77, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10290, 'COMMI', 8, '1996-08-27 00:00:00', '1996-09-24 00:00:00', '1996-09-03 00:00:00', 1, 79.7, 'Com�rcio Mineiro', 'Av. dos Lus�adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
(10291, 'QUEDE', 6, '1996-08-27 00:00:00', '1996-09-24 00:00:00', '1996-09-04 00:00:00', 2, 6.4, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10292, 'TRADH', 1, '1996-08-28 00:00:00', '1996-09-25 00:00:00', '1996-09-02 00:00:00', 2, 1.35, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10293, 'TORTU', 1, '1996-08-29 00:00:00', '1996-09-26 00:00:00', '1996-09-11 00:00:00', 3, 21.18, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10294, 'RATTC', 4, '1996-08-30 00:00:00', '1996-09-27 00:00:00', '1996-09-05 00:00:00', 2, 147.26, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10295, 'VINET', 2, '1996-09-02 00:00:00', '1996-09-30 00:00:00', '1996-09-10 00:00:00', 2, 1.15, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France'),
(10296, 'LILAS', 6, '1996-09-03 00:00:00', '1996-10-01 00:00:00', '1996-09-11 00:00:00', 1, 0.12, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10297, 'BLONP', 5, '1996-09-04 00:00:00', '1996-10-16 00:00:00', '1996-09-10 00:00:00', 2, 5.74, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10298, 'HUNGO', 6, '1996-09-05 00:00:00', '1996-10-03 00:00:00', '1996-09-11 00:00:00', 2, 168.22, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10299, 'RICAR', 4, '1996-09-06 00:00:00', '1996-10-04 00:00:00', '1996-09-13 00:00:00', 2, 29.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10300, 'MAGAA', 2, '1996-09-09 00:00:00', '1996-10-07 00:00:00', '1996-09-18 00:00:00', 2, 17.68, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10301, 'WANDK', 8, '1996-09-09 00:00:00', '1996-10-07 00:00:00', '1996-09-17 00:00:00', 2, 45.08, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10302, 'SUPRD', 4, '1996-09-10 00:00:00', '1996-10-08 00:00:00', '1996-10-09 00:00:00', 2, 6.27, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10303, 'GODOS', 7, '1996-09-11 00:00:00', '1996-10-09 00:00:00', '1996-09-18 00:00:00', 2, 107.83, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10304, 'TORTU', 1, '1996-09-12 00:00:00', '1996-10-10 00:00:00', '1996-09-17 00:00:00', 2, 63.79, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10305, 'OLDWO', 8, '1996-09-13 00:00:00', '1996-10-11 00:00:00', '1996-10-09 00:00:00', 3, 257.62, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10306, 'ROMEY', 1, '1996-09-16 00:00:00', '1996-10-14 00:00:00', '1996-09-23 00:00:00', 3, 7.56, 'Romero y tomillo', 'Gran V�a, 1', 'Madrid', '', '28001', 'Spain'),
(10307, 'LONEP', 2, '1996-09-17 00:00:00', '1996-10-15 00:00:00', '1996-09-25 00:00:00', 2, 0.56, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10308, 'ANATR', 7, '1996-09-18 00:00:00', '1996-10-16 00:00:00', '1996-09-24 00:00:00', 3, 1.61, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constituci�n 2222', 'M�xico D.F.', '', '5021', 'Mexico'),
(10309, 'HUNGO', 3, '1996-09-19 00:00:00', '1996-10-17 00:00:00', '1996-10-23 00:00:00', 1, 47.3, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10310, 'THEBI', 8, '1996-09-20 00:00:00', '1996-10-18 00:00:00', '1996-09-27 00:00:00', 2, 17.52, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
(10311, 'DUMON', 1, '1996-09-20 00:00:00', '1996-10-04 00:00:00', '1996-09-26 00:00:00', 3, 24.69, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', '', '44000', 'France'),
(10312, 'WANDK', 2, '1996-09-23 00:00:00', '1996-10-21 00:00:00', '1996-10-03 00:00:00', 2, 40.26, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10313, 'QUICK', 2, '1996-09-24 00:00:00', '1996-10-22 00:00:00', '1996-10-04 00:00:00', 2, 1.96, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10314, 'RATTC', 1, '1996-09-25 00:00:00', '1996-10-23 00:00:00', '1996-10-04 00:00:00', 2, 74.16, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10315, 'ISLAT', 4, '1996-09-26 00:00:00', '1996-10-24 00:00:00', '1996-10-03 00:00:00', 2, 41.76, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10316, 'RATTC', 1, '1996-09-27 00:00:00', '1996-10-25 00:00:00', '1996-10-08 00:00:00', 3, 150.15, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10317, 'LONEP', 6, '1996-09-30 00:00:00', '1996-10-28 00:00:00', '1996-10-10 00:00:00', 1, 12.69, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10318, 'ISLAT', 8, '1996-10-01 00:00:00', '1996-10-29 00:00:00', '1996-10-04 00:00:00', 2, 4.73, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10319, 'TORTU', 7, '1996-10-02 00:00:00', '1996-10-30 00:00:00', '1996-10-11 00:00:00', 3, 64.5, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10320, 'WARTH', 5, '1996-10-03 00:00:00', '1996-10-17 00:00:00', '1996-10-18 00:00:00', 3, 34.57, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10321, 'ISLAT', 3, '1996-10-03 00:00:00', '1996-10-31 00:00:00', '1996-10-11 00:00:00', 2, 3.43, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10322, 'PERIC', 7, '1996-10-04 00:00:00', '1996-11-01 00:00:00', '1996-10-23 00:00:00', 3, 0.4, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(10323, 'KOENE', 4, '1996-10-07 00:00:00', '1996-11-04 00:00:00', '1996-10-14 00:00:00', 1, 4.88, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10324, 'SAVEA', 9, '1996-10-08 00:00:00', '1996-11-05 00:00:00', '1996-10-10 00:00:00', 1, 214.27, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10325, 'KOENE', 1, '1996-10-09 00:00:00', '1996-10-23 00:00:00', '1996-10-14 00:00:00', 3, 64.86, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10326, 'BOLID', 4, '1996-10-10 00:00:00', '1996-11-07 00:00:00', '1996-10-14 00:00:00', 2, 77.92, 'B�lido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', '', '28023', 'Spain'),
(10327, 'FOLKO', 2, '1996-10-11 00:00:00', '1996-11-08 00:00:00', '1996-10-14 00:00:00', 1, 63.36, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10328, 'FURIB', 4, '1996-10-14 00:00:00', '1996-11-11 00:00:00', '1996-10-17 00:00:00', 3, 87.03, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10329, 'SPLIR', 4, '1996-10-15 00:00:00', '1996-11-26 00:00:00', '1996-10-23 00:00:00', 2, 191.67, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10330, 'LILAS', 3, '1996-10-16 00:00:00', '1996-11-13 00:00:00', '1996-10-28 00:00:00', 1, 12.75, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10331, 'BONAP', 9, '1996-10-16 00:00:00', '1996-11-27 00:00:00', '1996-10-21 00:00:00', 1, 10.19, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10332, 'MEREP', 3, '1996-10-17 00:00:00', '1996-11-28 00:00:00', '1996-10-21 00:00:00', 2, 52.84, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10333, 'WARTH', 5, '1996-10-18 00:00:00', '1996-11-15 00:00:00', '1996-10-25 00:00:00', 3, 0.59, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10334, 'VICTE', 8, '1996-10-21 00:00:00', '1996-11-18 00:00:00', '1996-10-28 00:00:00', 2, 8.56, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10335, 'HUNGO', 7, '1996-10-22 00:00:00', '1996-11-19 00:00:00', '1996-10-24 00:00:00', 2, 42.11, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10336, 'PRINI', 7, '1996-10-23 00:00:00', '1996-11-20 00:00:00', '1996-10-25 00:00:00', 2, 15.51, 'Princesa Isabel Vinhos', 'Estrada da sa�de n. 58', 'Lisboa', '', '1756', 'Portugal'),
(10337, 'FRANK', 4, '1996-10-24 00:00:00', '1996-11-21 00:00:00', '1996-10-29 00:00:00', 3, 108.26, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10338, 'OLDWO', 4, '1996-10-25 00:00:00', '1996-11-22 00:00:00', '1996-10-29 00:00:00', 3, 84.21, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10339, 'MEREP', 2, '1996-10-28 00:00:00', '1996-11-25 00:00:00', '1996-11-04 00:00:00', 2, 15.66, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10340, 'BONAP', 1, '1996-10-29 00:00:00', '1996-11-26 00:00:00', '1996-11-08 00:00:00', 3, 166.31, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10341, 'SIMOB', 7, '1996-10-29 00:00:00', '1996-11-26 00:00:00', '1996-11-05 00:00:00', 3, 26.78, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10342, 'FRANK', 4, '1996-10-30 00:00:00', '1996-11-13 00:00:00', '1996-11-04 00:00:00', 2, 54.83, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10343, 'LEHMS', 4, '1996-10-31 00:00:00', '1996-11-28 00:00:00', '1996-11-06 00:00:00', 1, 110.37, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10344, 'WHITC', 4, '1996-11-01 00:00:00', '1996-11-29 00:00:00', '1996-11-05 00:00:00', 2, 23.29, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10345, 'QUICK', 2, '1996-11-04 00:00:00', '1996-12-02 00:00:00', '1996-11-11 00:00:00', 2, 249.06, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10346, 'RATTC', 3, '1996-11-05 00:00:00', '1996-12-17 00:00:00', '1996-11-08 00:00:00', 3, 142.08, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10347, 'FAMIA', 4, '1996-11-06 00:00:00', '1996-12-04 00:00:00', '1996-11-08 00:00:00', 3, 3.1, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10348, 'WANDK', 4, '1996-11-07 00:00:00', '1996-12-05 00:00:00', '1996-11-15 00:00:00', 2, 0.78, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10349, 'SPLIR', 7, '1996-11-08 00:00:00', '1996-12-06 00:00:00', '1996-11-15 00:00:00', 1, 8.63, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10350, 'LAMAI', 6, '1996-11-11 00:00:00', '1996-12-09 00:00:00', '1996-12-03 00:00:00', 2, 64.19, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10351, 'ERNSH', 1, '1996-11-11 00:00:00', '1996-12-09 00:00:00', '1996-11-20 00:00:00', 1, 162.33, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10352, 'FURIB', 3, '1996-11-12 00:00:00', '1996-11-26 00:00:00', '1996-11-18 00:00:00', 3, 1.3, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10353, 'PICCO', 7, '1996-11-13 00:00:00', '1996-12-11 00:00:00', '1996-11-25 00:00:00', 3, 360.63, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10354, 'PERIC', 8, '1996-11-14 00:00:00', '1996-12-12 00:00:00', '1996-11-20 00:00:00', 3, 53.8, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(10355, 'AROUT', 6, '1996-11-15 00:00:00', '1996-12-13 00:00:00', '1996-11-20 00:00:00', 1, 41.95, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10356, 'WANDK', 6, '1996-11-18 00:00:00', '1996-12-16 00:00:00', '1996-11-27 00:00:00', 2, 36.71, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10357, 'LILAS', 1, '1996-11-19 00:00:00', '1996-12-17 00:00:00', '1996-12-02 00:00:00', 3, 34.88, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10358, 'LAMAI', 5, '1996-11-20 00:00:00', '1996-12-18 00:00:00', '1996-11-27 00:00:00', 1, 19.64, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10359, 'SEVES', 5, '1996-11-21 00:00:00', '1996-12-19 00:00:00', '1996-11-26 00:00:00', 3, 288.43, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10360, 'BLONP', 4, '1996-11-22 00:00:00', '1996-12-20 00:00:00', '1996-12-02 00:00:00', 3, 131.7, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10361, 'QUICK', 1, '1996-11-22 00:00:00', '1996-12-20 00:00:00', '1996-12-03 00:00:00', 2, 183.17, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10362, 'BONAP', 3, '1996-11-25 00:00:00', '1996-12-23 00:00:00', '1996-11-28 00:00:00', 1, 96.04, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10363, 'DRACD', 4, '1996-11-26 00:00:00', '1996-12-24 00:00:00', '1996-12-04 00:00:00', 3, 30.54, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(10364, 'EASTC', 1, '1996-11-26 00:00:00', '1997-01-07 00:00:00', '1996-12-04 00:00:00', 1, 71.97, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(10365, 'ANTON', 3, '1996-11-27 00:00:00', '1996-12-25 00:00:00', '1996-12-02 00:00:00', 2, 22, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10366, 'GALED', 8, '1996-11-28 00:00:00', '1997-01-09 00:00:00', '1996-12-30 00:00:00', 2, 10.14, 'Galer�a del gastron�mo', 'Rambla de Catalu�a, 23', 'Barcelona', '', '8022', 'Spain'),
(10367, 'VAFFE', 7, '1996-11-28 00:00:00', '1996-12-26 00:00:00', '1996-12-02 00:00:00', 3, 13.55, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10368, 'ERNSH', 2, '1996-11-29 00:00:00', '1996-12-27 00:00:00', '1996-12-02 00:00:00', 2, 101.95, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10369, 'SPLIR', 8, '1996-12-02 00:00:00', '1996-12-30 00:00:00', '1996-12-09 00:00:00', 2, 195.68, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10370, 'CHOPS', 6, '1996-12-03 00:00:00', '1996-12-31 00:00:00', '1996-12-27 00:00:00', 2, 1.17, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10371, 'LAMAI', 1, '1996-12-03 00:00:00', '1996-12-31 00:00:00', '1996-12-24 00:00:00', 1, 0.45, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10372, 'QUEEN', 5, '1996-12-04 00:00:00', '1997-01-01 00:00:00', '1996-12-09 00:00:00', 2, 890.78, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10373, 'HUNGO', 4, '1996-12-05 00:00:00', '1997-01-02 00:00:00', '1996-12-11 00:00:00', 3, 124.12, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10374, 'WOLZA', 1, '1996-12-05 00:00:00', '1997-01-02 00:00:00', '1996-12-09 00:00:00', 3, 3.94, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10375, 'HUNGC', 3, '1996-12-06 00:00:00', '1997-01-03 00:00:00', '1996-12-09 00:00:00', 2, 20.12, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(10376, 'MEREP', 1, '1996-12-09 00:00:00', '1997-01-06 00:00:00', '1996-12-13 00:00:00', 2, 20.39, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10377, 'SEVES', 1, '1996-12-09 00:00:00', '1997-01-06 00:00:00', '1996-12-13 00:00:00', 3, 22.21, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10378, 'FOLKO', 5, '1996-12-10 00:00:00', '1997-01-07 00:00:00', '1996-12-19 00:00:00', 3, 5.44, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10379, 'QUEDE', 2, '1996-12-11 00:00:00', '1997-01-08 00:00:00', '1996-12-13 00:00:00', 1, 45.03, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10380, 'HUNGO', 8, '1996-12-12 00:00:00', '1997-01-09 00:00:00', '1997-01-16 00:00:00', 3, 35.03, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10381, 'LILAS', 3, '1996-12-12 00:00:00', '1997-01-09 00:00:00', '1996-12-13 00:00:00', 3, 7.99, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10382, 'ERNSH', 4, '1996-12-13 00:00:00', '1997-01-10 00:00:00', '1996-12-16 00:00:00', 1, 94.77, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10383, 'AROUT', 8, '1996-12-16 00:00:00', '1997-01-13 00:00:00', '1996-12-18 00:00:00', 3, 34.24, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10384, 'BERGS', 3, '1996-12-16 00:00:00', '1997-01-13 00:00:00', '1996-12-20 00:00:00', 3, 168.64, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10385, 'SPLIR', 1, '1996-12-17 00:00:00', '1997-01-14 00:00:00', '1996-12-23 00:00:00', 2, 30.96, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10386, 'FAMIA', 9, '1996-12-18 00:00:00', '1997-01-01 00:00:00', '1996-12-25 00:00:00', 3, 13.99, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10387, 'SANTG', 1, '1996-12-18 00:00:00', '1997-01-15 00:00:00', '1996-12-20 00:00:00', 2, 93.63, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(10388, 'SEVES', 2, '1996-12-19 00:00:00', '1997-01-16 00:00:00', '1996-12-20 00:00:00', 1, 34.86, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10389, 'BOTTM', 4, '1996-12-20 00:00:00', '1997-01-17 00:00:00', '1996-12-24 00:00:00', 2, 47.42, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10390, 'ERNSH', 6, '1996-12-23 00:00:00', '1997-01-20 00:00:00', '1996-12-26 00:00:00', 1, 126.38, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10391, 'DRACD', 3, '1996-12-23 00:00:00', '1997-01-20 00:00:00', '1996-12-31 00:00:00', 3, 5.45, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(10392, 'PICCO', 2, '1996-12-24 00:00:00', '1997-01-21 00:00:00', '1997-01-01 00:00:00', 3, 122.46, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10393, 'SAVEA', 1, '1996-12-25 00:00:00', '1997-01-22 00:00:00', '1997-01-03 00:00:00', 3, 126.56, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10394, 'HUNGC', 1, '1996-12-25 00:00:00', '1997-01-22 00:00:00', '1997-01-03 00:00:00', 3, 30.34, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(10395, 'HILAA', 6, '1996-12-26 00:00:00', '1997-01-23 00:00:00', '1997-01-03 00:00:00', 1, 184.41, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10396, 'FRANK', 1, '1996-12-27 00:00:00', '1997-01-10 00:00:00', '1997-01-06 00:00:00', 3, 135.35, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10397, 'PRINI', 5, '1996-12-27 00:00:00', '1997-01-24 00:00:00', '1997-01-02 00:00:00', 1, 60.26, 'Princesa Isabel Vinhos', 'Estrada da sa�de n. 58', 'Lisboa', '', '1756', 'Portugal'),
(10398, 'SAVEA', 2, '1996-12-30 00:00:00', '1997-01-27 00:00:00', '1997-01-09 00:00:00', 3, 89.16, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10399, 'VAFFE', 8, '1996-12-31 00:00:00', '1997-01-14 00:00:00', '1997-01-08 00:00:00', 3, 27.36, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10400, 'EASTC', 1, '1997-01-01 00:00:00', '1997-01-29 00:00:00', '1997-01-16 00:00:00', 3, 83.93, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(10401, 'RATTC', 1, '1997-01-01 00:00:00', '1997-01-29 00:00:00', '1997-01-10 00:00:00', 1, 12.51, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10402, 'ERNSH', 8, '1997-01-02 00:00:00', '1997-02-13 00:00:00', '1997-01-10 00:00:00', 2, 67.88, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10403, 'ERNSH', 4, '1997-01-03 00:00:00', '1997-01-31 00:00:00', '1997-01-09 00:00:00', 3, 73.79, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10404, 'MAGAA', 2, '1997-01-03 00:00:00', '1997-01-31 00:00:00', '1997-01-08 00:00:00', 1, 155.97, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10405, 'LINOD', 1, '1997-01-06 00:00:00', '1997-02-03 00:00:00', '1997-01-22 00:00:00', 1, 34.82, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10406, 'QUEEN', 7, '1997-01-07 00:00:00', '1997-02-18 00:00:00', '1997-01-13 00:00:00', 1, 108.04, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10407, 'OTTIK', 2, '1997-01-07 00:00:00', '1997-02-04 00:00:00', '1997-01-30 00:00:00', 2, 91.48, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10408, 'FOLIG', 8, '1997-01-08 00:00:00', '1997-02-05 00:00:00', '1997-01-14 00:00:00', 1, 11.26, 'Folies gourmandes', '184, chauss�e de Tournai', 'Lille', '', '59000', 'France'),
(10409, 'OCEAN', 3, '1997-01-09 00:00:00', '1997-02-06 00:00:00', '1997-01-14 00:00:00', 1, 29.83, 'Oc�ano Atl�ntico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina'),
(10410, 'BOTTM', 3, '1997-01-10 00:00:00', '1997-02-07 00:00:00', '1997-01-15 00:00:00', 3, 2.4, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10411, 'BOTTM', 9, '1997-01-10 00:00:00', '1997-02-07 00:00:00', '1997-01-21 00:00:00', 3, 23.65, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10412, 'WARTH', 8, '1997-01-13 00:00:00', '1997-02-10 00:00:00', '1997-01-15 00:00:00', 2, 3.77, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10413, 'LAMAI', 3, '1997-01-14 00:00:00', '1997-02-11 00:00:00', '1997-01-16 00:00:00', 2, 95.66, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10414, 'FAMIA', 2, '1997-01-14 00:00:00', '1997-02-11 00:00:00', '1997-01-17 00:00:00', 3, 21.48, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10415, 'HUNGC', 3, '1997-01-15 00:00:00', '1997-02-12 00:00:00', '1997-01-24 00:00:00', 1, 0.2, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(10416, 'WARTH', 8, '1997-01-16 00:00:00', '1997-02-13 00:00:00', '1997-01-27 00:00:00', 3, 22.72, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10417, 'SIMOB', 4, '1997-01-16 00:00:00', '1997-02-13 00:00:00', '1997-01-28 00:00:00', 3, 70.29, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10418, 'QUICK', 4, '1997-01-17 00:00:00', '1997-02-14 00:00:00', '1997-01-24 00:00:00', 1, 17.55, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10419, 'RICSU', 4, '1997-01-20 00:00:00', '1997-02-17 00:00:00', '1997-01-30 00:00:00', 2, 137.35, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10420, 'WELLI', 3, '1997-01-21 00:00:00', '1997-02-18 00:00:00', '1997-01-27 00:00:00', 1, 44.12, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10421, 'QUEDE', 8, '1997-01-21 00:00:00', '1997-03-04 00:00:00', '1997-01-27 00:00:00', 1, 99.23, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10422, 'FRANS', 2, '1997-01-22 00:00:00', '1997-02-19 00:00:00', '1997-01-31 00:00:00', 1, 3.02, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(10423, 'GOURL', 6, '1997-01-23 00:00:00', '1997-02-06 00:00:00', '1997-02-24 00:00:00', 3, 24.5, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10424, 'MEREP', 7, '1997-01-23 00:00:00', '1997-02-20 00:00:00', '1997-01-27 00:00:00', 2, 370.61, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10425, 'LAMAI', 6, '1997-01-24 00:00:00', '1997-02-21 00:00:00', '1997-02-14 00:00:00', 2, 7.93, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10426, 'GALED', 4, '1997-01-27 00:00:00', '1997-02-24 00:00:00', '1997-02-06 00:00:00', 1, 18.69, 'Galer�a del gastron�mo', 'Rambla de Catalu�a, 23', 'Barcelona', '', '8022', 'Spain'),
(10427, 'PICCO', 4, '1997-01-27 00:00:00', '1997-02-24 00:00:00', '1997-03-03 00:00:00', 2, 31.29, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10428, 'REGGC', 7, '1997-01-28 00:00:00', '1997-02-25 00:00:00', '1997-02-04 00:00:00', 1, 11.09, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10429, 'HUNGO', 3, '1997-01-29 00:00:00', '1997-03-12 00:00:00', '1997-02-07 00:00:00', 2, 56.63, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10430, 'ERNSH', 4, '1997-01-30 00:00:00', '1997-02-13 00:00:00', '1997-02-03 00:00:00', 1, 458.78, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10431, 'BOTTM', 4, '1997-01-30 00:00:00', '1997-02-13 00:00:00', '1997-02-07 00:00:00', 2, 44.17, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10432, 'SPLIR', 3, '1997-01-31 00:00:00', '1997-02-14 00:00:00', '1997-02-07 00:00:00', 2, 4.34, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10433, 'PRINI', 3, '1997-02-03 00:00:00', '1997-03-03 00:00:00', '1997-03-04 00:00:00', 3, 73.83, 'Princesa Isabel Vinhos', 'Estrada da sa�de n. 58', 'Lisboa', '', '1756', 'Portugal'),
(10434, 'FOLKO', 3, '1997-02-03 00:00:00', '1997-03-03 00:00:00', '1997-02-13 00:00:00', 2, 17.92, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10435, 'CONSH', 8, '1997-02-04 00:00:00', '1997-03-18 00:00:00', '1997-02-07 00:00:00', 2, 9.21, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', '', 'WX1 6LT', 'UK'),
(10436, 'BLONP', 3, '1997-02-05 00:00:00', '1997-03-05 00:00:00', '1997-02-11 00:00:00', 2, 156.66, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10437, 'WARTH', 8, '1997-02-05 00:00:00', '1997-03-05 00:00:00', '1997-02-12 00:00:00', 1, 19.97, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10438, 'TOMSP', 3, '1997-02-06 00:00:00', '1997-03-06 00:00:00', '1997-02-14 00:00:00', 2, 8.24, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10439, 'MEREP', 6, '1997-02-07 00:00:00', '1997-03-07 00:00:00', '1997-02-10 00:00:00', 3, 4.07, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10440, 'SAVEA', 4, '1997-02-10 00:00:00', '1997-03-10 00:00:00', '1997-02-28 00:00:00', 2, 86.53, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10441, 'OLDWO', 3, '1997-02-10 00:00:00', '1997-03-24 00:00:00', '1997-03-14 00:00:00', 2, 73.02, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10442, 'ERNSH', 3, '1997-02-11 00:00:00', '1997-03-11 00:00:00', '1997-02-18 00:00:00', 2, 47.94, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10443, 'REGGC', 8, '1997-02-12 00:00:00', '1997-03-12 00:00:00', '1997-02-14 00:00:00', 1, 13.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10444, 'BERGS', 3, '1997-02-12 00:00:00', '1997-03-12 00:00:00', '1997-02-21 00:00:00', 3, 3.5, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10445, 'BERGS', 3, '1997-02-13 00:00:00', '1997-03-13 00:00:00', '1997-02-20 00:00:00', 1, 9.3, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10446, 'TOMSP', 6, '1997-02-14 00:00:00', '1997-03-14 00:00:00', '1997-02-19 00:00:00', 1, 14.68, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10447, 'RICAR', 4, '1997-02-14 00:00:00', '1997-03-14 00:00:00', '1997-03-07 00:00:00', 2, 68.66, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10448, 'RANCH', 4, '1997-02-17 00:00:00', '1997-03-17 00:00:00', '1997-02-24 00:00:00', 2, 38.82, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina'),
(10449, 'BLONP', 3, '1997-02-18 00:00:00', '1997-03-18 00:00:00', '1997-02-27 00:00:00', 2, 53.3, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10450, 'VICTE', 8, '1997-02-19 00:00:00', '1997-03-19 00:00:00', '1997-03-11 00:00:00', 2, 7.23, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10451, 'QUICK', 4, '1997-02-19 00:00:00', '1997-03-05 00:00:00', '1997-03-12 00:00:00', 3, 189.09, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10452, 'SAVEA', 8, '1997-02-20 00:00:00', '1997-03-20 00:00:00', '1997-02-26 00:00:00', 1, 140.26, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10453, 'AROUT', 1, '1997-02-21 00:00:00', '1997-03-21 00:00:00', '1997-02-26 00:00:00', 2, 25.36, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10454, 'LAMAI', 4, '1997-02-21 00:00:00', '1997-03-21 00:00:00', '1997-02-25 00:00:00', 3, 2.74, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10455, 'WARTH', 8, '1997-02-24 00:00:00', '1997-04-07 00:00:00', '1997-03-03 00:00:00', 2, 180.45, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10456, 'KOENE', 8, '1997-02-25 00:00:00', '1997-04-08 00:00:00', '1997-02-28 00:00:00', 2, 8.12, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10457, 'KOENE', 2, '1997-02-25 00:00:00', '1997-03-25 00:00:00', '1997-03-03 00:00:00', 1, 11.57, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10458, 'SUPRD', 7, '1997-02-26 00:00:00', '1997-03-26 00:00:00', '1997-03-04 00:00:00', 3, 147.06, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10459, 'VICTE', 4, '1997-02-27 00:00:00', '1997-03-27 00:00:00', '1997-02-28 00:00:00', 2, 25.09, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10460, 'FOLKO', 8, '1997-02-28 00:00:00', '1997-03-28 00:00:00', '1997-03-03 00:00:00', 1, 16.27, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10461, 'LILAS', 1, '1997-02-28 00:00:00', '1997-03-28 00:00:00', '1997-03-05 00:00:00', 3, 148.61, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10462, 'CONSH', 2, '1997-03-03 00:00:00', '1997-03-31 00:00:00', '1997-03-18 00:00:00', 1, 6.17, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', '', 'WX1 6LT', 'UK'),
(10463, 'SUPRD', 5, '1997-03-04 00:00:00', '1997-04-01 00:00:00', '1997-03-06 00:00:00', 3, 14.78, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10464, 'FURIB', 4, '1997-03-04 00:00:00', '1997-04-01 00:00:00', '1997-03-14 00:00:00', 2, 89, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10465, 'VAFFE', 1, '1997-03-05 00:00:00', '1997-04-02 00:00:00', '1997-03-14 00:00:00', 3, 145.04, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10466, 'COMMI', 4, '1997-03-06 00:00:00', '1997-04-03 00:00:00', '1997-03-13 00:00:00', 1, 11.93, 'Com�rcio Mineiro', 'Av. dos Lus�adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
(10467, 'MAGAA', 8, '1997-03-06 00:00:00', '1997-04-03 00:00:00', '1997-03-11 00:00:00', 2, 4.93, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10468, 'KOENE', 3, '1997-03-07 00:00:00', '1997-04-04 00:00:00', '1997-03-12 00:00:00', 3, 44.12, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10469, 'WHITC', 1, '1997-03-10 00:00:00', '1997-04-07 00:00:00', '1997-03-14 00:00:00', 1, 60.18, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10470, 'BONAP', 4, '1997-03-11 00:00:00', '1997-04-08 00:00:00', '1997-03-14 00:00:00', 2, 64.56, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10471, 'BSBEV', 2, '1997-03-11 00:00:00', '1997-04-08 00:00:00', '1997-03-18 00:00:00', 3, 45.59, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10472, 'SEVES', 8, '1997-03-12 00:00:00', '1997-04-09 00:00:00', '1997-03-19 00:00:00', 1, 4.2, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10473, 'ISLAT', 1, '1997-03-13 00:00:00', '1997-03-27 00:00:00', '1997-03-21 00:00:00', 3, 16.37, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10474, 'PERIC', 5, '1997-03-13 00:00:00', '1997-04-10 00:00:00', '1997-03-21 00:00:00', 2, 83.49, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(10475, 'SUPRD', 9, '1997-03-14 00:00:00', '1997-04-11 00:00:00', '1997-04-04 00:00:00', 1, 68.52, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10476, 'HILAA', 8, '1997-03-17 00:00:00', '1997-04-14 00:00:00', '1997-03-24 00:00:00', 3, 4.41, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10477, 'PRINI', 5, '1997-03-17 00:00:00', '1997-04-14 00:00:00', '1997-03-25 00:00:00', 2, 13.02, 'Princesa Isabel Vinhos', 'Estrada da sa�de n. 58', 'Lisboa', '', '1756', 'Portugal'),
(10478, 'VICTE', 2, '1997-03-18 00:00:00', '1997-04-01 00:00:00', '1997-03-26 00:00:00', 3, 4.81, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10479, 'RATTC', 3, '1997-03-19 00:00:00', '1997-04-16 00:00:00', '1997-03-21 00:00:00', 3, 708.95, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10480, 'FOLIG', 6, '1997-03-20 00:00:00', '1997-04-17 00:00:00', '1997-03-24 00:00:00', 2, 1.35, 'Folies gourmandes', '184, chauss�e de Tournai', 'Lille', '', '59000', 'France'),
(10481, 'RICAR', 8, '1997-03-20 00:00:00', '1997-04-17 00:00:00', '1997-03-25 00:00:00', 2, 64.33, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10482, 'LAZYK', 1, '1997-03-21 00:00:00', '1997-04-18 00:00:00', '1997-04-10 00:00:00', 3, 7.48, 'Lazy K Kountry Store', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA'),
(10483, 'WHITC', 7, '1997-03-24 00:00:00', '1997-04-21 00:00:00', '1997-04-25 00:00:00', 2, 15.28, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10484, 'BSBEV', 3, '1997-03-24 00:00:00', '1997-04-21 00:00:00', '1997-04-01 00:00:00', 3, 6.88, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10485, 'LINOD', 4, '1997-03-25 00:00:00', '1997-04-08 00:00:00', '1997-03-31 00:00:00', 2, 64.45, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10486, 'HILAA', 1, '1997-03-26 00:00:00', '1997-04-23 00:00:00', '1997-04-02 00:00:00', 2, 30.53, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10487, 'QUEEN', 2, '1997-03-26 00:00:00', '1997-04-23 00:00:00', '1997-03-28 00:00:00', 2, 71.07, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10488, 'FRANK', 8, '1997-03-27 00:00:00', '1997-04-24 00:00:00', '1997-04-02 00:00:00', 2, 4.93, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10489, 'PICCO', 6, '1997-03-28 00:00:00', '1997-04-25 00:00:00', '1997-04-09 00:00:00', 2, 5.29, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10490, 'HILAA', 7, '1997-03-31 00:00:00', '1997-04-28 00:00:00', '1997-04-03 00:00:00', 2, 210.19, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10491, 'FURIB', 8, '1997-03-31 00:00:00', '1997-04-28 00:00:00', '1997-04-08 00:00:00', 3, 16.96, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10492, 'BOTTM', 3, '1997-04-01 00:00:00', '1997-04-29 00:00:00', '1997-04-11 00:00:00', 1, 62.89, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10493, 'LAMAI', 4, '1997-04-02 00:00:00', '1997-04-30 00:00:00', '1997-04-10 00:00:00', 3, 10.64, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10494, 'COMMI', 4, '1997-04-02 00:00:00', '1997-04-30 00:00:00', '1997-04-09 00:00:00', 2, 65.99, 'Com�rcio Mineiro', 'Av. dos Lus�adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
(10495, 'LAUGB', 3, '1997-04-03 00:00:00', '1997-05-01 00:00:00', '1997-04-11 00:00:00', 3, 4.65, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
(10496, 'TRADH', 7, '1997-04-04 00:00:00', '1997-05-02 00:00:00', '1997-04-07 00:00:00', 2, 46.77, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10497, 'LEHMS', 7, '1997-04-04 00:00:00', '1997-05-02 00:00:00', '1997-04-07 00:00:00', 1, 36.21, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10498, 'HILAA', 8, '1997-04-07 00:00:00', '1997-05-05 00:00:00', '1997-04-11 00:00:00', 2, 29.75, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10499, 'LILAS', 4, '1997-04-08 00:00:00', '1997-05-06 00:00:00', '1997-04-16 00:00:00', 2, 102.02, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10500, 'LAMAI', 6, '1997-04-09 00:00:00', '1997-05-07 00:00:00', '1997-04-17 00:00:00', 1, 42.68, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10501, 'BLAUS', 9, '1997-04-09 00:00:00', '1997-05-07 00:00:00', '1997-04-16 00:00:00', 3, 8.85, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10502, 'PERIC', 2, '1997-04-10 00:00:00', '1997-05-08 00:00:00', '1997-04-29 00:00:00', 1, 69.32, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(10503, 'HUNGO', 6, '1997-04-11 00:00:00', '1997-05-09 00:00:00', '1997-04-16 00:00:00', 2, 16.74, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10504, 'WHITC', 4, '1997-04-11 00:00:00', '1997-05-09 00:00:00', '1997-04-18 00:00:00', 3, 59.13, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10505, 'MEREP', 3, '1997-04-14 00:00:00', '1997-05-12 00:00:00', '1997-04-21 00:00:00', 3, 7.13, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10506, 'KOENE', 9, '1997-04-15 00:00:00', '1997-05-13 00:00:00', '1997-05-02 00:00:00', 2, 21.19, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10507, 'ANTON', 7, '1997-04-15 00:00:00', '1997-05-13 00:00:00', '1997-04-22 00:00:00', 1, 47.45, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10508, 'OTTIK', 1, '1997-04-16 00:00:00', '1997-05-14 00:00:00', '1997-05-13 00:00:00', 2, 4.99, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10509, 'BLAUS', 4, '1997-04-17 00:00:00', '1997-05-15 00:00:00', '1997-04-29 00:00:00', 1, 0.15, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10510, 'SAVEA', 6, '1997-04-18 00:00:00', '1997-05-16 00:00:00', '1997-04-28 00:00:00', 3, 367.63, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10511, 'BONAP', 4, '1997-04-18 00:00:00', '1997-05-16 00:00:00', '1997-04-21 00:00:00', 3, 350.64, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10512, 'FAMIA', 7, '1997-04-21 00:00:00', '1997-05-19 00:00:00', '1997-04-24 00:00:00', 2, 3.53, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10513, 'WANDK', 7, '1997-04-22 00:00:00', '1997-06-03 00:00:00', '1997-04-28 00:00:00', 1, 105.65, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10514, 'ERNSH', 3, '1997-04-22 00:00:00', '1997-05-20 00:00:00', '1997-05-16 00:00:00', 2, 789.95, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10515, 'QUICK', 2, '1997-04-23 00:00:00', '1997-05-07 00:00:00', '1997-05-23 00:00:00', 1, 204.47, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10516, 'HUNGO', 2, '1997-04-24 00:00:00', '1997-05-22 00:00:00', '1997-05-01 00:00:00', 3, 62.78, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10517, 'NORTS', 3, '1997-04-24 00:00:00', '1997-05-22 00:00:00', '1997-04-29 00:00:00', 3, 32.07, 'North/South', 'South House 300 Queensbridge', 'London', '', 'SW7 1RZ', 'UK'),
(10518, 'TORTU', 4, '1997-04-25 00:00:00', '1997-05-09 00:00:00', '1997-05-05 00:00:00', 2, 218.15, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10519, 'CHOPS', 6, '1997-04-28 00:00:00', '1997-05-26 00:00:00', '1997-05-01 00:00:00', 3, 91.76, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10520, 'SANTG', 7, '1997-04-29 00:00:00', '1997-05-27 00:00:00', '1997-05-01 00:00:00', 1, 13.37, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(10521, 'CACTU', 8, '1997-04-29 00:00:00', '1997-05-27 00:00:00', '1997-05-02 00:00:00', 2, 17.22, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(10522, 'LEHMS', 4, '1997-04-30 00:00:00', '1997-05-28 00:00:00', '1997-05-06 00:00:00', 1, 45.33, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10523, 'SEVES', 7, '1997-05-01 00:00:00', '1997-05-29 00:00:00', '1997-05-30 00:00:00', 2, 77.63, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10524, 'BERGS', 1, '1997-05-01 00:00:00', '1997-05-29 00:00:00', '1997-05-07 00:00:00', 2, 244.79, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden');
INSERT INTO `orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES
(10525, 'BONAP', 1, '1997-05-02 00:00:00', '1997-05-30 00:00:00', '1997-05-23 00:00:00', 2, 11.06, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10526, 'WARTH', 4, '1997-05-05 00:00:00', '1997-06-02 00:00:00', '1997-05-15 00:00:00', 2, 58.59, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10527, 'QUICK', 7, '1997-05-05 00:00:00', '1997-06-02 00:00:00', '1997-05-07 00:00:00', 1, 41.9, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10528, 'GREAL', 6, '1997-05-06 00:00:00', '1997-05-20 00:00:00', '1997-05-09 00:00:00', 2, 3.35, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10529, 'MAISD', 5, '1997-05-07 00:00:00', '1997-06-04 00:00:00', '1997-05-09 00:00:00', 2, 66.69, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10530, 'PICCO', 3, '1997-05-08 00:00:00', '1997-06-05 00:00:00', '1997-05-12 00:00:00', 2, 339.22, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10531, 'OCEAN', 7, '1997-05-08 00:00:00', '1997-06-05 00:00:00', '1997-05-19 00:00:00', 1, 8.12, 'Oc�ano Atl�ntico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina'),
(10532, 'EASTC', 7, '1997-05-09 00:00:00', '1997-06-06 00:00:00', '1997-05-12 00:00:00', 3, 74.46, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(10533, 'FOLKO', 8, '1997-05-12 00:00:00', '1997-06-09 00:00:00', '1997-05-22 00:00:00', 1, 188.04, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10534, 'LEHMS', 8, '1997-05-12 00:00:00', '1997-06-09 00:00:00', '1997-05-14 00:00:00', 2, 27.94, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10535, 'ANTON', 4, '1997-05-13 00:00:00', '1997-06-10 00:00:00', '1997-05-21 00:00:00', 1, 15.64, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10536, 'LEHMS', 3, '1997-05-14 00:00:00', '1997-06-11 00:00:00', '1997-06-06 00:00:00', 2, 58.88, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10537, 'RICSU', 1, '1997-05-14 00:00:00', '1997-05-28 00:00:00', '1997-05-19 00:00:00', 1, 78.85, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10538, 'BSBEV', 9, '1997-05-15 00:00:00', '1997-06-12 00:00:00', '1997-05-16 00:00:00', 3, 4.87, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10539, 'BSBEV', 6, '1997-05-16 00:00:00', '1997-06-13 00:00:00', '1997-05-23 00:00:00', 3, 12.36, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10540, 'QUICK', 3, '1997-05-19 00:00:00', '1997-06-16 00:00:00', '1997-06-13 00:00:00', 3, 1007.64, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10541, 'HANAR', 2, '1997-05-19 00:00:00', '1997-06-16 00:00:00', '1997-05-29 00:00:00', 1, 68.65, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10542, 'KOENE', 1, '1997-05-20 00:00:00', '1997-06-17 00:00:00', '1997-05-26 00:00:00', 3, 10.95, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10543, 'LILAS', 8, '1997-05-21 00:00:00', '1997-06-18 00:00:00', '1997-05-23 00:00:00', 2, 48.17, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10544, 'LONEP', 4, '1997-05-21 00:00:00', '1997-06-18 00:00:00', '1997-05-30 00:00:00', 1, 24.91, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10545, 'LAZYK', 8, '1997-05-22 00:00:00', '1997-06-19 00:00:00', '1997-06-26 00:00:00', 2, 11.92, 'Lazy K Kountry Store', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA'),
(10546, 'VICTE', 1, '1997-05-23 00:00:00', '1997-06-20 00:00:00', '1997-05-27 00:00:00', 3, 194.72, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10547, 'SEVES', 3, '1997-05-23 00:00:00', '1997-06-20 00:00:00', '1997-06-02 00:00:00', 2, 178.43, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10548, 'TOMSP', 3, '1997-05-26 00:00:00', '1997-06-23 00:00:00', '1997-06-02 00:00:00', 2, 1.43, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10549, 'QUICK', 5, '1997-05-27 00:00:00', '1997-06-10 00:00:00', '1997-05-30 00:00:00', 1, 171.24, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10550, 'GODOS', 7, '1997-05-28 00:00:00', '1997-06-25 00:00:00', '1997-06-06 00:00:00', 3, 4.32, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10551, 'FURIB', 4, '1997-05-28 00:00:00', '1997-07-09 00:00:00', '1997-06-06 00:00:00', 3, 72.95, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10552, 'HILAA', 2, '1997-05-29 00:00:00', '1997-06-26 00:00:00', '1997-06-05 00:00:00', 1, 83.22, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10553, 'WARTH', 2, '1997-05-30 00:00:00', '1997-06-27 00:00:00', '1997-06-03 00:00:00', 2, 149.49, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10554, 'OTTIK', 4, '1997-05-30 00:00:00', '1997-06-27 00:00:00', '1997-06-05 00:00:00', 3, 120.97, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10555, 'SAVEA', 6, '1997-06-02 00:00:00', '1997-06-30 00:00:00', '1997-06-04 00:00:00', 3, 252.49, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10556, 'SIMOB', 2, '1997-06-03 00:00:00', '1997-07-15 00:00:00', '1997-06-13 00:00:00', 1, 9.8, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10557, 'LEHMS', 9, '1997-06-03 00:00:00', '1997-06-17 00:00:00', '1997-06-06 00:00:00', 2, 96.72, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10558, 'AROUT', 1, '1997-06-04 00:00:00', '1997-07-02 00:00:00', '1997-06-10 00:00:00', 2, 72.97, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10559, 'BLONP', 6, '1997-06-05 00:00:00', '1997-07-03 00:00:00', '1997-06-13 00:00:00', 1, 8.05, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10560, 'FRANK', 8, '1997-06-06 00:00:00', '1997-07-04 00:00:00', '1997-06-09 00:00:00', 1, 36.65, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10561, 'FOLKO', 2, '1997-06-06 00:00:00', '1997-07-04 00:00:00', '1997-06-09 00:00:00', 2, 242.21, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10562, 'REGGC', 1, '1997-06-09 00:00:00', '1997-07-07 00:00:00', '1997-06-12 00:00:00', 1, 22.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10563, 'RICAR', 2, '1997-06-10 00:00:00', '1997-07-22 00:00:00', '1997-06-24 00:00:00', 2, 60.43, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10564, 'RATTC', 4, '1997-06-10 00:00:00', '1997-07-08 00:00:00', '1997-06-16 00:00:00', 3, 13.75, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10565, 'MEREP', 8, '1997-06-11 00:00:00', '1997-07-09 00:00:00', '1997-06-18 00:00:00', 2, 7.15, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10566, 'BLONP', 9, '1997-06-12 00:00:00', '1997-07-10 00:00:00', '1997-06-18 00:00:00', 1, 88.4, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10567, 'HUNGO', 1, '1997-06-12 00:00:00', '1997-07-10 00:00:00', '1997-06-17 00:00:00', 1, 33.97, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10568, 'GALED', 3, '1997-06-13 00:00:00', '1997-07-11 00:00:00', '1997-07-09 00:00:00', 3, 6.54, 'Galer�a del gastron�mo', 'Rambla de Catalu�a, 23', 'Barcelona', '', '8022', 'Spain'),
(10569, 'RATTC', 5, '1997-06-16 00:00:00', '1997-07-14 00:00:00', '1997-07-11 00:00:00', 1, 58.98, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10570, 'MEREP', 3, '1997-06-17 00:00:00', '1997-07-15 00:00:00', '1997-06-19 00:00:00', 3, 188.99, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10571, 'ERNSH', 8, '1997-06-17 00:00:00', '1997-07-29 00:00:00', '1997-07-04 00:00:00', 3, 26.06, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10572, 'BERGS', 3, '1997-06-18 00:00:00', '1997-07-16 00:00:00', '1997-06-25 00:00:00', 2, 116.43, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10573, 'ANTON', 7, '1997-06-19 00:00:00', '1997-07-17 00:00:00', '1997-06-20 00:00:00', 3, 84.84, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10574, 'TRAIH', 4, '1997-06-19 00:00:00', '1997-07-17 00:00:00', '1997-06-30 00:00:00', 2, 37.6, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
(10575, 'MORGK', 5, '1997-06-20 00:00:00', '1997-07-04 00:00:00', '1997-06-30 00:00:00', 1, 127.34, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', '', '4179', 'Germany'),
(10576, 'TORTU', 3, '1997-06-23 00:00:00', '1997-07-07 00:00:00', '1997-06-30 00:00:00', 3, 18.56, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10577, 'TRAIH', 9, '1997-06-23 00:00:00', '1997-08-04 00:00:00', '1997-06-30 00:00:00', 2, 25.41, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
(10578, 'BSBEV', 4, '1997-06-24 00:00:00', '1997-07-22 00:00:00', '1997-07-25 00:00:00', 3, 29.6, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10579, 'LETSS', 1, '1997-06-25 00:00:00', '1997-07-23 00:00:00', '1997-07-04 00:00:00', 2, 13.73, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
(10580, 'OTTIK', 4, '1997-06-26 00:00:00', '1997-07-24 00:00:00', '1997-07-01 00:00:00', 3, 75.89, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10581, 'FAMIA', 3, '1997-06-26 00:00:00', '1997-07-24 00:00:00', '1997-07-02 00:00:00', 1, 3.01, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10582, 'BLAUS', 3, '1997-06-27 00:00:00', '1997-07-25 00:00:00', '1997-07-14 00:00:00', 2, 27.71, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10583, 'WARTH', 2, '1997-06-30 00:00:00', '1997-07-28 00:00:00', '1997-07-04 00:00:00', 2, 7.28, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10584, 'BLONP', 4, '1997-06-30 00:00:00', '1997-07-28 00:00:00', '1997-07-04 00:00:00', 1, 59.14, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10585, 'WELLI', 7, '1997-07-01 00:00:00', '1997-07-29 00:00:00', '1997-07-10 00:00:00', 1, 13.41, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10586, 'REGGC', 9, '1997-07-02 00:00:00', '1997-07-30 00:00:00', '1997-07-09 00:00:00', 1, 0.48, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10587, 'QUEDE', 1, '1997-07-02 00:00:00', '1997-07-30 00:00:00', '1997-07-09 00:00:00', 1, 62.52, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10588, 'QUICK', 2, '1997-07-03 00:00:00', '1997-07-31 00:00:00', '1997-07-10 00:00:00', 3, 194.67, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10589, 'GREAL', 8, '1997-07-04 00:00:00', '1997-08-01 00:00:00', '1997-07-14 00:00:00', 2, 4.42, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10590, 'MEREP', 4, '1997-07-07 00:00:00', '1997-08-04 00:00:00', '1997-07-14 00:00:00', 3, 44.77, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10591, 'VAFFE', 1, '1997-07-07 00:00:00', '1997-07-21 00:00:00', '1997-07-16 00:00:00', 1, 55.92, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10592, 'LEHMS', 3, '1997-07-08 00:00:00', '1997-08-05 00:00:00', '1997-07-16 00:00:00', 1, 32.1, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10593, 'LEHMS', 7, '1997-07-09 00:00:00', '1997-08-06 00:00:00', '1997-08-13 00:00:00', 2, 174.2, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10594, 'OLDWO', 3, '1997-07-09 00:00:00', '1997-08-06 00:00:00', '1997-07-16 00:00:00', 2, 5.24, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10595, 'ERNSH', 2, '1997-07-10 00:00:00', '1997-08-07 00:00:00', '1997-07-14 00:00:00', 1, 96.78, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10596, 'WHITC', 8, '1997-07-11 00:00:00', '1997-08-08 00:00:00', '1997-08-12 00:00:00', 1, 16.34, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10597, 'PICCO', 7, '1997-07-11 00:00:00', '1997-08-08 00:00:00', '1997-07-18 00:00:00', 3, 35.12, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10598, 'RATTC', 1, '1997-07-14 00:00:00', '1997-08-11 00:00:00', '1997-07-18 00:00:00', 3, 44.42, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10599, 'BSBEV', 6, '1997-07-15 00:00:00', '1997-08-26 00:00:00', '1997-07-21 00:00:00', 3, 29.98, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10600, 'HUNGC', 4, '1997-07-16 00:00:00', '1997-08-13 00:00:00', '1997-07-21 00:00:00', 1, 45.13, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(10601, 'HILAA', 7, '1997-07-16 00:00:00', '1997-08-27 00:00:00', '1997-07-22 00:00:00', 1, 58.3, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10602, 'VAFFE', 8, '1997-07-17 00:00:00', '1997-08-14 00:00:00', '1997-07-22 00:00:00', 2, 2.92, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10603, 'SAVEA', 8, '1997-07-18 00:00:00', '1997-08-15 00:00:00', '1997-08-08 00:00:00', 2, 48.77, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10604, 'FURIB', 1, '1997-07-18 00:00:00', '1997-08-15 00:00:00', '1997-07-29 00:00:00', 1, 7.46, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10605, 'MEREP', 1, '1997-07-21 00:00:00', '1997-08-18 00:00:00', '1997-07-29 00:00:00', 2, 379.13, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10606, 'TRADH', 4, '1997-07-22 00:00:00', '1997-08-19 00:00:00', '1997-07-31 00:00:00', 3, 79.4, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10607, 'SAVEA', 5, '1997-07-22 00:00:00', '1997-08-19 00:00:00', '1997-07-25 00:00:00', 1, 200.24, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10608, 'TOMSP', 4, '1997-07-23 00:00:00', '1997-08-20 00:00:00', '1997-08-01 00:00:00', 2, 27.79, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10609, 'DUMON', 7, '1997-07-24 00:00:00', '1997-08-21 00:00:00', '1997-07-30 00:00:00', 2, 1.85, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', '', '44000', 'France'),
(10610, 'LAMAI', 8, '1997-07-25 00:00:00', '1997-08-22 00:00:00', '1997-08-06 00:00:00', 1, 26.78, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10611, 'WOLZA', 6, '1997-07-25 00:00:00', '1997-08-22 00:00:00', '1997-08-01 00:00:00', 2, 80.65, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10612, 'SAVEA', 1, '1997-07-28 00:00:00', '1997-08-25 00:00:00', '1997-08-01 00:00:00', 2, 544.08, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10613, 'HILAA', 4, '1997-07-29 00:00:00', '1997-08-26 00:00:00', '1997-08-01 00:00:00', 2, 8.11, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10614, 'BLAUS', 8, '1997-07-29 00:00:00', '1997-08-26 00:00:00', '1997-08-01 00:00:00', 3, 1.93, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10615, 'WILMK', 2, '1997-07-30 00:00:00', '1997-08-27 00:00:00', '1997-08-06 00:00:00', 3, 0.75, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10616, 'GREAL', 1, '1997-07-31 00:00:00', '1997-08-28 00:00:00', '1997-08-05 00:00:00', 2, 116.53, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10617, 'GREAL', 4, '1997-07-31 00:00:00', '1997-08-28 00:00:00', '1997-08-04 00:00:00', 2, 18.53, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10618, 'MEREP', 1, '1997-08-01 00:00:00', '1997-09-12 00:00:00', '1997-08-08 00:00:00', 1, 154.68, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10619, 'MEREP', 3, '1997-08-04 00:00:00', '1997-09-01 00:00:00', '1997-08-07 00:00:00', 3, 91.05, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10620, 'LAUGB', 2, '1997-08-05 00:00:00', '1997-09-02 00:00:00', '1997-08-14 00:00:00', 3, 0.94, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
(10621, 'ISLAT', 4, '1997-08-05 00:00:00', '1997-09-02 00:00:00', '1997-08-11 00:00:00', 2, 23.73, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10622, 'RICAR', 4, '1997-08-06 00:00:00', '1997-09-03 00:00:00', '1997-08-11 00:00:00', 3, 50.97, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10623, 'FRANK', 8, '1997-08-07 00:00:00', '1997-09-04 00:00:00', '1997-08-12 00:00:00', 2, 97.18, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10624, 'THECR', 4, '1997-08-07 00:00:00', '1997-09-04 00:00:00', '1997-08-19 00:00:00', 2, 94.8, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
(10625, 'ANATR', 3, '1997-08-08 00:00:00', '1997-09-05 00:00:00', '1997-08-14 00:00:00', 1, 43.9, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constituci�n 2222', 'M�xico D.F.', '', '5021', 'Mexico'),
(10626, 'BERGS', 1, '1997-08-11 00:00:00', '1997-09-08 00:00:00', '1997-08-20 00:00:00', 2, 138.69, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10627, 'SAVEA', 8, '1997-08-11 00:00:00', '1997-09-22 00:00:00', '1997-08-21 00:00:00', 3, 107.46, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10628, 'BLONP', 4, '1997-08-12 00:00:00', '1997-09-09 00:00:00', '1997-08-20 00:00:00', 3, 30.36, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10629, 'GODOS', 4, '1997-08-12 00:00:00', '1997-09-09 00:00:00', '1997-08-20 00:00:00', 3, 85.46, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10630, 'KOENE', 1, '1997-08-13 00:00:00', '1997-09-10 00:00:00', '1997-08-19 00:00:00', 2, 32.35, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10631, 'LAMAI', 8, '1997-08-14 00:00:00', '1997-09-11 00:00:00', '1997-08-15 00:00:00', 1, 0.87, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10632, 'WANDK', 8, '1997-08-14 00:00:00', '1997-09-11 00:00:00', '1997-08-19 00:00:00', 1, 41.38, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10633, 'ERNSH', 7, '1997-08-15 00:00:00', '1997-09-12 00:00:00', '1997-08-18 00:00:00', 3, 477.9, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10634, 'FOLIG', 4, '1997-08-15 00:00:00', '1997-09-12 00:00:00', '1997-08-21 00:00:00', 3, 487.38, 'Folies gourmandes', '184, chauss�e de Tournai', 'Lille', '', '59000', 'France'),
(10635, 'MAGAA', 8, '1997-08-18 00:00:00', '1997-09-15 00:00:00', '1997-08-21 00:00:00', 3, 47.46, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10636, 'WARTH', 4, '1997-08-19 00:00:00', '1997-09-16 00:00:00', '1997-08-26 00:00:00', 1, 1.15, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10637, 'QUEEN', 6, '1997-08-19 00:00:00', '1997-09-16 00:00:00', '1997-08-26 00:00:00', 1, 201.29, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10638, 'LINOD', 3, '1997-08-20 00:00:00', '1997-09-17 00:00:00', '1997-09-01 00:00:00', 1, 158.44, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10639, 'SANTG', 7, '1997-08-20 00:00:00', '1997-09-17 00:00:00', '1997-08-27 00:00:00', 3, 38.64, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(10640, 'WANDK', 4, '1997-08-21 00:00:00', '1997-09-18 00:00:00', '1997-08-28 00:00:00', 1, 23.55, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10641, 'HILAA', 4, '1997-08-22 00:00:00', '1997-09-19 00:00:00', '1997-08-26 00:00:00', 2, 179.61, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10642, 'SIMOB', 7, '1997-08-22 00:00:00', '1997-09-19 00:00:00', '1997-09-05 00:00:00', 3, 41.89, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10643, 'ALFKI', 6, '1997-08-25 00:00:00', '1997-09-22 00:00:00', '1997-09-02 00:00:00', 1, 29.46, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(10644, 'WELLI', 3, '1997-08-25 00:00:00', '1997-09-22 00:00:00', '1997-09-01 00:00:00', 2, 0.14, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10645, 'HANAR', 4, '1997-08-26 00:00:00', '1997-09-23 00:00:00', '1997-09-02 00:00:00', 1, 12.41, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10646, 'HUNGO', 9, '1997-08-27 00:00:00', '1997-10-08 00:00:00', '1997-09-03 00:00:00', 3, 142.33, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10647, 'QUEDE', 4, '1997-08-27 00:00:00', '1997-09-10 00:00:00', '1997-09-03 00:00:00', 2, 45.54, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10648, 'RICAR', 5, '1997-08-28 00:00:00', '1997-10-09 00:00:00', '1997-09-09 00:00:00', 2, 14.25, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10649, 'MAISD', 5, '1997-08-28 00:00:00', '1997-09-25 00:00:00', '1997-08-29 00:00:00', 3, 6.2, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10650, 'FAMIA', 5, '1997-08-29 00:00:00', '1997-09-26 00:00:00', '1997-09-03 00:00:00', 3, 176.81, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10651, 'WANDK', 8, '1997-09-01 00:00:00', '1997-09-29 00:00:00', '1997-09-11 00:00:00', 2, 20.6, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10652, 'GOURL', 4, '1997-09-01 00:00:00', '1997-09-29 00:00:00', '1997-09-08 00:00:00', 2, 7.14, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10653, 'FRANK', 1, '1997-09-02 00:00:00', '1997-09-30 00:00:00', '1997-09-19 00:00:00', 1, 93.25, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10654, 'BERGS', 5, '1997-09-02 00:00:00', '1997-09-30 00:00:00', '1997-09-11 00:00:00', 1, 55.26, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10655, 'REGGC', 1, '1997-09-03 00:00:00', '1997-10-01 00:00:00', '1997-09-11 00:00:00', 2, 4.41, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10656, 'GREAL', 6, '1997-09-04 00:00:00', '1997-10-02 00:00:00', '1997-09-10 00:00:00', 1, 57.15, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10657, 'SAVEA', 2, '1997-09-04 00:00:00', '1997-10-02 00:00:00', '1997-09-15 00:00:00', 2, 352.69, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10658, 'QUICK', 4, '1997-09-05 00:00:00', '1997-10-03 00:00:00', '1997-09-08 00:00:00', 1, 364.15, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10659, 'QUEEN', 7, '1997-09-05 00:00:00', '1997-10-03 00:00:00', '1997-09-10 00:00:00', 2, 105.81, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10660, 'HUNGC', 8, '1997-09-08 00:00:00', '1997-10-06 00:00:00', '1997-10-15 00:00:00', 1, 111.29, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
(10661, 'HUNGO', 7, '1997-09-09 00:00:00', '1997-10-07 00:00:00', '1997-09-15 00:00:00', 3, 17.55, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10662, 'LONEP', 3, '1997-09-09 00:00:00', '1997-10-07 00:00:00', '1997-09-18 00:00:00', 2, 1.28, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10663, 'BONAP', 2, '1997-09-10 00:00:00', '1997-09-24 00:00:00', '1997-10-03 00:00:00', 2, 113.15, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10664, 'FURIB', 1, '1997-09-10 00:00:00', '1997-10-08 00:00:00', '1997-09-19 00:00:00', 3, 1.27, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10665, 'LONEP', 1, '1997-09-11 00:00:00', '1997-10-09 00:00:00', '1997-09-17 00:00:00', 2, 26.31, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10666, 'RICSU', 7, '1997-09-12 00:00:00', '1997-10-10 00:00:00', '1997-09-22 00:00:00', 2, 232.42, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10667, 'ERNSH', 7, '1997-09-12 00:00:00', '1997-10-10 00:00:00', '1997-09-19 00:00:00', 1, 78.09, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10668, 'WANDK', 1, '1997-09-15 00:00:00', '1997-10-13 00:00:00', '1997-09-23 00:00:00', 2, 47.22, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(10669, 'SIMOB', 2, '1997-09-15 00:00:00', '1997-10-13 00:00:00', '1997-09-22 00:00:00', 1, 24.39, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10670, 'FRANK', 4, '1997-09-16 00:00:00', '1997-10-14 00:00:00', '1997-09-18 00:00:00', 1, 203.48, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10671, 'FRANR', 1, '1997-09-17 00:00:00', '1997-10-15 00:00:00', '1997-09-24 00:00:00', 1, 30.34, 'France restauration', '54, rue Royale', 'Nantes', '', '44000', 'France'),
(10672, 'BERGS', 9, '1997-09-17 00:00:00', '1997-10-01 00:00:00', '1997-09-26 00:00:00', 2, 95.75, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10673, 'WILMK', 2, '1997-09-18 00:00:00', '1997-10-16 00:00:00', '1997-09-19 00:00:00', 1, 22.76, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10674, 'ISLAT', 4, '1997-09-18 00:00:00', '1997-10-16 00:00:00', '1997-09-30 00:00:00', 2, 0.9, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10675, 'FRANK', 5, '1997-09-19 00:00:00', '1997-10-17 00:00:00', '1997-09-23 00:00:00', 2, 31.85, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10676, 'TORTU', 2, '1997-09-22 00:00:00', '1997-10-20 00:00:00', '1997-09-29 00:00:00', 2, 2.01, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10677, 'ANTON', 1, '1997-09-22 00:00:00', '1997-10-20 00:00:00', '1997-09-26 00:00:00', 3, 4.03, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10678, 'SAVEA', 7, '1997-09-23 00:00:00', '1997-10-21 00:00:00', '1997-10-16 00:00:00', 3, 388.98, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10679, 'BLONP', 8, '1997-09-23 00:00:00', '1997-10-21 00:00:00', '1997-09-30 00:00:00', 3, 27.94, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10680, 'OLDWO', 1, '1997-09-24 00:00:00', '1997-10-22 00:00:00', '1997-09-26 00:00:00', 1, 26.61, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10681, 'GREAL', 3, '1997-09-25 00:00:00', '1997-10-23 00:00:00', '1997-09-30 00:00:00', 3, 76.13, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10682, 'ANTON', 3, '1997-09-25 00:00:00', '1997-10-23 00:00:00', '1997-10-01 00:00:00', 2, 36.13, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10683, 'DUMON', 2, '1997-09-26 00:00:00', '1997-10-24 00:00:00', '1997-10-01 00:00:00', 1, 4.4, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', '', '44000', 'France'),
(10684, 'OTTIK', 3, '1997-09-26 00:00:00', '1997-10-24 00:00:00', '1997-09-30 00:00:00', 1, 145.63, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10685, 'GOURL', 4, '1997-09-29 00:00:00', '1997-10-13 00:00:00', '1997-10-03 00:00:00', 2, 33.75, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10686, 'PICCO', 2, '1997-09-30 00:00:00', '1997-10-28 00:00:00', '1997-10-08 00:00:00', 1, 96.5, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10687, 'HUNGO', 9, '1997-09-30 00:00:00', '1997-10-28 00:00:00', '1997-10-30 00:00:00', 2, 296.43, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10688, 'VAFFE', 4, '1997-10-01 00:00:00', '1997-10-15 00:00:00', '1997-10-07 00:00:00', 2, 299.09, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10689, 'BERGS', 1, '1997-10-01 00:00:00', '1997-10-29 00:00:00', '1997-10-07 00:00:00', 2, 13.42, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10690, 'HANAR', 1, '1997-10-02 00:00:00', '1997-10-30 00:00:00', '1997-10-03 00:00:00', 1, 15.8, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10691, 'QUICK', 2, '1997-10-03 00:00:00', '1997-11-14 00:00:00', '1997-10-22 00:00:00', 2, 810.05, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10692, 'ALFKI', 4, '1997-10-03 00:00:00', '1997-10-31 00:00:00', '1997-10-13 00:00:00', 2, 61.02, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(10693, 'WHITC', 3, '1997-10-06 00:00:00', '1997-10-20 00:00:00', '1997-10-10 00:00:00', 3, 139.34, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10694, 'QUICK', 8, '1997-10-06 00:00:00', '1997-11-03 00:00:00', '1997-10-09 00:00:00', 3, 398.36, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10695, 'WILMK', 7, '1997-10-07 00:00:00', '1997-11-18 00:00:00', '1997-10-14 00:00:00', 1, 16.72, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10696, 'WHITC', 8, '1997-10-08 00:00:00', '1997-11-19 00:00:00', '1997-10-14 00:00:00', 3, 102.55, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10697, 'LINOD', 3, '1997-10-08 00:00:00', '1997-11-05 00:00:00', '1997-10-14 00:00:00', 1, 45.52, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10698, 'ERNSH', 4, '1997-10-09 00:00:00', '1997-11-06 00:00:00', '1997-10-17 00:00:00', 1, 272.47, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10699, 'MORGK', 3, '1997-10-09 00:00:00', '1997-11-06 00:00:00', '1997-10-13 00:00:00', 3, 0.58, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', '', '4179', 'Germany'),
(10700, 'SAVEA', 3, '1997-10-10 00:00:00', '1997-11-07 00:00:00', '1997-10-16 00:00:00', 1, 65.1, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10701, 'HUNGO', 6, '1997-10-13 00:00:00', '1997-10-27 00:00:00', '1997-10-15 00:00:00', 3, 220.31, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10702, 'ALFKI', 4, '1997-10-13 00:00:00', '1997-11-24 00:00:00', '1997-10-21 00:00:00', 1, 23.94, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(10703, 'FOLKO', 6, '1997-10-14 00:00:00', '1997-11-11 00:00:00', '1997-10-20 00:00:00', 2, 152.3, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10704, 'QUEEN', 6, '1997-10-14 00:00:00', '1997-11-11 00:00:00', '1997-11-07 00:00:00', 1, 4.78, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10705, 'HILAA', 9, '1997-10-15 00:00:00', '1997-11-12 00:00:00', '1997-11-18 00:00:00', 2, 3.52, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10706, 'OLDWO', 8, '1997-10-16 00:00:00', '1997-11-13 00:00:00', '1997-10-21 00:00:00', 3, 135.63, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10707, 'AROUT', 4, '1997-10-16 00:00:00', '1997-10-30 00:00:00', '1997-10-23 00:00:00', 3, 21.74, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10708, 'THEBI', 6, '1997-10-17 00:00:00', '1997-11-28 00:00:00', '1997-11-05 00:00:00', 2, 2.96, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
(10709, 'GOURL', 1, '1997-10-17 00:00:00', '1997-11-14 00:00:00', '1997-11-20 00:00:00', 3, 210.8, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10710, 'FRANS', 1, '1997-10-20 00:00:00', '1997-11-17 00:00:00', '1997-10-23 00:00:00', 1, 4.98, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(10711, 'SAVEA', 5, '1997-10-21 00:00:00', '1997-12-02 00:00:00', '1997-10-29 00:00:00', 2, 52.41, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10712, 'HUNGO', 3, '1997-10-21 00:00:00', '1997-11-18 00:00:00', '1997-10-31 00:00:00', 1, 89.93, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10713, 'SAVEA', 1, '1997-10-22 00:00:00', '1997-11-19 00:00:00', '1997-10-24 00:00:00', 1, 167.05, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10714, 'SAVEA', 5, '1997-10-22 00:00:00', '1997-11-19 00:00:00', '1997-10-27 00:00:00', 3, 24.49, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10715, 'BONAP', 3, '1997-10-23 00:00:00', '1997-11-06 00:00:00', '1997-10-29 00:00:00', 1, 63.2, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10716, 'RANCH', 4, '1997-10-24 00:00:00', '1997-11-21 00:00:00', '1997-10-27 00:00:00', 2, 22.57, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina'),
(10717, 'FRANK', 1, '1997-10-24 00:00:00', '1997-11-21 00:00:00', '1997-10-29 00:00:00', 2, 59.25, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10718, 'KOENE', 1, '1997-10-27 00:00:00', '1997-11-24 00:00:00', '1997-10-29 00:00:00', 3, 170.88, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10719, 'LETSS', 8, '1997-10-27 00:00:00', '1997-11-24 00:00:00', '1997-11-05 00:00:00', 2, 51.44, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
(10720, 'QUEDE', 8, '1997-10-28 00:00:00', '1997-11-11 00:00:00', '1997-11-05 00:00:00', 2, 9.53, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10721, 'QUICK', 5, '1997-10-29 00:00:00', '1997-11-26 00:00:00', '1997-10-31 00:00:00', 3, 48.92, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10722, 'SAVEA', 8, '1997-10-29 00:00:00', '1997-12-10 00:00:00', '1997-11-04 00:00:00', 1, 74.58, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10723, 'WHITC', 3, '1997-10-30 00:00:00', '1997-11-27 00:00:00', '1997-11-25 00:00:00', 1, 21.72, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10724, 'MEREP', 8, '1997-10-30 00:00:00', '1997-12-11 00:00:00', '1997-11-05 00:00:00', 2, 57.75, 'M�re Paillarde', '43 rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada'),
(10725, 'FAMIA', 4, '1997-10-31 00:00:00', '1997-11-28 00:00:00', '1997-11-05 00:00:00', 3, 10.83, 'Familia Arquibaldo', 'Rua Or�s, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
(10726, 'EASTC', 4, '1997-11-03 00:00:00', '1997-11-17 00:00:00', '1997-12-05 00:00:00', 1, 16.56, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(10727, 'REGGC', 2, '1997-11-03 00:00:00', '1997-12-01 00:00:00', '1997-12-05 00:00:00', 1, 89.9, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10728, 'QUEEN', 4, '1997-11-04 00:00:00', '1997-12-02 00:00:00', '1997-11-11 00:00:00', 2, 58.33, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10729, 'LINOD', 8, '1997-11-04 00:00:00', '1997-12-16 00:00:00', '1997-11-14 00:00:00', 3, 141.06, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10730, 'BONAP', 5, '1997-11-05 00:00:00', '1997-12-03 00:00:00', '1997-11-14 00:00:00', 1, 20.12, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10731, 'CHOPS', 7, '1997-11-06 00:00:00', '1997-12-04 00:00:00', '1997-11-14 00:00:00', 1, 96.65, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10732, 'BONAP', 3, '1997-11-06 00:00:00', '1997-12-04 00:00:00', '1997-11-07 00:00:00', 1, 16.97, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10733, 'BERGS', 1, '1997-11-07 00:00:00', '1997-12-05 00:00:00', '1997-11-10 00:00:00', 3, 110.11, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10734, 'GOURL', 2, '1997-11-07 00:00:00', '1997-12-05 00:00:00', '1997-11-12 00:00:00', 3, 1.63, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10735, 'LETSS', 6, '1997-11-10 00:00:00', '1997-12-08 00:00:00', '1997-11-21 00:00:00', 2, 45.97, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
(10736, 'HUNGO', 9, '1997-11-11 00:00:00', '1997-12-09 00:00:00', '1997-11-21 00:00:00', 2, 44.1, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10737, 'VINET', 2, '1997-11-11 00:00:00', '1997-12-09 00:00:00', '1997-11-18 00:00:00', 2, 7.79, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France'),
(10738, 'SPECD', 2, '1997-11-12 00:00:00', '1997-12-10 00:00:00', '1997-11-18 00:00:00', 1, 2.91, 'Sp�cialit�s du monde', '25, rue Lauriston', 'Paris', '', '75016', 'France'),
(10739, 'VINET', 3, '1997-11-12 00:00:00', '1997-12-10 00:00:00', '1997-11-17 00:00:00', 3, 11.08, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '', '51100', 'France'),
(10740, 'WHITC', 4, '1997-11-13 00:00:00', '1997-12-11 00:00:00', '1997-11-25 00:00:00', 2, 81.88, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10741, 'AROUT', 4, '1997-11-14 00:00:00', '1997-11-28 00:00:00', '1997-11-18 00:00:00', 3, 10.96, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10742, 'BOTTM', 3, '1997-11-14 00:00:00', '1997-12-12 00:00:00', '1997-11-18 00:00:00', 3, 243.73, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10743, 'AROUT', 1, '1997-11-17 00:00:00', '1997-12-15 00:00:00', '1997-11-21 00:00:00', 2, 23.72, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10744, 'VAFFE', 6, '1997-11-17 00:00:00', '1997-12-15 00:00:00', '1997-11-24 00:00:00', 1, 69.19, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10745, 'QUICK', 9, '1997-11-18 00:00:00', '1997-12-16 00:00:00', '1997-11-27 00:00:00', 1, 3.52, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10746, 'CHOPS', 1, '1997-11-19 00:00:00', '1997-12-17 00:00:00', '1997-11-21 00:00:00', 3, 31.43, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10747, 'PICCO', 6, '1997-11-19 00:00:00', '1997-12-17 00:00:00', '1997-11-26 00:00:00', 1, 117.33, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10748, 'SAVEA', 3, '1997-11-20 00:00:00', '1997-12-18 00:00:00', '1997-11-28 00:00:00', 1, 232.55, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10749, 'ISLAT', 4, '1997-11-20 00:00:00', '1997-12-18 00:00:00', '1997-12-19 00:00:00', 2, 61.53, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10750, 'WARTH', 9, '1997-11-21 00:00:00', '1997-12-19 00:00:00', '1997-11-24 00:00:00', 1, 79.3, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10751, 'RICSU', 3, '1997-11-24 00:00:00', '1997-12-22 00:00:00', '1997-12-03 00:00:00', 3, 130.79, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10752, 'NORTS', 2, '1997-11-24 00:00:00', '1997-12-22 00:00:00', '1997-11-28 00:00:00', 3, 1.39, 'North/South', 'South House 300 Queensbridge', 'London', '', 'SW7 1RZ', 'UK'),
(10753, 'FRANS', 3, '1997-11-25 00:00:00', '1997-12-23 00:00:00', '1997-11-27 00:00:00', 1, 7.7, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(10754, 'MAGAA', 6, '1997-11-25 00:00:00', '1997-12-23 00:00:00', '1997-11-27 00:00:00', 3, 2.38, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10755, 'BONAP', 4, '1997-11-26 00:00:00', '1997-12-24 00:00:00', '1997-11-28 00:00:00', 2, 16.71, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10756, 'SPLIR', 8, '1997-11-27 00:00:00', '1997-12-25 00:00:00', '1997-12-02 00:00:00', 2, 73.21, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10757, 'SAVEA', 6, '1997-11-27 00:00:00', '1997-12-25 00:00:00', '1997-12-15 00:00:00', 1, 8.19, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10758, 'RICSU', 3, '1997-11-28 00:00:00', '1997-12-26 00:00:00', '1997-12-04 00:00:00', 3, 138.17, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10759, 'ANATR', 3, '1997-11-28 00:00:00', '1997-12-26 00:00:00', '1997-12-12 00:00:00', 3, 11.99, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constituci�n 2222', 'M�xico D.F.', '', '5021', 'Mexico'),
(10760, 'MAISD', 4, '1997-12-01 00:00:00', '1997-12-29 00:00:00', '1997-12-10 00:00:00', 1, 155.64, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10761, 'RATTC', 5, '1997-12-02 00:00:00', '1997-12-30 00:00:00', '1997-12-08 00:00:00', 2, 18.66, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10762, 'FOLKO', 3, '1997-12-02 00:00:00', '1997-12-30 00:00:00', '1997-12-09 00:00:00', 1, 328.74, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10763, 'FOLIG', 3, '1997-12-03 00:00:00', '1997-12-31 00:00:00', '1997-12-08 00:00:00', 3, 37.35, 'Folies gourmandes', '184, chauss�e de Tournai', 'Lille', '', '59000', 'France'),
(10764, 'ERNSH', 6, '1997-12-03 00:00:00', '1997-12-31 00:00:00', '1997-12-08 00:00:00', 3, 145.45, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10765, 'QUICK', 3, '1997-12-04 00:00:00', '1998-01-01 00:00:00', '1997-12-09 00:00:00', 3, 42.74, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10766, 'OTTIK', 4, '1997-12-05 00:00:00', '1998-01-02 00:00:00', '1997-12-09 00:00:00', 1, 157.55, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10767, 'SUPRD', 4, '1997-12-05 00:00:00', '1998-01-02 00:00:00', '1997-12-15 00:00:00', 3, 1.59, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10768, 'AROUT', 3, '1997-12-08 00:00:00', '1998-01-05 00:00:00', '1997-12-15 00:00:00', 2, 146.32, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10769, 'VAFFE', 3, '1997-12-08 00:00:00', '1998-01-05 00:00:00', '1997-12-12 00:00:00', 1, 65.06, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10770, 'HANAR', 8, '1997-12-09 00:00:00', '1998-01-06 00:00:00', '1997-12-17 00:00:00', 3, 5.32, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10771, 'ERNSH', 9, '1997-12-10 00:00:00', '1998-01-07 00:00:00', '1998-01-02 00:00:00', 2, 11.19, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10772, 'LEHMS', 3, '1997-12-10 00:00:00', '1998-01-07 00:00:00', '1997-12-19 00:00:00', 2, 91.28, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10773, 'ERNSH', 1, '1997-12-11 00:00:00', '1998-01-08 00:00:00', '1997-12-16 00:00:00', 3, 96.43, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10774, 'FOLKO', 4, '1997-12-11 00:00:00', '1997-12-25 00:00:00', '1997-12-12 00:00:00', 1, 48.2, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10775, 'THECR', 7, '1997-12-12 00:00:00', '1998-01-09 00:00:00', '1997-12-26 00:00:00', 1, 20.25, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
(10776, 'ERNSH', 1, '1997-12-15 00:00:00', '1998-01-12 00:00:00', '1997-12-18 00:00:00', 3, 351.53, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10777, 'GOURL', 7, '1997-12-15 00:00:00', '1997-12-29 00:00:00', '1998-01-21 00:00:00', 2, 3.01, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10778, 'BERGS', 3, '1997-12-16 00:00:00', '1998-01-13 00:00:00', '1997-12-24 00:00:00', 1, 6.79, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10779, 'MORGK', 3, '1997-12-16 00:00:00', '1998-01-13 00:00:00', '1998-01-14 00:00:00', 2, 58.13, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', '', '4179', 'Germany'),
(10780, 'LILAS', 2, '1997-12-16 00:00:00', '1997-12-30 00:00:00', '1997-12-25 00:00:00', 1, 42.13, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10781, 'WARTH', 2, '1997-12-17 00:00:00', '1998-01-14 00:00:00', '1997-12-19 00:00:00', 3, 73.16, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(10782, 'CACTU', 9, '1997-12-17 00:00:00', '1998-01-14 00:00:00', '1997-12-22 00:00:00', 3, 1.1, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(10783, 'HANAR', 4, '1997-12-18 00:00:00', '1998-01-15 00:00:00', '1997-12-19 00:00:00', 2, 124.98, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10784, 'MAGAA', 4, '1997-12-18 00:00:00', '1998-01-15 00:00:00', '1997-12-22 00:00:00', 3, 70.09, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10785, 'GROSR', 1, '1997-12-18 00:00:00', '1998-01-15 00:00:00', '1997-12-24 00:00:00', 3, 1.51, 'GROSELLA-Restaurante', '5� Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela'),
(10786, 'QUEEN', 8, '1997-12-19 00:00:00', '1998-01-16 00:00:00', '1997-12-23 00:00:00', 1, 110.87, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10787, 'LAMAI', 2, '1997-12-19 00:00:00', '1998-01-02 00:00:00', '1997-12-26 00:00:00', 1, 249.93, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10788, 'QUICK', 1, '1997-12-22 00:00:00', '1998-01-19 00:00:00', '1998-01-19 00:00:00', 2, 42.7, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10789, 'FOLIG', 1, '1997-12-22 00:00:00', '1998-01-19 00:00:00', '1997-12-31 00:00:00', 2, 100.6, 'Folies gourmandes', '184, chauss�e de Tournai', 'Lille', '', '59000', 'France'),
(10790, 'GOURL', 6, '1997-12-22 00:00:00', '1998-01-19 00:00:00', '1997-12-26 00:00:00', 1, 28.23, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10791, 'FRANK', 6, '1997-12-23 00:00:00', '1998-01-20 00:00:00', '1998-01-01 00:00:00', 2, 16.85, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10792, 'WOLZA', 1, '1997-12-23 00:00:00', '1998-01-20 00:00:00', '1997-12-31 00:00:00', 3, 23.79, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10793, 'AROUT', 3, '1997-12-24 00:00:00', '1998-01-21 00:00:00', '1998-01-08 00:00:00', 3, 4.52, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10794, 'QUEDE', 6, '1997-12-24 00:00:00', '1998-01-21 00:00:00', '1998-01-02 00:00:00', 1, 21.49, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10795, 'ERNSH', 8, '1997-12-24 00:00:00', '1998-01-21 00:00:00', '1998-01-20 00:00:00', 2, 126.66, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10796, 'HILAA', 3, '1997-12-25 00:00:00', '1998-01-22 00:00:00', '1998-01-14 00:00:00', 1, 26.52, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10797, 'DRACD', 7, '1997-12-25 00:00:00', '1998-01-22 00:00:00', '1998-01-05 00:00:00', 2, 33.35, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(10798, 'ISLAT', 2, '1997-12-26 00:00:00', '1998-01-23 00:00:00', '1998-01-05 00:00:00', 1, 2.33, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10799, 'KOENE', 9, '1997-12-26 00:00:00', '1998-02-06 00:00:00', '1998-01-05 00:00:00', 3, 30.76, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10800, 'SEVES', 1, '1997-12-26 00:00:00', '1998-01-23 00:00:00', '1998-01-05 00:00:00', 3, 137.44, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10801, 'BOLID', 4, '1997-12-29 00:00:00', '1998-01-26 00:00:00', '1997-12-31 00:00:00', 2, 97.09, 'B�lido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', '', '28023', 'Spain'),
(10802, 'SIMOB', 4, '1997-12-29 00:00:00', '1998-01-26 00:00:00', '1998-01-02 00:00:00', 2, 257.26, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(10803, 'WELLI', 4, '1997-12-30 00:00:00', '1998-01-27 00:00:00', '1998-01-06 00:00:00', 1, 55.23, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO `orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES
(10804, 'SEVES', 6, '1997-12-30 00:00:00', '1998-01-27 00:00:00', '1998-01-07 00:00:00', 2, 27.33, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10805, 'THEBI', 2, '1997-12-30 00:00:00', '1998-01-27 00:00:00', '1998-01-09 00:00:00', 3, 237.34, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
(10806, 'VICTE', 3, '1997-12-31 00:00:00', '1998-01-28 00:00:00', '1998-01-05 00:00:00', 2, 22.11, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10807, 'FRANS', 4, '1997-12-31 00:00:00', '1998-01-28 00:00:00', '1998-01-30 00:00:00', 1, 1.36, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(10808, 'OLDWO', 2, '1998-01-01 00:00:00', '1998-01-29 00:00:00', '1998-01-09 00:00:00', 3, 45.53, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10809, 'WELLI', 7, '1998-01-01 00:00:00', '1998-01-29 00:00:00', '1998-01-07 00:00:00', 1, 4.87, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10810, 'LAUGB', 2, '1998-01-01 00:00:00', '1998-01-29 00:00:00', '1998-01-07 00:00:00', 3, 4.33, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
(10811, 'LINOD', 8, '1998-01-02 00:00:00', '1998-01-30 00:00:00', '1998-01-08 00:00:00', 1, 31.22, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10812, 'REGGC', 5, '1998-01-02 00:00:00', '1998-01-30 00:00:00', '1998-01-12 00:00:00', 1, 59.78, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10813, 'RICAR', 1, '1998-01-05 00:00:00', '1998-02-02 00:00:00', '1998-01-09 00:00:00', 1, 47.38, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10814, 'VICTE', 3, '1998-01-05 00:00:00', '1998-02-02 00:00:00', '1998-01-14 00:00:00', 3, 130.94, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10815, 'SAVEA', 2, '1998-01-05 00:00:00', '1998-02-02 00:00:00', '1998-01-14 00:00:00', 3, 14.62, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10816, 'GREAL', 4, '1998-01-06 00:00:00', '1998-02-03 00:00:00', '1998-02-04 00:00:00', 2, 719.78, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10817, 'KOENE', 3, '1998-01-06 00:00:00', '1998-01-20 00:00:00', '1998-01-13 00:00:00', 2, 306.07, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10818, 'MAGAA', 7, '1998-01-07 00:00:00', '1998-02-04 00:00:00', '1998-01-12 00:00:00', 3, 65.48, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10819, 'CACTU', 2, '1998-01-07 00:00:00', '1998-02-04 00:00:00', '1998-01-16 00:00:00', 3, 19.76, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(10820, 'RATTC', 3, '1998-01-07 00:00:00', '1998-02-04 00:00:00', '1998-01-13 00:00:00', 2, 37.52, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10821, 'SPLIR', 1, '1998-01-08 00:00:00', '1998-02-05 00:00:00', '1998-01-15 00:00:00', 1, 36.68, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10822, 'TRAIH', 6, '1998-01-08 00:00:00', '1998-02-05 00:00:00', '1998-01-16 00:00:00', 3, 7, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
(10823, 'LILAS', 5, '1998-01-09 00:00:00', '1998-02-06 00:00:00', '1998-01-13 00:00:00', 2, 163.97, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10824, 'FOLKO', 8, '1998-01-09 00:00:00', '1998-02-06 00:00:00', '1998-01-30 00:00:00', 1, 1.23, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10825, 'DRACD', 1, '1998-01-09 00:00:00', '1998-02-06 00:00:00', '1998-01-14 00:00:00', 1, 79.25, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(10826, 'BLONP', 6, '1998-01-12 00:00:00', '1998-02-09 00:00:00', '1998-02-06 00:00:00', 1, 7.09, 'Blondel p�re et fils', '24, place Kl�ber', 'Strasbourg', '', '67000', 'France'),
(10827, 'BONAP', 1, '1998-01-12 00:00:00', '1998-01-26 00:00:00', '1998-02-06 00:00:00', 2, 63.54, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10828, 'RANCH', 9, '1998-01-13 00:00:00', '1998-01-27 00:00:00', '1998-02-04 00:00:00', 1, 90.85, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina'),
(10829, 'ISLAT', 9, '1998-01-13 00:00:00', '1998-02-10 00:00:00', '1998-01-23 00:00:00', 1, 154.72, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10830, 'TRADH', 4, '1998-01-13 00:00:00', '1998-02-24 00:00:00', '1998-01-21 00:00:00', 2, 81.83, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10831, 'SANTG', 3, '1998-01-14 00:00:00', '1998-02-11 00:00:00', '1998-01-23 00:00:00', 2, 72.19, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(10832, 'LAMAI', 2, '1998-01-14 00:00:00', '1998-02-11 00:00:00', '1998-01-19 00:00:00', 2, 43.26, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10833, 'OTTIK', 6, '1998-01-15 00:00:00', '1998-02-12 00:00:00', '1998-01-23 00:00:00', 2, 71.49, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(10834, 'TRADH', 1, '1998-01-15 00:00:00', '1998-02-12 00:00:00', '1998-01-19 00:00:00', 3, 29.78, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10835, 'ALFKI', 1, '1998-01-15 00:00:00', '1998-02-12 00:00:00', '1998-01-21 00:00:00', 3, 69.53, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(10836, 'ERNSH', 7, '1998-01-16 00:00:00', '1998-02-13 00:00:00', '1998-01-21 00:00:00', 1, 411.88, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10837, 'BERGS', 9, '1998-01-16 00:00:00', '1998-02-13 00:00:00', '1998-01-23 00:00:00', 3, 13.32, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10838, 'LINOD', 3, '1998-01-19 00:00:00', '1998-02-16 00:00:00', '1998-01-23 00:00:00', 3, 59.28, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10839, 'TRADH', 3, '1998-01-19 00:00:00', '1998-02-16 00:00:00', '1998-01-22 00:00:00', 3, 35.43, 'Tradi�ao Hipermercados', 'Av. In�s de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
(10840, 'LINOD', 4, '1998-01-19 00:00:00', '1998-03-02 00:00:00', '1998-02-16 00:00:00', 2, 2.71, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10841, 'SUPRD', 5, '1998-01-20 00:00:00', '1998-02-17 00:00:00', '1998-01-29 00:00:00', 2, 424.3, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10842, 'TORTU', 1, '1998-01-20 00:00:00', '1998-02-17 00:00:00', '1998-01-29 00:00:00', 3, 54.42, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10843, 'VICTE', 4, '1998-01-21 00:00:00', '1998-02-18 00:00:00', '1998-01-26 00:00:00', 2, 9.26, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10844, 'PICCO', 8, '1998-01-21 00:00:00', '1998-02-18 00:00:00', '1998-01-26 00:00:00', 2, 25.22, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(10845, 'QUICK', 8, '1998-01-21 00:00:00', '1998-02-04 00:00:00', '1998-01-30 00:00:00', 1, 212.98, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10846, 'SUPRD', 2, '1998-01-22 00:00:00', '1998-03-05 00:00:00', '1998-01-23 00:00:00', 3, 56.46, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10847, 'SAVEA', 4, '1998-01-22 00:00:00', '1998-02-05 00:00:00', '1998-02-10 00:00:00', 3, 487.57, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10848, 'CONSH', 7, '1998-01-23 00:00:00', '1998-02-20 00:00:00', '1998-01-29 00:00:00', 2, 38.24, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', '', 'WX1 6LT', 'UK'),
(10849, 'KOENE', 9, '1998-01-23 00:00:00', '1998-02-20 00:00:00', '1998-01-30 00:00:00', 2, 0.56, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10850, 'VICTE', 1, '1998-01-23 00:00:00', '1998-03-06 00:00:00', '1998-01-30 00:00:00', 1, 49.19, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', '', '69004', 'France'),
(10851, 'RICAR', 5, '1998-01-26 00:00:00', '1998-02-23 00:00:00', '1998-02-02 00:00:00', 1, 160.55, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10852, 'RATTC', 8, '1998-01-26 00:00:00', '1998-02-09 00:00:00', '1998-01-30 00:00:00', 1, 174.05, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10853, 'BLAUS', 9, '1998-01-27 00:00:00', '1998-02-24 00:00:00', '1998-02-03 00:00:00', 2, 53.83, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10854, 'ERNSH', 3, '1998-01-27 00:00:00', '1998-02-24 00:00:00', '1998-02-05 00:00:00', 2, 100.22, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10855, 'OLDWO', 3, '1998-01-27 00:00:00', '1998-02-24 00:00:00', '1998-02-04 00:00:00', 1, 170.97, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10856, 'ANTON', 3, '1998-01-28 00:00:00', '1998-02-25 00:00:00', '1998-02-10 00:00:00', 2, 58.43, 'Antonio Moreno Taquer�a', 'Mataderos  2312', 'M�xico D.F.', '', '5023', 'Mexico'),
(10857, 'BERGS', 8, '1998-01-28 00:00:00', '1998-02-25 00:00:00', '1998-02-06 00:00:00', 2, 188.85, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10858, 'LACOR', 2, '1998-01-29 00:00:00', '1998-02-26 00:00:00', '1998-02-03 00:00:00', 1, 52.51, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', '', '78000', 'France'),
(10859, 'FRANK', 1, '1998-01-29 00:00:00', '1998-02-26 00:00:00', '1998-02-02 00:00:00', 2, 76.1, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10860, 'FRANR', 3, '1998-01-29 00:00:00', '1998-02-26 00:00:00', '1998-02-04 00:00:00', 3, 19.26, 'France restauration', '54, rue Royale', 'Nantes', '', '44000', 'France'),
(10861, 'WHITC', 4, '1998-01-30 00:00:00', '1998-02-27 00:00:00', '1998-02-17 00:00:00', 2, 14.93, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10862, 'LEHMS', 8, '1998-01-30 00:00:00', '1998-03-13 00:00:00', '1998-02-02 00:00:00', 2, 53.23, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10863, 'HILAA', 4, '1998-02-02 00:00:00', '1998-03-02 00:00:00', '1998-02-17 00:00:00', 2, 30.26, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10864, 'AROUT', 4, '1998-02-02 00:00:00', '1998-03-02 00:00:00', '1998-02-09 00:00:00', 2, 3.04, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10865, 'QUICK', 2, '1998-02-02 00:00:00', '1998-02-16 00:00:00', '1998-02-12 00:00:00', 1, 348.14, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10866, 'BERGS', 5, '1998-02-03 00:00:00', '1998-03-03 00:00:00', '1998-02-12 00:00:00', 1, 109.11, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10867, 'LONEP', 6, '1998-02-03 00:00:00', '1998-03-17 00:00:00', '1998-02-11 00:00:00', 1, 1.93, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10868, 'QUEEN', 7, '1998-02-04 00:00:00', '1998-03-04 00:00:00', '1998-02-23 00:00:00', 2, 191.27, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10869, 'SEVES', 5, '1998-02-04 00:00:00', '1998-03-04 00:00:00', '1998-02-09 00:00:00', 1, 143.28, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', '', 'OX15 4NB', 'UK'),
(10870, 'WOLZA', 5, '1998-02-04 00:00:00', '1998-03-04 00:00:00', '1998-02-13 00:00:00', 3, 12.04, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10871, 'BONAP', 9, '1998-02-05 00:00:00', '1998-03-05 00:00:00', '1998-02-10 00:00:00', 2, 112.27, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10872, 'GODOS', 5, '1998-02-05 00:00:00', '1998-03-05 00:00:00', '1998-02-09 00:00:00', 2, 175.32, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10873, 'WILMK', 4, '1998-02-06 00:00:00', '1998-03-06 00:00:00', '1998-02-09 00:00:00', 1, 0.82, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10874, 'GODOS', 5, '1998-02-06 00:00:00', '1998-03-06 00:00:00', '1998-02-11 00:00:00', 2, 19.58, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10875, 'BERGS', 4, '1998-02-06 00:00:00', '1998-03-06 00:00:00', '1998-03-03 00:00:00', 2, 32.37, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10876, 'BONAP', 7, '1998-02-09 00:00:00', '1998-03-09 00:00:00', '1998-02-12 00:00:00', 3, 60.42, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10877, 'RICAR', 1, '1998-02-09 00:00:00', '1998-03-09 00:00:00', '1998-02-19 00:00:00', 1, 38.06, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(10878, 'QUICK', 4, '1998-02-10 00:00:00', '1998-03-10 00:00:00', '1998-02-12 00:00:00', 1, 46.69, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10879, 'WILMK', 3, '1998-02-10 00:00:00', '1998-03-10 00:00:00', '1998-02-12 00:00:00', 3, 8.5, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10880, 'FOLKO', 7, '1998-02-10 00:00:00', '1998-03-24 00:00:00', '1998-02-18 00:00:00', 1, 88.01, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10881, 'CACTU', 4, '1998-02-11 00:00:00', '1998-03-11 00:00:00', '1998-02-18 00:00:00', 1, 2.84, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(10882, 'SAVEA', 4, '1998-02-11 00:00:00', '1998-03-11 00:00:00', '1998-02-20 00:00:00', 3, 23.1, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10883, 'LONEP', 8, '1998-02-12 00:00:00', '1998-03-12 00:00:00', '1998-02-20 00:00:00', 3, 0.53, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(10884, 'LETSS', 4, '1998-02-12 00:00:00', '1998-03-12 00:00:00', '1998-02-13 00:00:00', 2, 90.97, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
(10885, 'SUPRD', 6, '1998-02-12 00:00:00', '1998-03-12 00:00:00', '1998-02-18 00:00:00', 3, 5.64, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10886, 'HANAR', 1, '1998-02-13 00:00:00', '1998-03-13 00:00:00', '1998-03-02 00:00:00', 1, 4.99, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10887, 'GALED', 8, '1998-02-13 00:00:00', '1998-03-13 00:00:00', '1998-02-16 00:00:00', 3, 1.25, 'Galer�a del gastron�mo', 'Rambla de Catalu�a, 23', 'Barcelona', '', '8022', 'Spain'),
(10888, 'GODOS', 1, '1998-02-16 00:00:00', '1998-03-16 00:00:00', '1998-02-23 00:00:00', 2, 51.87, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10889, 'RATTC', 9, '1998-02-16 00:00:00', '1998-03-16 00:00:00', '1998-02-23 00:00:00', 3, 280.61, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10890, 'DUMON', 7, '1998-02-16 00:00:00', '1998-03-16 00:00:00', '1998-02-18 00:00:00', 1, 32.76, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', '', '44000', 'France'),
(10891, 'LEHMS', 7, '1998-02-17 00:00:00', '1998-03-17 00:00:00', '1998-02-19 00:00:00', 2, 20.37, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10892, 'MAISD', 4, '1998-02-17 00:00:00', '1998-03-17 00:00:00', '1998-02-19 00:00:00', 2, 120.27, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10893, 'KOENE', 9, '1998-02-18 00:00:00', '1998-03-18 00:00:00', '1998-02-20 00:00:00', 2, 77.78, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(10894, 'SAVEA', 1, '1998-02-18 00:00:00', '1998-03-18 00:00:00', '1998-02-20 00:00:00', 1, 116.13, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10895, 'ERNSH', 3, '1998-02-18 00:00:00', '1998-03-18 00:00:00', '1998-02-23 00:00:00', 1, 162.75, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10896, 'MAISD', 7, '1998-02-19 00:00:00', '1998-03-19 00:00:00', '1998-02-27 00:00:00', 3, 32.45, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10897, 'HUNGO', 3, '1998-02-19 00:00:00', '1998-03-19 00:00:00', '1998-02-25 00:00:00', 2, 603.54, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10898, 'OCEAN', 4, '1998-02-20 00:00:00', '1998-03-20 00:00:00', '1998-03-06 00:00:00', 2, 1.27, 'Oc�ano Atl�ntico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina'),
(10899, 'LILAS', 5, '1998-02-20 00:00:00', '1998-03-20 00:00:00', '1998-02-26 00:00:00', 3, 1.21, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10900, 'WELLI', 1, '1998-02-20 00:00:00', '1998-03-20 00:00:00', '1998-03-04 00:00:00', 2, 1.66, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10901, 'HILAA', 4, '1998-02-23 00:00:00', '1998-03-23 00:00:00', '1998-02-26 00:00:00', 1, 62.09, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10902, 'FOLKO', 1, '1998-02-23 00:00:00', '1998-03-23 00:00:00', '1998-03-03 00:00:00', 1, 44.15, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10903, 'HANAR', 3, '1998-02-24 00:00:00', '1998-03-24 00:00:00', '1998-03-04 00:00:00', 3, 36.71, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10904, 'WHITC', 3, '1998-02-24 00:00:00', '1998-03-24 00:00:00', '1998-02-27 00:00:00', 3, 162.95, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(10905, 'WELLI', 9, '1998-02-24 00:00:00', '1998-03-24 00:00:00', '1998-03-06 00:00:00', 2, 13.72, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10906, 'WOLZA', 4, '1998-02-25 00:00:00', '1998-03-11 00:00:00', '1998-03-03 00:00:00', 3, 26.29, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10907, 'SPECD', 6, '1998-02-25 00:00:00', '1998-03-25 00:00:00', '1998-02-27 00:00:00', 3, 9.19, 'Sp�cialit�s du monde', '25, rue Lauriston', 'Paris', '', '75016', 'France'),
(10908, 'REGGC', 4, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-06 00:00:00', 2, 32.96, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10909, 'SANTG', 1, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-10 00:00:00', 2, 53.05, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(10910, 'WILMK', 1, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-04 00:00:00', 3, 38.11, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(10911, 'GODOS', 3, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-05 00:00:00', 1, 38.19, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10912, 'HUNGO', 2, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-18 00:00:00', 2, 580.91, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10913, 'QUEEN', 4, '1998-02-26 00:00:00', '1998-03-26 00:00:00', '1998-03-04 00:00:00', 1, 33.05, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10914, 'QUEEN', 6, '1998-02-27 00:00:00', '1998-03-27 00:00:00', '1998-03-02 00:00:00', 1, 21.19, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10915, 'TORTU', 2, '1998-02-27 00:00:00', '1998-03-27 00:00:00', '1998-03-02 00:00:00', 2, 3.51, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(10916, 'RANCH', 1, '1998-02-27 00:00:00', '1998-03-27 00:00:00', '1998-03-09 00:00:00', 2, 63.77, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina'),
(10917, 'ROMEY', 4, '1998-03-02 00:00:00', '1998-03-30 00:00:00', '1998-03-11 00:00:00', 2, 8.29, 'Romero y tomillo', 'Gran V�a, 1', 'Madrid', '', '28001', 'Spain'),
(10918, 'BOTTM', 3, '1998-03-02 00:00:00', '1998-03-30 00:00:00', '1998-03-11 00:00:00', 3, 48.83, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10919, 'LINOD', 2, '1998-03-02 00:00:00', '1998-03-30 00:00:00', '1998-03-04 00:00:00', 2, 19.8, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10920, 'AROUT', 4, '1998-03-03 00:00:00', '1998-03-31 00:00:00', '1998-03-09 00:00:00', 2, 29.61, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10921, 'VAFFE', 1, '1998-03-03 00:00:00', '1998-04-14 00:00:00', '1998-03-09 00:00:00', 1, 176.48, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10922, 'HANAR', 5, '1998-03-03 00:00:00', '1998-03-31 00:00:00', '1998-03-05 00:00:00', 3, 62.74, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10923, 'LAMAI', 7, '1998-03-03 00:00:00', '1998-04-14 00:00:00', '1998-03-13 00:00:00', 3, 68.26, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(10924, 'BERGS', 3, '1998-03-04 00:00:00', '1998-04-01 00:00:00', '1998-04-08 00:00:00', 2, 151.52, 'Berglunds snabbk�p', 'Berguvsv�gen  8', 'Lule�', '', 'S-958 22', 'Sweden'),
(10925, 'HANAR', 3, '1998-03-04 00:00:00', '1998-04-01 00:00:00', '1998-03-13 00:00:00', 1, 2.27, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10926, 'ANATR', 4, '1998-03-04 00:00:00', '1998-04-01 00:00:00', '1998-03-11 00:00:00', 3, 39.92, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constituci�n 2222', 'M�xico D.F.', '', '5021', 'Mexico'),
(10927, 'LACOR', 4, '1998-03-05 00:00:00', '1998-04-02 00:00:00', '1998-04-08 00:00:00', 1, 19.79, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', '', '78000', 'France'),
(10928, 'GALED', 1, '1998-03-05 00:00:00', '1998-04-02 00:00:00', '1998-03-18 00:00:00', 1, 1.36, 'Galer�a del gastron�mo', 'Rambla de Catalu�a, 23', 'Barcelona', '', '8022', 'Spain'),
(10929, 'FRANK', 6, '1998-03-05 00:00:00', '1998-04-02 00:00:00', '1998-03-12 00:00:00', 1, 33.93, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(10930, 'SUPRD', 4, '1998-03-06 00:00:00', '1998-04-17 00:00:00', '1998-03-18 00:00:00', 3, 15.55, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(10931, 'RICSU', 4, '1998-03-06 00:00:00', '1998-03-20 00:00:00', '1998-03-19 00:00:00', 2, 13.6, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10932, 'BONAP', 8, '1998-03-06 00:00:00', '1998-04-03 00:00:00', '1998-03-24 00:00:00', 1, 134.64, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10933, 'ISLAT', 6, '1998-03-06 00:00:00', '1998-04-03 00:00:00', '1998-03-16 00:00:00', 3, 54.15, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
(10934, 'LEHMS', 3, '1998-03-09 00:00:00', '1998-04-06 00:00:00', '1998-03-12 00:00:00', 3, 32.01, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(10935, 'WELLI', 4, '1998-03-09 00:00:00', '1998-04-06 00:00:00', '1998-03-18 00:00:00', 3, 47.59, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
(10936, 'GREAL', 3, '1998-03-09 00:00:00', '1998-04-06 00:00:00', '1998-03-18 00:00:00', 2, 33.68, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(10937, 'CACTU', 7, '1998-03-10 00:00:00', '1998-03-24 00:00:00', '1998-03-13 00:00:00', 3, 31.51, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(10938, 'QUICK', 3, '1998-03-10 00:00:00', '1998-04-07 00:00:00', '1998-03-16 00:00:00', 2, 31.89, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10939, 'MAGAA', 2, '1998-03-10 00:00:00', '1998-04-07 00:00:00', '1998-03-13 00:00:00', 2, 76.33, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10940, 'BONAP', 8, '1998-03-11 00:00:00', '1998-04-08 00:00:00', '1998-03-23 00:00:00', 3, 19.77, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(10941, 'SAVEA', 7, '1998-03-11 00:00:00', '1998-04-08 00:00:00', '1998-03-20 00:00:00', 2, 400.81, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10942, 'REGGC', 9, '1998-03-11 00:00:00', '1998-04-08 00:00:00', '1998-03-18 00:00:00', 3, 17.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(10943, 'BSBEV', 4, '1998-03-11 00:00:00', '1998-04-08 00:00:00', '1998-03-19 00:00:00', 2, 2.17, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10944, 'BOTTM', 6, '1998-03-12 00:00:00', '1998-03-26 00:00:00', '1998-03-13 00:00:00', 3, 52.92, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10945, 'MORGK', 4, '1998-03-12 00:00:00', '1998-04-09 00:00:00', '1998-03-18 00:00:00', 1, 10.22, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', '', '4179', 'Germany'),
(10946, 'VAFFE', 1, '1998-03-12 00:00:00', '1998-04-09 00:00:00', '1998-03-19 00:00:00', 2, 27.2, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10947, 'BSBEV', 3, '1998-03-13 00:00:00', '1998-04-10 00:00:00', '1998-03-16 00:00:00', 2, 3.26, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(10948, 'GODOS', 3, '1998-03-13 00:00:00', '1998-04-10 00:00:00', '1998-03-19 00:00:00', 3, 23.39, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(10949, 'BOTTM', 2, '1998-03-13 00:00:00', '1998-04-10 00:00:00', '1998-03-17 00:00:00', 3, 74.44, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10950, 'MAGAA', 1, '1998-03-16 00:00:00', '1998-04-13 00:00:00', '1998-03-23 00:00:00', 2, 2.5, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', '', '24100', 'Italy'),
(10951, 'RICSU', 9, '1998-03-16 00:00:00', '1998-04-27 00:00:00', '1998-04-07 00:00:00', 2, 30.85, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(10952, 'ALFKI', 1, '1998-03-16 00:00:00', '1998-04-27 00:00:00', '1998-03-24 00:00:00', 1, 40.42, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(10953, 'AROUT', 9, '1998-03-16 00:00:00', '1998-03-30 00:00:00', '1998-03-25 00:00:00', 2, 23.72, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(10954, 'LINOD', 5, '1998-03-17 00:00:00', '1998-04-28 00:00:00', '1998-03-20 00:00:00', 1, 27.91, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(10955, 'FOLKO', 8, '1998-03-17 00:00:00', '1998-04-14 00:00:00', '1998-03-20 00:00:00', 2, 3.26, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10956, 'BLAUS', 6, '1998-03-17 00:00:00', '1998-04-28 00:00:00', '1998-03-20 00:00:00', 2, 44.65, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(10957, 'HILAA', 8, '1998-03-18 00:00:00', '1998-04-15 00:00:00', '1998-03-27 00:00:00', 3, 105.36, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10958, 'OCEAN', 7, '1998-03-18 00:00:00', '1998-04-15 00:00:00', '1998-03-27 00:00:00', 2, 49.56, 'Oc�ano Atl�ntico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina'),
(10959, 'GOURL', 6, '1998-03-18 00:00:00', '1998-04-29 00:00:00', '1998-03-23 00:00:00', 2, 4.98, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(10960, 'HILAA', 3, '1998-03-19 00:00:00', '1998-04-02 00:00:00', '1998-04-08 00:00:00', 1, 2.08, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10961, 'QUEEN', 8, '1998-03-19 00:00:00', '1998-04-16 00:00:00', '1998-03-30 00:00:00', 1, 104.47, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(10962, 'QUICK', 8, '1998-03-19 00:00:00', '1998-04-16 00:00:00', '1998-03-23 00:00:00', 2, 275.79, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10963, 'FURIB', 9, '1998-03-19 00:00:00', '1998-04-16 00:00:00', '1998-03-26 00:00:00', 3, 2.7, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', '', '1675', 'Portugal'),
(10964, 'SPECD', 3, '1998-03-20 00:00:00', '1998-04-17 00:00:00', '1998-03-24 00:00:00', 2, 87.38, 'Sp�cialit�s du monde', '25, rue Lauriston', 'Paris', '', '75016', 'France'),
(10965, 'OLDWO', 6, '1998-03-20 00:00:00', '1998-04-17 00:00:00', '1998-03-30 00:00:00', 3, 144.38, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(10966, 'CHOPS', 4, '1998-03-20 00:00:00', '1998-04-17 00:00:00', '1998-04-08 00:00:00', 1, 27.19, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(10967, 'TOMSP', 2, '1998-03-23 00:00:00', '1998-04-20 00:00:00', '1998-04-02 00:00:00', 2, 62.22, 'Toms Spezialit�ten', 'Luisenstr. 48', 'M�nster', '', '44087', 'Germany'),
(10968, 'ERNSH', 1, '1998-03-23 00:00:00', '1998-04-20 00:00:00', '1998-04-01 00:00:00', 3, 74.6, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10969, 'COMMI', 1, '1998-03-23 00:00:00', '1998-04-20 00:00:00', '1998-03-30 00:00:00', 2, 0.21, 'Com�rcio Mineiro', 'Av. dos Lus�adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
(10970, 'BOLID', 9, '1998-03-24 00:00:00', '1998-04-07 00:00:00', '1998-04-24 00:00:00', 1, 16.16, 'B�lido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', '', '28023', 'Spain'),
(10971, 'FRANR', 2, '1998-03-24 00:00:00', '1998-04-21 00:00:00', '1998-04-02 00:00:00', 2, 121.82, 'France restauration', '54, rue Royale', 'Nantes', '', '44000', 'France'),
(10972, 'LACOR', 4, '1998-03-24 00:00:00', '1998-04-21 00:00:00', '1998-03-26 00:00:00', 2, 0.02, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', '', '78000', 'France'),
(10973, 'LACOR', 6, '1998-03-24 00:00:00', '1998-04-21 00:00:00', '1998-03-27 00:00:00', 2, 15.17, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', '', '78000', 'France'),
(10974, 'SPLIR', 3, '1998-03-25 00:00:00', '1998-04-08 00:00:00', '1998-04-03 00:00:00', 3, 12.96, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
(10975, 'BOTTM', 1, '1998-03-25 00:00:00', '1998-04-22 00:00:00', '1998-03-27 00:00:00', 3, 32.27, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10976, 'HILAA', 1, '1998-03-25 00:00:00', '1998-05-06 00:00:00', '1998-04-03 00:00:00', 1, 37.97, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(10977, 'FOLKO', 8, '1998-03-26 00:00:00', '1998-04-23 00:00:00', '1998-04-10 00:00:00', 3, 208.5, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10978, 'MAISD', 9, '1998-03-26 00:00:00', '1998-04-23 00:00:00', '1998-04-23 00:00:00', 2, 32.82, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(10979, 'ERNSH', 8, '1998-03-26 00:00:00', '1998-04-23 00:00:00', '1998-03-31 00:00:00', 2, 353.07, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10980, 'FOLKO', 4, '1998-03-27 00:00:00', '1998-05-08 00:00:00', '1998-04-17 00:00:00', 1, 1.26, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10981, 'HANAR', 1, '1998-03-27 00:00:00', '1998-04-24 00:00:00', '1998-04-02 00:00:00', 2, 193.37, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(10982, 'BOTTM', 2, '1998-03-27 00:00:00', '1998-04-24 00:00:00', '1998-04-08 00:00:00', 1, 14.01, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(10983, 'SAVEA', 2, '1998-03-27 00:00:00', '1998-04-24 00:00:00', '1998-04-06 00:00:00', 2, 657.54, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10984, 'SAVEA', 1, '1998-03-30 00:00:00', '1998-04-27 00:00:00', '1998-04-03 00:00:00', 3, 211.22, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(10985, 'HUNGO', 2, '1998-03-30 00:00:00', '1998-04-27 00:00:00', '1998-04-02 00:00:00', 1, 91.51, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(10986, 'OCEAN', 8, '1998-03-30 00:00:00', '1998-04-27 00:00:00', '1998-04-21 00:00:00', 2, 217.86, 'Oc�ano Atl�ntico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '', '1010', 'Argentina'),
(10987, 'EASTC', 8, '1998-03-31 00:00:00', '1998-04-28 00:00:00', '1998-04-06 00:00:00', 1, 185.48, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(10988, 'RATTC', 3, '1998-03-31 00:00:00', '1998-04-28 00:00:00', '1998-04-10 00:00:00', 2, 61.14, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(10989, 'QUEDE', 2, '1998-03-31 00:00:00', '1998-04-28 00:00:00', '1998-04-02 00:00:00', 1, 34.76, 'Que Del�cia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
(10990, 'ERNSH', 2, '1998-04-01 00:00:00', '1998-05-13 00:00:00', '1998-04-07 00:00:00', 3, 117.61, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(10991, 'QUICK', 1, '1998-04-01 00:00:00', '1998-04-29 00:00:00', '1998-04-07 00:00:00', 1, 38.51, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10992, 'THEBI', 1, '1998-04-01 00:00:00', '1998-04-29 00:00:00', '1998-04-03 00:00:00', 3, 4.27, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
(10993, 'FOLKO', 7, '1998-04-01 00:00:00', '1998-04-29 00:00:00', '1998-04-10 00:00:00', 3, 8.81, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(10994, 'VAFFE', 2, '1998-04-02 00:00:00', '1998-04-16 00:00:00', '1998-04-09 00:00:00', 3, 65.53, 'Vaffeljernet', 'Smagsloget 45', '�rhus', '', '8200', 'Denmark'),
(10995, 'PERIC', 1, '1998-04-02 00:00:00', '1998-04-30 00:00:00', '1998-04-06 00:00:00', 3, 46, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(10996, 'QUICK', 4, '1998-04-02 00:00:00', '1998-04-30 00:00:00', '1998-04-10 00:00:00', 2, 1.12, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(10997, 'LILAS', 8, '1998-04-03 00:00:00', '1998-05-15 00:00:00', '1998-04-13 00:00:00', 2, 73.91, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(10998, 'WOLZA', 8, '1998-04-03 00:00:00', '1998-04-17 00:00:00', '1998-04-17 00:00:00', 2, 20.31, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(10999, 'OTTIK', 6, '1998-04-03 00:00:00', '1998-05-01 00:00:00', '1998-04-10 00:00:00', 2, 96.35, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(11000, 'RATTC', 2, '1998-04-06 00:00:00', '1998-05-04 00:00:00', '1998-04-14 00:00:00', 3, 55.12, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(11001, 'FOLKO', 2, '1998-04-06 00:00:00', '1998-05-04 00:00:00', '1998-04-14 00:00:00', 2, 197.3, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(11002, 'SAVEA', 4, '1998-04-06 00:00:00', '1998-05-04 00:00:00', '1998-04-16 00:00:00', 1, 141.16, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(11003, 'THECR', 3, '1998-04-06 00:00:00', '1998-05-04 00:00:00', '1998-04-08 00:00:00', 3, 14.91, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
(11004, 'MAISD', 3, '1998-04-07 00:00:00', '1998-05-05 00:00:00', '1998-04-20 00:00:00', 1, 44.84, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', '', 'B-1180', 'Belgium'),
(11005, 'WILMK', 2, '1998-04-07 00:00:00', '1998-05-05 00:00:00', '1998-04-10 00:00:00', 1, 0.75, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', '', '21240', 'Finland'),
(11006, 'GREAL', 3, '1998-04-07 00:00:00', '1998-05-05 00:00:00', '1998-04-15 00:00:00', 2, 25.19, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(11007, 'PRINI', 8, '1998-04-08 00:00:00', '1998-05-06 00:00:00', '1998-04-13 00:00:00', 2, 202.24, 'Princesa Isabel Vinhos', 'Estrada da sa�de n. 58', 'Lisboa', '', '1756', 'Portugal'),
(11008, 'ERNSH', 7, '1998-04-08 00:00:00', '1998-05-06 00:00:00', '0000-00-00 00:00:00', 3, 79.46, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(11009, 'GODOS', 2, '1998-04-08 00:00:00', '1998-05-06 00:00:00', '1998-04-10 00:00:00', 1, 59.11, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(11010, 'REGGC', 2, '1998-04-09 00:00:00', '1998-05-07 00:00:00', '1998-04-21 00:00:00', 2, 28.71, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(11011, 'ALFKI', 3, '1998-04-09 00:00:00', '1998-05-07 00:00:00', '1998-04-13 00:00:00', 1, 1.21, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', '', '12209', 'Germany'),
(11012, 'FRANK', 1, '1998-04-09 00:00:00', '1998-04-23 00:00:00', '1998-04-17 00:00:00', 3, 242.95, 'Frankenversand', 'Berliner Platz 43', 'M�nchen', '', '80805', 'Germany'),
(11013, 'ROMEY', 2, '1998-04-09 00:00:00', '1998-05-07 00:00:00', '1998-04-10 00:00:00', 1, 32.99, 'Romero y tomillo', 'Gran V�a, 1', 'Madrid', '', '28001', 'Spain'),
(11014, 'LINOD', 2, '1998-04-10 00:00:00', '1998-05-08 00:00:00', '1998-04-15 00:00:00', 3, 23.6, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(11015, 'SANTG', 2, '1998-04-10 00:00:00', '1998-04-24 00:00:00', '1998-04-20 00:00:00', 2, 4.62, 'Sant� Gourmet', 'Erling Skakkes gate 78', 'Stavern', '', '4110', 'Norway'),
(11016, 'AROUT', 9, '1998-04-10 00:00:00', '1998-05-08 00:00:00', '1998-04-13 00:00:00', 2, 33.8, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
(11017, 'ERNSH', 9, '1998-04-13 00:00:00', '1998-05-11 00:00:00', '1998-04-20 00:00:00', 2, 754.26, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(11018, 'LONEP', 4, '1998-04-13 00:00:00', '1998-05-11 00:00:00', '1998-04-16 00:00:00', 2, 11.65, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
(11019, 'RANCH', 6, '1998-04-13 00:00:00', '1998-05-11 00:00:00', '0000-00-00 00:00:00', 3, 3.17, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', '', '1010', 'Argentina'),
(11020, 'OTTIK', 2, '1998-04-14 00:00:00', '1998-05-12 00:00:00', '1998-04-16 00:00:00', 2, 43.3, 'Ottilies K�seladen', 'Mehrheimerstr. 369', 'K�ln', '', '50739', 'Germany'),
(11021, 'QUICK', 3, '1998-04-14 00:00:00', '1998-05-12 00:00:00', '1998-04-21 00:00:00', 1, 297.18, 'QUICK-Stop', 'Taucherstra�e 10', 'Cunewalde', '', '1307', 'Germany'),
(11022, 'HANAR', 9, '1998-04-14 00:00:00', '1998-05-12 00:00:00', '1998-05-04 00:00:00', 2, 6.27, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(11023, 'BSBEV', 1, '1998-04-14 00:00:00', '1998-04-28 00:00:00', '1998-04-24 00:00:00', 2, 123.83, 'B''s Beverages', 'Fauntleroy Circus', 'London', '', 'EC2 5NT', 'UK'),
(11024, 'EASTC', 4, '1998-04-15 00:00:00', '1998-05-13 00:00:00', '1998-04-20 00:00:00', 1, 74.36, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(11025, 'WARTH', 6, '1998-04-15 00:00:00', '1998-05-13 00:00:00', '1998-04-24 00:00:00', 3, 29.17, 'Wartian Herkku', 'Torikatu 38', 'Oulu', '', '90110', 'Finland'),
(11026, 'FRANS', 4, '1998-04-15 00:00:00', '1998-05-13 00:00:00', '1998-04-28 00:00:00', 1, 47.09, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(11027, 'BOTTM', 1, '1998-04-16 00:00:00', '1998-05-14 00:00:00', '1998-04-20 00:00:00', 1, 52.52, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(11028, 'KOENE', 2, '1998-04-16 00:00:00', '1998-05-14 00:00:00', '1998-04-22 00:00:00', 1, 29.59, 'K�niglich Essen', 'Maubelstr. 90', 'Brandenburg', '', '14776', 'Germany'),
(11029, 'CHOPS', 4, '1998-04-16 00:00:00', '1998-05-14 00:00:00', '1998-04-27 00:00:00', 1, 47.84, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(11030, 'SAVEA', 7, '1998-04-17 00:00:00', '1998-05-15 00:00:00', '1998-04-27 00:00:00', 2, 830.75, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(11031, 'SAVEA', 6, '1998-04-17 00:00:00', '1998-05-15 00:00:00', '1998-04-24 00:00:00', 2, 227.22, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(11032, 'WHITC', 2, '1998-04-17 00:00:00', '1998-05-15 00:00:00', '1998-04-23 00:00:00', 3, 606.19, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(11033, 'RICSU', 7, '1998-04-17 00:00:00', '1998-05-15 00:00:00', '1998-04-23 00:00:00', 3, 84.74, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(11034, 'OLDWO', 8, '1998-04-20 00:00:00', '1998-06-01 00:00:00', '1998-04-27 00:00:00', 1, 40.32, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
(11035, 'SUPRD', 2, '1998-04-20 00:00:00', '1998-05-18 00:00:00', '1998-04-24 00:00:00', 2, 0.17, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(11036, 'DRACD', 8, '1998-04-20 00:00:00', '1998-05-18 00:00:00', '1998-04-22 00:00:00', 3, 149.47, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(11037, 'GODOS', 7, '1998-04-21 00:00:00', '1998-05-19 00:00:00', '1998-04-27 00:00:00', 1, 3.2, 'Godos Cocina T�pica', 'C/ Romero, 33', 'Sevilla', '', '41101', 'Spain'),
(11038, 'SUPRD', 1, '1998-04-21 00:00:00', '1998-05-19 00:00:00', '1998-04-30 00:00:00', 2, 29.59, 'Supr�mes d�lices', 'Boulevard Tirou, 255', 'Charleroi', '', 'B-6000', 'Belgium'),
(11039, 'LINOD', 1, '1998-04-21 00:00:00', '1998-05-19 00:00:00', '0000-00-00 00:00:00', 2, 65, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
(11040, 'GREAL', 4, '1998-04-22 00:00:00', '1998-05-20 00:00:00', '0000-00-00 00:00:00', 3, 18.84, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(11041, 'CHOPS', 3, '1998-04-22 00:00:00', '1998-05-20 00:00:00', '1998-04-28 00:00:00', 2, 48.22, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', '', '3012', 'Switzerland'),
(11042, 'COMMI', 2, '1998-04-22 00:00:00', '1998-05-06 00:00:00', '1998-05-01 00:00:00', 1, 29.99, 'Com�rcio Mineiro', 'Av. dos Lus�adas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
(11043, 'SPECD', 5, '1998-04-22 00:00:00', '1998-05-20 00:00:00', '1998-04-29 00:00:00', 2, 8.8, 'Sp�cialit�s du monde', '25, rue Lauriston', 'Paris', '', '75016', 'France'),
(11044, 'WOLZA', 4, '1998-04-23 00:00:00', '1998-05-21 00:00:00', '1998-05-01 00:00:00', 1, 8.72, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', '', '01-012', 'Poland'),
(11045, 'BOTTM', 6, '1998-04-23 00:00:00', '1998-05-21 00:00:00', '0000-00-00 00:00:00', 2, 70.58, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(11046, 'WANDK', 8, '1998-04-23 00:00:00', '1998-05-21 00:00:00', '1998-04-24 00:00:00', 2, 71.64, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', '', '70563', 'Germany'),
(11047, 'EASTC', 7, '1998-04-24 00:00:00', '1998-05-22 00:00:00', '1998-05-01 00:00:00', 3, 46.62, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(11048, 'BOTTM', 7, '1998-04-24 00:00:00', '1998-05-22 00:00:00', '1998-04-30 00:00:00', 3, 24.12, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
(11049, 'GOURL', 3, '1998-04-24 00:00:00', '1998-05-22 00:00:00', '1998-05-04 00:00:00', 1, 8.34, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
(11050, 'FOLKO', 8, '1998-04-27 00:00:00', '1998-05-25 00:00:00', '1998-05-05 00:00:00', 2, 59.41, 'Folk och f� HB', '�kergatan 24', 'Br�cke', '', 'S-844 67', 'Sweden'),
(11051, 'LAMAI', 7, '1998-04-27 00:00:00', '1998-05-25 00:00:00', '0000-00-00 00:00:00', 3, 2.79, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', '', '31000', 'France'),
(11052, 'HANAR', 3, '1998-04-27 00:00:00', '1998-05-25 00:00:00', '1998-05-01 00:00:00', 1, 67.26, 'Hanari Carnes', 'Rua do Pa�o, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
(11053, 'PICCO', 2, '1998-04-27 00:00:00', '1998-05-25 00:00:00', '1998-04-29 00:00:00', 2, 53.05, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', '', '5020', 'Austria'),
(11054, 'CACTU', 8, '1998-04-28 00:00:00', '1998-05-26 00:00:00', '0000-00-00 00:00:00', 1, 0.33, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', '', '1010', 'Argentina'),
(11055, 'HILAA', 7, '1998-04-28 00:00:00', '1998-05-26 00:00:00', '1998-05-05 00:00:00', 2, 120.92, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Crist�bal', 'T�chira', '5022', 'Venezuela'),
(11056, 'EASTC', 8, '1998-04-28 00:00:00', '1998-05-12 00:00:00', '1998-05-01 00:00:00', 2, 278.96, 'Eastern Connection', '35 King George', 'London', '', 'WX3 6FW', 'UK'),
(11057, 'NORTS', 3, '1998-04-29 00:00:00', '1998-05-27 00:00:00', '1998-05-01 00:00:00', 3, 4.13, 'North/South', 'South House 300 Queensbridge', 'London', '', 'SW7 1RZ', 'UK'),
(11058, 'BLAUS', 9, '1998-04-29 00:00:00', '1998-05-27 00:00:00', '0000-00-00 00:00:00', 3, 31.14, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', '', '68306', 'Germany'),
(11059, 'RICAR', 2, '1998-04-29 00:00:00', '1998-06-10 00:00:00', '0000-00-00 00:00:00', 2, 85.8, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
(11060, 'FRANS', 2, '1998-04-30 00:00:00', '1998-05-28 00:00:00', '1998-05-04 00:00:00', 2, 10.98, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', '', '10100', 'Italy'),
(11061, 'GREAL', 4, '1998-04-30 00:00:00', '1998-06-11 00:00:00', '0000-00-00 00:00:00', 3, 14.01, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
(11062, 'REGGC', 4, '1998-04-30 00:00:00', '1998-05-28 00:00:00', '0000-00-00 00:00:00', 2, 29.93, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', '', '42100', 'Italy'),
(11063, 'HUNGO', 3, '1998-04-30 00:00:00', '1998-05-28 00:00:00', '1998-05-06 00:00:00', 2, 81.73, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', '', 'Ireland'),
(11064, 'SAVEA', 1, '1998-05-01 00:00:00', '1998-05-29 00:00:00', '1998-05-04 00:00:00', 1, 30.09, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
(11065, 'LILAS', 8, '1998-05-01 00:00:00', '1998-05-29 00:00:00', '0000-00-00 00:00:00', 1, 12.91, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(11066, 'WHITC', 7, '1998-05-01 00:00:00', '1998-05-29 00:00:00', '1998-05-04 00:00:00', 2, 44.72, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
(11067, 'DRACD', 1, '1998-05-04 00:00:00', '1998-05-18 00:00:00', '1998-05-06 00:00:00', 2, 7.98, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', '', '52066', 'Germany'),
(11068, 'QUEEN', 8, '1998-05-04 00:00:00', '1998-06-01 00:00:00', '0000-00-00 00:00:00', 2, 81.75, 'Queen Cozinha', 'Alameda dos Can�rios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
(11069, 'TORTU', 1, '1998-05-04 00:00:00', '1998-06-01 00:00:00', '1998-05-06 00:00:00', 2, 15.67, 'Tortuga Restaurante', 'Avda. Azteca 123', 'M�xico D.F.', '', '5033', 'Mexico'),
(11070, 'LEHMS', 2, '1998-05-05 00:00:00', '1998-06-02 00:00:00', '0000-00-00 00:00:00', 1, 136, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', '', '60528', 'Germany'),
(11071, 'LILAS', 1, '1998-05-05 00:00:00', '1998-06-02 00:00:00', '0000-00-00 00:00:00', 1, 0.93, 'LILA-Supermercado', 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
(11072, 'ERNSH', 4, '1998-05-05 00:00:00', '1998-06-02 00:00:00', '0000-00-00 00:00:00', 2, 258.64, 'Ernst Handel', 'Kirchgasse 6', 'Graz', '', '8010', 'Austria'),
(11073, 'PERIC', 2, '1998-05-05 00:00:00', '1998-06-02 00:00:00', '0000-00-00 00:00:00', 2, 24.95, 'Pericles Comidas cl�sicas', 'Calle Dr. Jorge Cash 321', 'M�xico D.F.', '', '5033', 'Mexico'),
(11074, 'SIMOB', 7, '1998-05-06 00:00:00', '1998-06-03 00:00:00', '0000-00-00 00:00:00', 2, 18.44, 'Simons bistro', 'Vinb�ltet 34', 'Kobenhavn', '', '1734', 'Denmark'),
(11075, 'RICSU', 8, '1998-05-06 00:00:00', '1998-06-03 00:00:00', '0000-00-00 00:00:00', 2, 6.19, 'Richter Supermarkt', 'Starenweg 5', 'Gen�ve', '', '1204', 'Switzerland'),
(11076, 'BONAP', 4, '1998-05-06 00:00:00', '1998-06-03 00:00:00', '0000-00-00 00:00:00', 2, 38.28, 'Bon app''', '12, rue des Bouchers', 'Marseille', '', '13008', 'France'),
(11077, 'RATTC', 1, '1998-05-06 00:00:00', '1998-06-03 00:00:00', '0000-00-00 00:00:00', 2, 8.53, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
(11078, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11079, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11080, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11081, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico');
INSERT INTO `orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES
(11082, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11083, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11084, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11085, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11086, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11087, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11088, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11089, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11090, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11091, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11092, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11093, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11094, 'BOTTM', 2, '2017-07-04 00:00:00', '2007-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11095, 'BOTTM', 2, '2017-07-04 00:00:00', '0202-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11096, 'BOTTM', 2, '2017-07-04 00:00:00', '0201-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11097, 'BOTTM', 2, '2017-07-04 00:00:00', '0201-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11098, 'BOTTM', 2, '2017-07-04 00:00:00', '0202-08-01 00:00:00', '1996-07-16 00:00:00', 3, 32.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11099, 'BOTTM', 2, '2017-07-04 00:00:00', '2020-08-01 00:00:00', '1996-07-16 00:00:00', 3, 1.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11100, 'BOTTM', 2, '2017-07-04 00:00:00', '2020-08-01 00:00:00', '1996-07-16 00:00:00', 3, 2.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11101, 'BOTTM', 2, '2017-07-04 00:00:00', '2020-08-01 00:00:00', '1996-07-16 00:00:00', 3, 3.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11102, 'BOTTM', 2, '2017-07-04 00:00:00', '2020-08-01 00:00:00', '1996-07-16 00:00:00', 3, 4.38, 'pros', 'reforma 14', 'valpa', 'RJ', '99200', 'mexico'),
(11103, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11104, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11105, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11106, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11107, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11108, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11111, 'wwwe', 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11112, 'wwwe', 2, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(11113, 'wwwe', 2, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(40) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `QuantityPerUnit` varchar(20) DEFAULT NULL,
  `UnitPrice` double DEFAULT '0',
  `UnitsInStock` smallint(6) DEFAULT '0',
  `UnitsOnOrder` smallint(6) DEFAULT '0',
  `ReorderLevel` smallint(6) DEFAULT '0',
  `Discontinued` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`ProductID`, `ProductName`, `SupplierID`, `CategoryID`, `QuantityPerUnit`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`, `ReorderLevel`, `Discontinued`) VALUES
(1, 'Chai', 1, 1, '10 boxes x 20 bags', 18, 34, 0, 10, 0),
(2, 'Chango', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25, 0),
(3, 'goku', 1, 6, 'sdfsdf', 10, 13, 70, 25, 0),
(4, 'kjhdfjkesrkljghi', 2, 2, '48 - 6 oz jars', 22, 53, 0, 0, 0),
(5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35, 0, 0, 0, 0),
(6, 'Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25, 120, 0, 25, 0),
(7, 'Uncle Bob''s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30, 15, 0, 10, 0),
(8, 'Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40, 6, 0, 0, 0),
(9, 'Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97, 29, 0, 0, 0),
(10, 'Ikura', 4, 8, '12 - 200 ml jars', 31, 31, 0, 0, 0),
(11, 'Queso Cabrales', 5, 4, '1 kg pkg.', 21, 22, 30, 30, 0),
(12, 'Queso Manchego La Pastora', 5, 4, '10 - 500 g pkgs.', 38, 86, 0, 0, 0),
(13, 'Konbu', 6, 8, '2 kg box', 6, 24, 0, 5, 0),
(14, 'Tofu', 6, 7, '40 - 100 g pkgs.', 23.25, 35, 0, 0, 0),
(15, 'Genen Shouyu', 6, 2, '24 - 250 ml bottles', 15.5, 39, 0, 5, 0),
(16, 'Pavlova', 7, 3, '32 - 500 g boxes', 17.45, 29, 0, 10, 0),
(17, 'Alice Mutton', 7, 6, '20 - 1 kg tins', 39, 0, 0, 0, 0),
(18, 'Carnarvon Tigers', 7, 8, '16 kg pkg.', 62.5, 42, 0, 0, 0),
(19, 'Teatime Chocolate Biscuits', 8, 3, '10 boxes x 12 pieces', 9.2, 25, 0, 5, 0),
(20, 'Sir Rodney''s Marmalade', 8, 3, '30 gift boxes', 81, 40, 0, 0, 0),
(21, 'Sir Rodney''s Scones', 8, 3, '24 pkgs. x 4 pieces', 10, 3, 40, 5, 0),
(22, 'Gustaf''s Kn�ckebr�d', 9, 5, '24 - 500 g pkgs.', 21, 104, 0, 25, 0),
(23, 'Tunnbr�d', 9, 5, '12 - 250 g pkgs.', 9, 61, 0, 25, 0),
(24, 'Guaran� Fant�stica', 10, 1, '12 - 355 ml cans', 4.5, 20, 0, 0, 0),
(25, 'NuNuCa Nu�-Nougat-Creme', 11, 3, '20 - 450 g glasses', 14, 76, 0, 30, 0),
(26, 'Gumb�r Gummib�rchen', 11, 3, '100 - 250 g bags', 31.23, 15, 0, 0, 0),
(27, 'Schoggi Schokolade', 11, 3, '100 - 100 g pieces', 43.9, 49, 0, 30, 0),
(28, 'R�ssle Sauerkraut', 12, 7, '25 - 825 g cans', 45.6, 26, 0, 0, 0),
(29, 'Th�ringer Rostbratwurst', 12, 6, '50 bags x 30 sausgs.', 123.79, 0, 0, 0, 0),
(30, 'Nord-Ost Matjeshering', 13, 8, '10 - 200 g glasses', 25.89, 10, 0, 15, 0),
(31, 'Gorgonzola Telino', 14, 4, '12 - 100 g pkgs', 12.5, 0, 70, 20, 0),
(32, 'Mascarpone Fabioli', 14, 4, '24 - 200 g pkgs.', 32, 9, 40, 25, 0),
(33, 'Geitost', 15, 4, '500 g', 2.5, 112, 0, 20, 0),
(34, 'Sasquatch Ale', 16, 1, '24 - 12 oz bottles', 14, 111, 0, 15, 0),
(35, 'Steeleye Stout', 16, 1, '24 - 12 oz bottles', 18, 20, 0, 15, 0),
(36, 'Inlagd Sill', 17, 8, '24 - 250 g  jars', 19, 112, 0, 20, 0),
(37, 'Gravad lax', 17, 8, '12 - 500 g pkgs.', 26, 11, 50, 25, 0),
(38, 'C�te de Blaye', 18, 1, '12 - 75 cl bottles', 263.5, 17, 0, 15, 0),
(39, 'Chartreuse verte', 18, 1, '750 cc per bottle', 18, 69, 0, 5, 0),
(40, 'Boston Crab Meat', 19, 8, '24 - 4 oz tins', 18.4, 123, 0, 30, 0),
(41, 'Jack''s New England Clam Chowder', 19, 8, '12 - 12 oz cans', 9.65, 85, 0, 10, 0),
(42, 'Singaporean Hokkien Fried Mee', 20, 5, '32 - 1 kg pkgs.', 14, 26, 0, 0, 0),
(43, 'Ipoh Coffee', 20, 1, '16 - 500 g tins', 46, 17, 10, 25, 0),
(44, 'Gula Malacca', 20, 2, '20 - 2 kg bags', 19.45, 27, 0, 15, 0),
(45, 'Rogede sild', 21, 8, '1k pkg.', 9.5, 5, 70, 15, 0),
(46, 'Spegesild', 21, 8, '4 - 450 g glasses', 12, 95, 0, 0, 0),
(47, 'Zaanse koeken', 22, 3, '10 - 4 oz boxes', 9.5, 36, 0, 0, 0),
(48, 'Chocolade', 22, 3, '10 pkgs.', 12.75, 15, 70, 25, 0),
(49, 'Maxilaku', 23, 3, '24 - 50 g pkgs.', 20, 10, 60, 15, 0),
(50, 'Valkoinen suklaa', 23, 3, '12 - 100 g bars', 16.25, 65, 0, 30, 0),
(51, 'Manjimup Dried Apples', 24, 7, '50 - 300 g pkgs.', 53, 20, 0, 10, 0),
(52, 'Filo Mix', 24, 5, '16 - 2 kg boxes', 7, 38, 0, 25, 0),
(53, 'Perth Pasties', 24, 6, '48 pieces', 32.8, 0, 0, 0, 0),
(54, 'Tourti�re', 25, 6, '16 pies', 7.45, 21, 0, 10, 0),
(55, 'P�t� chinois', 25, 6, '24 boxes x 2 pies', 24, 115, 0, 20, 0),
(56, 'Gnocchi di nonna Alice', 26, 5, '24 - 250 g pkgs.', 38, 21, 10, 30, 0),
(57, 'Ravioli Angelo', 26, 5, '24 - 250 g pkgs.', 19.5, 36, 0, 20, 0),
(58, 'Escargots de Bourgogne', 27, 8, '24 pieces', 13.25, 62, 0, 20, 0),
(59, 'Raclette Courdavault', 28, 4, '5 kg pkg.', 55, 79, 0, 0, 0),
(60, 'Camembert Pierrot', 28, 4, '15 - 300 g rounds', 34, 19, 0, 0, 0),
(61, 'Sirop d''�rable', 29, 2, '24 - 500 ml bottles', 28.5, 113, 0, 25, 0),
(62, 'Tarte au sucre', 29, 3, '48 pies', 49.3, 17, 0, 0, 0),
(63, 'Vegie-spread', 7, 2, '15 - 625 g jars', 43.9, 24, 0, 5, 0),
(64, 'Wimmers gute Semmelkn�del', 12, 5, '20 bags x 4 pieces', 33.25, 22, 80, 30, 0),
(65, 'Louisiana Fiery Hot Pepper Sauce', 2, 2, '32 - 8 oz bottles', 21.05, 76, 0, 0, 0),
(66, 'Louisiana Hot Spiced Okra', 2, 2, '24 - 8 oz jars', 17, 4, 100, 20, 0),
(67, 'Laughing Lumberjack Lager', 16, 1, '24 - 12 oz bottles', 14, 52, 0, 10, 0),
(68, 'Scottish Longbreads', 8, 3, '10 boxes x 8 pieces', 12.5, 6, 10, 15, 0),
(69, 'Gudbrandsdalsost', 15, 4, '10 kg pkg.', 36, 26, 0, 15, 0),
(70, 'Outback Lager', 7, 1, '24 - 355 ml bottles', 15, 15, 10, 30, 0),
(71, 'Flotemysost', 15, 4, '10 - 500 g pkgs.', 21.5, 26, 0, 0, 0),
(72, 'Mozzarella di Giovanni', 14, 4, '24 - 200 g pkgs.', 34.8, 14, 0, 0, 0),
(73, 'R�d Kaviar', 17, 8, '24 - 150 g jars', 15, 101, 0, 5, 0),
(74, 'Longlife Tofu', 4, 7, '5 kg pkg.', 10, 4, 20, 5, 0),
(75, 'Rh�nbr�u Klosterbier', 12, 1, '24 - 0.5 l bottles', 7.75, 125, 0, 25, 0),
(76, 'Lakkalik��ri', 23, 1, '500 ml', 18, 55, 0, 20, 0),
(77, 'Original Frankfurter gr�ne So�e', 12, 2, '12 boxes', 13, 28, 0, 15, 0),
(78, 'nada', 4, 3, NULL, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

CREATE TABLE `region` (
  `RegionID` int(11) NOT NULL,
  `RegionDescription` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`RegionID`, `RegionDescription`) VALUES
(1, 'Eastern'),
(2, 'Western'),
(3, 'Northern'),
(4, 'Southern');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `shippers`
--

CREATE TABLE `shippers` (
  `ShipperID` int(11) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `Phone` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `shippers`
--

INSERT INTO `shippers` (`ShipperID`, `CompanyName`, `Phone`) VALUES
(1, 'Speedy Express', '(503) 555-9831'),
(2, 'United Package', '(503) 555-3199'),
(3, 'Federal Shipping', '(503) 555-9931');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) DEFAULT NULL,
  `ContactTitle` varchar(30) DEFAULT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(15) DEFAULT NULL,
  `Region` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL,
  `Country` varchar(15) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  `Fax` varchar(24) DEFAULT NULL,
  `HomePage` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`, `HomePage`) VALUES
(1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', '', 'EC1 4SD', 'UK', '(171) 555-2222', '', ''),
(2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', '', '#CAJUN.HTM#'),
(3, 'Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', ''),
(4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', '', '100', 'Japan', '(03) 3555-5011', '', ''),
(5, 'Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', '', ''),
(6, 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', '', '545', 'Japan', '(06) 431-7877', '', 'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'),
(7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', ''),
(8, 'Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', '', 'M14 GSD', 'UK', '(161) 555-4448', '', ''),
(9, 'PB Kn�ckebr�d AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'G�teborg', '', 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', ''),
(10, 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', '', '5442', 'Brazil', '(11) 555 4640', '', ''),
(11, 'Heli S��waren GmbH & Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstra�e 5', 'Berlin', '', '10785', 'Germany', '(010) 9984510', '', ''),
(12, 'Plutzer Lebensmittelgro�m�rkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', '', '60439', 'Germany', '(069) 992755', '', 'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'),
(13, 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', '', '27478', 'Germany', '(04721) 8713', '(04721) 8714', ''),
(14, 'Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', '', '48100', 'Italy', '(0544) 60323', '(0544) 60603', '#FORMAGGI.HTM#'),
(15, 'Norske Meierier', 'Beate Vileid', 'Marketing Manager', 'Hatlevegen 5', 'Sandvika', '', '1320', 'Norway', '(0)2-953010', '', ''),
(16, 'Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th Avenue Suite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931', '', ''),
(17, 'Svensk Sj�f�da AB', 'Michael Bj�rn', 'Sales Representative', 'Brovallav�gen 231', 'Stockholm', '', 'S-123 45', 'Sweden', '08-123 45 67', '', ''),
(18, 'Aux joyeux eccl�siastiques', 'Guyl�ne Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', '', '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62', ''),
(19, 'New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '2134', 'USA', '(617) 555-3267', '(617) 555-3389', ''),
(20, 'Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', '', '512', 'Singapore', '555-8787', '', ''),
(21, 'Lyngbysild', 'Niels Petersen', 'Sales Manager', 'Lyngbysild Fiskebakken 10', 'Lyngby', '', '2800', 'Denmark', '43844108', '43844115', ''),
(22, 'Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'Verkoop Rijnweg 22', 'Zaandam', '', '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210', ''),
(23, 'Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', '', '53120', 'Finland', '(953) 10956', '', ''),
(24, 'G''day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward Parade Hunter''s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873', 'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'),
(25, 'Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montr�al', 'Qu�bec', 'H1J 1C3', 'Canada', '(514) 555-9022', '', ''),
(26, 'Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', '', '84100', 'Italy', '(089) 6547665', '(089) 6547667', ''),
(27, 'Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', '', '71300', 'France', '85.57.00.07', '', ''),
(28, 'Gai p�turage', 'Eliane Noz', 'Sales Representative', 'Bat. B 3, rue des Alpes', 'Annecy', '', '74000', 'France', '38.76.98.06', '38.76.98.58', ''),
(29, 'For�ts d''�rables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Qu�bec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `territories`
--

CREATE TABLE `territories` (
  `TerritoryID` varchar(20) NOT NULL,
  `TerritoryDescription` char(50) NOT NULL,
  `RegionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `territories`
--

INSERT INTO `territories` (`TerritoryID`, `TerritoryDescription`, `RegionID`) VALUES
('10019', 'New York', 1),
('10038', 'New York', 1),
('11747', 'Mellvile', 1),
('14450', 'Fairport', 1),
('1581', 'Westboro', 1),
('1730', 'Bedford', 1),
('1833', 'Georgetow', 1),
('19428', 'Philadelphia', 3),
('19713', 'Neward', 1),
('20852', 'Rockville', 1),
('2116', 'Boston', 1),
('2139', 'Cambridge', 1),
('2184', 'Braintree', 1),
('27403', 'Greensboro', 1),
('27511', 'Cary', 1),
('2903', 'Providence', 1),
('29202', 'Columbia', 4),
('30346', 'Atlanta', 4),
('3049', 'Hollis', 3),
('31406', 'Savannah', 4),
('32859', 'Orlando', 4),
('33607', 'Tampa', 4),
('3801', 'Portsmouth', 3),
('40222', 'Louisville', 1),
('44122', 'Beachwood', 3),
('45839', 'Findlay', 3),
('48075', 'Southfield', 3),
('48084', 'Troy', 3),
('48304', 'Bloomfield Hills', 3),
('53404', 'Racine', 3),
('55113', 'Roseville', 3),
('55439', 'Minneapolis', 3),
('60179', 'Hoffman Estates', 2),
('60601', 'Chicago', 2),
('6897', 'Wilton', 1),
('72716', 'Bentonville', 4),
('75234', 'Dallas', 4),
('78759', 'Austin', 4),
('7960', 'Morristown', 1),
('80202', 'Denver', 2),
('80909', 'Colorado Springs', 2),
('85014', 'Phoenix', 2),
('85251', 'Scottsdale', 2),
('8837', 'Edison', 1),
('90405', 'Santa Monica', 2),
('94025', 'Menlo Park', 2),
('94105', 'San Francisco', 2),
('95008', 'Campbell', 2),
('95054', 'Santa Clara', 2),
('95060', 'Santa Cruz', 2),
('98004', 'Bellevue', 2),
('98052', 'Redmond', 2),
('98104', 'Seattle', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CategoryID`),
  ADD KEY `Categories_CategoryName` (`CategoryName`);

--
-- Indices de la tabla `customercustomerdemo`
--
ALTER TABLE `customercustomerdemo`
  ADD PRIMARY KEY (`CustomerID`,`CustomerTypeID`),
  ADD KEY `FK_CustomerCustomerDemo` (`CustomerTypeID`),
  ADD KEY `FK_CustomerCustomerDemo_Customers` (`CustomerID`);

--
-- Indices de la tabla `customerdemographics`
--
ALTER TABLE `customerdemographics`
  ADD PRIMARY KEY (`CustomerTypeID`);

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`),
  ADD KEY `Customers_City` (`City`),
  ADD KEY `Customers_CompanyName` (`CompanyName`),
  ADD KEY `Customers_PostalCode` (`PostalCode`),
  ADD KEY `Customers_Region` (`Region`);

--
-- Indices de la tabla `customers2`
--
ALTER TABLE `customers2`
  ADD PRIMARY KEY (`CustomerID`),
  ADD KEY `customers2_City` (`City`),
  ADD KEY `customers2_CompanyName` (`CompanyName`),
  ADD KEY `customers2_PostalCode` (`PostalCode`),
  ADD KEY `customers2_Region` (`Region`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`),
  ADD KEY `Employees_LastName` (`LastName`),
  ADD KEY `Employees_PostalCode` (`PostalCode`),
  ADD KEY `FK_Employees_Employees` (`ReportsTo`);

--
-- Indices de la tabla `employeeterritories`
--
ALTER TABLE `employeeterritories`
  ADD PRIMARY KEY (`EmployeeID`,`TerritoryID`),
  ADD KEY `FK_EmployeeTerritories_Territories` (`TerritoryID`);

--
-- Indices de la tabla `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`OrderID`,`ProductID`),
  ADD KEY `OrderDetails_OrderID` (`OrderID`),
  ADD KEY `OrderDetails_OrdersOrder_Details` (`OrderID`),
  ADD KEY `OrderDetails_ProductID` (`ProductID`),
  ADD KEY `OrderDetails_ProductsOrder_Details` (`ProductID`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `Orders_CustomerID` (`CustomerID`),
  ADD KEY `Orders_CustomersOrders` (`CustomerID`),
  ADD KEY `Orders_EmployeeID` (`EmployeeID`),
  ADD KEY `Orders_EmployeesOrders` (`EmployeeID`),
  ADD KEY `Orders_OrderDate` (`OrderDate`),
  ADD KEY `Orders_ShippedDate` (`ShippedDate`),
  ADD KEY `Orders_ShippersOrders` (`ShipVia`),
  ADD KEY `Orders_ShipPostalCode` (`ShipPostalCode`),
  ADD KEY `FK_Orders_Customers` (`CustomerID`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `Products_CategoriesProducts` (`CategoryID`),
  ADD KEY `Products_CategoryID` (`CategoryID`),
  ADD KEY `Products_ProductName` (`ProductName`),
  ADD KEY `Products_SupplierID` (`SupplierID`),
  ADD KEY `Products_SuppliersProducts` (`SupplierID`);

--
-- Indices de la tabla `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`RegionID`);

--
-- Indices de la tabla `shippers`
--
ALTER TABLE `shippers`
  ADD PRIMARY KEY (`ShipperID`);

--
-- Indices de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`),
  ADD KEY `Suppliers_CompanyName` (`CompanyName`),
  ADD KEY `Suppliers_PostalCode` (`PostalCode`);

--
-- Indices de la tabla `territories`
--
ALTER TABLE `territories`
  ADD PRIMARY KEY (`TerritoryID`),
  ADD KEY `FK_Territories_Region` (`RegionID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11114;
--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT de la tabla `shippers`
--
ALTER TABLE `shippers`
  MODIFY `ShipperID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `customercustomerdemo`
--
ALTER TABLE `customercustomerdemo`
  ADD CONSTRAINT `FK_CustomerCustomerDemo` FOREIGN KEY (`CustomerTypeID`) REFERENCES `customerdemographics` (`CustomerTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_CustomerCustomerDemo_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `FK_Employees_Employees` FOREIGN KEY (`ReportsTo`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `employeeterritories`
--
ALTER TABLE `employeeterritories`
  ADD CONSTRAINT `FK_EmployeeTerritories_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_EmployeeTerritories_Territories` FOREIGN KEY (`TerritoryID`) REFERENCES `territories` (`TerritoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `FK_Order_Details_Orders` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Order_Details_Products` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Orders_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Orders_Shippers` FOREIGN KEY (`ShipVia`) REFERENCES `shippers` (`ShipperID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_Products_Categories` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Products_Suppliers` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `territories`
--
ALTER TABLE `territories`
  ADD CONSTRAINT `FK_Territories_Region` FOREIGN KEY (`RegionID`) REFERENCES `region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `papema`
--
CREATE DATABASE IF NOT EXISTS `papema` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `papema`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProNoRepetirArticulos` (IN `nombre` VARCHAR(60), OUT `msj` INT)  begin
	if exists (select *from articulos where nombre_articulo = nombre) then
		set msj = 0;
	else
		set msj = 1;
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProVentas` (IN `total` DOUBLE, IN `fecha` VARCHAR(80), IN `idCliente` INT, OUT `idVenta` INT)  begin
		if exists (select *from clientes where id_clientes = idCliente) then
			insert into ventas values ('',total,fecha,idCliente);
			select max(id_ventas) into idVenta from ventas;
        else
        	set idVenta = -1;
		end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProVentas_Articulos` (IN `idArticulos` INT, `idVentas` INT, `cantidad` INT, OUT `msj` VARCHAR(50))  begin
	declare aux int;
    set autocommit = 0;
	insert into articulos_ventas values (idArticulos,idVentas,cantidad);
    select existencia into aux from articulos where id_articulos = idArticulos;
    
    update articulos
    set existencia = (aux - cantidad)
    where id_articulos = idArticulos;
    
    if (aux - cantidad) < 0 then
		rollback;
        set msj = 'Insertar no permitido';
	else
		commit;
        set msj = 'Insertado correctamente';
	end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id_articulos` int(11) NOT NULL,
  `nombre_articulo` varchar(45) NOT NULL,
  `precio_compra_mayoreo` float DEFAULT NULL,
  `precio_compra_menudeo` float DEFAULT NULL,
  `descripcion` varchar(60) DEFAULT NULL,
  `precio_venta` double NOT NULL,
  `iva` double NOT NULL,
  `existencia` int(11) NOT NULL,
  `id_categorias` int(11) NOT NULL,
  `id_provedores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id_articulos`, `nombre_articulo`, `precio_compra_mayoreo`, `precio_compra_menudeo`, `descripcion`, `precio_venta`, `iva`, `existencia`, `id_categorias`, `id_provedores`) VALUES
(1, 'Lapiz', 0.5, 1, 'Lapiz con goma', 2, 0.1599999964237213, 96, 4, 1),
(2, 'cuaderno', 5.5, 6, 'cuaderno convecional', 7.5, 0.1599999964237213, 96, 4, 1),
(3, 'Boligrafo', 5, 6, 'Lapicero con estilo', 6.5, 0.1599999964237213, 192, 4, 2),
(4, 'Calculadora Cientifica', 50.7, 60, 'calculadora profecional', 65.5, 0.14000000059604645, 74, 5, 2),
(8, 'Goma', 0.2, 1, 'goma convencional', 2, 0.1599999964237213, 80, 4, 12),
(9, 'Libreta Scribe', 15, 17, 'libreta convecional', 18, 0.1599999964237213, 80, 4, 1),
(10, 'hojas', 50.2, 60, 'hojas de maquina para impreciones', 70, 0.1599999964237213, 90, 1, 1),
(11, 'Tijeras', 5.25, 6, 'tijeras convencionales', 6, 0.1599999964237213, 94, 9, 12),
(14, 'Escuadra', 15.23, 14.5, 'Escuadra profesional', 16.25, 0.16, 80, 13, 123),
(15, 'Headphones', 250.56, 300, 'Audifonos de alta fidelidad', 300, 0.14, 50, 9, 123);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos_ventas`
--

CREATE TABLE `articulos_ventas` (
  `id_articulos` int(11) NOT NULL,
  `id_ventas` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `articulos_ventas`
--

INSERT INTO `articulos_ventas` (`id_articulos`, `id_ventas`, `cantidad`) VALUES
(1, 22, 1),
(2, 19, 1),
(3, 19, 1),
(3, 20, 1),
(4, 19, 1),
(4, 21, 1),
(8, 19, 1),
(9, 19, 1),
(9, 22, 1),
(10, 19, 1),
(10, 22, 2),
(11, 19, 1),
(11, 22, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categorias` int(11) NOT NULL,
  `nombre_categoria` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categorias`, `nombre_categoria`) VALUES
(1, 'Hojas de máquina'),
(2, 'Impresión y/o copiado'),
(3, 'Papel'),
(4, 'Escritura (lapiz, pluma, plumón, etc)'),
(5, 'Calculadora'),
(6, 'Folders/sobres'),
(7, 'Carpeta'),
(8, 'Borradores'),
(9, 'Otros'),
(10, 'Abarrotes'),
(11, 'Lacteos'),
(12, 'Bebidas'),
(13, 'Geometria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_clientes` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `a_paterno` varchar(45) DEFAULT NULL,
  `a_materno` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `calle` varchar(45) DEFAULT NULL,
  `colonia` varchar(35) DEFAULT NULL,
  `num_casa` int(11) DEFAULT NULL,
  `estado` varchar(4) DEFAULT NULL,
  `municipio` varchar(4) DEFAULT NULL,
  `correo` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_clientes`, `nombre`, `a_paterno`, `a_materno`, `telefono`, `calle`, `colonia`, `num_casa`, `estado`, `municipio`, `correo`) VALUES
(1, 'Goku', 'Kakaroto', 'Gohan', '4578961236', NULL, NULL, NULL, NULL, NULL, 'dragon@ball.com'),
(2, 'Kevin', 'Rodarte', 'Moralez', '4571028456', 'Conocido', 'Siana', 15, 'zac', 'val', 'changorodarte@outlok.com'),
(3, 'Rodrigo', 'Lopez', 'Mateo', '545456897', NULL, NULL, NULL, NULL, NULL, 'kjxfhkjsd@hotmail.com'),
(4, 'Paty', '', '', '', NULL, NULL, NULL, NULL, NULL, ''),
(5, 'Gohan', 'fsdfdsfsdf', 'd', 'xzc', 'zxczxc', '', 0, '', '', ''),
(6, 'Bills sama', 'sdfk', '', '', '', '', 0, '', '', ''),
(7, 'Cibel', 'Gomez', 'Gonzalez', '4931234598', 'calera pro 145', 'villas de tronco', 16, 'zac', 'cal', 'cbel@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provedores`
--

CREATE TABLE `provedores` (
  `id_provedores` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `a_paterno` varchar(45) DEFAULT NULL,
  `a_materno` varchar(45) DEFAULT NULL,
  `agencia` varchar(45) DEFAULT NULL,
  `calle` varchar(45) DEFAULT NULL,
  `colonia` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `provedores`
--

INSERT INTO `provedores` (`id_provedores`, `nombre`, `a_paterno`, `a_materno`, `agencia`, `calle`, `colonia`, `telefono`, `correo`) VALUES
(1, 'Roberto', 'Rolando', 'Mota', 'Lala', 'plateros', 'centro', '4931234565', 'lala@lala.com'),
(2, 'Mario', 'Lopez', 'Mateo', 'CocaCola', 'Av. Lopez ', 'centro', '7779871236', 'cocacola@coca.net'),
(3, 'Goku', 'Gonzales', 'Sayan', 'Gonzales', 'tierra', 'namek', '4578945678', 'kakaro@hotmail.com'),
(12, 'Kevin', 'Perez', 'Mateo', 'TuMama', 'La luna', 'marte', '00', 'dfsgdsg'),
(123, 'Uriel', 'Muruato', 'Martinez', 'Home Diport', 'Reforma 416', 'centro', '4571085696', 'rueiel@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuarios` int(11) NOT NULL,
  `usuario` varchar(10) NOT NULL,
  `contrasenia` varchar(8) NOT NULL,
  `tipo_registro` varchar(15) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `a_paterno` varchar(45) DEFAULT NULL,
  `a_materno` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `ciudad` varchar(20) DEFAULT NULL,
  `calle` varchar(30) DEFAULT NULL,
  `colonia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuarios`, `usuario`, `contrasenia`, `tipo_registro`, `nombre`, `a_paterno`, `a_materno`, `telefono`, `estado`, `ciudad`, `calle`, `colonia`) VALUES
(1, 'rodo', 'rodo', 'Administrador', 'Rodolfo', 'Rodarte Jr', 'Morales', '4571078441', '', 'valpa', 'siana', 'siana'),
(7, 'usuario', 'hola', 'Usuario', 'Rodolfo', 'Rodolfo Jr', ' ', '65466656', 'zac', 'la luna', 'tu madre', 'cx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_ventas` int(11) NOT NULL,
  `total_venta` double NOT NULL,
  `fecha_venta` varchar(20) DEFAULT NULL,
  `id_clientes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_ventas`, `total_venta`, `fecha_venta`, `id_clientes`) VALUES
(18, 0, '18/08/2017 09:12:27 ', 7),
(19, 116.43, '18/08/2017 09:15:46 ', 7),
(20, 7.54, '18/08/2017 09:24:17 ', 7),
(21, 74.67, '20/08/2017 11:11:18 ', 1),
(22, 41.76, '20/08/2017 11:28:15 ', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id_articulos`),
  ADD KEY `fk_articulos_categorias1_idx` (`id_categorias`),
  ADD KEY `fk_articulos_provedores1_idx` (`id_provedores`);

--
-- Indices de la tabla `articulos_ventas`
--
ALTER TABLE `articulos_ventas`
  ADD PRIMARY KEY (`id_articulos`,`id_ventas`),
  ADD KEY `fk_articulos_has_ventas_ventas1_idx` (`id_ventas`),
  ADD KEY `fk_articulos_has_ventas_articulos1_idx` (`id_articulos`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categorias`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_clientes`);

--
-- Indices de la tabla `provedores`
--
ALTER TABLE `provedores`
  ADD PRIMARY KEY (`id_provedores`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuarios`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_ventas`),
  ADD KEY `fk_ventas_clientes1_idx` (`id_clientes`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id_articulos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categorias` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_ventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `fk_articulos_categorias1` FOREIGN KEY (`id_categorias`) REFERENCES `categorias` (`id_categorias`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_articulos_provedores1` FOREIGN KEY (`id_provedores`) REFERENCES `provedores` (`id_provedores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `articulos_ventas`
--
ALTER TABLE `articulos_ventas`
  ADD CONSTRAINT `fk_articulos_has_ventas_articulos1` FOREIGN KEY (`id_articulos`) REFERENCES `articulos` (`id_articulos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_articulos_has_ventas_ventas1` FOREIGN KEY (`id_ventas`) REFERENCES `ventas` (`id_ventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_ventas_clientes1` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`id_clientes`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{"angular_direct":"direct","snap_to_grid":"off","relation_lines":"true"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Volcado de datos para la tabla `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'database', 'papema', '{"quick_or_custom":"quick","what":"sql","structure_or_data_forced":"0","table_select[]":["articulos","articulos_ventas","categorias","clientes","compras","compras_articulos","provedores","usuarios","ventas"],"table_structure[]":["articulos","articulos_ventas","categorias","clientes","compras","compras_articulos","provedores","usuarios","ventas"],"table_data[]":["articulos","articulos_ventas","categorias","clientes","compras","compras_articulos","provedores","usuarios","ventas"],"output_format":"sendit","filename_template":"@DATABASE@","remember_template":"on","charset":"utf-8","compression":"none","maxsize":"","codegen_structure_or_data":"data","codegen_format":"0","csv_separator":",","csv_enclosed":"\\"","csv_escaped":"\\"","csv_terminated":"AUTO","csv_null":"NULL","csv_structure_or_data":"data","excel_null":"NULL","excel_edition":"win","excel_structure_or_data":"data","htmlword_structure_or_data":"structure_and_data","htmlword_null":"NULL","json_structure_or_data":"data","latex_caption":"something","latex_structure_or_data":"structure_and_data","latex_structure_caption":"Estructura de la tabla @TABLE@","latex_structure_continued_caption":"Estructura de la tabla @TABLE@ (continÃºa)","latex_structure_label":"tab:@TABLE@-structure","latex_relation":"something","latex_comments":"something","latex_mime":"something","latex_columns":"something","latex_data_caption":"Contenido de la tabla @TABLE@","latex_data_continued_caption":"Contenido de la tabla @TABLE@ (continÃºa)","latex_data_label":"tab:@TABLE@-data","latex_null":"\\\\textit{NULL}","mediawiki_structure_or_data":"structure_and_data","mediawiki_caption":"something","mediawiki_headers":"something","ods_null":"NULL","ods_structure_or_data":"data","odt_structure_or_data":"structure_and_data","odt_relation":"something","odt_comments":"something","odt_mime":"something","odt_columns":"something","odt_null":"NULL","pdf_report_title":"","pdf_structure_or_data":"structure_and_data","phparray_structure_or_data":"data","sql_include_comments":"something","sql_header_comment":"","sql_compatibility":"NONE","sql_structure_or_data":"structure_and_data","sql_create_table":"something","sql_auto_increment":"something","sql_create_view":"something","sql_procedure_function":"something","sql_create_trigger":"something","sql_backquotes":"something","sql_type":"INSERT","sql_insert_syntax":"both","sql_max_query_size":"50000","sql_hex_for_binary":"something","sql_utc_time":"something","texytext_structure_or_data":"structure_and_data","texytext_null":"NULL","xml_structure_or_data":"data","xml_export_events":"something","xml_export_functions":"something","xml_export_procedures":"something","xml_export_tables":"something","xml_export_triggers":"something","xml_export_views":"something","xml_export_contents":"something","yaml_structure_or_data":"data","":null,"lock_tables":null,"as_separate_files":null,"csv_removeCRLF":null,"csv_columns":null,"excel_removeCRLF":null,"excel_columns":null,"htmlword_columns":null,"json_pretty_print":null,"ods_columns":null,"sql_dates":null,"sql_relation":null,"sql_mime":null,"sql_use_transaction":null,"sql_disable_fk":null,"sql_views_as_tables":null,"sql_metadata":null,"sql_create_database":null,"sql_drop_table":null,"sql_if_not_exists":null,"sql_truncate":null,"sql_delayed":null,"sql_ignore":null,"texytext_columns":null}'),
(2, 'root', 'database', 'customers', '{"quick_or_custom":"quick","what":"sql","structure_or_data_forced":"0","table_select[]":["categories","customercustomerdemo","customerdemographics","customers","employees","employeeterritories","orderdetails","orders","products","region","shippers","suppliers","territories"],"table_structure[]":["categories","customercustomerdemo","customerdemographics","customers","employees","employeeterritories","orderdetails","orders","products","region","shippers","suppliers","territories"],"table_data[]":["categories","customercustomerdemo","customerdemographics","customers","employees","employeeterritories","orderdetails","orders","products","region","shippers","suppliers","territories"],"output_format":"sendit","filename_template":"@DATABASE@","remember_template":"on","charset":"utf-8","compression":"none","maxsize":"","codegen_structure_or_data":"data","codegen_format":"0","csv_separator":",","csv_enclosed":"\\"","csv_escaped":"\\"","csv_terminated":"AUTO","csv_null":"NULL","csv_structure_or_data":"data","excel_null":"NULL","excel_edition":"win","excel_structure_or_data":"data","htmlword_structure_or_data":"structure_and_data","htmlword_null":"NULL","json_structure_or_data":"data","latex_caption":"something","latex_structure_or_data":"structure_and_data","latex_structure_caption":"Estructura de la tabla @TABLE@","latex_structure_continued_caption":"Estructura de la tabla @TABLE@ (continÃºa)","latex_structure_label":"tab:@TABLE@-structure","latex_relation":"something","latex_comments":"something","latex_mime":"something","latex_columns":"something","latex_data_caption":"Contenido de la tabla @TABLE@","latex_data_continued_caption":"Contenido de la tabla @TABLE@ (continÃºa)","latex_data_label":"tab:@TABLE@-data","latex_null":"\\\\textit{NULL}","mediawiki_structure_or_data":"structure_and_data","mediawiki_caption":"something","mediawiki_headers":"something","ods_null":"NULL","ods_structure_or_data":"data","odt_structure_or_data":"structure_and_data","odt_relation":"something","odt_comments":"something","odt_mime":"something","odt_columns":"something","odt_null":"NULL","pdf_report_title":"","pdf_structure_or_data":"structure_and_data","phparray_structure_or_data":"data","sql_include_comments":"something","sql_header_comment":"","sql_compatibility":"NONE","sql_structure_or_data":"structure_and_data","sql_create_table":"something","sql_auto_increment":"something","sql_create_view":"something","sql_procedure_function":"something","sql_create_trigger":"something","sql_backquotes":"something","sql_type":"INSERT","sql_insert_syntax":"both","sql_max_query_size":"50000","sql_hex_for_binary":"something","sql_utc_time":"something","texytext_structure_or_data":"structure_and_data","texytext_null":"NULL","xml_structure_or_data":"data","xml_export_events":"something","xml_export_functions":"something","xml_export_procedures":"something","xml_export_tables":"something","xml_export_triggers":"something","xml_export_views":"something","xml_export_contents":"something","yaml_structure_or_data":"data","":null,"lock_tables":null,"as_separate_files":null,"csv_removeCRLF":null,"csv_columns":null,"excel_removeCRLF":null,"excel_columns":null,"htmlword_columns":null,"json_pretty_print":null,"ods_columns":null,"sql_dates":null,"sql_relation":null,"sql_mime":null,"sql_use_transaction":null,"sql_disable_fk":null,"sql_views_as_tables":null,"sql_metadata":null,"sql_create_database":null,"sql_drop_table":null,"sql_if_not_exists":null,"sql_truncate":null,"sql_delayed":null,"sql_ignore":null,"texytext_columns":null}'),
(3, 'root', 'server', 'papema', '{"quick_or_custom":"quick","what":"sql","db_select[]":["northwind","papema","phpmyadmin","test"],"output_format":"sendit","filename_template":"@SERVER@","remember_template":"on","charset":"utf-8","compression":"none","maxsize":"","codegen_structure_or_data":"data","codegen_format":"0","csv_separator":",","csv_enclosed":"\\"","csv_escaped":"\\"","csv_terminated":"AUTO","csv_null":"NULL","csv_structure_or_data":"data","excel_null":"NULL","excel_edition":"win","excel_structure_or_data":"data","htmlword_structure_or_data":"structure_and_data","htmlword_null":"NULL","json_structure_or_data":"data","latex_caption":"something","latex_structure_or_data":"structure_and_data","latex_structure_caption":"Estructura de la tabla @TABLE@","latex_structure_continued_caption":"Estructura de la tabla @TABLE@ (continÃºa)","latex_structure_label":"tab:@TABLE@-structure","latex_relation":"something","latex_comments":"something","latex_mime":"something","latex_columns":"something","latex_data_caption":"Contenido de la tabla @TABLE@","latex_data_continued_caption":"Contenido de la tabla @TABLE@ (continÃºa)","latex_data_label":"tab:@TABLE@-data","latex_null":"\\\\textit{NULL}","mediawiki_structure_or_data":"data","mediawiki_caption":"something","mediawiki_headers":"something","ods_null":"NULL","ods_structure_or_data":"data","odt_structure_or_data":"structure_and_data","odt_relation":"something","odt_comments":"something","odt_mime":"something","odt_columns":"something","odt_null":"NULL","pdf_report_title":"","pdf_structure_or_data":"data","phparray_structure_or_data":"data","sql_include_comments":"something","sql_header_comment":"","sql_compatibility":"NONE","sql_structure_or_data":"structure_and_data","sql_create_table":"something","sql_auto_increment":"something","sql_create_view":"something","sql_procedure_function":"something","sql_create_trigger":"something","sql_backquotes":"something","sql_type":"INSERT","sql_insert_syntax":"both","sql_max_query_size":"50000","sql_hex_for_binary":"something","sql_utc_time":"something","texytext_structure_or_data":"structure_and_data","texytext_null":"NULL","yaml_structure_or_data":"data","":null,"as_separate_files":null,"csv_removeCRLF":null,"csv_columns":null,"excel_removeCRLF":null,"excel_columns":null,"htmlword_columns":null,"json_pretty_print":null,"ods_columns":null,"sql_dates":null,"sql_relation":null,"sql_mime":null,"sql_use_transaction":null,"sql_disable_fk":null,"sql_views_as_tables":null,"sql_metadata":null,"sql_drop_database":null,"sql_drop_table":null,"sql_if_not_exists":null,"sql_truncate":null,"sql_delayed":null,"sql_ignore":null,"texytext_columns":null}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{"db":"papema","table":"articulos"},{"db":"papema","table":"ventas"},{"db":"papema","table":"usuarios"},{"db":"papema","table":"provedores"},{"db":"papema","table":"clientes"},{"db":"papema","table":"articulos_ventas"},{"db":"papema","table":"categorias"},{"db":"northwind","table":"products"},{"db":"northwind","table":"orderdetails"},{"db":"northwind","table":"orders"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'northwind', 'customers', '{"sorted_col":"`customers`.`CustomerID`  DESC"}', '2017-08-09 14:31:09'),
('root', 'northwind', 'orderdetails', '{"sorted_col":"`orderdetails`.`OrderID`  DESC"}', '2017-08-14 16:32:56'),
('root', 'northwind', 'orders', '{"sorted_col":"`orders`.`OrderID`  DESC"}', '2017-08-14 16:28:53'),
('root', 'northwind', 'products', '{"sorted_col":"`products`.`ProductID`  DESC"}', '2017-08-02 14:30:45'),
('root', 'papema', 'articulos_ventas', '{"sorted_col":"`articulos_ventas`.`id_ventas`  ASC"}', '2017-08-18 14:17:18'),
('root', 'papema', 'ventas', '{"sorted_col":"`id_ventas`  DESC"}', '2017-08-18 14:09:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2017-06-06 00:42:41', '{"lang":"es","collation_connection":"utf8mb4_unicode_ci"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;