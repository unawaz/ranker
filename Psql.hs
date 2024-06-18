module Ogg where
import qualified Util as U

data Video = Video FileName
data Audio = Audio FileName
type FileName = String
type Seconds = Int
type Flag = String

resize = undefined
addComment = undefined
createPreview = undefined
transcode = undefined

thumbnail = undefined
slideshow = undefined
silence = undefined

split :: Video -> IO ()
split v = U.shell [vid v]

cutLength = cut "l"
cutEnd = cut "e"

cut :: Flag -> Video -> Video -> Seconds -> Seconds -> IO ()
cut k o i s v = U.shell $ [start,opt] ++ [vid i,vid o] 
  where
    start = flagi "s" s
    opt = flagi k v

cat :: Video -> [Video] -> IO ()
cat o = U.shell . (++) ["oggCat",vid o] . map vid

join :: Video -> Audio -> Video -> IO ()
join o a v = U.shell [vid o,vid v,aud a]


flagi k i = flag k $ show i
flag k v = unwords ["-" ++ k,v]
vid (Video s) = s
aud (Audio s) = s
