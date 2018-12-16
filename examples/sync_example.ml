open Lwt.Infix

module S = Irmin_unix.Git.FS.KV(Irmin.Contents.String)
module Sync = Irmin.Sync(S)
let config = Irmin_git.config "/tmp/test"

let upstream =
  if Array.length Sys.argv = 2 then (Irmin.remote_uri Sys.argv.(1))
  else (Printf.eprintf "Usage: sync [uri]\n%!"; exit 1)

let test () =
  S.Repo.v config >>= S.master
  >>= fun t  -> Sync.pull_exn t upstream `Set
  >>= fun () -> S.get t ["README.md"]
  >|= fun r  -> Printf.printf "%s\n%!" r

let () = Lwt_main.run (test ())
