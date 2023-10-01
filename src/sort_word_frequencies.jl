

function sort_by_frequency(freqs)
    sort(collect(pairs(freqs)), by=x->x[2], rev=true)
end

function sort_by_keystroke_cost(freqs)
    sort(collect(pairs(freqs)), by=x->length(x[1])*x[2], rev=true)
end