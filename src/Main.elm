module Main exposing (..)

import Html exposing (div, h1, text, Html)
import Html.Attributes exposing (class)
import Html.App

import Types exposing (..)
import Commands exposing (..)
import Views exposing (..)

type alias Model =
  { brands : List Brand
  , keyword : String
  , totalPages : Int
  , page : Int
  }

init : (Model, Cmd Msg)
init =
  let initialModel =
        { brands = []
        , keyword = ""
        , totalPages = 0
        , page = 0
        }
  in (initialModel, searchBrandList 1 "")

view : Model -> Html Msg
view model =
  div [class "Container"]
    [ h1 [] [text "Zalando Brand Search"]
    , searchBox
    , brandsView model.brands (model.page /= model.totalPages)
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FetchBrandListDone brandList ->
      let brands = if brandList.page == 1
                   then brandList.content
                   else model.brands ++ brandList.content
          updatedModel =
            { model
            | brands = brands
            , totalPages = brandList.totalPages
            , page = brandList.page
            }
      in (updatedModel, Cmd.none)
    FetchBrandListFail error ->
      (model, Cmd.none)
    FetchMoreBrands ->
      (model, searchBrandList (model.page + 1) model.keyword)
    SearchBrands ->
      (model, searchBrandList 1 model.keyword)
    UpdateSearchKeyword keyword ->
      ({ model | keyword = keyword }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
