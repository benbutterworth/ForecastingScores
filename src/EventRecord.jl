function check_inputs(input1, input2)
    if length(input1) != length(input2)
        throw(ArgumentError("Incompatible Lengths"))
    elseif !all(x->0≤x≤1, input1)
        throw(ArgumentError("Not valid probabilities"))
    end
end

"""
    EventRecord
A record of the predictions of a sequence of events that either did (true) or did not (false) occur.

```julia
events = Dict(
    0.15 => true,
    0.50 => false,
    0.99 => true
)
er = EventRecord(events)
er[1] # record of event 1
(0.15, true)
```
"""
struct EventRecord
    predictions::Vector{Float32}
    outcomes::Vector{Bool}   
    function EventRecord(predictions, outcomes)
        check_inputs(predictions, outcomes)
        new(predictions, outcomes)
    end
end

function EventRecord(eventDictionary::Dict{T, Bool}) where T<:AbstractFloat
    ps = keys(eventDictionary) |> collect
    os = values(eventDictionary) |> collect
    EventRecord(ps, os)
end

predictions(er::EventRecord) = er.predictions
outcomes(er::EventRecord) = er.outcomes


import Base: length, getindex, setindex!, iterate, show

length(er::EventRecord) = length(predictions(er))

function getindex(er::EventRecord, index::Int)
    (predictions(er)[index], outcomes(er)[index])
end
function setindex!(er::EventRecord, index::Int)
	er[index] = (predictions(er)[index], outcomes(er)[index])
end

function iterate(er::EventRecord, index=1)
	if index ≤ length(er)
	    return er[index], index+1
    else
        return nothing
    end
end

function show(io::IO, er::EventRecord)
	for (i, (p,o)) in enumerate(er)
	    print(io, "Pr($(i)):", p)
	    println(io, "\tevent $(i) ", ifelse(o, "did", "did not"), " occur.")
	end
end
