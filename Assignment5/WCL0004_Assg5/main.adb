with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, Binary;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, Binary;

procedure Main is

   My_Array: BINARY_ARRAY;
   IntResult1: Integer;
   Another_Array: BINARY_ARRAY;
   Array3: BINARY_ARRAY;
   Result2: Integer;
   Result3: Integer;
   Array4: BINARY_ARRAY;
   Result4: Integer;

begin
   My_Array := (Create_16BitBinaryArray);
   Put_Line("Printing Random Array My_Array");
   Print_Bin_Arr(My_Array);
   New_Line(1);

   Put_Line("Printing Integer value of My_Array");
   IntResult1 := Bin_To_Int(My_Array);
   Put_Line(IntResult1'Image);
   New_Line(1);

   Put_Line("Printing Array created from Int_To_Bin function: Int_To_Bin(55);");
   Another_Array := Int_To_Bin(55);
   Print_Bin_Arr(Another_Array);
   New_Line(1);

   Put_Line("Printing value of My_Array + Another_Array, first + overload");
   Array3 := My_Array + Another_Array;
   Put("Int value of My_Array: ");
   IntResult1 := Bin_To_Int(My_Array);
   Put_Line(IntResult1'Image);
   Put("Int value of Another_Array: ");
   Result2 := Bin_To_Int(Another_Array);
   Put_Line(Result2'Image);
   Put("Int value of Array3: ");
   Result3 := Bin_To_Int(Array3);
   Put_Line(Result3'Image);
   Put("Binary value of Array3: ");
   Print_Bin_Arr(Array3);
   New_Line(1);

   Put_Line("Printing value of My_Array - Another_Array, first - overload");
   Array4 := My_Array - Another_Array;
   Put("Int value of My_Array: ");
   IntResult1 := Bin_To_Int(My_Array);
   Put_Line(IntResult1'Image);
   Put("Int value of Another_Array: ");
   Result2 := Bin_To_Int(Another_Array);
   Put_Line(Result2'Image);
   Put("Int value of Array4 (Note, this value will be incorrect if first number is smaller than second): ");
   Result4 := Bin_To_Int(Array4);
   Put_Line(Result4'Image);
   Put("Binary value of Array4: ");
   Print_Bin_Arr(Array4);
   New_Line(1);

   Put_Line("Reversing and printing Array4");
   Reverse_Bin_Arr(Array4);
   New_Line(1);

end Main;
