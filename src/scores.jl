"""
    brier_score 
Calculate the Brier Score, b∈[0,1] of a sequence of preductions for the events {oᵢ | i∈1:N } that were predicted to occur with probability pᵢ. Good predictions have a Brier score close to zero.
"""
function brier_score end

function brier_score(prediction::Float32, outcome::Bool)
    (prediction - Float32(outcome))^2
end

function brier_score(eventrecord::EventRecord)
    N = length(eventrecord)
    score = 1/N * sum(eventrecord) do (p,o)
        brier_score(p,o)
    end
    return score
end

"""
    logarithmic_score
Calculate the logarithmic score of a sequence of predictions of the events {oᵢ} occuring with probability {pᵢ}.  
"""
function logarithmic_score end

function logarithmic_score(prediction::Float32, outcome::Bool)
    if outcome
        return log(prediction)
    else
        return log(1-prediction)
    end
end

function logarithmic_score(eventrecord::EventRecord)
    N = length(eventrecord)
    score = 1/N * sum(eventrecord) do (p,o)
        logarithmic_score(p,o)
    end
    score
end

"""
    naive_score
Calculate a naive score for a sequence of predictions about events {oᵢ} occuring with probabilities {pᵢ}. 
"""
function naive_score end

function naive_score(er::EventRecord)
    result = 1/length(er) * sum(er) do (p,o)
        p-Float32(o)
    end |> Float64
    result
end
