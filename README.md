# Haskell-Instant-Runoff-Voting
A simple implementation of IRV

## Algorithm

> Recursively disqualify the least popular candidate until ballots are unanimous.

## Goal

Optimised for concise expressiveness for ease of verification and comprehension by removing performance optimisations found in most implementations and explanations of the algorithm.

## Optimisations Removed

* Majority support as the winning condition: 
Replaced with unanimity as the winning condition.
The condition of unanimity is simpler to demonstrate than the condition of majority.
Explicitly testing for unanimity better expresses the consensus.

* Redistributing ballots from the weakest candidates: 
Replaced with the disqualification of the weakest candidate.
Filtering the weakest candidates from the ballots is simpler than redistributing ballots between candidates while recording disqualifications.
This better expresses that all filled ballots remain between rounds and that all are recounted.

## Optimisation Retained

* Use ranked-choice ballots.
The simplest alternative is a series of referenda with single-choice ballots.
This would cost users' an impractical amount of time.
However, the alternative better demonstrates the fairness of the system, as abstaining from providing preferences on a ranked-choice ballot is not so clearly equivalent to abstaining from a round of voting.
