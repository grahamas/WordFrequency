

function word2chord(word)
    sort(unique(word))
end

function chord_possibilities(words::AbstractVector{T}) where T <: AbstractString
    chord_mapping = Dict{Vector{Char},Vector{T}}()
    chords = word2chord.(words)
    for (chord, word) in zip(chords, words)
        push!(get!(chord_mapping, chord, []), word)
    end
    return chord_mapping
end