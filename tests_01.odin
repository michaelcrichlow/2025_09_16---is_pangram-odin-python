package test

import "core:fmt"
import "core:time"
import p_str "python_string_functions"
print :: fmt.println

main :: proc() {
    print(is_pangram_01("The quick brown fox jumps over the lazy dog"))
    print(is_pangram_01("When zombies arrive, quickly fax Judge Pat"))
    print(is_pangram_01("Hello, world!"))

    iterations := 1_000
    total_time := time.Duration(0)
    
    for _ in 0 ..< iterations {
        start := time.now()
        // code to test goes here
        is_pangram_01("The quick brown fox jumps over the lazy dog")
    
        total_time += time.since(start)
    }
    print("Average time:", int(total_time) / iterations, "ns")

    // OUTPUT:
    // true
    // true
    // false
}

// simple, 'first way I thought of' solution
// Average Time in Debug Build:      33338 ns
// Average Time in Optimized Build:   3677 ns
is_pangram :: proc(s: string) -> bool {
    _s := p_str.lower(s, context.temp_allocator)
    c  := Counter(_s)

    for val in 'a' ..= 'z' {
        if val not_in c { c[val] = 0 }
    }

    for val in 'a' ..= 'z' {
        if c[val] == 0 { return false }
    }

    return true
}


// better, more efficient solution
// Average Time in Debug Build:      697 ns
// Average Time in Optimized Build:   88 ns
is_pangram_01 :: proc(s: string) -> bool {
    local_array := [256]u8{}

    for i in 0 ..< len(s) {
        if s[i] > 90 { 
            local_array[s[i] - 32] += 1
        } else {
            local_array[s[i]] += 1
        }
    }

    for val in 65 ..= 90 {
        if local_array[val] == 0 { return false }
    }

    return true
}


