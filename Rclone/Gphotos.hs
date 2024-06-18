module Gphotos where
import qualified Util as U
import Data.List

downloadDay y m d = do
  fl <- day y m d >>= return . map last
  mapM_ dl fl
  where 
    fn f = slash [byDay y m d,f]
    dl f = download f $ fn f  

byDay y m d = slash ["/media","by-day",show y,dash [show y,n2 m,n2 d]]
byMonth y m = slash ["/media","by-month",show y,dash [show y,n2 m]]

slash = intercalate "/"
dash = intercalate "-"
n2 i = if length s == 2 then s else "0" ++ s 
  where s = show i

day y m d = ls $ byDay y m d 
month y m = ls $ byMonth y m
days y = lsd $ "/media/by-day/" ++ show y
months y = lsd $ "/media/by-month/" ++ show y
years = lsd "/media/by-year"
everything = lsd "/media/all"
media = lsd "/media"
root = lsd "/"
albums = lsd "album"

download o i = rclone ["copy",remote i,o]
lsd d = rclone ["lsd",remote d]
ls d = rclone ["ls",remote d]

remote = (++) "gphotos:"

rclone l = do
  putStrLn $ unwords opts 
  U.proc "rclone" opts >>= return . map words . lines
  where
    opts = ["--gphotos-include-archived"] ++ l

