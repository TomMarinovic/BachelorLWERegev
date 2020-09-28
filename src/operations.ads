-- Für Tatsächliche Verschlüsselungs und Entschlüsselungs Funktionen
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_Io; use Ada.Text_IO.Unbounded_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Streams; use Ada.Streams;
with System.Aux_DEC; use System.Aux_DEC;
with customtyps; use customtyps;
with Util; use Util;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package operations 
with SPARK_Mode => On
is
   -- Außerhalb von Encrypt einzusetzen
   function GenB (A_array : Pub_Array; Secret : Sec; Error_array : E_Array) return Pub_Array
     with    
       Global => null,
       Pre => A_array'Length = customtyps.Index'Last; 
   
   -- wird innerhalb von Encrpyt aufgerufen
   function CalcU(A_array : Pub_Array; S_List : Sample_Array) return RangeType
   with 
       Global => null,
       Pre => S_List'Length < 10 and A_array'Length = customtyps.Index'Last,
       Post => CalcU'Result mod q = CalcU'Result;
   
   function CalcV(B_array : Pub_Array; S_List : Sample_Array; MessageBit : Integer) return RangeType
   with 
       Global => null,
       Pre => (MessageBit = 1 or MessageBit = 0) and S_List'Length < 10 and B_array'Length = customtyps.Index'Last;
   
   procedure Encrypt (A_array : Pub_Array; B_array : Pub_Array; Filename : Unbounded_String)
   with 
       Global => null,
       Pre => A_array'Length = customtyps.Index'Last and B_array'Length = customtyps.Index'Last and Filename /= " ";
   
   procedure Decrypt (Filename : Unbounded_String; Secret : Sec)
   with 
       Global => null,
       Pre => Secret > 0 and Filename /= " ";
  
   
   
   

end operations;
