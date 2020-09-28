-- Utility Funktionen generieren der Random listen später auch für konvertierung

with Ada.Numerics.Discrete_Random;
with Ada.Directories; use Ada.Directories;
with customtyps; use customtyps;
package Util
with SPARK_Mode => On
is
   package Random_GenP is new Ada.Numerics.Discrete_Random (ZR_Pub);
   package Random_GenE is new Ada.Numerics.Discrete_Random (E);
   package Random_GenSample is new Ada.Numerics.Discrete_Random (Index);
   package Random_GenSec is new Ada.Numerics.Discrete_Random (Sec);
   
   -- Generiert eine Liste an Random Zahlen im Bereich von PublicKey entspricht A (0 .. m*n)
   function GenRandomPub return Pub_Array
     with 
       Global => null; 
   
   -- Generiert eine Liste an Random Zahlen im Bereich von Error e (1 .. 4)
   function GenRandomError return E_Array
     with 
       Global => null; 
   
   -- Generiert eine Liste an Random Zahlen im Bereich Index (1 - 1500) für die Zufällige auswahl A und B
   function GenSampleList return Sample_Array 
     with 
       Global => null; 
   
   function GenSecretKey (Secret : Integer) return Sec
     with 
       Global => null;
   
   function GenSecretArray (Secret : Sec) return Sec_Array
     with 
       Global => null;
   function FileExist (Name : String) return Boolean
     with
       Global => null;
   
end Util; 
