         --Assignment 5
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

package body binary is 

   --Creates a random Binary_Array
   function Create_16BitBinaryArray return BINARY_ARRAY is 

   package Random_Binary is new Ada.Numerics.Discrete_Random (BINARY_NUMBER);
   use Random_Binary;
   G: Generator;
   Array1: BINARY_ARRAY;
   
   begin
      Reset(G);
      for i in Array1'range loop 
         Array1(i) := Random(G);
         
      end loop;   
      
      Put_Line("New Binary Array Generated");
      return Array1;

   end Create_16BitBinaryArray;
   
   --Prints a Binary Array
   procedure Print_Bin_Arr(Array_In : BINARY_ARRAY) is 
   begin
      for i in Array_In'range loop 
         Put(String(Integer'Image(Integer(Array_In(i)))));         
      end loop; 
      New_Line;
   end Print_Bin_Arr;

   --Reverses a Binary Array   
   procedure Reverse_Bin_Arr(Array_In : BINARY_ARRAY) is 
   begin
      for i in reverse Array_In'range loop 
         Put(String(Integer'Image(Integer(Array_In(i)))));         
      end loop; 
      New_Line;
   end Reverse_Bin_Arr;
   
   --Turn a Binary Array into an Int
   function Bin_To_Int(Array_In : BINARY_ARRAY) return Integer is
      Multiplier: Integer := 1;
      Result: Integer := 0;

   begin
      for i in reverse Array_In'range loop  
         Result := Result + Integer(Array_In(i)) * Multiplier;
         Multiplier := Multiplier * 2;
      end loop;
      return Result;
   end Bin_To_Int;
      
   --Turn an Int into a Binary Array
   function Int_To_Bin(Int_In : Integer) return BINARY_ARRAY is
      Quotient: Integer := Int_In;
      Remainder: Integer;
      Result_Bin_Array: BINARY_ARRAY;

   begin
      for i in reverse Result_Bin_Array'range loop  
         if Quotient = 0 then
            Remainder := 0;
         else
            Remainder := Quotient mod 2;
            Quotient := Quotient / 2;
         end if;
         Result_Bin_Array(i) := BINARY_NUMBER(Remainder);
      end loop;
      return Result_Bin_Array;
   end Int_To_Bin;   

   
   --Overloads the + operator for BINARY_ARRAY
   function "+"(Left_Array: BINARY_ARRAY; Right_Array: BINARY_ARRAY) return BINARY_ARRAY is
      Carry: Integer := 0;
      Result_Array: BINARY_ARRAY;
   begin
      for i in reverse Left_Array'range loop
         if Carry <= 0 then
            
            if Left_Array(i) = 1 and Right_Array(i) = 1 then 
               Result_Array(i) := BINARY_NUMBER(0);
               Carry := Carry + 1;
            elsif Left_Array(i) = 0 and Right_Array(i) = 0 then  
               Result_Array(i) := BINARY_NUMBER(0);
            else
               Result_Array(i) := BINARY_NUMBER(1);
            end if;
         
         
         elsif Carry > 0 then
            if Left_Array(i) = 1 and Right_Array(i) = 1 then 
               Result_Array(i) := BINARY_NUMBER(1);
            elsif Left_Array(i) = 0 and Right_Array(i) = 0 then  
               Result_Array(i) := BINARY_NUMBER(1);
               Carry := Carry - 1;
            else
               Result_Array(i) := BINARY_NUMBER(0);
            end if;
         end if;
            
      end loop;
      
      return Result_Array;
         
   end "+";
   
   
   --Overloads the - operator for BINARY_ARRAY
   function "-"(Left_Array: BINARY_ARRAY; Right_Array: BINARY_ARRAY) return BINARY_ARRAY is
      Borrow: Integer := 0;
      Result_Array: BINARY_ARRAY;
   begin
      for i in reverse Left_Array'range loop
         if Borrow <= 0 then
            
            if Left_Array(i) = 0 and Right_Array(i) = 1 then 
               Result_Array(i) := BINARY_NUMBER(1);
               Borrow := Borrow + 1;
            elsif Left_Array(i) = 1 and Right_Array(i) = 0 then  
               Result_Array(i) := BINARY_NUMBER(1);
            else
               Result_Array(i) := BINARY_NUMBER(0);
            end if;
         
         
         elsif Borrow > 0 then
            if Left_Array(i) = 1 and Right_Array(i) = 1 then 
               Result_Array(i) := BINARY_NUMBER(1);
            elsif Left_Array(i) = 0 and Right_Array(i) = 0 then  
               Result_Array(i) := BINARY_NUMBER(1);
            elsif Left_Array(i) = 1 and Right_Array(i) = 0 then  
               Result_Array(i) := BINARY_NUMBER(0);
               Borrow := Borrow - 1;               
            else
               Result_Array(i) := BINARY_NUMBER(0);

            end if;
         end if;
            
      end loop;
      
      return Result_Array;
         
   end "-";
      
end Binary;
