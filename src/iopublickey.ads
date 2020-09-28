with customtyps; use customtyps;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
package IOPublicKey 
with SPARK_Mode => On
is
   -- Reads from a given File a Public key and returns the array
   function ReadPK (filename : String) return Pub_Array
   with 
       Global => null,
       Pre => filename /= " ",
       Post => (if (filename = PKB_FILE) then ((for all I in Pub_Array'Range => (ReadPK'Result(I) = ReadPK'Result(I) mod customtyps.q) and (ReadPK'Result(I) /= 0))));
    
   -- writes a Public Key could be combinded in one
   procedure WritePK (A_array : Pub_Array; B_array : Pub_Array)
   with 
       Global => null,
       Pre => A_array'Length = customtyps.Index'Last and B_array'Length = customtyps.Index'Last;
   
   
end IOPublicKey;
