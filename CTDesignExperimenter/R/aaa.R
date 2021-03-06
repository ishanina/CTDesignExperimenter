cat("======== aaa.R  ================\n")


#printFunctionBody = function(f) attributes(attributes(f)$srcref)$srcfile$lines

printFunctionBody = function(f) {
  theBody = capture.output(f)
  theBody = gsub("^<environment.*", "", theBody) ## Remove env line if not .Primitive
  #gsub("[\t ]+", " ", 
  paste(collapse="\n", theBody) 
}
##  Previously (deparse((body(f)))), but doesnt work on .Primitives

### Convenience utilities borrowed from mvbutils

`%&%` = function (a, b)
        paste(a, b, sep = "")

`%except%` = function (vector, condition) 
	vector[match(vector, condition, 0) == 0]

"cq" = function (...) 
{
    as.character(sapply(as.list(match.call(expand.dots = TRUE))[-1], 
        as.character))
}

as.cat = function (x) 
{
  stopifnot(is.character(x))
  oldClass(x) <- "cat"
  x
}

catn=function(...) cat(..., "\n")

withNames =
  function(x, n) {
	if(length(x) != length(n))
		stop("withNames: ",length(x), "!=", length(n)) 
	if(length(x) == 0)
		return(NULL)
	temp = data.frame(x=x,n=n);
        x = temp$x;
        n = temp$n;
        names(x) <- n; 
        x
}

###### Other utilities

shorten = function(vec, cutsize) vec[1: (length(vec)-cutsize)]
## should be an S3 generic.

ifVerboseCat = function(..., defaultVerbose=FALSE){
  #print(paste0("ifVerboseCat: sys.call(-1)=", sys.call(-1)))
  f=try(as.character(parse(text=sys.call(-1)[1]))[1] )
  if(class(f) == "try-error") return(invisible(NULL))
  if(!exists("verboseOptions"))
    assign("verboseOptions", logical(0), pos=1, immediate=TRUE)
  if(is.na(verboseOptions[f])) {
    verboseOptions[f] <<- defaultVerbose
    #ifVerboseCat(verboseOptions)
  }
  if(verboseOptions[f]) 
    catn(f, ": ", ...)
  invisible(NULL)
}

clear = function(keep=c(".ctde", "startup", "verboseOptions")){
  answer <- repeat {
    cat("Delete ALL files in .GlobalEnv except ",
      paste(keep, collapse="&"), "?\n  (cannot be undone): ")
    answer <- readline()
    answer <- gsub("(\\w)", "\\U\\1", answer, perl=T)
    answer <- pmatch(answer, c("YES",  "NO", "N"))
      if (!is.na(answer)) {
        if(answer %in% 1)  
        rm(list=setdiff(ls(all=T, pos=1), keep), pos=1)
      else
        cat("Aborted. No objects deleted.\n")
      return(invisible(NULL))
    }
  }
}


#' from Yuanyuan
#' ## Function: instantiateS4Object
# className is a character 
# "slots" is a named list with the names corresponding to the slot names
instantiateS4Object <- function(className,slots){
  Object <- new(className)
  for ( SlotName in names(slots))
    slot(Object,SlotName) <- slots[[SlotName]]
  return(Object)
} 

### other utilities
### inclusive , includes the endpoints
"%between%" = function(x, range) { (x<=range[2] & x>=range[1])}


######################
### Some utility classes and methods.  These may no longer be necessary.
## Class Union: NumericLogical
setClassUnion("NumericLogical",c("numeric","logical"))

## Class Union: OptionalNumeric
setClassUnion("OptionalNumeric",c("numeric","NULL"))

## Class Union: OptionalCharacter
setClassUnion("OptionalCharacter",c("character","NULL"))
