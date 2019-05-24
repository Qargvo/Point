program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

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
  n: Cardinal; //amount of numbers
  rand: Byte; //random number
  i: Cardinal; //cunter
  head {, prev, p}: pntnum;
  inp: Char; //command
  inpnum: Byte; //new or del numver in case
  t, fr: Int64;//time

function time: int64;
asm
   rdtsc
end;

procedure write_chain(WHead: pntnum);
begin
  if WHead <> nil then
    repeat
      Writeln(whead^.num);
      whead := WHead^.next;
    until WHead = nil;
end;
procedure insert_num(var IHead: pntnum; Inum: byte);
var
  i: Byte; //counter
  p, prev: pntnum;
begin
  if IHead = nil then
  begin
    New(ihead);
    IHead^.num := Inum;
    Exit;
  end;
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

procedure Delete_num(var dhead: pntnum; inum: byte);
var
  p, prev: pntnum;
begin
  if dhead = nil then
    Exit;
  p := dhead;
  while (Inum > p^.num) and (p^.next <> nil) do //find place
  begin
    prev := p;
    p := p^.next;
  end;
  while inum = p^.num do
  begin
    if p = dhead then
    begin
      if p^.next <> nil then
        dhead := p^.next
      else
      begin
        Dispose(p);
        dhead := nil;
        exit;
      end;
      dispose(p);
      p := dhead;
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
    p := prev^.next;
  end;

end;

procedure clear_chain(var chead: pntnum);
var
  p: pntnum;
begin
  if cHead <> nil then
    repeat
      p := chead;
      chead := cHead^.next;
    until cHead = nil;
end;

begin
  randomize;
  Write('Input amount of numbers: '); // n
  Readln(n);

  for i := 1 to n do // create chain
  begin
    rand := Random(ubord - dbord + 1) + dbord;
    insert_num(head, rand);
  end; //  end of create chain
  write_chain(head);
  inp := 'h';
  while Inp <> 'o' do
  begin
    case inp of
      'i':
        begin
          Readln(inpnum);
          insert_num(head, inpnum)
        end;
      'd':
        begin
          Readln(inpnum);
          delete_num(head, inpnum)
        end;
      'w':
        begin
          write_chain(head);
        end;
      'h':
        writeln('i - insert number; d - del mubers; w - write chain; o - out; c - clear; g - generate n numbers');
      'g':
        begin
          Readln(n);
          QueryPerformanceFrequency(fr);
          t := time;
          for i := 1 to n do // create chain
          begin
            rand := Random(ubord - dbord + 1) + dbord;
            insert_num(head, rand);
          end;
          t := time - t;
          writeln('time = ', t / fr: 0: 4, ' ms ', 'Gen');
        end;
      'c': clear_chain(head);
    end;
    write('--');
    Readln(inp);
  end;
  //  p := head;
  //  while p^.next <> nil do
  //  begin
  //    prev := p;
  //    p := p^.next;
  //    Dispose(prev);
  //  end;
  //  Dispose(p);
end.
 
