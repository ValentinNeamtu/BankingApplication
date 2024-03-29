DROP DATABASE if exists Bancar;
CREATE DATABASE Bancar;
USE Bancar;

CREATE TABLE IF NOT EXISTS PERSOANA (
	NUME VARCHAR(200),
	PRENUME VARCHAR(200),
	PAROLA VARCHAR(200),
	ADRESA VARCHAR(200),
	TELEFON VARCHAR(200),
	EMAIL VARCHAR(200),
	CONTACT VARCHAR(200),
	CNP VARCHAR(200),
	PRIMARY KEY (CNP)
);

CREATE TABLE IF NOT EXISTS CLIENT(
	DATA_NASTERE DATE,
	SURSA_VENIT VARCHAR(200),
	NR_CONTURI INT,
	TRANZACTII_ONLINE BOOL,
	CNP VARCHAR(200),
	PRIMARY KEY (CNP),
	FOREIGN KEY (CNP) REFERENCES PERSOANA(CNP)
);

CREATE TABLE IF NOT EXISTS ANGAJAT (
	NORMA INT,
	SALARIU double,
	DEPARTAMENT ENUM('HR' ,'IT' ,'FUNCTIONAR'),
	SUCURSALA VARCHAR(200),
	CNP VARCHAR(200),
	PRIMARY KEY (CNP),
	FOREIGN KEY (CNP) REFERENCES PERSOANA(CNP)
);

CREATE TABLE IF NOT EXISTS ADMINISTRATOR (
	CNP VARCHAR(200),
	PRIMARY KEY (CNP),
	FOREIGN KEY (CNP) REFERENCES ANGAJAT(CNP)
);

CREATE TABLE IF NOT EXISTS Cerere_card(
	CNP varchar(200),
	IBAN VARCHAR(200),
	CNP_admin varchar(200), 
	CNP_angajat varchar(200),
	cerere_id INT PRIMARY KEY auto_increment,
	FOREIGN KEY (CNP) REFERENCES Client (CNP)
); 

CREATE TABLE IF NOT EXISTS Lista_contacte(
	comentariu VARCHAR(200),
	nume_client_destinatie varchar(200), 
	IBAN_destinatie char(200), 
	CNP varchar(200),
	lista_id int PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (CNP) REFERENCES Client (CNP)
);

CREATE TABLE Cont(
	suma double, 
	data_creare DATE,
	IBAN VARCHAR(200) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS  Cont_client(
	CNP varchar(200), foreign key (CNP) references Client(CNP) ,
	IBAN VARCHAR(200) PRIMARY KEY,
	FOREIGN KEY (IBAN) REFERENCES cont (IBAN)
);

CREATE TABLE Dobanda(
	perioada INT, 
	dobanda INT,
	dobanda_id INT PRIMARY KEY
);

CREATE TABLE Depozit(
	data_ultim_mod DATE,
	IBAN VARCHAR(200) PRIMARY KEY, 
	dobanda_id int,
	FOREIGN KEY (dobanda_id) REFERENCES Dobanda (dobanda_id),
	FOREIGN KEY (IBAN) REFERENCES Cont (IBAN)
);

CREATE TABLE Cont_Curent(
	IBAN VARCHAR(200) PRIMARY KEY,
	FOREIGN KEY (IBAN) REFERENCES Cont (IBAN)
);

CREATE TABLE Cont_Economii(
	dobanda INT,
	IBAN VARCHAR(200) PRIMARY KEY,
	FOREIGN KEY (IBAN) REFERENCES Cont (IBAN)
);

CREATE TABLE IF NOT EXISTS Transfer(
	status ENUM('CREATED','SUCCESSFUL', 'ERROR'), 
	nume_client_destinatie varchar(200), 
	nume_client_sursa varchar(200),
	data_creare date, 
	SUMA double,
	IBAN_destinatie varchar(200), 
	IBAN_sursa varchar(200), 
	CNP_angajat VARCHAR(200), 
	transfer_id int PRIMARY KEY AUTO_INCREMENT, 
	FOREIGN KEY (IBAN_destinatie) REFERENCES Cont (IBAN),
	FOREIGN KEY (IBAN_sursa) REFERENCES Cont (IBAN),
	FOREIGN KEY (CNP_angajat) REFERENCES Angajat(CNP)
);

-- POPULAM TABELA DE DOBANDA
INSERT INTO dobanda VALUES (1, 5, 1);
INSERT INTO dobanda VALUES (3, 10, 2);
INSERT INTO dobanda VALUES (6, 15, 3);
            
create table facturi (
	NUME VARCHAR (200),
	SUMA DOUBLE ,
	CNP VARCHAR(200),
	FACTURA_ID INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE VERSIUNI(
	id_versiune int PRIMARY KEY DEFAULT 0,
    mesaj varchar(200)
);
INSERT INTO versiuni VALUES (1, 'Baza de date creeata si tabele creeate');



-- call versiunea2();
SELECT * FROM versiuni;

-- CALL undo_versiunea1;
-- CALL versionare(2);
-- SELECT * FROM versiuni;
-- SELECT * FROM curs_valutar_BNR;
