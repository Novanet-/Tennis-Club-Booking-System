library GlobalSubroutines;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes, Globals, ShareMem;

{$R *.res}
procedure InsertionSortTBookingDate(var List: TBookingArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TBooking;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (List[Pointer].Date > CurrentValue.Date) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTBookingBookingID(var List: TBookingArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TBooking;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (StrToInt(List[Pointer].BookingID) > StrToInt(CurrentValue.BookingID)) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTBookingCourtNo(var List: TBookingArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TBooking;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (List[Pointer].CourtNo > CurrentValue.CourtNo) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTBookingEventType(var List: TBookingArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TBooking;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (List[Pointer].EventType > CurrentValue.EventType) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;


procedure InsertionSortTSubmissionBookingID(var List: TSubmissionArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TSubmission;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (StrToInt(List[Pointer].BookingID) > StrToInt(CurrentValue.BookingID)) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTSubmissionMemberID(var List: TSubmissionArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TSubmission;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (StrToInt(List[Pointer].MemberID) > StrToInt(CurrentValue.MemberID)) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTMemberMemberID(var List: TMemberArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TMember;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (StrToInt(List[Pointer].MemberID) > StrToInt(CurrentValue.MemberID)) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure InsertionSortTMemberSurname(var List: TMemberArray); stdcall;
var
  CurrentPointer, Pointer: integer;
  CurrentValue: TMember;
begin
  //CurrentPointer starts at 2
  for CurrentPointer := (Low(List)+1) to High(List) do
  begin
      //Get next value from unsorted array
      CurrentValue:= List[CurrentPointer];
      //Find the end of sorted array
      Pointer:= CurrentPointer-1;
      //Go through sorted array until you find where to insert
      //Or you reach the bottom
      while (Pointer >= 0) and (List[Pointer].Surname > CurrentValue.Surname) do
      begin
          //Move up the sorted array above the insertion point
          List[Pointer+1]:= List[Pointer];
          Pointer:= Pointer-1;
      end;
      //Insert
      List[Pointer+1]:= CurrentValue;
  end;
end;

procedure BinarySearchTBookingBookingID(var List: TBookingArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= false;
ItemSearchFailed:= false;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].BookingID = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if StrToInt(List[Midpoint].BookingID) > StrToInt(ItemSought) then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTBookingDate(var List: TBookingArray; var ItemSought: TDateTime; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
Itemfound:= false;
ItemSearchFailed:= false;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if Trunc(List[Midpoint].Date) = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
			    if List[Midpoint].Date > ItemSought then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTBookingCourtNo(var List: TBookingArray; var ItemSought: Byte; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= false;
ItemSearchFailed:= false;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].CourtNo = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if List[Midpoint].CourtNo > ItemSought then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTBookingEventType(var List: TBookingArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= false;
ItemSearchFailed:= false;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].EventType = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if List[Midpoint].EventType > ItemSought then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTSubmissionBookingID(var List: TSubmissionArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= false;
ItemSearchFailed:= false;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].BookingID = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if StrToInt(List[Midpoint].BookingID) > StrToInt(ItemSought) then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTSubmissionMemberID(var List: TSubmissionArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= false;
ItemSearchFailed:= False;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].MemberId = ItemSought then
  begin
     ItemFound:= True;
     ItemLocation:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if StrToInt(List[Midpoint].MemberId) > StrToInt(ItemSought) then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;

procedure BinarySearchTMemberMemberID(var List: TMemberArray; var ItemSought: ShortString; var ItemSoughtPosition: integer; var ItemFound: boolean); stdcall;
var
   ItemSearchFailed: boolean;
   Midpoint, FirstItemPosition, LastItemPosition: integer;
begin
ItemFound:= False;
ItemSearchFailed:= False;
FirstItemPosition:= Low(List);
LastItemPosition:= High(List);
repeat
	MidPoint:= (FirstItemPosition+LastItemPosition) DIV 2;
	if List[Midpoint].MemberID = ItemSought then
  begin
     ItemFound:= True;
     ItemSoughtPosition:= Midpoint
  end
	else
      if FirstItemPosition >= LastItemPosition then
          ItemSearchFailed:= True
      else
      begin
          //If the item sought is more than the mid point, make the elements above the midpoint the new list, otherwise elements below the midpoint are the new list
			    if StrToInt(List[Midpoint].MemberID) > StrtoInt(ItemSought) then
              LastItemPosition:= Midpoint -1
          else
              FirstItemPosition:= Midpoint+1
      end;
until (ItemFound OR ItemSearchFailed);
end;


exports InsertionSortTBookingDate,
        InsertionSortTBookingBookingID,
        InsertionSortTBookingCourtNo,
        InsertionSortTBookingEventType,
        InsertionSortTSubmissionBookingID,
        InsertionSortTSubmissionMemberID,
        InsertionSortTMemberMemberID,
        InsertionSortTMemberSurname,
        BinarySearchTBookingBookingID,
        BinarySearchTBookingDate,
        BinarySearchTBookingCourtNo,
        BinarySearchTBookingEventType,
        BinarySearchTSubmissionBookingID,
        BinarySearchTSubmissionMemberID,
        BinarySearchTMemberMemberID;


begin
end.
