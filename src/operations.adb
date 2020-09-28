package body operations is

   -- Generates B the non random part of the publickey
   function GenB(A_array : Pub_Array; Secret : Sec; Error_array : E_Array) return Pub_Array 
     with SPARK_Mode => On
   is
      Temp : Pub_Array;
   begin
      for I in customtyps.Index loop
         Temp(I) := ((A_array(I)*Secret) + Error_array(I)) mod q;
      end loop;
      return Temp;
   end GenB;
   
   -- Part of the encrypted bit needed for decryption
   function CalcU(A_array : Pub_Array; S_List : Sample_Array) return RangeType 
     with SPARK_Mode => On
   is    
      U : Pub := 0;
   begin
      for I in Sample loop
         -- U ist Summe aus zufällig ausgewählten A Elementen in S_List stehen zufällige Positionen für A_List
         U := U + A_array(S_List(I));
      end loop;
      U := U mod q;
      return U;
   end CalcU;
   
   -- the actual encrypte bit 
   function CalcV(B_array : Pub_Array; S_List : Sample_Array; MessageBit : Integer) return RangeType 
     with SPARK_Mode => On
   is       
      V : Pub := 0;
   begin
      for I in Sample loop
         V := V + B_array(S_List(I));
      end loop;
      -- Falls das Bit 0 ist wird der Summant ebenfalls Null was dem Algorithmus entspricht
      V := V + ((q/2) * RangeType(MessageBit));
      V := V mod q;
      return V;
   end CalcV;
   
   
 ----------------------------------------------------------------------------------------------------------------------------------------------------------- Encrypt  

   
   procedure Encrypt (A_array : Pub_Array; B_array : Pub_Array; Filename : Unbounded_String) is
      S : Sample_Array := GenSampleList;
      -- U and V need the same sample list for encryption
      -- FI / FO = File int / out;  SI / SO = Stream in / out
      FI : Ada.Streams.Stream_IO.File_Type;
      SI : Ada.Streams.Stream_IO.Stream_Access;
      FO : Ada.Streams.Stream_IO.File_Type;
      SO : Ada.Streams.Stream_IO.Stream_Access;
      U : RangeType;
      V : RangeType; 
      Temp : Stream_Element;
      MessageElement : Bit_Array_8;
      -- needed since append doesnt take Filename as a variable / create and open do though
      FN : Unbounded_String := Filename;
   begin   
      Open (FI, IN_File, Ada.Strings.Unbounded.To_String(FN));
      Append(FN,".bin");
      Create (FO, Out_File, Ada.Strings.Unbounded.To_String(FN));
      SI := Stream (FI);
      SO := Stream (FO);
      while not End_Of_File(FI) loop
         -- Stream Element takes the form of 8 byte which should be easily transferable to bit 
         Stream_Element'Read(SI, Temp);
         -- casting the 8 byte to an array that can hold them
         MessageElement := To_Bit_Array_8(Unsigned_Byte(Temp));
         for I in 0 .. 7 loop
            S := GenSampleList;
            U := CalcU(A_array, S);
            -- encrypting every single bit if is needed since there is no possiblity to compute boolean in ada
            if MessageElement(I) = True then
               V := CalcV(B_array, S, 1);
            else
               V := CalcV(B_array, S, 0);
            end if;
            RangeType'Write(SO, U);
            RangeType'Write(SO ,V);
         end loop;
      end loop;

      Close (FI);
      Close (FO);

   end Encrypt;
   
  
 ----------------------------------------------------------------------------------------------------------------------------------------------------------- Decrypt     

   procedure Decrypt (Filename : Unbounded_String; Secret : Sec) is
      FI : Ada.Streams.Stream_IO.File_Type;
      SI : Ada.Streams.Stream_IO.Stream_Access;
      FO : Ada.Streams.Stream_IO.File_Type;
      SO : Ada.Streams.Stream_IO.Stream_Access;
      U_Var : RangeType;
      V_Var : RangeType; 
      Erg : RangeType;
      ErgB : Boolean;
      Temp: Unsigned_Byte;
      MessageElement : Bit_Array_8;
      -- Head cannot override the in value therefor this is necsseasery 
      FN : Unbounded_String := Filename;
   begin
      
      Open (FI, IN_File, Ada.Strings.Unbounded.To_String(FN));
      -- removing the appended .bin
      FN := Head(Filename, Length(Filename) - 4);
      Create (FO, Out_File, Ada.Strings.Unbounded.To_String(FN));
      SI := Stream (FI);
      SO := Stream (FO);
      
      while not End_Of_File(FI) loop
         
         for I in 0 .. 7 loop
            -- reading the value set fpr U and V == in 1 Bit 
            RangeType'Read(SI, U_Var);
            RangeType'Read(SI, V_Var);
            Erg := (V_Var - (U_Var*Secret)) mod q; 
            
            -- was q\2 before but now its acutally according to definition (dosent make a difference though)
            if Erg < (q/4) then
               ErgB := False;
            else
               ErgB := True;
            end if;
                
            MessageElement(I) := ErgB;
            
         end loop;
         Temp := To_Unsigned_Byte(MessageElement);
         Stream_Element'Write(SO, Stream_Element(Temp));
      end loop;
      
      Close (FI);
      Close (FO);
      
   end Decrypt;
   
   
end operations;
