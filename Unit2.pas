unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TAbout = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    procedure LimeTree(x, y: Integer; a: Real; l: Integer);
    procedure BlackTree(x, y : Integer; l, u : real);
    procedure BlackPap(x, y : Integer; l, u : real);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

{$R *.dfm}

procedure TAbout.Button1Click(Sender: TObject);
begin
    //Требуется Очистка
    PaintBox1.Canvas.Brush.Style:=bsclear;
    PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);
    PaintBox1.Canvas.Brush.Style:=bssolid;
    case Random(3) of
    0: LimeTree(300, 550, 3*pi/2, 200);
    1: BlackTree(300, 460, 200, pi/2);
    2: BlackPap(320, 460, 140, pi/2);
    end;
end;

procedure TAbout.LimeTree(x, y: Integer; a: Real; l: Integer);
var
	x1, y1: Integer;
	p, s  : Integer;
	i     : Integer;
	a1    : Real;
begin
	if l < 8 then
		exit;
	x1 := Round(x + l*cos(a));
	y1 := Round(y + l*sin(a));
	if l > 100 then
		p := 100
	else
		p := l;
	if p < 40 then
	begin
	//Генерация листьев
		if Random > 0.5 then
      paintbox1.Canvas.Pen.Color:=clLime
    else
      paintbox1.Canvas.Pen.Color:=clGreen;
    for i := 0 to 3 do begin
      paintbox1.Canvas.MoveTo(x+i,y);
      paintbox1.Canvas.Lineto(x1,y1);
    end;
  end
	else
	begin
		//Генерация веток
    paintbox1.Canvas.Pen.Color:=clMaroon;
		for i := 0 to (p div 6) do begin
      paintbox1.Canvas.MoveTo(x + i - (p div 12), y);
			paintbox1.Canvas.Lineto(x1, y1);
    end;
	end;
	//Следующие ветки
 	for i := 0 to 9 - Random(9) do
	begin
		s := Random(l - l div 6) + (l div 6);
		a1 := a + 1.6 * (0.5 - Random); //Угол наклона веток
		x1 := Round(x + s * cos(a));
		y1 := Round(y + s * sin(a));
		LimeTree(x1, y1, a1, p - 5 - Random(30)); //Чем меньше вычетаем, тем пышнее дерево
	end;
end;

procedure TAbout.BlackTree(x, y : Integer; l, u : real);
const max = 3;
begin
    if l > max then
    begin
        l := l * 0.7;
        PaintBox1.Canvas.Pen.Color:=clBlack;
        paintbox1.Canvas.MoveTo(x, y);
        paintbox1.Canvas.LineTo(Round(x + l * cos(u)), Round(y - l * sin(u)));
        x := Round(x + l * cos(u));
        y := Round(y - l * sin(u));
        BlackTree(x, y, l, u + pi / 4); {Угол поворота 1}
        BlackTree(x, y, l, u - pi / 6); {Угол поворота 2}
    end;
end;

procedure TAbout.BlackPap(x, y : Integer; l, u : real);
const min = 3;
begin
    if l > min then
    begin
        Paintbox1.Canvas.MoveTo(x, y);
        Paintbox1.Canvas.LineTo(Round(x + l * cos(u)), Round(y - l * sin(u)));
        x := Round(x + l * cos(u));
        y := Round(y - l * sin(u));
        BlackPap(x, y, l*0.4, u - 14*pi/30);
        BlackPap(x, y, l*0.4, u + 14*pi/30);
        BlackPap(x, y, l*0.7, u + pi/30);
    end;
end;

procedure TAbout.FormCreate(Sender: TObject);
begin
  //LimeTree(320, 580, 3*pi/2, 200);
end;





end.
