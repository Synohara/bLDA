library(tm)
library(RMeCab)

parsed <- RMeCab::docMatrixDF(kaken_informatics[, '研究概要'], pos = c("名詞", "形容詞", "動詞"),minFreq = 10)
stopwords <- c("!", "!!", "!!!", "!!!!????", "\")", "(\"", "(´･_･`)", "(•", ")(", ")。", "+", "...※", ".@",
               "\"", "#", "&", "'", "(", ")", ",", "-", ".", "...", "/", "0", "1", "10", "1000", "14", "2",
               "2Z", "3", "30", "3M", "3R", "4", "4P", "5", "6", "7", "8", "80", "9", "00", "04", "085",
               "100", "1019", "1031", "109", "11", "12", "1350", "18", "19", "20", "22", "23", "27", "28日",
               "2G", "2X", "2号", "344", "357", "3D", "44", "45", "500", "542", "5月23日", "630", "6376",
               "9S", ";&", ";;", "@IT", "@_", ":", "://", ";", "?", "@", "A", "RT", "http://", "co", "_", "ー", 
               "ん", "t", "in", "N", "Q", "ﾟ", "JP", "\\", "]", "a", "I", "一", "P", "V", "vvvv", "m", "w",
               "the", "z", "w/", "|", "д", "⇒", "♪", "あれ", "の", "さん", "的", "む", "あと", "いい", "いま",
               "こと", "こないだ", "これ", "さ", "さん", "せい", "そう", "それ", "気", "系", "よう", "方",
               "ある", "する", "いる", "やる", "れる", "できる", "られる", "てる", "化", "もの", "なる")
#stop <-read.csv('stop_words.txt',sep=",")

parsed <- parsed[setdiff(rownames(parsed), stopwords), ]
#parsed <- parsed[setdiff(rownames(parsed), stop), ]

# 1回しか出現しない Termを除外 
parsed <- parsed[!(rowSums(parsed) <= 1), ]
# Term を含まない Document,Blance は削除
balance <- kaken_informatics[, '総配分額']/max(kaken_informatics[, '総配分額'])
balance <- balance[!(colSums(parsed) == 0)] 
balance <- balance * 10 + 0.3
balance[which(balance >= 1)] <- 1
parsed <- parsed[, !(colSums(parsed) == 0)]

head(parsed[, 1:4])


d_kaken <- data.frame()
for (n in 1:length(parsed[1, ])){
  item <- c()
   for (t in 1:length(parsed[, 1])){
     if (parsed[t, n]>= 1) {
       for (i in 1:parsed[t,n]){
        item <- c(item,t)
       }
     }
   }
  d_kaken <- rbind(d_kaken,data.frame(DocumentID=n, WordID=item,Balance=balance[n]))
  print(data.frame(DocumentID=n, WordID=item,Balance=balance[n]))
}