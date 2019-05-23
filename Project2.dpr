program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  pntnum = ^numbers;

  numbers = record
    num: Integer;
    next: pntnum;
  end;

const
  ubord = 100;
  dbord = 0;
var
  n: Byte; //amount of numbers
  rand: Byte; //random number
  i:Byte;//cunter
  head, prev, p: pntnum;
  inp:Char;   //command
  inpnum:Byte;//new or del numver in case

procedure write_chain(WHead: pntnum);
begin
  repeat
    Writeln(whead^.num);
    whead := WHead^.next;
  until WHead = nil;
end;
procedure insert_num(var IHead:pntnum;Inum:byte);
var
  i:Byte;//counter
  p,prev:pntnum;
begin
    p := ihead;
    while (Inum > p^.num) and (p^.next <> nil) do //find place
    begin
      prev := p;
      p := p^.next;
    end;
    if Inum <= p^.num then
      if p = ihead then
      begin
        New(p);
        p^.num := Inum;
        p^.next := ihead;
        ihead := p;
      end
      else
      begin
        New(p);
        p^.num := Inum;
        p^.next := prev^.next;
        prev^.next := p;
      end
    else
    begin
      prev := p;
      New(p);
      prev^.next := p;
      p^.num := Inum;
    end;
  end;

procedure Delete_num(var dhead:pntnum;inum:byte);
var
  p,prev:pntnum;
begin
  p:= dhead;
  while (Inum > p^.num) and (p^.next <> nil) do //find place
    begin
      prev := p;
      p := p^.next;
    end;
  while inum = p^.num do
    begin
      if p = head then
        begin
        if p^.next <> nil then
          head:=p^.next;
        Dispose(p);
        p:=head;
        Continue;
        end;
      if p^.next = nil then
        begin
          prev^.next := nil;
          Dispose(p);
          Exit;
        end;
       //
      prev^.next := p^.next;
      Dispose(p);
      p:=prev^.next;
    end;

end;
begin
  randomize;
  Write('Input amount of numbers: '); // n
  Readln(n);

  New(head); //head

  //create

  rand := Random(ubord - dbord + 1) + dbord;
  head^.num := rand;

  for i := 1 to n - 1 do // create chain
  begin
    rand := Random(ubord - dbord + 1) + dbord;
    insert_num(head,rand);
  end; //  end of create chain
  write_chain(head);
  inp := 'h';
  while Inp <> 'o' do
    begin
      case inp of
      'i':begin Readln(inpnum); insert_num(head,inpnum) end;
      'd':begin Readln(inpnum); delete_num(head,inpnum) end;
      'w':begin write_chain(head); end;
      'h':writeln('i - insert number; d - del mubers; w - write chain; o - out');
      end;
      write('--');
      Readln(inp);
    end;
  p:=head;
  while  p^.next <> nil;
    begin
      prev := p;
      p:=p^.next;
      Dispose(prev);
    end;
  Dispose(p);
end.
 
