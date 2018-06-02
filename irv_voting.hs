import GHC.Exts (sortWith, groupWith)
import Data.List (sort, group)
import System.Random (randomRIO)
import System.Environment (getArgs)

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
pick ballots = fmap (ballots !!) $ randomRIO (0, length ballots - 1)

favourite :: Ballot -> Candidate
favourite = head