import GHC.Exts (sortWith, groupWith)
import Data.List (sort, group)
--import System.Random (randomRIO)

type Candidate = Char
type Ballot = [Candidate]

main :: IO ()
main = consensus testBallot >>= print

-- disqualify weakest candidate until unanimous

consensus :: [Ballot] -> IO Candidate
consensus ballots
    | unanimous ballots = return . favourite $ head ballots
    | otherwise = do
                    weakest <- pick (weakests ballots)
                    consensus $ disqualify weakest ballots

unanimous :: [Ballot] -> Bool
unanimous = (== 1) . length . groupWith favourite

disqualify :: Candidate -> [Ballot] -> [Ballot]
disqualify candidate = nonEmpty . filtered
    where
        filtered = map $ filter (/= candidate)
        nonEmpty = filter $ not . null

weakests :: [Ballot] -> [Candidate]
weakests = weakests' . counts
    where
        counts = group . sort . map favourite
        weakests' = map head . head . groupWith length . sortWith length

pick :: [Candidate] -> IO Candidate
pick = return . head
--pick ballots = fmap (ballots !!) $ randomRIO (0, length ballots - 1)

favourite :: Ballot -> Candidate
favourite = head

-- Data

testBallot :: [Ballot]
testBallot = ["ABC"
             ,"ABC"
             ,"CBA"
             ,"BCA"
             ]

ballots :: [Ballot]
ballots = ["ABCD"
          ,"ABCD"
          ,"ABCD"
          ,"BACD"
          ,"BACD"
          ,"CBAD"
          ,"CBAD"
          ,"DBAC"
          ]

ballots2 :: [Ballot]
ballots2 = ["EABFCD"
           ,"AECBFD"          
           ,"BFDEAC"
           ,"FCADEB"
           ,"ABFDCE"
           ,"ECDFBA"
           ,"DEBACF"
           ,"ADFEBC"
           ,"FCABED"
           ,"DAFCBE"
           ,"ECADFB"
           ,"CDEBAF"
           ,"DBFAEC"
           ,"BADFCE"
           ,"ECFABD"
           ,"DFEACB"
           ,"CAEDFB"
           ,"ECADFB"
           ,"CDFEBA"
           ,"EABFCD"
           ,"AECBFD"
           ,"BFDEAC"
           ,"FCADEB"
           ,"ABFDCE"
           ,"ECDFBA"
           ,"DEBACF"
           ,"FCABED"
           ,"ECADFB"
           ]
