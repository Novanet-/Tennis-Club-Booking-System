unit DisplayFormattedBookings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmDisplayFormattedBookings = class(TForm)
    edtFormattedBookings: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDisplayFormattedBookings: TfrmDisplayFormattedBookings;

implementation    //A window to display the web formatted booking list

{$R *.dfm}

end.
