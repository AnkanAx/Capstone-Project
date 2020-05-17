library(shiny)

load("ngrams.RData")

remove_symbols <- function(x){
        x <- gsub("[`’‘]","'",x)
        x <- gsub("[^a-z']"," ",x)
        x <- gsub("' "," ",x)
        x <- gsub(" '"," ",x)
        x <- gsub("^'","",x)
        x <- gsub("'$","",x)
        x
}

Predictor <- function(sentence) {
        Match <- FALSE
        txt <- tolower(sentence)
        txt <- remove_symbols(txt)
        txt <- unlist(strsplit(txt, split=" "))
        txtlength <- length(txt)
        
        #tetra
        if (txtlength > 2 & !Match)  {
                tritxt <- paste(txt[(txtlength-2):txtlength])
                tritx <- paste("^",tritxt,"$", sep = "")
                word4 <- tetra[grepl(tritx[1],tetra$word1) & grepl(tritx[2],tetra$word2) & grepl(tritx[3],tetra$word3),]
                
                if (length(word4[,1]) > 0) {
                        Predict1 <- word4[1,4];
                        Predict2 <- word4[2,4];
                        Predict3 <- word4[3,4];
                        terms <- paste(tritxt,collapse=" ")
                        ngram <- 4
                        Match <- TRUE;
                }
        }
        
        #tri
        if (txtlength > 1 & !Match)  {
                bitxt <- paste(txt[(txtlength-1):txtlength])
                bitx <- paste("^",bitxt,"$", sep = "")
                word3 <- tri[grepl(bitx[1],tri$word1) & grepl(bitx[2],tri$word2),]
                
                if (length(word3[,1]) > 0) {
                        Predict1 <- word3[1,3];
                        Predict2 <- word3[2,3];
                        Predict3 <- word3[3,3];
                        terms <- paste(bitxt,collapse=" ")
                        ngram <- 3
                        Match <- TRUE;
                }
        }
        
        #bi
        if (txtlength > 0 & !Match)  {
                unitxt <- paste(txt[txtlength])
                unitx <- paste("^",unitxt,"$", sep = "")
                word2 <- bi[grepl(unitx[1],bi$word1),]
                
                if (length(word2[,1]) > 0) {
                        Predict1 <- word2[1,2];
                        Predict2 <- word2[2,2];
                        Predict3 <- word2[3,2];
                        terms <- paste(unitxt,collapse=" ")
                        ngram <- 2
                        Match <- TRUE;
                }
        }
        
        #uni
        if (txtlength > 0 & !Match)  {
                Predict1 <- 'the';
                Predict2 <- 'and';
                Predict3 <- 'for';
                terms <- 'NA'
                ngram <- 1
                Match <- TRUE;
        }
        
        result <- data.frame(Prediction1 = Predict1, Prediction2 = Predict2, Prediction3 = Predict3);
        return(result)
}

shinyServer(function(input, output) {
    observeEvent(input$do, {
    out <- Predictor(input$sentence);
    output$out1 <- renderText({as.character(out[1,1])});
    })
})
