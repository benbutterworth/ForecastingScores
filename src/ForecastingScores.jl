module ForecastingScores

include("EventRecord.jl")
include("scores.jl")

export EventRecord
export brier_score, logarithmic_score, naive_score

end # module ForecastingScores
