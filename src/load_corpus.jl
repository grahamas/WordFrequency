using Lazy #stop being lazy and get rid of this dep

function load_corpus(directory_name;
        file_reqs...
    )
    word_freqs = Dict{SubString{String},Int}()
    if !isdir(directory_name)
        @warn "Directory does not exist."
    end
    for (root, dirs, files) in walkdir(directory_name)
        @info "Entering $root"
        for filename in files
            path = joinpath(root, filename)
            if loadable_path(path; file_reqs...)
                parse_word_frequencies!(word_freqs, path)
            else
                @info "...skipped $filename"
            end
        end
    end
    return word_freqs
end

function loadable_path(path; 
        extension_whitelist=["txt", "md", "org"],
        max_filesize=1_000_000_000
    )
    size = filesize(path)
    ext = lstrip(splitext(path)[2], '.')
    return (size <= max_filesize) && (ext ∈ extension_whitelist)
end

function parse_word_frequencies!(freqs, filepath)
    for line in eachline(filepath)
        words = parse_words(line)
        for word in words
            freqs[word] = get(freqs, word, 0) + 1
        end
    end
end

function parse_words(text)
    @as t text begin
        replace(t, "---" => "—", "--" => "—", "..." => "—")
        split(t, x -> (isspace(x) || x == '—' || x == '–'))
        strip.(!isletter, t)
        filter(x -> length(x) > 1, t)
        lowercase.(t)
    end
end