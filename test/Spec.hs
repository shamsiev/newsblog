import qualified Spec.Logger as Logger
import Test.Hspec (hspec)

main :: IO ()
main =
  hspec $ do
    Logger.test1
    Logger.test2
    Logger.test3
    Logger.test4
