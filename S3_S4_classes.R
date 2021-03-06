#####  S3_S4_classes.R
####  See also S3andS4_getting_info.Rnw and S3andS4_getting_info.pdf

methodsInBase = intersect(apropos("method"), ls(pos="package:base"))
methodsInUtils = intersect(apropos("method"), ls(pos="package:utils"))  
methodsInMethods = intersect(apropos("method"), ls(pos="package:methods"))
methodsInRoo = intersect(apropos("method"), ls(pos="package:R.oo"))
methodsInR.mS3 = intersect(apropos("method"), ls(pos="package:R.methodsS3"))
method_related = rbind(
  data.frame(sys="S3", f=methodsInBase, wh="base"),
  data.frame(sys="S3", f=methodsInUtils, wh="utils"),
  data.frame(sys="S3", f=methodsInRoo, wh="R.oo"),
  data.frame(sys="S3", f=methodsInR.mS3, wh="R.methodsS3"),
  data.frame(sys="S4", f=methodsInMethods, wh="methods")
)
classesInBase = intersect(apropos("class"), ls(pos="package:base"))
classesInUtils = intersect(apropos("class"), ls(pos="package:utils"))  
classesInMethods = intersect(apropos("class"), ls(pos="package:methods"))
classesInRoo = intersect(apropos("class"), ls(pos="package:R.oo"))
classesInR.mS3 = intersect(apropos("class"), ls(pos="package:R.methodsS3"))
class_related = rbind(
  data.frame(sys="S3", f=classesInBase, wh="base"),
#  data.frame(sys="S3", f=classesInUtils, wh="utils"),
  data.frame(sys="S3", f=classesInRoo, wh="R.oo"),
#  data.frame(sys="S3", f=classesInR.mS3, wh="R.methodsS3"),
  data.frame(sys="S4", f=classesInMethods, wh="methods")
)



setdiff(apropos("method"), 
        c(methodsInBase, methodsInUtils, methodsInMethods, methodsInRoo, methodsInR.mS3))
table(unlist(sapply(..(), find)))
