
import GHC.Exts
import Data.List

type Candidate = Char
type Ballot = [Candidate]

main :: IO ()
main = print $ consensus ballotFail1

-- disqualify weakest candidate until unanimous

consensus :: [Ballot] -> Candidate
consensus ballots
    | unanimous ballots = head . head $ ballots
    | otherwise         = consensus $ disqualify (weakest ballots) ballots

unanimous :: [Ballot] -> Bool
unanimous = (== 1) . length . groupWith head

disqualify :: Candidate -> [Ballot] -> [Ballot]
disqualify candidate = filter (/= []) . map (filter (/= candidate))

weakest :: [Ballot] -> Candidate
weakest = head . head . sortWith length . group . sort . map head

-- Data

ballotFail1 :: [Ballot]
ballotFail1 = ["ABC"
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
