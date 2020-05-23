// Exercise 1.3: Experiment to measure the difference in running time between ourpotentially inefficient versions and the one that uses strings.Join.(Section 1.6 illustrates part of the time package,and Section 11.4 shows how to write benchmark testsfor systematic performance evaluation.)

/*
100 arguments
Concatenation:
Time: 0.000077
Join:
Time: 0.000013

1000 arguments
Concatenation:
Time: 0.000701
Join:
Time: 0.000101

10000 arguments
Concatenation:
Time: 0.020110
Join:
Time: 0.000951

*/

package main

import (
	"fmt"
	"strings"
	"time"
)

func main() {
	fmt.Println("100 arguments")
	loop(100)

	fmt.Println("")
	fmt.Println("1000 arguments")
	loop(1000)

	fmt.Println("")
	fmt.Println("10000 arguments")
	loop(10000)
}

func loop(times int) {
	fmt.Println("Concatenation:")
	start := time.Now()
	s := "concatenation"
	for i := 0; i < times; i++ {
		s += " "
	}
	fmt.Println(fmt.Sprintf("Time: %f", time.Since(start).Seconds()))

	fmt.Println("Join:")
	start = time.Now()
	s = "join"
	for i := 0; i < times; i++ {
		strings.Join([]string{s, "join"}, " ")
	}
	fmt.Println(fmt.Sprintf("Time: %f", time.Since(start).Seconds()))
}
