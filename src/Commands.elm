module Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task

import Types exposing (..)

-- Decoders

brandFamilyDecoder : Decode.Decoder BrandFamily
brandFamilyDecoder =
  Decode.object3 BrandFamily
    ("key" := Decode.string)
    ("name" := Decode.string)
    ("shopUrl" := Decode.string)

brandDecoder : Decode.Decoder Brand
brandDecoder =
  Decode.object6 Brand
    ("key" := Decode.string)
    ("name" := Decode.string)
    ("shopUrl" := Decode.string)
    (Decode.maybe ("logoUrl" := Decode.string))
    (Decode.maybe ("logoLargeUrl" := Decode.string))
    (Decode.maybe ("brandFamily" := brandFamilyDecoder))

brandListDecoder : Decode.Decoder BrandList
brandListDecoder =
  Decode.object5 BrandList
    ("totalElements" := Decode.int)
    ("totalPages" := Decode.int)
    ("page" := Decode.int)
    ("size" := Decode.int)
    ("content" := Decode.list brandDecoder)

-- Fetch

brandsUrl : String
brandsUrl =
  "https://api.zalando.com/brands"

searchBrandsUrl : Int -> String -> String
searchBrandsUrl page keyword =
  brandsUrl ++ "?page=" ++ (toString page) ++ "&name=" ++ keyword

searchBrandList : Int -> String -> Cmd Msg
searchBrandList page keyword =
  Http.get brandListDecoder (searchBrandsUrl page keyword)
    |> Task.perform FetchBrandListFail FetchBrandListDone
