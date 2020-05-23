# Chapter 1 - Tutorial
#### Slices
> Slices are a fundamental notion in Go, and we’ll talk a lot more aboutthem soon.  For now, think of a slice as a dynamically sized sequences of array elements where individual elements can be accessed ass[i] and a contiguous subsequence as s[m:n].The number of elements is given by len(s).As in most other programming languages,all indexing in Go uses half-open intervalsthat include the first index but exclude the last, because itsimplifies logic.  For example, the slice s[m:n],where 0 ≤ m ≤ n ≤ len(s), containsn-m elements. If m or n are omitted, it defaults to 0 or len(s)

#### Loops
> The for loop is the only loop statement in Go

The basic form is like the following one:

```go
for initialization; condition; post {
    // Zero or more statements
}
```

We can choose to omit any of the blocks. If there is no initialization and no post, we can also omit the semicolons, to get the equivalent of while in other languages:

```go
for condition {
    // Statements
}
```

If we omit everything, we get an infinite loop (but it can be terminated with `break` or `return`

```go
for {
    // Statements
}
```

We can also use kind-of a for-each version:

```go
for index, value := slice {
    // Statements
}
```

Go doesn't allow unused variables, so if we don't need the index, we should use the `blank identifier`:

```go
for _, value := slice {
    // Statements
}
```
