
struct ChordingEffect
    seqwpm
    chrwpm
end

function effective_wpm(sorted_freqs, wpm, n_chords=100)
    cpm = wpm * 5
    cps = cpm / 60
    spc = 1 / cps
    numchars = 0
    chorded_time = unchorded_time = 0
    chorded_words = sorted_freqs[1:n_chords]
    for (word, freq) in chorded_words
        chorded_time += freq * spc
        unchorded_time += freq * (length(word) + 1) * spc
        numchars += freq * (length(word) + 1)
    end
    unchorded_words = sorted_freqs[n_chords+1:end]
    for (word, freq) in unchorded_words
        chorded_time += freq * (length(word) + 1) * spc
        unchorded_time += freq * (length(word) + 1) * spc
        numchars += freq * (length(word) + 1)
    end
    chorded_mins = chorded_time / 60
    unchorded_mins = unchorded_time / 60
    estnumwords = numchars / 5
    return (estnumwords / chorded_mins, estnumwords / unchorded_mins)
end
