import GHC.Exts (sortWith, groupWith)
import Data.List (sort, group)
import System.Random (randomRIO)
import System.Environment (getArgs)
import Data.List (nub)

type Candidate = Char
type Ballot = [Candidate]


main :: IO ()
main = do
    args <- getArgs
    let path = head args :: FilePath
    ballots' <- readFile path
    let ballots = read ballots' :: [Ballot]
    result <- consensus ballots
    print result


consensus :: [Ballot] -> IO Candidate
consensus ballots
    | unanimous ballots = return . favourite $ head ballots
    | otherwise = do
                    weakest <- random (weakests ballots)
                    consensus $ disqualify weakest ballots


unanimous :: [Ballot] -> Bool
unanimous = (== 1) . length . groupWith favourite


disqualify :: Candidate -> [Ballot] -> [Ballot]
disqualify candidate = nonEmpty . filtered
    where
        filtered = map $ filter (/= candidate)
        nonEmpty = filter $ not . null


weakests :: [Ballot] -> [Candidate]
weakests ballots = head $ groupWith count $ sortWith count candidates
    where
        count candidate = length $ filter (for candidate) ballots
        for candidate ballot = (favourite ballot) == candidate
        candidates = nub . concat $ ballots


random :: [Candidate] -> IO Candidate
random ballots = (ballots !!) <$> randomRIO (0, length ballots - 1)


favourite :: Ballot -> Candidate
favourite = head
