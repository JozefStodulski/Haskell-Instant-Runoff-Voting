import GHC.Exts (sortWith, groupWith)
import Data.List (sort, group)
--import System.Random (randomRIO)

type Candidate = Char
type Ballot = [Candidate]

main :: IO ()
main = do
        result <- consensus testBallot
        print result

-- disqualify weakest candidate until unanimous

consensus :: [Ballot] -> IO Candidate
consensus ballots
    | unanimous ballots = return $ head . head $ ballots
    | otherwise = do
                    weakest <- random (weakests ballots)
                    consensus $ disqualify weakest ballots

unanimous :: [Ballot] -> Bool
unanimous = (== 1) . length . groupWith head

disqualify :: Candidate -> [Ballot] -> [Ballot]
disqualify candidate = removeEmptyBallots . filterCandidate
    where
        filterCandidate = map (filter (/= candidate))
        removeEmptyBallots = filter (/= [])

weakests :: [Ballot] -> [Candidate]
weakests = weakests' . count
    where
        count = group . sort . map head
        weakests' = map head . head . groupWith length . sortWith length

random :: [Candidate] -> IO Candidate
random = return . head
--random ballots = fmap (ballots !!) $ randomRIO (0, length ballots - 1)

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
