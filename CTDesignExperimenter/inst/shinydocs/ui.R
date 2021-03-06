
require(RBioinf)
require(RJSONIO)
specClassNames <<- c(`Variables`="Variable",
                   `Variable Generators`="VariableGenerator",
                   `Inserts`="Insert",
                   `Scenarios`="ListOfInserts")
shortName = function(specifierName)
  names(classNames)[match(specifierName, classNames)]

addAttr = function(x, att, value) {attr(x, att) = value; x }
asHTML = function(x) addAttr(x, "html", TRUE)

shinyUI(pageWithSidebar(  
  #<style font='red' bg='yellow' > </style>
  headerPanel=uiOutput(outputId="headerOutput")
 ,
  sidebarPanel=sidebarPanel(
    #tag('font', varArgs=c(size=-2))
    #tags$style(" size=\"-2\" color='red'",
    radioButtons("viewChoice", "Choose a view",
                 c("View spec classes", 
                    "View spec objects",
                    "Define one clinical trial",
                    "Run one clinical trial",
                    "Do a CT experiment"))
    #, tag('hr', NULL) ###  May cause the chr(0) problem in htmlEscape
    , conditionalPanel(condition=
                         "input.viewChoice==\"View spec classes\"",
                       "Choose spec class to view its subclasses.",
                       radioButtons("specChoiceClasses", "choose spec type", specClassNames)
    )
    , conditionalPanel(condition=
                         "input.viewChoice==\"View spec objects\"",
                       "Choose spec class to view its objects.",
                       radioButtons("specChoiceModels", "choose spec type", 
                                    specClassNames )
    )
    , conditionalPanel(condition=
                         "input.viewChoice==\"Define one clinical trial\""
                       , "Spec selections for one CT:"
                       ,     uiOutput("componentsForBuildingModel")
    )
    , conditionalPanel(condition=
                         "input.viewChoice==\"Run one clinical trial\""
                       ,   "sim1CTbuttonUI"
                       ,  uiOutput("sim1CTbuttonUI")
    )
    , conditionalPanel(condition=
                         "input.viewChoice==\"Do a CT experiment\""
                       # #        textOutput("viewChoice")
                       , "This view choice is not yet implemented." 
    )
  ),
  mainPanel=mainPanel(
    # condition MUST BE VALID JS. 
    # Therefore: input & output cannot share an ID. 
    # Thus, the prepended "x".
    # Likewise, you can't put the following 2 lines in 2 places!!
    # If you see...
    #   Error in tag("div", list(...)) : argument is missing, with no default
    # it's because of an extra comma--  empty arg.
      
    h3(uiOutput(outputId="mainPanelHeader"))
    , conditionalPanel(
      condition="input.viewChoice==\"View spec classes\"",
      tableOutput(outputId="classes_table")
    )
    , conditionalPanel(
      condition="input.viewChoice==\"View spec objects\"",
      tableOutput(outputId="objects_table_1")
    )
    ,  conditionalPanel(
        condition="input.viewChoice==\"Define one clinical trial\""
      , uiOutput("buildingModelMain")
        
    )
    ,  conditionalPanel(
      condition="input.viewChoice==\"Run one clinical trial\""
      , uiOutput("resultsSim1CTModelMain")
    )
    
    ,  conditionalPanel(
        condition=
        "input.viewChoice==\"Do a CT experiment\"",
      ("NOT YET IMPLEMENTED")
    )
  )))
