module Ranker where
import qualified Psql as S

relations = [
  e admin,e user,e item,e list,
  em admin,em user,
  t item "text",t list "directive",
  om admin user,om user list,om user item,
  m "comparison" [user,list,item,item]
  ]
  where
    admin = "admin"
    user = "user"
    item = "item"
    list = "list"
    e = S.entity
    m = S.mapping
    om = S.oneMany
    em = S.email
    t = S.text

ex = psql [S.entity "a",S.entity "b"]

file = readFile S.file >>= putStr
restart = psql [S.dropSchema schema,S.createSchema schema]
functions = psql [S.functions]
tables = psql [S.tables]
psql l = S.psql $ [S.changeSchema schema] ++ l

schema = "prioritizer"

notes = readFile "prioritizer.sql" >>= putStrLn

