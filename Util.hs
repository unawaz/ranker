module Util where
import qualified System.Process as P
import Data.List

proc p l = P.readProcess p l ""
shell = P.callCommand . unwords
pipe = shell . intersperse "|"
