package customtyps is
   
   --Basis typ f�r Kalkulationen sonst Konflikt 
   type RangeType is range 0 .. (10**11);
   

   -- Parameter entsprechend Bernstein
   -- n = Sicherheitsparameter 192
   -- m = Anzahl der Publicekey elemente 1500
   -- q = Primzahl als Faktor f�r kalkulationen 
   
   n : constant RangeType := 192;
   l : constant RangeType := 192;
   m : constant RangeType := 1500;
   q : constant RangeType := 8191;
   --Konstanten f�r Dateinamen
   PKA_FILE : constant String := "PKA.bin";
   PKB_FILE : constant String := "PKB.bin";
   PKS_FILE : constant String := "PKS.bin";
   
   -- wiederholungsrate Blowupfaktor 1500
   type Index is range 1 .. 750;
   
   --Fehlerrate
   subtype E is RangeType'Base range 0 .. 4;
   type E_Array is array (Index) of E;
   
   -- Basistyp f�r Schl�ssel
   subtype Key is RangeType'Base range 0 .. (10**11);
   
   
   -- PublicKey entspricht (n*m)^2  Array f�r Speicherung der beiden PublicKeys A und B
   subtype Pub is Key'Base range 0 .. ((n*m)**2);
   type Pub_Array is array (Index) of Pub;
    -- Bereich f�r Zufallszahlen
   subtype ZR_Pub is Pub'Base range 0 .. (n*m);
   
  
   -- Zahlenbereich f�r Serectkey SecretKey wird sp�ter auch Vektor
   subtype Sec is Key'Base range 0 .. (n*m);
   type Sec_Array is array (Index) of Sec;
   
   -- Auswahl f�r Zufallszahlen aus Liste A / B zur Berechnung von U / V --> 5
   type Sample is range 1 .. 3;
   type Sample_Array is array (Sample) of Index; 
   
   

end customtyps;
