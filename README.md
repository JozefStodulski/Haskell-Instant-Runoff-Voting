# Haskell-Instant-Runoff-Voting
A simple implementation of IRV

## Algorithm

> Recursively disqualify the least popular candidate until the result is unanimous.

## Goal

Optimised for concise expressiveness for ease of verification and comprehension by removing performance optimisations found in most implementations and explanations of the algorithm.

## Optimisations Removed

* Majority support as the winning condition
Replaced with unanimity as the winning condition.
The function to determin the winner, given unanimity, is far simpler than the equivelent, given majority.
Explicitly testing for unanimity better explesses the goal of reaching consensus.

* Redistributing ballots from the weakest candidates to the stronger
Replaced with the disqualification of the weakest candidate and recounting of all ballots.
The function to perform a 2D filter of candidates from ballots is far simpler than the equivalent to redistribute ballots from the weakest candidates to the remaining candidates based on their preferences while removing the weakest.
This better expresses that every ballot is recounted as many times as there are rounds of voting.

## Known Bugs

In the case of a tie between weakest candidates, only one is disqualified, and the selection of the which is disqualified is based on their alphabetical order, giving an advantage to candidate 'C' over candidate 'A', as seen in the example:

`["ABC"
,"ABC"
,"CBA"
,"BCA"
]

-> 'C'`
