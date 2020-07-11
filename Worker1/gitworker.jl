# This file must be place in the Worker root directory
# inside a git repository. It must be run in a way that
# `worker_dir` point to this file location (by default julia I use @__FILE__ for doing that)

# This script launch all the process that manage the GitWorker

# TODO add installation info here
using Distributed
addprocs(2) # The Updater and the TaskManagerbig
@everywhere begin
     using GitWorkers
     GW = GitWorkers
end

 # ------------------- LAUNCHING TASK MANNAGER -------------------
 # This process will screen the worker dir for tasks and runs them
 # or kill them depending on its configuration files
 remote_do(GW.task_manager_loop, 2)


# ------------------- LAUNCHING UPDATER  -------------------
# This process will sync the content of the local repo, the copy repo and the origin
remotecall_wait(GW.update_loop, 3)
 
