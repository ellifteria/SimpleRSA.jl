module TxtbkRSA

include("x308PrimeUtils.jl")

using .x308PrimeUtils

export encrypt, decrypt, generate_keys

function encrypt(msg::String, e::Int64, n::Int64)::Vector{UInt32}
    numeric_msg::Vector{UInt32} = transcode(UInt32, msg)
    enc::Vector{UInt32} = powermod.(numeric_msg, e, n)
    return enc
end

encrypt(msg::String, private_key::Tuple{Int64, Int64}) = encrypt(msg, private_key[1], private_key[2])

function decrypt(msg::Vector{UInt32}, d::Int64, n::Int64)::String
    dec::Vector{UInt32} = powermod.(msg, d, n)
    dec_msg = transcode(String, dec)
    return dec_msg
end

decrypt(msg::Vector{UInt32}, public_key::Tuple{Int64, Int64}) = decrypt(msg, public_key[1], public_key[2])

function generate_keys(p::Int64, q::Int64)::Tuple{Tuple{Int64, Int64}, Tuple{Int64, Int64}}
    n = p * q
    phi = (p - 1) * (q - 1)
    e = generate_random_coprime(phi, 1, phi)
    d = invmod(e, phi)
    private_key = (e, n)
    public_key = (d, n)
    return private_key, public_key
end

function generate_keys()::Tuple{Tuple{Int64, Int64}, Tuple{Int64, Int64}}
    p, q = generate_random_primes(2)
    return generate_keys(p, q)
end

end