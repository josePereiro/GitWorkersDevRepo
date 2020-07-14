try
    using Random
catch err
    import Pkg
    Pkg.add("Random")
    using Random
end

for i in 1:100
    println(randstring(i))
    sleep(rand())
end