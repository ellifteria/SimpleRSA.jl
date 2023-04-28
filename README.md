# Julia Simple RSA Implementation

## Usage

In the Julia REPL:

```julia
julia> include("src/TxtbkRSA.jl")
julia> using .TxtbkRSA
julia> priv, pub = generate_keys()
julia> encrypted = encrypt("Hello, World!", pub)
julia> decrypted = decrypt(encrypted, priv)
julia> println(decrypted)
```

Output:

```text
Hello, World!
```
