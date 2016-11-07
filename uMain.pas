unit uMain;

interface

uses
  System.IOUtils, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,MyPaintBox,
  FMX.StdCtrls, FMX.Colors, FMX.ExtCtrls, FMX.ListBox, FMX.ListView.Types,
  FMX.ListView, FMX.Layouts, FMX.Objects, FMX.Edit, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.EditBox,
  FMX.SpinBox, FMX.Controls.Presentation, FMX.MultiView;

type
  TMainForm = class(TForm)
    tbdraw: TToolBar;
    cbfg: TComboColorBox;
    cbbg: TComboColorBox;
    lbdraw: TListBox;
    idrawnone: TListBoxItem;
    idrawline: TListBoxItem;
    idrawrectangle: TListBoxItem;
    idrawellipse: TListBoxItem;
    idrawfill: TListBoxItem;
    imgf: TImage;
    idrawpen: TListBoxItem;
    sbthickmess: TSpinBox;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    chknofill: TCheckBox;
    idrawbitmap: TListBoxItem;
    actionall: TActionList;
    sbimgselect: TSpeedButton;
    actloadbmpstamp: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbbgChange(Sender: TObject);
    procedure cbfgChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure imgfClick(Sender: TObject);
    procedure lbdrawChange(Sender: TObject);
    procedure sbthickmessChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure chknofillChange(Sender: TObject);
    procedure sbimgselectClick(Sender: TObject);
  private
    { Private declarations }
    fdrawbox:TMyPaintBox;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses frmSelectBmp;
{$R *.fmx}

procedure TMainForm.cbbgChange(Sender: TObject);
begin
  fdrawbox.BackgroundColor:=cbbg.Color;
end;

procedure TMainForm.cbfgChange(Sender: TObject);
begin
  fdrawbox.ForegroundColor:=cbfg.Color;
end;

procedure TMainForm.chknofillChange(Sender: TObject);
begin
  fdrawbox.NoFill:=chknofill.IsChecked;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  fdrawbox:=TMyPaintBox.Create(self);
  fdrawbox.ForegroundColor:=cbfg.Color;
  fdrawbox.BackgroundColor:=cbbg.Color;
  imgf.Bitmap:=lbdraw.Selected.ItemData.Bitmap;
  lbdraw.BringToFront;
  tbdraw.BringToFront;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if assigned(fdrawbox) then
    fdrawbox.Free;
end;



procedure TMainForm.imgfClick(Sender: TObject);
begin
  lbdraw.Visible:=not lbdraw.Visible;

end;

procedure TMainForm.lbdrawChange(Sender: TObject);
begin
  imgf.Bitmap:=lbdraw.Selected.ItemData.Bitmap;
  lbdraw.Visible:=false;
  if assigned(fdrawbox) then
  begin
    fdrawbox.FuncDraw:=TFunctionDraw(lbdraw.ItemIndex);
  end;
end;

procedure TMainForm.sbimgselectClick(Sender: TObject);
begin
{$IF Defined(ANDROID)}
    SelectBmpfrm.ShowModal( procedure(ModalResult: TModalResult)
    begin
      if ModalResult = mrOK then
    if assigned(SelectBmpfrm.fbmp) then
    begin
      fdrawbox.BitmapStamp:=SelectBmpfrm.fbmp;
    end;
    end);
{$ELSE}
  if SelectBmpfrm.ShowModal=mrOK then
    if assigned(SelectBmpfrm.fbmp) then
    begin
      fdrawbox.BitmapStamp:=SelectBmpfrm.fbmp;
    end;
{$ENDIF}


end;

procedure TMainForm.sbthickmessChange(Sender: TObject);
begin
  if assigned(fdrawbox) then
    fdrawbox.Thickness:=sbthickmess.Value;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
sfile:string;
fs:TFileStream;
begin
sfile:=InputBox('Save File','Input File Name','sample.jpg');
if (sfile<>'') then
begin
sfile:=System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath(),sfile);
  try
    fs:=TFileStream.Create(sfile,fmCreate);
    fdrawbox.SaveToJPEGStream(fs);
    fs.Free;
  finally
  end;

end;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  CloseModal;
end;

end.
