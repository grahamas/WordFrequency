include.(srcdir.(["chording.jl", "time_saved.jl", "load_corpus.jl", "sort_word_frequencies.jl"]))

#corpus = load_corpus(joinpath(homedir(), "cloud", "book"))
sorted_corpus = sort_by_keystroke_cost(corpus)
(postwpm, prewpm) = effective_wpm(sorted_corpus, 80, 600)