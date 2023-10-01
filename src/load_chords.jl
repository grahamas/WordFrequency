using CSV

function load_chords(chord_file=datadir("CC1_Default_Chord_Library.csv"))
    chord_csv = CSV.File(chord_file, header=["chord","word"])
    
end

function parse_chord(chord)
    strip.(split(chord, '+'))
end