---
title: Testing and Refactoring sharing
date: 2022-11-17 23:16:34
tags:
  - testing
  - refactoring
---

+ Bi-weekly Tech Sharing

## Agenda

+ Experience
+ Testing
+ Refactoring
+ References

## Experience

+ best thing learned this year
+ I'm proud that we have testing culture and code review

+ how I test my code before?
    + coding -> run program -> postman / repl -> verify by eye -> QA
+ how I test my code now?
    + coding -> add tests -> green -> refactoring -> coding -> repeat -> code review

+ hopefully I'll benefit from TDD style sooner


## Testing

+ raise a question: we're relying on tests to guarantee code work as expected, who guarantees our tests are correct then?
    + short answer: we can only rely on simple tests
    + too simple to be wrong(ideal world)

+ [testing proportion](https://insights.thoughtworks.cn/wp-content/uploads/2018/10/3.png)

+ testing helped on
    + building confidence
    + building solid(bug free) code as possible
    + gives me a button to click
        + "if you ever get that button, you'll never want to lose it or work other way round so you wouldn't have it."

+ testing drives me to write simple code
    + I want class to be small
    + I want responsiblilty to be single/simple/clear
    + I want method to be short
    + I want interface to be well defined
    + **I love good names**

+ example of using `let`(private git repo pull request)
    + demo for independant tests
    + avoid mutable variable
    + discipline posed upon assignment/mutability

+ key points:
    + write simple code & test when possible
    + more unit tests
    + "write enough tests to be confident"


## Refactoring

+ let's put performance aside while coding & refactoring
+ let's focus on clarity/simplicity/readability/maintainability, not performance
    + make it simple
    + make it easier to read/review
    + make it easier to change/maintain

+ How I do code refactoring?
    + clean up feature flags
    + check code coverage and make it up to 100%
    + remove code smell
    + simplify code
    + enjoy the tiny changes/improvements
    + enjoy the green dots
    + enjoy the red dots(it shows I didn't fully understand my code)
    + remove unused/dead code(`unused`)
    + check with `flog`(rely on metric tools, not "feeling")
    + choose a better name for variables/methods/class/file/moudles
    + simplify tests
    + I got better understanding of the code, and I can repeat the above process...


+ example of simplifying code(private git repo pull request)

+ The point is: "business complixity is the lower limit of system complixity"
    + so I want my code to be as simple/readable as possible
    + try functional thinking: e.g. use filter/map/reduce
    + ruby: `Enumerable` module is amazing

+ key points:
    + lean on tests, no tests, no refactoring
    + do your refactoring with small steps(highlighted in both "refactoring" and "99 bottles of OOP")
    + refactoring is just pattern matching(focus on code smell) and follow the solution


### References

+ book: [99 Bottles of OOP — Sandi Metz](https://sandimetz.com/99bottles)
+ book: [Refactoring](https://refactoring.com/)
+ gitrepo: [A tool to identify potentially unused code.](https://github.com/unused-code/unused)
+ gitrepo: [sandimetz/99bottles_ruby](https://github.com/sandimetz/99bottles_ruby/tree/2.0-c9-revisit-tests-360)
+ guide: [Better Specs. Testing Guidelines for Developers.](https://www.betterspecs.org/)
+ paper: [algorithm = logic + control.pdf](https://www.doc.ic.ac.uk/~rak/papers/algorithm%20=%20logic%20+%20control.pdf)
+ post: ["You Don’t Know What You Don’t Know"](https://skorks.com/2011/02/the-greatest-developer-fallacy-or-the-wisest-words-youll-ever-hear/#you-don-t-know-what-you-don-t-know)
+ post: [Let vs. Let! vs. Instance Variables in RSpec](https://mixandgo.com/learn/ruby/let-vs-let!)
+ post: [Simplifying Tests by Extracting Side-Effects](https://thoughtbot.com/blog/simplify-tests-by-extracting-side-effects)
+ post: [测试指南 - Rei](https://chloerei.com/2015/10/26/testing-guide/)
+ quote: "Do yourself a favor and make sure your test coverage is good before you start an upgrade."
+ quote: "Pain in your tests should push you to change the design of objects being tested"
+ quote: ["if you ever get that button, you'll never want to lose it or work other way round so you wouldn't have it."](https://coderanch.com/t/686754/engineering/Laws-TDD-Uncle-Bob)
+ quote: ["Running our test table: Click the Test button"](http://butunclebob.com/FitNesse.UserGuide.TwoMinuteExample)
+ slide: [slide page7: "Focus on Simplicity & Clarity, **Otherwise, you don't fully understand.**"](https://www.zenspider.com/pdf/TDD_With_ZenTest.pdf)
+ talk: ["Fearless Competence / Conquer the fear with Test."](https://youtu.be/Qjywrq2gM8o?t=2106)
+ talk: [Clean Code - Uncle Bob - YouTube](https://www.youtube.com/watch?v=7EmboKQH8lM&list=PLmmYSbUCWJ4x1GO839azG_BBw8rkh-zOj&ab_channel=UnityCoin)
+ tool: [Catalog of Refactorings](https://refactoring.com/catalog/?filter=tags-simplify-conditional-logic)
+ tool: [Confessions of a Ruby Sadist sudo gem install flog](https://ruby.sadi.st/Flog.html)
+ wiki: [Code Smell](https://wiki.c2.com/?CodeSmell)
+ wiki: [Rules Of Optimization](https://wiki.c2.com/?RulesOfOptimization)
+ wiki: [Test Driven Development](https://wiki.c2.com/?TestDrivenDevelopment)

## At last

these are just my limited experience on testing & refactoring; I'm pretty sure I have a lot more to learn

I really want to learn from everyone about these two topics

pls correct me if I'm wrong. pls discuss with me if you're interested~ Orz
