unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Clipbrd, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Menus;

type
  TPassGen = class(TForm)
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
    procedure ResultReplace(source: string; position: byte; symb: string;
                                 var aLatLower: byte; var aLatUpper: byte; var aSpecial: byte; var aNumber: byte; var aRusLower: byte; var aRusUpper: byte);


  private

  public

  end;

const
  LATLOWER = 'abcdefghijklmnopqrstuvwxyz';
  LATUPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  NUMBER = '1234567890';
  SPECIAl = '!@#$%^&*()"''\\/|~`?<>,.;:{}[]';
  RUSLOWER = 'јЅ¬√ƒ≈∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏ№џЁёя';
  RUSUPPER = 'абвгдежзийклмнопрстуфхцчшщъьыэю€';


var
  PassGen: TPassGen;
  latLower_, latUpper_, number_, special_, rusLower_, rusUpper_: boolean;
  cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper: byte;
  res, hash: string;



implementation

{$R *.dfm}

uses Unit2;

procedure TPassGen.CheckBox1Click(Sender: TObject);

begin
  if CheckBox1.Checked then latLower_:= true
  else latLower_:= false;

end;

procedure TPassGen.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then latUpper_:= true
  else latUpper_:= false;
end;

procedure TPassGen.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then special_:= true
  else special_:= false;
end;

procedure TPassGen.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then number_:= true
  else number_:= false;
end;

procedure TPassGen.CheckBox5Click(Sender: TObject);
begin
  CheckBox5.Checked:=true;
end;

procedure TPassGen.CheckBox6Click(Sender: TObject);
begin
   if CheckBox6.Checked then rusLower_:= true
   else rusLower_:= false;
end;

procedure TPassGen.CheckBox7Click(Sender: TObject);
begin
    if CheckBox7.Checked then rusUpper_:= true
    else rusUpper_:= false;
end;

procedure TPassGen.Edit1Change(Sender: TObject);
begin
   HashGen(edit1.Text);
end;

procedure TPassGen.Edit1Click(Sender: TObject);
begin
  edit1.SelectAll;
end;

procedure TPassGen.Image1Click(Sender: TObject);
begin
  Clipboard.AsText := Edit1.Text;
  CheckBox5.Visible:= true;
  Image1.Visible:=false;
  Image3.Visible:=true;
end;

procedure TPassGen.Image2Click(Sender: TObject);
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

function TPassGen.PwdGen(aLength: byte): string;
var _cLatLower, _cLatUpper, _cSpecial, _cNumber, _cRusLower, _cRusUpper: boolean;
begin
  randomize;
  res:= '';
  cLatLower:= 0; _cLatLower:= false;
  cLatUpper:= 0; _cLatUpper:= false;
  cSpecial:= 0; _cSpecial:= false;
  cNumber:= 0; _cNumber:= false;
  cRusLower:= 0; _cRusLower:= false;
  cRusUpper:= 0; _cRusUpper:= false;
  while (length(res) < aLength) do begin
    case (Random(6)+1) of
    1: if LatLower_ then begin
          res:=res + LATLOWER[random(length(LATLOWER))+1];
          inc(cLatLower);
          _cLatLower:= true;
       end;
    2: if LatUpper_ then begin
          res:= res + LATUPPER[random(length(LATUPPER)) + 1];
          inc(cLatUpper);
          _cLatUpper:= true;
       end;
    3: if Special_ then begin
          res:= res + SPECIAL[random(length(SPECIAL)) + 1];
          inc(cSpecial);
          _cSpecial:= true;
       end;
    4: if Number_ then begin
          res:= res + NUMBER[random(length(NUMBER)) + 1];
          inc(cNumber);
          _cNumber:= true;
       end;
    5: if RusLower_ then begin
          res:= res + RUSLOWER[random(length(RUSLOWER)) + 1];
          inc(cRusLower);
          _cRusLower:= true;
       end;
    6: if RusUpper_ then begin
          res:= res + RUSUPPER[random(length(RUSUPPER)) + 1];
          inc(cRusUpper);
          _cRusUpper:= true;
       end;
    end;
  end;
  repeat
    if (cLatLower = 0) and (LatLower_ = true) then begin
      ResultReplace(res, random(length(res)+1), LATLOWER[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cLatLower:=true;
      inc(cLatLower);
    end;
    if (cLatUpper = 0) and (LatUpper_ = true) then begin
      ResultReplace(res, random(length(res)+1), LATUPPER[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cLatUpper:=true;
      inc(cLatUpper);
    end;
    if (cSpecial = 0) and (Special_ = true) then begin
      ResultReplace(res, random(length(res)+1), SPECIAL[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cSpecial:=true;
      inc(cSpecial);
    end;
    if (cNumber = 0) and (Number_ = true) then begin
      ResultReplace(res, random(length(res)+1), NUMBER[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cNumber:=true;
      inc(cNumber);
    end;
    if (cRusLower = 0) and (RusLower_ = true) then begin
      ResultReplace(res, random(length(res)+1), RUSLOWER[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cRusLower:=true;
      inc(cRusLower);
    end;
    if (cRusUpper = 0) and (RusUpper_ = true) then begin
      ResultReplace(res, random(length(res)+1), RUSUPPER[random(length(res)+1)],
                    cLatLower, cLatUpper, cSpecial, cNumber, cRusLower, cRusUpper);
      _cRusUpper:=true;
      inc(cRusUpper);
    end;
  until (LatLower_ = _cLatLower) and (LatUpper_ = _cLatUpper) and (Special_ = _cSpecial)
         and (Number_ = _cNumber) and (RusLower_ = _cRusLower) and (RusUpper_ = _cRusUpper);
  PwdGen:= res;
end;

procedure TPassGen.ResultReplace(source: string; position: byte; symb: string;
                                 var aLatLower: byte; var aLatUpper: byte; var aSpecial: byte; var aNumber: byte; var aRusLower: byte; var aRusUpper: byte);

var charCheck: string;
begin
  charcheck:= source[position];
  if pos(charCheck, LATLOWER) <> 0 then dec(aLatLower)
  else if pos(charCheck, LATUPPER) <> 0 then dec(aLatUpper)
  else if pos(charCheck, SPECIAL) <> 0 then dec(aSpecial)
  else if pos(charCheck, NUMBER) <> 0 then dec(aNumber)
  else if pos(charCheck, RUSLOWER) <> 0 then dec(aRusLower)
  else if pos(charCheck, RUSUPPER) <> 0 then dec(aRusUpper);
  Delete(source, position, 1);
  Insert(symb, source, position);
end;

procedure TPassGen.About1Click(Sender: TObject);
begin
 about.show;
end;

procedure TPassGen.Button1Click(Sender: TObject);
var i: integer;
  temp: string;
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
         temp:=inttostr(clatlower)+inttostr(cLatUpper)+inttostr(cSpecial)+inttostr(cNumber)+inttostr(cRusLower)+inttostr(cRusUpper);
         Memo1.Lines.Add(temp);
         HashGen(res);
      end;
    end;
  end
  else ShowMessage('¬ыберите хот€ бы один параметр');
end;

procedure TPassGen.HashGen(source: string);
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
  {неработаюищй чекер
  неправильный счет кол-ва символов определенного типа
  if charCheck in LATUPPER then dec(aLatUpper) - Operator not applicable to this operand type}
end.