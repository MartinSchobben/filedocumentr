# library initiation works

    Code
      library_entry("my-library", foo = 1, bar = "a", baz = "b")
    Output
      # A tibble: 1 x 4
        prim_key   foo bar   baz  
           <dbl> <dbl> <chr> <chr>
      1        1     1 a     b    

---

    Code
      library_entry("my-library", foo = 2, bar = "a", baz = "b")
    Output
      # A tibble: 2 x 4
        prim_key   foo bar   baz  
           <dbl> <dbl> <chr> <chr>
      1        1     1 a     b    
      2        2     2 a     b    

---

    Code
      library_entry("my-library", foo = 3, bar = "a", baz = "b")
    Output
      # A tibble: 3 x 4
        prim_key   foo bar   baz  
           <dbl> <dbl> <chr> <chr>
      1        1     1 a     b    
      2        2     2 a     b    
      3        3     3 a     b    

---

    Code
      add_variable(readRDS("my-library/my-library.RDS"), c(foo = 3, bar = "a", baz = "b",
        fruit = "Apple"))
    Output
      # A tibble: 3 x 5
        prim_key   foo bar   baz   fruit
           <dbl> <dbl> <chr> <chr> <lgl>
      1        1     1 a     b     NA   
      2        2     2 a     b     NA   
      3        3     3 a     b     NA   

---

    Code
      library_entry("my-library", foo = 3, bar = "a", baz = "b", fruit = "Apple")
    Output
      # A tibble: 4 x 5
        prim_key   foo bar   baz   fruit
           <dbl> <dbl> <chr> <chr> <chr>
      1        1     1 a     b     <NA> 
      2        2     2 a     b     <NA> 
      3        3     3 a     b     <NA> 
      4        4     3 a     b     Apple

