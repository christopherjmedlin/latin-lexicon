{-# LANGUAGE QuasiQuotes, TemplateHaskell, TypeFamilies #-}
{-# LANGUAGE OverloadedStrings, GADTs, FlexibleContexts #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Database where

import Database.Esqueleto
import qualified Database.Persist as P
import Database.Persist.TH
import Data.Text (Text)
import Data.Word (Word8)
import Database.Persist.Sqlite

share [mkPersist sqlSettings, mkMigrate "migrateTables"] [persistLowerCase|
Noun
  nominativeSingular Text
  genitiveSingular   Text
  gender             Word8
Verb
  firstPresentActiveIndicative Text
  activeInfinitive             Text
  firstPerfectActiveIndicative Text
  supine                       Text
  deponent                     Bool
|]

initDb :: IO ()
initDb = runSqlite ":memory:" $ runMigration migrateTables

