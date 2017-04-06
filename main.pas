(*
 * Project: lab7
 * User: alexa
 * Date: 06.04.2017
 *)
program FracSierp2;
uses wincrt, graph;

var
    gd, gm,VisualPage : Integer;
    iter:integer;
    x1,x2,x3,y1,y2,y3,dx2,dx3,dy2,dy3:Real;
    sauser:Pointer;
procedure tr(x1, y1, x2, y2, x3, y3: Real);
begin
    Line(Round(x1), Round(y1), Round(x2), Round(y2));
    Line(Round(x2), Round(y2), Round(x3), Round(y3));
    Line(Round(x3), Round(y3), Round(x1), Round(y1));
end;

procedure draw(x1, y1, x2, y2, x3, y3: Real; n: Integer);
var
    x1n, y1n, x2n, y2n, x3n, y3n : Real;
begin
    if  n > 0  then
    begin
        x1n := (x1 + x2) / 2;
        y1n := (y1 + y2) / 2;
        x2n := (x2 + x3) / 2;
        y2n := (y2 + y3) / 2;
        x3n := (x3 + x1) / 2;
        y3n := (y3 + y1) / 2;
        tr(x1n, y1n, x2n, y2n, x3n, y3n);

        draw(x1, y1, x1n, y1n, x3n, y3n, n - 1);
        draw(x2, y2, x1n, y1n, x2n, y2n, n - 1);
        draw(x3, y3, x2n, y2n, x3n, y3n, n - 1);
    end;
end;

procedure key_pres();
var
key:char;
begin
    SetVisualPage(1- (VisualPage mod 2));
{установка номера видимой видеостраницы}
    VisualPage := VisualPage+1; {листание видеостраниц}
    SetActivePage(1 - (VisualPage mod 2));
{установка номера невидимой (активной) видеостраницы,}
{используемой для построения смещенного изображения }
    ClearDevice; {очистка графического экрана}
    tr(x1,y1,x2,y2,x3,y3);
    draw(x1,y1,x2,y2,x3,y3,iter);
key:=readkey();
    Case key Of
    #27: Halt();
    'a':
    begin
        x1:=x1-20;
        x2:=x2-20;
        x3:=x3-20;
    end;
    'd':
    begin
        x1:=x1+20;
        x2:=x2+20;
        x3:=x3+20;
    end;
    's':
    begin
        y1:=y1+20;
        y2:=y2+20;
        y3:=y3+20;
    end;
    'w':
    begin
        y1:=y1-20;
        y2:=y2-20;
        y3:=y3-20;
    end;
    'z':
    begin
        y1:=y1/1.1;
        y2:=y2/1.1;
        y3:=y3/1.1;
        x1:=x1/1.1;
        x2:=x2/1.1;
        x3:=x3/1.1;
        if iter > 1 then
            iter:=iter-1;
    end;
    'x':
    begin
        y1:=y1*1.1;
        y2:=y2*1.1;
        y3:=y3*1.1;
        x1:=x1*1.1;
        x2:=x2*1.1;
        x3:=x3*1.1;
        if iter < 7 then
            iter:=iter+1;
    end;
    End;
end;

begin
    gd := Detect;
    InitGraph(gd, gm, '');
    iter:=4;
    VisualPage := 1;
    x1:=320;y1:=20;
    x2:=700;y2:=470;
    x3:=40;y3:=470;
    tr(x1,y1,x2,y2,x3,y3);
    draw(x1,y1,x2,y2,x3,y3,iter);
    while true do
        key_pres();
    CloseGraph;
end.