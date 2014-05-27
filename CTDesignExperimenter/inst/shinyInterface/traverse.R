## traverse over tree using recursion

temp = tagList(div(hr(),"abc"))
temp[[1]] = tagAppendAttributes(temp[[1]], class="c")

traverse = function(tree, level=1, index=numeric(0), searchTerm=NULL,
                    searchCallback='as.vector(attr(tree, "index"))') {
  if(is.list(tree)){
    answer = list()
    for(i in seq(along=tree)){
      nextanswer = traverse(tree[[i]], level=level+1, 
                            index=c(index,i), searchTerm=searchTerm)
     if(!is.null(nextanswer)) {
        attr( nextanswer, "index") = c(index,i)
        if(!is.null(searchTerm))
          return(nextanswer)
      }
      answer = list(answer, nextanswer)
    }
    if(is.null(searchTerm))
      return(answer)
    else
      return(NULL)
  }
  else {
    attr( tree, "index") = index
    if(is.null(searchTerm))
      return(tree)
    if(searchTerm == tree) 
      return(eval(parse(text=searchCallback)))
    return(NULL)
  }
}
#traverse(myTree)

myTree[[print(as.vector(
  traverse(myTree, searchTerm = "SummarizeSimulation"))
  )]]
# myTree[[c(5 , 3,  1,  3,  1, 13,  3,  1,  1)]]
## OK it will work.
#myTree[[c(5 , 3,  1,  3,  1, 13,  3,  1,  2)]]  # (0)
#myTree[[c(5 , 3,  1,  3,  1, 13,  2 )]]  # list()
#traverse(myTree, searchTerm = " (2)")


#The data are in myTree[[5]].  1 2 and 3 are NOT empty...
# but not printing unless unlisted first
# myTree[[4]]
# <script>$(function() {$('#jstree1').jstree()})</script> 

# debug(traverse)
# 
# class(
#   myTree[[5]][[2]][[1]]  # jstree
#   myTree[[5]][[2]][[2]]  # ss-jstree
# )
# myTree[[5]][[3]][[1]][[1]] = "ul id='THIS-ID'"
# 
# 
# traverse(myTree)
# attr(traverse(myTree)[[186]], "index")
# 