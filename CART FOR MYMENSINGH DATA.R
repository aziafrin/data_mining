##===== CART for Mymensingh Climate Data =======#

rm(list=ls())

#install.packages("rpart.plot")
#install.packages("ggplot2")
#install.packages(c("rpart.plot","ggplot2","randomForest"))
library(rpart)
library(rpart.plot)
library(ggplot2)
library(randomForest)

DT=read.csv("D:/Mymensingh.csv",header=TRUE)
head(DT)
DT[,c(1:4,10:11)]=NULL
head(DT)
dim(DT)
DD=na.omit(DT,1)
head(DD)

DD$RAN=factor(DD$RAN)
str(DD)

#==Check that no data is missing ===#
##==HERE 1 for row, and 2 for column ===#
#apply(DD,1,function(x) sum(is.na(x)))
apply(DD,2,function(x) sum(is.na(x)))

dim(DD)

#==LIGHT RAIN (1-10 MM), MODERATE RAIN (11-22 MM), MODERATELY HEAVY RAIN (23-43 MM),
#==HEAVY RAIN (44-88 MM), VERY HEAVY RAIN WITH GREATER THAN 88 MM

set.seed(12357)
ID=sample(1:nrow(DD), round(nrow(DD)*0.75,0), replace=FALSE)

length(ID)
TR=data.frame(DD[ID,])  # Training Data
TS=data.frame(DD[-ID,]) # Test Data
nrow(TR)
head(TR)
tail(TR)

RT=rpart(RAN~., data=TR,method="class",control=rpart.control(cp=0.007))

summary(RT)
printcp(RT)

dev.new(width=6,height=6)
rpart.plot(RT,type=4,digits=2,fallen.leaves=FALSE,font=1,cex=0.6,main="CART Model",cex.main=1)



printcp(RT)
printcp(RT, digits = getOption("digits") - 4)

RT$cptable
bestcp =RT$cptable[which.min(RT$cptable[,"xerror"]),"CP"]
bestcp


#==Step3: Prune the tree using the best cp.
tree.pruned = prune(RT, cp = bestcp)
tree.pruned


dev.new(width=6,height=6)
rpart.plot(tree.pruned,type=4,digits=2,fallen.leaves=FALSE,font=1,cex=0.6,main="CART Model",cex.main=1)




head(TR)

PRR=predict(RT, data=TR[,-6],type="class")
TRR=table(TR$RAN,PRR)
ARR=sum(diag(TRR))/sum(TRR)
TRR
ARR
1-ARR


PRS=predict(RT, newdata=TS[,-6],type="class")
TSS=table(TS$RAN,PRS)
ASS=sum(diag(TSS))/sum(TSS)
TSS
ASS
1-ASS

