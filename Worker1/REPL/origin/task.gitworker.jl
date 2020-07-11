using Dates

all_procs = [] # This will track all the child process

print_inall(s = "", ss...) = foreach([stderr, stdout]) do io
    println(io, s, ss...)
    flush(io)
end
start_bookmark(ss...) = print_inall("\n\nSTART ", now(), "\n\n", ss..., "\n")
end_bookmark() = print_inall("\n\nEND ", now())

atexit() do ; kill.(all_procs) end

#########################################################
# here you place the call of external programs
#########################################################
cmd_to_run = [
    `julia repl.jl`,
] 

for cmd in cmd_to_run
    start_bookmark(cmd)
    proc = run(pipeline(cmd; stdout = stdout, stderr = stderr); wait = false)
    push!(all_procs, proc)
    wait(proc)
    end_bookmark()
end