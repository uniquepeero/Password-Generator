unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Clipbrd, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Menus;

type
  TPasswordGenerator = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    CheckBox5: TCheckBox;
    Label3: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Edit2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox8: TCheckBox;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    SpinEdit2: TSpinEdit;
    Memo1: TMemo;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    About1: TMenuItem;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure HashGen(source: string);
    function PwdGen(aLength: byte): string;
    procedure Edit1Change(Sender: TObject);
    procedure About1Click(Sender: TObject);

  private

  public

  end;

const
  LATLOWER = 'abcdefghijklmnopqrstuvwxyz';
  LATUPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  NUMBER = '1234567890';
  SPECIAl = '!@#$%^&*()"''\/|~`?<>,.;{}[]';
  RUSLOWER = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÜÛÝÞß';
  RUSUPPER = 'àáâãäåæçèéêëìíîïðñòóôõö÷øùúüûýþÿ';

var
  PasswordGenerator: TPasswordGenerator;
  latLower_, latUpper_, number_, special_, rusLower_, rusUpper_: boolean;
  res, hash: string;

implementation

{$R *.dfm}

uses Unit2;

procedure TPasswordGenerator.CheckBox1Click(Sender: TObject);

begin
  if CheckBox1.Checked then latLower_:= true
  else latLower_:= false;

end;

procedure TPasswordGenerator.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then latUpper_:= true
  else latUpper_:= false;
end;

procedure TPasswordGenerator.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then special_:= true
  else special_:= false;
end;

procedure TPasswordGenerator.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then number_:= true
  else number_:= false;
end;

procedure TPasswordGenerator.CheckBox5Click(Sender: TObject);
begin
  CheckBox5.Checked:=true;
end;

procedure TPasswordGenerator.CheckBox6Click(Sender: TObject);
begin
   if CheckBox6.Checked then rusLower_:= true
   else rusLower_:= false;
end;

procedure TPasswordGenerator.CheckBox7Click(Sender: TObject);
begin
    if CheckBox7.Checked then rusUpper_:= true
    else rusUpper_:= false;
end;

procedure TPasswordGenerator.Edit1Change(Sender: TObject);
begin
   HashGen(edit1.Text);
end;

procedure TPasswordGenerator.Edit1Click(Sender: TObject);
begin
  edit1.SelectAll;
end;

procedure TPasswordGenerator.Image1Click(Sender: TObject);
begin
  Clipboard.AsText := Edit1.Text;
  CheckBox5.Visible:= true;
  Image1.Visible:=false;
  Image3.Visible:=true;
end;

procedure TPasswordGenerator.Image2Click(Sender: TObject);
var
  f: textfile;
begin
  CheckBox8.Visible:= true;
  Image4.Visible:=true;
  Image2.Visible:=false;
  assignfile(f, 'pass.txt');
  if SpinEdit2.Value = 1 then begin
    rewrite(f);
    writeln(f, res);
    writeln(f, hash);
  end
  else begin
    rewrite(f);
    writeln(f, memo1.Text);
  end;
  closefile(f);
end;

function TPasswordGenerator.PwdGen(aLength: byte): string;
begin
  randomize;
  res:= '';
  while (length(res) < aLength) do begin
    case (Random(6)+1) of
    1: if LatLower_ then
          res:=res + LATLOWER[random(length(LATLOWER))+1];

    2: if LatUpper_ then
          res:= res + LATUPPER[random(length(LATUPPER)) + 1];

    3: if Special_ then
          res:= res + SPECIAL[random(length(SPECIAL)) + 1];

    4: if Number_ then
          res:= res + NUMBER[random(length(NUMBER)) + 1];

    5: if RusLower_ then
          res:= res + RUSLOWER[random(length(RUSLOWER)) + 1];

    6: if RusUpper_ then
          res:= res + RUSUPPER[random(length(RUSUPPER)) + 1];

    end;
  end;
  PwdGen:= res;
end;

procedure TPasswordGenerator.About1Click(Sender: TObject);
begin
 about.show;
end;

procedure TPasswordGenerator.Button1Click(Sender: TObject);
var i: integer;
begin
  Memo1.Text:= '';
  CheckBox5.Visible:=false;
  Image1.Visible:=true;
  Image2.Visible:=true;
  Image3.Visible:=false;
  Image4.Visible:=false;
  CheckBox8.Visible:= false;
  if LatLower_ or LatUpper_ or Special_ or Number_ or RusLower_ or RusUpper_ then begin
    if SpinEdit2.Value = 1 then begin
      Edit1.Text:=PwdGen(SpinEdit1.Value);
      HashGen(res)
    end
    else begin
      edit1.Text:='';
      for i := 1 to SpinEdit2.Value do begin
         Memo1.Lines.Add(PwdGen(SpinEdit1.Value));
         HashGen(res);
      end;
    end;
  end
  else ShowMessage('Âûáåðèòå õîòÿ áû îäèí ïàðàìåòð');
end;

procedure TPasswordGenerator.HashGen(source: string);
var
   i, lngth: integer;
begin
   hash:= '';
   lngth:= length(source);
   if lngth = 1 then hash:= IntToStr(ord(source[1]));
   if lngth mod 2 = 0 then begin
      for I := 0 to lngth-2 do
        hash:=hash + (IntToStr(ord(source[i]) xor ord(source[i+1])));
   end
   else begin
      for I := 0 to lngth - 3 do
        hash:= hash + (IntToStr(ord(source[i]) xor ord(source[i+1])));
      hash:= hash + (IntToStr(ord(source[lngth-1]) xor ord(source[lngth-2])));
   end;
   edit2.Text:=hash;
end;

begin
  latLower_:= true;
  latUpper_:= true;
  special_:= true;
  number_:= true;
  rusLower_:= false;
  rusUpper_:= false;
end.
