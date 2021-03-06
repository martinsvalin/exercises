module HelloWorld (..) where
helloWorld : Maybe String -> String
helloWorld name =
  case name of
    Nothing -> "Hello, World!"
    Just name -> "Hello, " ++ name ++ "!"