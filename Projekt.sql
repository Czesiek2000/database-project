DROP TABLE DOSTAWCA CASCADE CONSTRAINTS;
DROP TABLE KELNER CASCADE CONSTRAINTS;
DROP TABLE KLIENT CASCADE CONSTRAINTS;
DROP TABLE KUCHARZ CASCADE CONSTRAINTS;
DROP TABLE POMOCNIK CASCADE CONSTRAINTS;
DROP TABLE PRACOWNIK CASCADE CONSTRAINTS;
DROP TABLE ZAMOWIENIE CASCADE CONSTRAINTS;

CREATE TABLE Dostawca (
    Id_dostawca integer  NOT NULL,
    imie char(20)  NOT NULL,
    nazwisko char(20)  NOT NULL,
    CONSTRAINT Dostawca_pk PRIMARY KEY (Id_dostawca)
) ;


CREATE TABLE Kelner (
    Id_kelner integer  NOT NULL,
    Imie char(20)  NOT NULL,
    Nazwisko char(20)  NOT NULL,
    CONSTRAINT Kelner_pk PRIMARY KEY (Id_kelner)
) ;

CREATE TABLE Klient (
    Id_klient integer  NOT NULL,
    imie char(20)  NOT NULL,
    nazwisko char(20)  NOT NULL,
    numer_telefonu char(9)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (Id_klient)
) ;

CREATE TABLE Kucharz (
    Id_kucharz integer  NOT NULL,
    imie char(20)  NOT NULL,
    nazwisko char(20)  NOT NULL,
    doswiadczenie integer  NOT NULL,
    pensja integer  NOT NULL,
    Id_pracownik integer  NOT NULL,
    CONSTRAINT Kucharz_pk PRIMARY KEY (Id_kucharz)
) ;

CREATE TABLE Pomocnik (
    Id_pomocnik integer  NOT NULL,
    imie char(20)  NOT NULL,
    nazwisko char(20)  NOT NULL,
    doswiadczenie integer  NOT NULL,
    Id_kucharz integer  NOT NULL,
    CONSTRAINT Pomocnik_pk PRIMARY KEY (Id_pomocnik)
) ;

CREATE TABLE Pracownik (
    id_pracownik integer  NOT NULL,
    imie varchar2(20)  NOT NULL,
    nazwisko varchar2(20)  NOT NULL,
    data_zatrudnienia date  NOT NULL,
    pensja integer  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (id_pracownik)
) ;

CREATE TABLE Zamowienie (
    Id_zamowienia integer  NOT NULL,
    data_zamowienia date  NOT NULL,
    koszt_zamowienia integer  NOT NULL,
    nazwa_zamowienia varchar2(20)  NOT NULL,
    Id_klient integer  NOT NULL,
    Id_dostawca integer  NOT NULL,
    Id_pomocnik integer  NOT NULL,
    Id_kucharz integer  NOT NULL,
    Id_kelner integer  NOT NULL,
    CONSTRAINT Zamowienie_pk PRIMARY KEY (Id_zamowienia)
) ;

-- foreign keys
-- Reference: Kucharz_Pracownik (table: Kucharz)
ALTER TABLE Kucharz ADD CONSTRAINT Kucharz_Pracownik
    FOREIGN KEY (Id_pracownik)
    REFERENCES Pracownik (id_pracownik);

-- Reference: Pomocnik_Kucharz (table: Pomocnik)
ALTER TABLE Pomocnik ADD CONSTRAINT Pomocnik_Kucharz
    FOREIGN KEY (Id_kucharz)
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

-- End of file.


-- wstawianie wartosci do tabeli 
INSERT INTO PRACOWNIK VALUES (0, 'MARIUSZ', 'PAWLAK', TO_DATE('2019-12-10', 'YYYY-MM-DD'), 1000);
INSERT INTO PRACOWNIK VALUES (1, 'LECH', 'WALCZAK', TO_DATE('2020-05-12', 'YYYY-MM-DD'), 4000);
INSERT INTO PRACOWNIK VALUES (2, 'NATASZA', 'KALINOWSKA', TO_DATE('2018-01-22', 'YYYY-MM-DD'), 3000);
INSERT INTO PRACOWNIK VALUES (3, 'WISLAWA', 'KWIATKOWSKA', TO_DATE('2020-04-20', 'YYYY-MM-DD'), 5000);
INSERT INTO PRACOWNIK VALUES (4, 'SZYMON', 'DABROWSKI', TO_DATE('2019-03-14', 'YYYY-MM-DD'), 4000);
INSERT INTO PRACOWNIK VALUES (5, 'PATRYCJA', 'SAWICKA', TO_DATE('2020-02-29', 'YYYY-MM-DD'), 2000);
INSERT INTO PRACOWNIK VALUES (6, 'WLADYSLAW', 'NOWAKOWSKI', TO_DATE('2018-08-14', 'YYYY-MM-DD'), 6000);

INSERT INTO DOSTAWCA VALUES (0, 'JAN', 'KOWALSKI');
INSERT INTO DOSTAWCA VALUES (1, 'ADAM', 'NOWAK');
INSERT INTO DOSTAWCA VALUES (2, 'WIESLAW', 'KOWALCZYK');
INSERT INTO DOSTAWCA VALUES (3, 'MARIAN', 'CHMIEL');
INSERT INTO DOSTAWCA VALUES (4, 'EWA', 'ADAMSKA');

INSERT INTO KELNER VALUES (0, 'WOJCIECH', 'ZAJAC');
INSERT INTO KELNER VALUES (1, 'STANISLAW', 'WIECZOREK');
INSERT INTO KELNER VALUES (2, 'KAZIMIERZ', 'CHMIELEWSKI');
INSERT INTO KELNER VALUES (3, 'ANDRZEJ', 'ADAMSKI');
INSERT INTO KELNER VALUES (4, 'MACIEJ', 'SAWICKI');
INSERT INTO KELNER VALUES (5, 'PATRYK', 'KOWALCZYK');

INSERT INTO KLIENT VALUES (0, 'ZDZISLAW', 'GORSKI', '727239507');
INSERT INTO KLIENT VALUES (1, 'WACLAWA', 'RUTKOWSKA', '724914324');
INSERT INTO KLIENT VALUES (2, 'ZOFIA', 'WOZNIAK', '725279062');
INSERT INTO KLIENT VALUES (3, 'ANTONI', 'KOZLOWSKI', '603670761');
INSERT INTO KLIENT VALUES (4, 'JOANNA', 'KAMINSKA', '536081564');
INSERT INTO KLIENT VALUES (5, 'KRZYSZTOF', 'ZAJAC', '537839898');
INSERT INTO KLIENT VALUES (6, 'HIERONIM', 'OLSZEWSKI', '725594523');

INSERT INTO KUCHARZ VALUES (0, 'BENEDYKT', 'SOKOL', 2, 1000, 0);
INSERT INTO KUCHARZ VALUES (1, 'TOMASZ', 'GRABOWSKI', 20, 2000, 1);
INSERT INTO KUCHARZ VALUES (2, 'MARTYNA', 'OLSZEWSKA', 10, 3000, 1);
INSERT INTO KUCHARZ VALUES (3, 'FRYDERYK', 'KUCHARSKI', 15, 4000, 2);
INSERT INTO KUCHARZ VALUES (4, 'KAROLINA', 'ZAJAC', 5, 5000, 3);

INSERT INTO POMOCNIK VALUES (0, 'FERDYNAND', 'OSTROWSKI', 21, 0);
INSERT INTO POMOCNIK VALUES (1, 'JULIUSZ', 'PAWLOWSKI', 2, 1);
INSERT INTO POMOCNIK VALUES (2, 'GERTRUDA', 'MALINA', 14, 1);
INSERT INTO POMOCNIK VALUES (3, 'KLAUDIUSZ', 'MICHALSKI', 20, 2);
INSERT INTO POMOCNIK VALUES (4, 'ADAM', 'CZARNECKI', 5, 3);
INSERT INTO POMOCNIK VALUES (5, 'JADWIGA', 'TOMASZEWSKA', 10, 2);

INSERT INTO ZAMOWIENIE VALUES (0, TO_DATE('2018-07-30', 'YYYY-MM-DD'), 10, 'NAPOJE', 0, 0, 0, 0, 0);
INSERT INTO ZAMOWIENIE VALUES (1, TO_DATE('2018-07-30', 'YYYY-MM-DD'), 20, 'JEDZENIE', 0, 1, 1, 0, 0);
INSERT INTO ZAMOWIENIE VALUES (2, TO_DATE('2018-06-26', 'YYYY-MM-DD'), 40, 'PRZEKASKI', 2, 2, 2, 2, 2);
INSERT INTO ZAMOWIENIE VALUES (3, TO_DATE('2018-10-31', 'YYYY-MM-DD'), 20, 'NAPOJE GORACE', 2, 1, 2, 1, 2);
INSERT INTO ZAMOWIENIE VALUES (4, TO_DATE('2019-06-04', 'YYYY-MM-DD'), 40, 'NAPOJE', 3, 1, 2, 0, 3);
INSERT INTO ZAMOWIENIE VALUES (5, TO_DATE('2020-01-06', 'YYYY-MM-DD'), 70, 'NAPOJE GORACE', 3, 3, 3, 3, 3);
INSERT INTO ZAMOWIENIE VALUES (6, TO_DATE('2020-01-10', 'YYYY-MM-DD'), 10, 'JEDZENIE', 4, 3, 2, 1, 0);
INSERT INTO ZAMOWIENIE VALUES (7, TO_DATE('2018-02-25', 'YYYY-MM-DD'), 30, 'PRZEKASKI', 5, 4, 4, 2, 1);
INSERT INTO ZAMOWIENIE VALUES (8, TO_DATE('2018-10-23', 'YYYY-MM-DD'), 50, 'PRZEKASKI', 0,0, 1, 0, 1);
INSERT INTO ZAMOWIENIE VALUES (9, TO_DATE('2018-12-28', 'YYYY-MM-DD'), 60, 'ALKOHOLE', 0, 1, 1, 1, 0);
INSERT INTO ZAMOWIENIE VALUES (10, TO_DATE('2019-07-10', 'YYYY-MM-DD'), 80, 'ALKOHOLE', 3, 2, 2, 0, 2);
INSERT INTO ZAMOWIENIE VALUES (11, TO_DATE('2020-01-13', 'YYYY-MM-DD'), 60, 'NALEWKI', 0, 3, 2, 1, 3);

COMMIT;