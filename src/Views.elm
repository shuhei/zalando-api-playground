module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, src, alt, class, value, type', title, target)
import Html.Events exposing (onSubmit, onInput, onClick)

import Types exposing (..)

brandView : Brand -> Html Msg
brandView brand =
  let name = case brand.logoUrl of
               Just logoUrl -> img [src logoUrl, alt brand.name] []
               Nothing -> text brand.name
  in li [class "Brand"]
       [a [href brand.shopUrl, title brand.name, target "_blank"] [name]]

brandsView : List Brand -> Bool -> Html Msg
brandsView brands hasMore =
  let loadMore = if hasMore
                 then [button [class "Button", onClick FetchMoreBrands] [text "More"]]
                 else []
  in div []
       [ ul [class "BrandList"] <| List.map brandView brands
       , p [] loadMore
       ]

searchBox : Html Msg
searchBox =
  form [class "SearchBox", onSubmit SearchBrands]
    [ input [class "TextField", onInput UpdateSearchKeyword] []
    , button [class "Button"] [text "Search"]
    ]
