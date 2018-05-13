# Haskell-Instant-Runoff-Voting
A simple implementation of IRV

## Algorithm

> Recursively disqualify the least popular candidate until the result is unanimous.

## Goal

Optimised for concise expressiveness for ease of verification and comprehension by removing performance optimisations found in most implementations and explanations of the algorithm.

## Optimisations Removed

* Majority support as the winning condition: 
Replaced with unanimity as the winning condition.
The function to determin the winner, given unanimity, is far simpler than the equivelent, given majority.
Explicitly testing for unanimity better explesses the goal of reaching consensus. Unanimity is achieved when no other candidate has support, or by extension, when no other candidate remains non-disqualified.

* Redistributing ballots from the weakest candidate to the stronger candidates based on their preferences: 
Replaced with the disqualification of the weakest candidate and recounting of all ballots.
The function to perform a filter of candidates from ballots is far simpler than the equivalent to distribute ballots into groups, remove groups, and redistribute ballots between the groups while avoiding the removed groups.
This better expresses that every ballot is recounted as many times as there are rounds of voting.
