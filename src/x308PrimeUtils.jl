module x308PrimeUtils

using Primes

export generate_random_primes, generate_random_prime, generate_random_coprime, FIRST_100_PRIMES

global FIRST_100_PRIMES = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,521,523,541]

function generate_random_primes(length::Int64)::Vector{Int64}
    primes = Vector{Int64}(undef, length)

    for i = 1:length
        prime = generate_random_prime(16)
        while prime in primes
            prime = generate_random_prime(16)
        end
        primes[i] = prime
    end

    return primes
end

function generate_random_coprime(coprime_with::Int64, min::Int64, max::Int64)::Int64
    coprime = trunc(Int64, (max - min) * rand() + min)
    while gcd(coprime, coprime_with) != 1
        coprime = trunc(Int64, (max - min) * rand() + min)
    end

    return coprime
end

function generate_random_prime(bit_size::Int64)
    global FIRST_100_PRIMES
    while true
        candidate = generate_lowlevel_prime(bit_size, FIRST_100_PRIMES)
        if isprime(candidate)
            return candidate
        end
    end
end

function generate_lowlevel_prime(bit_size::Int64, primes_list::Vector{Int64})
    while true
        candidate = generate_n_bit_odd(bit_size)
        failed_test = false

        for prime in primes_list
            if candidate % prime == 0 && candidate != prime
                failed_test = true
                break
            end
        end

        if !failed_test
            return candidate
        end
    end
end

function generate_n_bit_odd(n::Int64)::Int64
    min = 2^(n - 1) + 1
    max = 2^n
    half_rand = (max - min) / 2 * rand() + (min - 1) / 2
    full_rand = 2 * half_rand + 1
    return trunc(Int64, full_rand)
end

end
