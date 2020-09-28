package body Util is

   -- Generates a Random Set of unsigned Numbers according to specefications of a
   function GenRandomPub return Pub_Array is
      Temp : Pub_Array := (others => 0);
       GP : Random_GenP.Generator;
   begin
      Random_GenP.Reset(GP);
      for I in Index loop
         Temp(I) := Random_GenP.Random(GP);
      end loop;
      return Temp;
   end GenRandomPub;
   
   -- Generates a set of random "Error" Numbers 
   function GenRandomError return E_Array is
      Temp : E_Array := (others => 0);
      GE : Random_GenE.Generator;
   begin
      Random_GenE.Reset(GE);
      for I in Index loop
         Temp(I) := Random_GenE.Random(GE);
      end loop;
      return Temp;
   end GenRandomError;
   
   -- Short list of random numbers used to pick samples from the primary keys
   function GenSampleList return Sample_Array is 
      Temp : Sample_Array := (others => 1);
      GS : Random_GenSample.Generator;
   begin
      Random_GenSample.Reset(GS);
      for I in Sample loop
         Temp(I) := Random_GenSample.Random(GS);
      end loop;
      return Temp;
   end GenSampleList;
   
   -- generates a more sutible Primary Key from an Input
   function GenSecretKey (Secret : Integer) return Sec is
      Temp : Sec := 0;
      GSEC : Random_GenSec.Generator;
   begin
      Random_GenSec.Reset(GSEC, Secret);
      Temp := Random_GenSec.Random(GSEC);
      return Temp;
   end GenSecretKey;
   
   -- generates a Secrey Array
   function GenSecretArray (Secret : Sec) return Sec_Array is
      Temp : Sec_Array := (others => 1);
      GSEC : Random_GenSec.Generator;
   begin
      Random_GenSec.Reset(GSEC, Integer(Secret));
       for I in Index loop
         Temp(I) := Random_GenSec.Random(GSEC);
      end loop;
      return Temp;
   end GenSecretArray;
   
   function FileExist (Name : String) return Boolean is
   begin
         return Exists(Name);
   end FileExist;

end Util;
