---
title: My understanding for IoC(Inversion of Control)
date: 2023-03-23 21:58:01
tags:
  - software design
  - sharing
---

20230322 free chat sharing notes

### Framework vs Library

+ our code calls library code
+ our code called by framework code

[](./framework-vs-library.png)

### My understanding for IoC

> IoC is we as programmers write codes that are called by `Frameworks`

+ control structures: Sequence, Selection & Iteration

+ normally we write business logic as step1, step2, step3... using above control structures

+ but we will notice bolier templates as we getting more and more familar with them, for examples:
    + we always need to close an open file
    + we always need to declare an empty array if we're only interested in part of the elements in a list
    + some code only differs in the middle part
    ```rb
    class Demo
      def perform_1
        puts 1
        puts 2
        puts 3
      end

      def perform_2
        puts 1
        puts 4
        puts 3
      end
    end

    # solu.1
    class Demo
      def perform_n
        puts 1
        yield
        puts 3
      end
    end



    # solu.2
    # DI (dependency injection)
    class Demo
      def initialize(operation_instance)
        @operation_instance = operation_instance
      end

      def perform_n
        puts 1
        @operation_instance.execute
        puts 3
      end
    end
    ```

### Examples

+ map/filter/reduce(pipelined list handling)
    + list.filter {}.map {}
    + list.filter {}.map {}.reduce {}
+ ruby: partition/all?/any?/none?
    + (1..6).partition { |v| v.even? }  #=> [[2, 4, 6], [1, 3, 5]]
+ dsl(describe what to do, not how to do it)
+ framework
    + rails
    + event_sourcing
+ lambda(ruby block / First-class Function)

### Take aways

+ find & use good abstraction(e.g.: use `map/filter/reduce` more)
+ learn more about the framework we're using

### References

+ [algorithm = logic + control.pdf](https://www.doc.ic.ac.uk/~rak/papers/algorithm%20=%20logic%20+%20control.pdf)
+ [Framework vs Library: Full Comparison - InterviewBit](https://www.interviewbit.com/blog/framework-vs-library/)
+ [Generic Map, Filter and Reduce in Go | by Erik Engheim | ITNEXT](https://itnext.io/generic-map-filter-and-reduce-in-go-3845781a591c)
+ [Go filter/map - filter and map functions in Golang](https://zetcode.com/golang/filter-map/)
+ [How to Read and Writes Files in Ruby](https://www.tutorialspoint.com/how-to-read-and-writes-files-in-ruby#:~:text=Opening%20a%20File%20in%20Ruby&text=There%20are%20two%20methods%20which,read%20the%20entire%20file%20content.)
+ [Inversion Of Control - wiki.c2](https://wiki.c2.com/?InversionOfControl)
+ [Inversion of control - Wikipedia](https://en.wikipedia.org/wiki/Inversion_of_control)
+ [Inversion of Control Containers and the Dependency Injection pattern](https://www.martinfowler.com/articles/injection.html)
+ [module Enumerable - RDoc Documentation](https://ruby-doc.org/3.2.1/Enumerable.html)
