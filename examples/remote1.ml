(* In this example, I am having a remote located at the uri provided to the "remote_uri" function and master remote is pulling the 
   content of that remote store *)
open Lwt.Infix

module Store = Irmin_unix.Git.FS.KV(Irmin.Contents.String)
module Sync = Irmin.Sync(Store)

(* remote1 is the remote store located at uri given below *)
let remote1 = Irmin.remote_uri "git://github.com/priyas13/ocaml-irmin.git"

let root = "/tmp/irmin/test"

let init () =
  let _ = Sys.command (Printf.sprintf "rm -rf %s" root) in
  let _ = Sys.command (Printf.sprintf "mkdir -p %s" root) in
  ()

let test () =
  init ();
  let config = Irmin_git.config root in
  (* Store.Repo.v connects to a repository in a backhend specific manner *)
  Store.Repo.v config >>= fun repo ->
  (* Store.master repo is a persistent store based on master's branch *)
  Store.master repo >>= fun t ->
  (* It populates the local store t with objects from the remote remote1 using t's current branch *)
  (* Here 'Set is the update strategy *)
  Sync.pull_exn t remote1 `Set >>= fun () ->
  Store.get t ["README.md"]>>= fun readme ->
  let _ = Printf.printf "%s\n%!" readme in 
  Lwt.return()

let () =
  Lwt_main.run (test ())
