unit SearchBooking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmSearchBooking = class(TForm)
    shpHeader: TShape;
    shpBody: TShape;
    btnHome: TBitBtn;
    lblSearchBooking: TLabel;
    procedure btnHomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchBooking: TfrmSearchBooking;

implementation

uses Globals, MainMenu;

{$R *.dfm}

procedure TfrmSearchBooking.btnHomeClick(Sender: TObject);
begin
  frmSearchBooking.hide;
  frmMainMenu.show;
end;

end.
