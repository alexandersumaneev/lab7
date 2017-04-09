(*
 * Project: lab7
 * User: alexa
 * Date: 06.04.2017
 *)
program fractal;
uses wincrt, graph;

var
    gd, gm,visualpage : Integer;
    iter:integer;
    kp:Boolean;
    x1,x2,x3,y1,y2,y3,dx2,dx3,dy2,dy3:Real;
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
    setvisualpage(1- (visualpage mod 2));
    visualpage := visualpage+1;
    setactivepage(1 - (visualpage mod 2));
    cleardevice;
    x2:=x1+dx2;x3:=x1+dx3;
    y2:=y1+dy2;y3:=y1+dy3;
    tr(x1,y1,x2,y2,x3,y3);
    draw(x1,y1,x2,y2,x3,y3,iter);
    key:=readkey();
    Case key Of
    #27:
    begin
        kp:=false;
        closegraph();
    end;
    'a': x1:=x1-20;
    'd': x1:=x1+20;
    's': y1:=y1+20;
    'w': y1:=y1-20;
    'z':
    begin
        if iter > 1 then
        begin
            iter:=iter-1;
            dx2:=dx2/1.4;
            dx3:=dx3/1.4;
            dy2:=dy2/1.4;
            dy3:=dy3/1.4;
        end;
    end;
    'x':
    begin
        if iter < 7 then
        begin
            iter:=iter+1;
            dx2:=dx2*1.4;
            dx3:=dx3*1.4;
            dy2:=dy2*1.4;
            dy3:=dy3*1.4;
        end;
    end;
    End;
end;

begin
    gd := detect;
    initgraph(gd, gm, '');
    iter:=3;
    kp:=true;
    visualpage := 1;
    x1:=320;y1:=20;
    dx2:=-200;dx3:=200;
    dy2:=300;dy3:=300;
    while kp do
        key_pres();
end.