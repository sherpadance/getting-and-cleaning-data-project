downloadData <- function() {
    # downloadData.R checks if the source data for the `Getting and Cleaning Data Course Project`
    # was previously downloaded. If so, it asks the user whether to refresh the data.
    # If not, the datafile is downloaded and extracted to a `Data` subdirectory, which
    # is created if it does not exist.
    #
    # After completion of this function, the working directory contains a 'Data'
    # directory, which contains a Dataset.zip file. The contents of this file
    # are extracted into Data/UCI HAR Dataset.
    # TThe function returns the date the dataset was downloaded; or NULL if no
    # data was downloaded
    
    # -------------------------------------------------------------------------
    
    # Initialize return value
    downloadDate <- NULL
    
    # check if datafile currently exists
    #   if not: download
    #   if yes: check if redownload required (user input)
    
    dataFile = file.path(getwd(), "Data", "Dataset.zip")
    replaceFile = ""
    
    print("Downloading data file...")
    if (!file.exists("Data")) {
        dir.create(file.path(getwd(), "Data"))
        replaceFile <- "yes"
    } else if (!file.exists(dataFile)) {
        replaceFile <- "yes"
    } else {
        while (replaceFile != "yes" & replaceFile != "no") {
            replaceFile <- tolower(readline("Existing datafile found. Would you like to re-download the data file? (yes/no) "))
        }
    }
    
    if (replaceFile == "yes") {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      dataFile, mode="wb")
        data.downloaded <- Sys.time()
        
        print("Unzipping file contents...")
        unzip(dataFile, overwrite=TRUE, exdir="Data")
        
        downloadDate <- Sys.time()
    }
    
    return(downloadDate)
}

