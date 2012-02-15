{-------------------------------------------------------------------------}
{ ZTools -- Memory Manager Unit }
{ June 20, 2004, Version 1 }
{ By L D Blake }
{ }
{ Simple fast and small uses Windows native memory management }
{-------------------------------------------------------------------------}

Unit ZMemory;
{$A4}

Interface
  // Allocate memory block.
  function ZGetMem(size: Integer): Pointer;
  // Deallocate memory block.
  function ZFreeMem(p: Pointer): Integer;
  // Resize memory block.
  function ZReallocMem(p: Pointer; size: Integer): Pointer;
  // kickstart the memory manager
  function ZInitAllocator : Boolean;
  // and we're done for the day
  function ZUninitAllocator : Boolean;

{--------------------------------------------------------------------------}

Implementation
Const
  Kernel = 'kernel32.dll'
  // windows imports
  function HeapCreate(flOptions, dwInitialSize,
  dwMaximumSize: longword): THandle; stdcall;
  external kernel32 name 'HeapCreate';
  function HeapAlloc(hHeap: THandle; dwFlags,
  dwBytes: longword): Pointer; stdcall;
  external kernel32 name 'HeapAlloc';
  function HeapReAlloc(hHeap: THandle; dwFlags: longword;
  lpMem: Pointer; dwBytes: longword): Pointer; stdcall;
  external kernel32 name 'HeapReAlloc';
  function HeapFree(hHeap: THandle; dwFlags: longword;
  lpMem: Pointer): LongBool; stdcall;
  external kernel32 name 'HeapFree';
  function HeapDestroy(hHeap: THandle): longbool; stdcall;
  external kernel32 name 'HeapDestroy';
  function HeapCompact(hHeap: THandle; dwFlags: longword): longint; stdcall;
  external kernel32 name 'HeapCompact';
Const
  HEAP_NO_SERIALIZE = $00001;
  HEAP_GROWABLE = $00002;
  HEAP_GENERATE_EXCEPTIONS = $00004;
  HEAP_ZERO_MEMORY = $00008;
  HEAP_REALLOC_IN_PLACE_ONLY = $00010;
  HEAP_TAIL_CHECKING_ENABLED = $00020;
  HEAP_FREE_CHECKING_ENABLED = $00040;
  HEAP_DISABLE_COALESCE_ON_FREE = $00080;
  HEAP_CREATE_ALIGN_16 = $10000;
  HEAP_CREATE_ENABLE_TRACING = $20000;
Var
  // the heap handle <--- do not change!
  HHeap: longword;
  
// Allocate memory block.
function ZGetMem(size: Integer): Pointer;
begin
  Result := HeapAlloc(HHeap,0,size);
end;

// Deallocate memory block.
function ZFreeMem(p: Pointer): Integer;
begin
  result := 0; // never fail memory release
  HeapFree(HHeap,0,p);
  heapcompact(hheap,0);
end;

// Resize memory block.
function ZReallocMem(p: Pointer; size: Integer): Pointer;
begin
  if p = nil then
    result := sysgetmem(size)
  else
    result := HeapRealloc(HHeap,0,p,size);
end;

// kickstart the memory manager
function ZInitAllocator : Boolean;
begin
  HHeap := heapcreate(heap_growable or heap_generate_exceptions,0,0);
  result := (HHeap <> 0);
end;

// and we're done for the day
function ZUninitAllocator : Boolean;
begin
  result := heapdestroy(HHeap);
end;

{--------------------------------------------------------------------------}

var
  ZMM : tmemorymanager;
Initialization
  with ZMM do
  begin
    getmem := @zgetmem;
    freemem := @Zfreemem;
    reallocmem := @Zreallocmem;
  end;
  setmemorymanager(zmm);
  ZinitAllocator;
{--------------------------------------------------------------------------}
Finalization
  ZUninitAllocator;
{--------------------------------------------------------------------------}
end.