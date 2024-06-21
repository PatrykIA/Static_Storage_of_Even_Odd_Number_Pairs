uses CRT;

type
  pNode = ^tNode;
  tNode = record
    Data: integer;
    Next: pNode;
  end;

  tQueue = record
    First, Last: pNode;
  end;

  tPairOfNumbers = record
    N1, N2: integer;
  end;

  tSequenceOfPairs = record
    Elem: array[1..25] of tPairOfNumbers;
    n: integer;
  end;

var
  Queue: tQueue;
  StackOdd, StackEven: pNode;
  PairsOfNumbers: tSequenceOfPairs;

procedure displayProgramInfo; forward;
procedure displayList(List: pNode; X, Y: integer); forward;
procedure displaySequenceOfPairs(var Pairs: tSequenceOfPairs; X, Y: integer); forward;
procedure addToQueue(var queue: tQueue; L: integer); forward;
function retrieveFromQueue(var queue: tQueue): integer; forward;
procedure pushToStack(var stack: pNode; L: integer); forward;
function popFromStack(var stack: pNode): integer; forward;
procedure generateRandomNumbersToQueue(var queue: tQueue); forward;
procedure executeExerciseAlgorithm(var queue: tQueue; var pairs: tSequenceOfPairs); forward;

procedure displayProgramInfo;
begin
  writeln('Program: Program storing a set of even-odd number pairs in an array, ver 3.0, _AiSD7_Z2');
  writeln('Author: Rogowski Patryk, Index number 162866, Year 1, Faculty of Technology and Informatics, group D2, Sem 1');
end;

procedure displayList(List: pNode; X, Y: integer);
var
  ptr: pNode;
  i: integer;
begin
  ptr := List;
  i := 1;
  while (ptr <> nil) do
  begin
    if i = 27 then
    begin
      y := Y - 5;
      X := X + 11;
    end;
    gotoXY(X, Y);
    writeln(i:2, ' : ', (ptr^.Data):3, ' ');
    ptr := ptr^.Next;
    i := i + 1;
    Y := Y + 1;
  end;
end;

procedure displaySequenceOfPairs(var Pairs: tSequenceOfPairs; X, Y: integer);
var
  i: integer;
begin
  for i := 1 to Pairs.n do
  begin
    gotoXY(X, Y);
    writeln(i:2, ' : ', (Pairs.Elem[i].N1):3, ' - ', (Pairs.Elem[i].N2):3, ' ');
    Y := Y + 1;
  end;
end;

procedure addToQueue(var queue: tQueue; L: integer);
var
  newPtr: pNode;
begin
  new(newPtr);
  newPtr^.Data := L;
  newPtr^.Next := nil;
  if queue.First = nil then
    queue.First := newPtr
  else
    queue.Last^.Next := newPtr;
  queue.Last := newPtr;
end;

function retrieveFromQueue(var queue: tQueue): integer;
var
  L: integer;
  delPtr: pNode;
begin
  if queue.First = nil then
    retrieveFromQueue := 0
  else
  begin
    L := queue.First^.Data;
    delPtr := queue.First;
    queue.First := queue.First^.Next;
    dispose(delPtr);
    if queue.First = nil then
      queue.Last := nil;
    retrieveFromQueue := L;
  end;
end;

procedure pushToStack(var stack: pNode; L: integer);
var
  newPtr: pNode;
begin
  new(newPtr);
  newPtr^.Data := L;
  newPtr^.Next := stack;
  stack := newPtr;
end;

function popFromStack(var stack: pNode): integer;
var
  L: integer;
  delPtr: pNode;
begin
  if stack = nil then
    popFromStack := 0
  else
  begin
    L := stack^.Data;
    delPtr := stack;
    stack := stack^.Next;
    dispose(delPtr);
    popFromStack := L;
  end;
end;

procedure generateRandomNumbersToQueue(var queue: tQueue);
var
  L: integer;
  i: integer;
begin
  while queue.First <> nil do
    L := retrieveFromQueue(queue);
  for i := 1 to 25 do
  begin
    L := random(1000);
    addToQueue(queue, L);
  end;
end;

procedure executeExerciseAlgorithm(var queue: tQueue; var pairs: tSequenceOfPairs);
var
  L, LOdd, LEven: integer;
begin
  while StackOdd <> nil do
    L := popFromStack(StackOdd);
  while StackEven <> nil do
    L := popFromStack(StackEven);
  while queue.First <> nil do
  begin
    L := retrieveFromQueue(queue);
    if L mod 2 <> 0 then
      pushToStack(StackOdd, L)
    else
      pushToStack(StackEven, L);
  end;
  pairs.n := 0;
  while (StackOdd <> nil) and (StackEven <> nil) do
  begin
    LOdd := popFromStack(StackOdd);
    LEven := popFromStack(StackEven);
    pairs.n := pairs.n + 1;
    pairs.Elem[pairs.n].N1 := LOdd;
    pairs.Elem[pairs.n].N2 := LEven;
  end;
end;

begin
  Randomize;
  Queue.First := nil;
  Queue.Last := nil;
  StackOdd := nil;
  StackEven := nil;
  PairsOfNumbers.n := 0;

  displayProgramInfo;
  writeln;
  writeln('Press <ENTER>... ');
  readln;

  ClrScr;

  generateRandomNumbersToQueue(Queue);

  gotoXY(1, 1);
  writeln('- QUEUE -');
  displayList(Queue.First, 2, 2);

  executeExerciseAlgorithm(Queue, PairsOfNumbers);

  gotoXY(16, 1);
  writeln('- STACK ODD -');
  displayList(StackOdd, 18, 2);
  gotoXY(38, 1);
  writeln('- STACK EVEN -');
  displayList(StackEven, 40, 2);
  gotoXY(54, 1);
  writeln('- PAIRS OF NUMBERS -');
  displaySequenceOfPairs(PairsOfNumbers, 55, 2);

  gotoXY(1, 28);
  writeln('To end, press <ENTER>');
  readln;
end.
