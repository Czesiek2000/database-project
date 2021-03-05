/*
    * SKRYPT TWORZACY TABELE DO PROJEKTU Z TSQL
    * PRZEDMIOT SBD
    * MICHAL CZECH 2020
*/

-- usuwanie tabel jezeli istnieja 

IF OBJECT_ID('Pracownik') IS NOT NULL
	DROP TABLE Pracownik;
Go

IF OBJECT_ID('Zamowienie') IS NOT NULL
	DROP TABLE Zamowienie;
Go

IF OBJECT_ID('Dostawca') IS NOT NULL
	DROP TABLE Dostawca;
Go

IF OBJECT_ID('Kelner') IS NOT NULL
	DROP TABLE Kelner;
Go

IF OBJECT_ID('Klient') IS NOT NULL
	DROP TABLE Klient;
Go

IF OBJECT_ID('Pomocnik') IS NOT NULL
	DROP TABLE Pomocnik;
Go

IF OBJECT_ID('Kucharz') IS NOT NULL
	DROP TABLE Kucharz;
Go

CREATE TABLE Dostawca (
    Id_dostawca int  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    CONSTRAINT Dostawca_pk PRIMARY KEY  (Id_dostawca)
);

CREATE TABLE Kelner (
    Id_kelner int  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    Data_zatrudnienia date  NOT NULL,
    CONSTRAINT Kelner_pk PRIMARY KEY  (Id_kelner)
);

CREATE TABLE Klient (
    Id_klient int  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    Numer_telefonu char(9)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY  (Id_klient)
);

CREATE TABLE Kucharz (
    Id_kucharz int  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    Doswiadczenie int  NOT NULL,
    Pensja int  NOT NULL,
    CONSTRAINT Kucharz_pk PRIMARY KEY  (Id_kucharz)
);

CREATE TABLE Pomocnik (
    Id_pomocnik int  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    Doswiadczenie int  NOT NULL,
    Id_kucharz int  NOT NULL,
    CONSTRAINT Pomocnik_pk PRIMARY KEY  (Id_pomocnik)
);

CREATE TABLE Pracownik (
    Id_pracownik int  NOT NULL,
    Imie varchar(20)  NOT NULL,
    Nazwisko varchar(20)  NOT NULL,
    Data_zatrudnienia date  NOT NULL,
    Pensja int  NOT NULL,
    Kucharz_Id_kucharz int  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY  (Id_pracownik)
);

CREATE TABLE Zamowienie (
    Id_zamowienia int  NOT NULL,
    Data_zamowienia date  NOT NULL,
    Koszt_zamowienia int  NOT NULL,
    Dazwa_zamowienia varchar(20)  NOT NULL,
    Id_klient int  NOT NULL,
    Id_dostawca int  NOT NULL,
    Id_pomocnik int  NOT NULL,
    Id_kucharz int  NOT NULL,
    Id_kelner int  NOT NULL,
    CONSTRAINT Zamowienie_pk PRIMARY KEY  (Id_zamowienia)
);

-- Reference: Pomocnik_Kucharz (table: Pomocnik)
ALTER TABLE Pomocnik ADD CONSTRAINT Pomocnik_Kucharz
    FOREIGN KEY (Id_kucharz)
    REFERENCES Kucharz (Id_kucharz);

-- Reference: Pracownik_Kucharz (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Kucharz
    FOREIGN KEY (Kucharz_Id_kucharz)
    REFERENCES Kucharz (Id_kucharz);

-- Reference: Zamowienia_Dostawca (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienia_Dostawca
    FOREIGN KEY (Id_dostawca)
    REFERENCES Dostawca (Id_dostawca);

-- Reference: Zamowienia_Kelner (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienia_Kelner
    FOREIGN KEY (Id_kelner)
    REFERENCES Kelner (Id_kelner);

-- Reference: Zamowienia_Klient (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienia_Klient
    FOREIGN KEY (Id_klient)
    REFERENCES Klient (Id_klient);

-- Reference: Zamowienia_Kucharz (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienia_Kucharz
    FOREIGN KEY (Id_kucharz)
    REFERENCES Kucharz (Id_kucharz);

-- Reference: Zamowienia_Pomocnik (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienia_Pomocnik
    FOREIGN KEY (Id_pomocnik)
    REFERENCES Pomocnik (Id_pomocnik);

-- wstawianie wartosci do tabeli
INSERT INTO KUCHARZ VALUES (0, 'BENEDYKT', 'SOKOL', 2, 1000);
INSERT INTO KUCHARZ VALUES (1, 'TOMASZ', 'GRABOWSKI', 20, 2000);
INSERT INTO KUCHARZ VALUES (2, 'MARTYNA', 'OLSZEWSKA', 10, 3000);
INSERT INTO KUCHARZ VALUES (3, 'FRYDERYK', 'KUCHARSKI', 15, 4000);
INSERT INTO KUCHARZ VALUES (4, 'KAROLINA', 'ZAJAC', 5, 5000);

INSERT INTO PRACOWNIK VALUES (0, 'MARIUSZ', 'PAWLAK', '2019-12-10', 1000, 1);
INSERT INTO PRACOWNIK VALUES (1, 'LECH', 'WALCZAK', '2020-05-12', 4000, 2);
INSERT INTO PRACOWNIK VALUES (2, 'NATASZA', 'KALINOWSKA', '2018-01-22', 3000, 3);
INSERT INTO PRACOWNIK VALUES (3, 'WISLAWA', 'KWIATKOWSKA', '2020-04-20', 5000, 4);
INSERT INTO PRACOWNIK VALUES (4, 'SZYMON', 'DABROWSKI', '2019-03-14', 4000, 1);
INSERT INTO PRACOWNIK VALUES (5, 'PATRYCJA', 'SAWICKA', '2020-02-29', 2000, 2);
INSERT INTO PRACOWNIK VALUES (6, 'WLADYSLAW', 'NOWAKOWSKI', '2018-08-14', 6000, 3);

INSERT INTO DOSTAWCA VALUES (0, 'JAN', 'KOWALSKI');
INSERT INTO DOSTAWCA VALUES (1, 'ADAM', 'NOWAK');
INSERT INTO DOSTAWCA VALUES (2, 'WIESLAW', 'KOWALCZYK');
INSERT INTO DOSTAWCA VALUES (3, 'MARIAN', 'CHMIEL');
INSERT INTO DOSTAWCA VALUES (4, 'EWA', 'ADAMSKA');

INSERT INTO KELNER VALUES (0, 'WOJCIECH', 'ZAJAC', '2019-12-10');
INSERT INTO KELNER VALUES (1, 'STANISLAW', 'WIECZOREK', '2020-05-12');
INSERT INTO KELNER VALUES (2, 'KAZIMIERZ', 'CHMIELEWSKI','2018-01-22');
INSERT INTO KELNER VALUES (3, 'ANDRZEJ', 'ADAMSKI', '2020-04-20');
INSERT INTO KELNER VALUES (4, 'MACIEJ', 'SAWICKI', '2020-04-20');
INSERT INTO KELNER VALUES (5, 'PATRYK', 'KOWALCZYK', '2018-08-14');

INSERT INTO KLIENT VALUES (0, 'ZDZISLAW', 'GORSKI', '727239507');
INSERT INTO KLIENT VALUES (1, 'WACLAWA', 'RUTKOWSKA', '724914324');
INSERT INTO KLIENT VALUES (2, 'ZOFIA', 'WOZNIAK', '725279062');
INSERT INTO KLIENT VALUES (3, 'ANTONI', 'KOZLOWSKI', '603670761');
INSERT INTO KLIENT VALUES (4, 'JOANNA', 'KAMINSKA', '536081564');
INSERT INTO KLIENT VALUES (5, 'KRZYSZTOF', 'ZAJAC', '537839898');
INSERT INTO KLIENT VALUES (6, 'HIERONIM', 'OLSZEWSKI', '725594523');

INSERT INTO POMOCNIK VALUES (0, 'FERDYNAND', 'OSTROWSKI', 21, 0);
INSERT INTO POMOCNIK VALUES (1, 'JULIUSZ', 'PAWLOWSKI', 2, 1);
INSERT INTO POMOCNIK VALUES (2, 'GERTRUDA', 'MALINA', 14, 1);
INSERT INTO POMOCNIK VALUES (3, 'KLAUDIUSZ', 'MICHALSKI', 20, 2);
INSERT INTO POMOCNIK VALUES (4, 'ADAM', 'CZARNECKI', 5, 3);
INSERT INTO POMOCNIK VALUES (5, 'JADWIGA', 'TOMASZEWSKA', 10, 2);

INSERT INTO ZAMOWIENIE VALUES (0, '2018-07-30', 10, 'NAPOJE', 0, 0, 0, 0, 0);
INSERT INTO ZAMOWIENIE VALUES (1, '2018-07-30', 20, 'JEDZENIE', 0, 1, 1, 0, 0);
INSERT INTO ZAMOWIENIE VALUES (2, '2018-06-26', 40, 'PRZEKASKI', 2, 2, 2, 2, 2);
INSERT INTO ZAMOWIENIE VALUES (3, '2018-10-31', 20, 'NAPOJE GORACE', 2, 1, 2, 1, 2);
INSERT INTO ZAMOWIENIE VALUES (4, '2019-06-04', 40, 'NAPOJE', 3, 1, 2, 0, 3);
INSERT INTO ZAMOWIENIE VALUES (5, '2020-01-06', 70, 'NAPOJE GORACE', 3, 3, 3, 3, 3);
INSERT INTO ZAMOWIENIE VALUES (6, '2020-01-10', 10, 'JEDZENIE', 4, 3, 2, 1, 0);
INSERT INTO ZAMOWIENIE VALUES (7, '2018-02-25', 30, 'PRZEKASKI', 5, 4, 4, 2, 1);
INSERT INTO ZAMOWIENIE VALUES (8, '2018-10-23', 50, 'PRZEKASKI', 0,0, 1, 0, 1);
INSERT INTO ZAMOWIENIE VALUES (9, '2018-12-28', 60, 'ALKOHOLE', 0, 1, 1, 1, 0);
INSERT INTO ZAMOWIENIE VALUES (10, '2019-07-10', 80, 'ALKOHOLE', 3, 2, 2, 0, 2);
INSERT INTO ZAMOWIENIE VALUES (11, '2020-01-13', 60, 'NALEWKI', 0, 3, 2, 1, 3);
