--ads File for binary package, used to Create and manipulate Binary number and array types

package Binary is

   type BINARY_NUMBER is range 0..1;
   type BINARY_ARRAY is array(0..15) of BINARY_NUMBER;
   function Create_16BitBinaryArray return BINARY_ARRAY;
   procedure Print_Bin_Arr(Array_In : BINARY_ARRAY);
   function Bin_To_Int(Array_In : BINARY_ARRAY) return Integer;
   function Int_To_Bin(Int_In : Integer) return BINARY_ARRAY;
   procedure Reverse_Bin_Arr(Array_In : BINARY_ARRAY);
   function "+"(Left_Array: BINARY_ARRAY; Right_Array: BINARY_ARRAY) return BINARY_ARRAY;
   function "-"(Left_Array: BINARY_ARRAY; Right_Array: BINARY_ARRAY) return BINARY_ARRAY;

end Binary;
