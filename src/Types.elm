module Types exposing (..)

import Http

type Msg
  = FetchBrandListDone BrandList
  | FetchBrandListFail Http.Error
  | FetchMoreBrands
  | SearchBrands
  | UpdateSearchKeyword String

type alias BrandFamily =
  { key : String
  , name : String
  , shopUrl : String
  }

type alias Brand =
  { key : String
  , name : String
  , shopUrl : String
  , logoUrl: Maybe String
  , logoLargeUrl : Maybe String
  , brandFamily: Maybe BrandFamily
  }

type alias BrandList =
  { totalElements : Int
  , totalPages : Int
  , page : Int
  , size : Int
  , content : List Brand
  }
