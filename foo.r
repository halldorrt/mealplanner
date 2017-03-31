



optimizeRecipe <- eventReactive(input$neossend, {
    if (nchar(urlGlobal)>0) {
        tmp <-NgetSolverTemplate(category = "milp", solvername = "MOSEK", inputMethod = "AMPL")
        modc <- paste(paste(readLines("spoonacular.mod"), collapse = "\n"), "\n")
        datc <- paste(paste(readLines("spoonacular.dat"), collapse = "\n"), "\n")
        runc <- paste(paste(readLines("spoonacular.run"), collapse = "\n"), "\n")
        ## create list object
        argslist <- list(model = modc, data = datc, commands = runc, comments = "")
        ## create XML string
        xmls <- CreateXmlString(neosxml = tmp, cdatalist = argslist)
        test <<- NsubmitJob(xmlstring = xmls, user = "rneos", interface = "",id = 0)
        result <- c("Uploaded to Neos server ... try to get results in a few seconds or so")
    }
    else {
        result <- c("Waiting for you to search for recipies ...")
    }
    result
})
output$optimizeString <- renderText(optimizeRecipe())

# Here we get the result from the Neos server
neosFetch <- eventReactive(input$neosget, {
    result <- NgetFinalResultsNonBlocking(obj = test, convert = TRUE)
    result <- getElement(result,"ans")
    lausn <- strsplit(result, '<lausn>', fixed = FALSE, perl = FALSE, useBytes = FALSE)[[1]][2]
    lausn <- strsplit(lausn," ")
    save(file="tmp.Rdata", list=c("recipeGlobal", "lausn", "result"))
    recipeGlobal[,"Selected"] <- FALSE
    for (i in c(1:length(lausn[[1]]))) {
        recipeGlobal[recipeGlobal[,"Ident"] == as.integer(lausn[[1]][i]), "Selected"] <- TRUE
    }
    hraefni <- strsplit(result, '<hraefni>', fixed = FALSE, perl = FALSE, useBytes = FALSE)[[1]][2]
    hraefni <- strsplit(hraefni," ")
    hraefnistr = c("")
    for (i in c(1:length(hraefni[[1]]))) {
        hraefnistr <- paste(hraefnistr,hraefni[[1]][i]);
    }
    output$recipeString <- renderDataTable(recipeGlobal)
    result <- hraefnistr
})
output$neosString <- renderText(neosFetch())
})
