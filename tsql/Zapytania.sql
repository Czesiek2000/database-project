-- PROCEDURA 1 - DODAJE NOWEGO PRACOWNIKA Z DATA ZATRUDNIENIA JAKO DZISIEJSZA. DODAJE PRACOWNIKA TYLKO JESLI NIE MA W TABELI PRACOWNIKA O IMIENIU I NAZWISKU TAKIM SAMYM JAK PARAMETRY PROCEDURY. JEZLI TAKI PRACOWNIK ISTNIEJE PODNOSZONY JEST WYJATEK.
IF (OBJECT_ID('UPDATEPRACOWNIK') IS NOT NULL)
  DROP PROCEDURE UPDATEPRACOWNIK
GO

CREATE PROCEDURE UPDATEPRACOWNIK @IMIE VARCHAR(20), @NAZWISKO VARCHAR(20), @PENSJA INT, @KUCHARZ INT 
AS
BEGIN
    DECLARE @IDPRACOWNIK INT;
    DECLARE @DATA DATE;
    SET @DATA = GETDATE();
    SELECT @IDPRACOWNIK = MAX(ID_PRACOWNIK) + 1 FROM PRACOWNIK;
    IF (SELECT COUNT(1) FROM PRACOWNIK WHERE IMIE = @IMIE AND NAZWISKO = @NAZWISKO) = 0
    BEGIN
      INSERT INTO PRACOWNIK VALUES (@IDPRACOWNIK, @IMIE, @NAZWISKO, @DATA, @PENSJA, @KUCHARZ, NULL);
      PRINT 'WSTAWIONO NOWEGO PRACOWNIKA ' + @IMIE + ' ' + @NAZWISKO + ' ZATRUDNIONEGO W DNIU ' + CAST(@DATA AS VARCHAR)
    END
    ELSE
      RAISERROR('TAKI PRACOWNIK JUZ ISTNIEJE', 1,2);
    
END;

-- PROCEDURA 2 PROCEDURA DODAJE NOWE ZAMOWIENIE I WYPISUJACA INFORMACJE O DANYM ZAMOWIENIU. JEZELI DANY KUCHARZ MA WIECEJ NIZ 5 ZAMOWIEN ZOSTAJE PODNIESIONY WYJATEK
IF (OBJECT_ID('ADDZAMOWIENIE') IS NOT NULL)
  DROP PROCEDURE ADDZAMOWIENIE
GO

CREATE PROCEDURE ADDZAMOWIENIE @DATA DATE, @KOSZT INT, @NAZWA VARCHAR(20), @KLIENT INT, @DOSTAWCA INT, @POMOCNIK INT, @KUCHARZ INT, @KELNER INT
AS
BEGIN
  DECLARE @ID INT, @DKLIENT VARCHAR(40), @DDOSTAWCA VARCHAR(40), @DKUCHARZ VARCHAR(40), @DKELNER VARCHAR(40);
  SELECT @ID = MAX(ID_ZAMOWIENIA) + 1 FROM ZAMOWIENIE;
  SELECT @DKLIENT = IMIE + NAZWISKO FROM KLIENT WHERE ID_KLIENT = @KLIENT;
  SELECT @DKELNER = IMIE + NAZWISKO FROM KELNER WHERE ID_KELNER = @KELNER;
  SELECT @DDOSTAWCA = IMIE + NAZWISKO FROM DOSTAWCA WHERE ID_DOSTAWCA = @DOSTAWCA;
  SELECT @DKUCHARZ = IMIE + NAZWISKO FROM KUCHARZ WHERE ID_KUCHARZ = @KUCHARZ;
  IF (SELECT COUNT(1) FROM ZAMOWIENIE WHERE ID_KUCHARZ = @KUCHARZ) < 5
  BEGIN
    PRINT 'DODANO NOWE ZAMOWIENIE NA ' + @NAZWA + ' W DNIU ' + CAST(@DATA AS VARCHAR) + ' KOSZTUJACE ' + CAST(@KOSZT AS VARCHAR) + ' ZAMOWIONE PRZEZ ' + @DKLIENT + ' OBSLUGIWANE PRZEZ ' + @DKELNER + ', ' + @DKUCHARZ + ', ' + @DDOSTAWCA;
    INSERT INTO ZAMOWIENIE VALUES (@ID, @DATA, @KOSZT, @NAZWA, @KLIENT, @DOSTAWCA, @POMOCNIK, @KUCHARZ, @KELNER);
  END;
  ELSE
    RAISERROR('TEN KUCHARZ JEST JUZ ZAJETY', 1,2);
END;

-- DODANIE KOLUMNY DO TABELI PRACOWNIK
ALTER TABLE PRACOWNIK ADD PODWYZKA INT;
GO;

-- PROCEDURA Z KURSOREM - DODAJE DO KOLUMNY PODWYZKA WARTOSC Z PARAMETRU DLA PRACOWNIKOW ZARABIAJACYCH POZNIEJ GRANICY PODANEJ JAKO PARAMETR PROCEDURY. WYPISUJE KTO DOSTAL PODWYZKE, ILE I ILE AKTUALNIE ZARABIA (RAZEM Z PODWYZKA)
CREATE PROCEDURE PENSJAUPD @PENSJA INT, @GRANICA INT
AS
DECLARE KURSOR CURSOR FOR SELECT ID_PRACOWNIK, PENSJA FROM PRACOWNIK WHERE PENSJA < @GRANICA;
DECLARE @IDPRACOWNIK INT, @IMIE VARCHAR(20), @NAZWISKO VARCHAR(20), @SALARY INT, @IDKUCHARZ INT, @OSOBA VARCHAR(40), @SUMA INT;
BEGIN
OPEN KURSOR
FETCH NEXT FROM KURSOR INTO @IDPRACOWNIK, @SALARY
WHILE @@FETCH_STATUS = 0
BEGIN
  SELECT @OSOBA = IMIE + ' ' + NAZWISKO FROM PRACOWNIK WHERE ID_PRACOWNIK = @IDPRACOWNIK
  SELECT @SUMA = PENSJA + @PENSJA FROM PRACOWNIK WHERE ID_PRACOWNIK = @IDPRACOWNIK;
  IF @SALARY < @GRANICA
    UPDATE PRACOWNIK SET PODWYZKA = @PENSJA WHERE ID_PRACOWNIK = @IDPRACOWNIK;

  PRINT 'PRACOWNIK ' + @OSOBA + ' DOSTAL PODWYZKE W WYSOKOSCI ' + CAST(@PENSJA AS VARCHAR) + ' I ZARABIA ' + CAST(@SUMA AS VARCHAR);
  FETCH NEXT FROM KURSOR INTO @IDPRACOWNIK, @SALARY
END;
CLOSE KURSOR;
DEALLOCATE KURSOR;
END;


-- WYZWALACZ 1 - WYZWALACZ KTORY ZLICZA WSZYSTKIE ZAMOWIENIA PO KAZDEJ OPERACJI INSERT, UPDATE I DODAJE DO TABELKI ILOSCZAMOWIEN ILOSC WSZYSTKICH ZAMOWIEN I DATE POKAZUJACA ILOSC NA KONKRETNY DZIEN
CREATE TABLE ILOSCZAMOWIEN (ILOSC INT, DATAAKTUALIZACJI DATE);
GO;

CREATE TRIGGER ILOSC ON ZAMOWIENIE
FOR INSERT, UPDATE
AS
BEGIN
  INSERT INTO ILOSCZAMOWIEN VALUES((SELECT COUNT(1) FROM ZAMOWIENIE), GETDATE());
END;


-- WYZWALACZ 2 - WYZWALACZ DODAJACY ILOSC ZAMOWIEN DO OBSLUGI PRZEZ DANEGO KELNERA
ALTER TABLE KELNER ADD ZAMOWIENIA INT;
GO;

CREATE TRIGGER KELNERZAMOWIENIE ON ZAMOWIENIE
FOR INSERT
AS
BEGIN
  UPDATE KELNER SET ZAMOWIENIA = (SELECT COUNT(*) FROM ZAMOWIENIE WHERE ID_KELNER = (SELECT ID_KELNER FROM INSERTED) GROUP BY ID_KELNER) WHERE ID_KELNER = (SELECT ID_KELNER FROM INSERTED);
END;
