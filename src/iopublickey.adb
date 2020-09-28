package body IOPublicKey 
is

   --write file with output stream 
   procedure WritePK (A_array : Pub_Array; B_array : Pub_Array)
   is
      F : Ada.Streams.Stream_IO.File_Type;
      S : Ada.Streams.Stream_IO.Stream_Access;
   begin
      Create (F, Out_File, PKA_FILE);
      S := Stream (F);

      for I in customtyps.Index loop
         Pub'Write (S, A_array(I));
      end loop;
      Close(F);

      Create (F, Out_File, PKB_FILE);
      S := Stream (F);

      for I in customtyps.Index loop
         Pub'Write (S, B_array(I));
      end loop;
      Close(F);

   end WritePK;   

   -- read file with aoutput stream 
   function ReadPK (filename : String) return Pub_Array is
      Temp : Pub_Array := (others => 0);
      F : Ada.Streams.Stream_IO.File_Type;
      S : Ada.Streams.Stream_IO.Stream_Access;
   begin
      Open (F, IN_File, filename);
      S := Stream (F);

      for I in customtyps.Index loop
         Pub'Read(S, Temp(I));
      end loop;

      Close (F);
      return Temp;
      
   end ReadPK;
   

end IOPublicKey;
