
open Prims
open FStar_Pervasives
type 'a __result =
  | Success of ('a,FStar_Tactics_Types.proofstate)
  FStar_Pervasives_Native.tuple2
  | Failed of (Prims.string,FStar_Tactics_Types.proofstate)
  FStar_Pervasives_Native.tuple2[@@deriving show]
let uu___is_Success: 'a . 'a __result -> Prims.bool =
  fun projectee  ->
    match projectee with | Success _0 -> true | uu____42 -> false
let __proj__Success__item___0:
  'a .
    'a __result ->
      ('a,FStar_Tactics_Types.proofstate) FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | Success _0 -> _0
let uu___is_Failed: 'a . 'a __result -> Prims.bool =
  fun projectee  ->
    match projectee with | Failed _0 -> true | uu____88 -> false
let __proj__Failed__item___0:
  'a .
    'a __result ->
      (Prims.string,FStar_Tactics_Types.proofstate)
        FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | Failed _0 -> _0