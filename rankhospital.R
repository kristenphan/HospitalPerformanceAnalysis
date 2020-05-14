## this program rankhospital.R houses the main function rankHospital() which returns the name of the 
## hospital in the specified 'state' with the given rank 30-day death rate ('num') for a specified 
## 'outcome' (i.e., heart attack, heart failure, or pneumonia)
## rankHospital.R is supported by ... functions:
##     (1) read_data(): read in the dataset containing data on 4000 major U.S. hospitals on various 
##          metrics including 30-day mortality rate for heart attack, heart failure, and pneumonia
##     (2) validateState(): ensure the passed in state is valid
##     (3) validateOutcome(): ensure the passed in outcome is valid 
##     (4) selectHospital(): return the best hospital in the state given the given rank for the outcome
## example: 
## rankhospital("MD", "heart failure", 5) would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate for heart failure in the state of Maryland


## the function reads in the outcome CSV file from the passed in filepath 
## and returns a data frame with complete records for the specified state and outcome
readData <- function(file_path, state, outcome, outcomes) {
  data <- read.csv(file_path, na.strings= "Not Available", stringsAsFactors=FALSE)
  # retain only 3 columns: hospital name (col 2), state (col 7), mortality rate the specified outcome
  data_by_outcome <- data[,c(2, 7, outcomes[outcome])] 
  names(data_by_outcome) <- c("hospital", "state", "rate")
  # filter out data for the specified state
  data_by_outcome_and_state <- subset(data_by_outcome, state == "TX", select = names(data_by_outcome))
  # filter out "Not Available" data in "rate" column
  final_df <- data_by_outcome_and_state[complete.cases(data_by_outcome_and_state), ]
  final_df
}


## this function checks if the state is valid and stops the execution if it is not
validateState <- function(state,state_file_path) {
  # read a csv file that contains abbreviations of 50 U.S. States and Washington DC (DC)
  states <- read.csv(state_file_path)
  # if the state is valid
  if (!(state %in% states$Postal.Code)) {
    stop("Invalid state!")  
  }
}


## this function checks if the state is valid and stops the execution if it is not
validateState <- function(state,state_file_path) {
  # read a csv file that contains abbreviations of 50 U.S. States and Washington DC (DC)
  states <- read.csv(state_file_path)
  # if the state is valid
  if (!(state %in% states$Postal.Code)) {
    stop("Invalid state!")  
  }
}


## this function checks that outcome is valid
## the outcomes can be one of "heart attack", "heart failure", or "pneumonia" 
## this function stops the execution if outcome is invalid
validateOutcome <- function(outcome, outcomes) {
  if (!(outcome %in% names(outcomes))) {
    stop("Invalid outcome!")
  }
}


## Return hospital name in that state with the given rank 30-day death rate
## In case multiple hospitals have the same 30-day mortality rate for a given cause, those hospitals should be ranked alphabetically
selectHospital <- function(data, outcome, num, outcomes) {
  # sort the hospitals by the mortalitiy rate (ascending) and name (alphabetically)
  sorted_df <- data[order(data$rate, data$hospital),]
  if(num == "best") {
    return(sorted_df$hospital[1])
  } 
  else if(num == "worst") {
    return(sorted_df$hospital[dim(data)[1]]) 
  } 
  else {
    return(sorted_df$hospital[num])  
  }
}

## this function takes three arguments: 
##   (1) the 2-character abbreviated name of a state (state)
##   (2) an outcome (outcome) which can take values "best", "worst", or an integer indicating the ranking (smaller numbers are better)
##   (3) the ranking of a hospital in that state for that outcome (num).
## the function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by the num argument. 
rankHospital <- function(state, outcome, num = "best") {
  ## Check that state and outcome are valid
  ## there are 3 outcomes in scope for this analysis: heart attack, heart failure, pneumonia 
  outcomes <- c("heart attack" = 11, "heart failure"=17, "pneumonia"=23)
  validateOutcome(outcome, outcomes)
  state_file_path <- "states.csv"
  validateState(state, state_file_path)
  
  ## Read outcome data for hospitals in the state, except ones with no data on the outcome
  outcome_file_path <- "outcome-of-care-measures.csv"
  data <- readData(outcome_file_path, state, outcome, outcomes)
  
  ## if the number given by num is larger than the number of hospitals in that state, 
  ## the function returns NA
  if (num != "best" & num != "worst" & num > nrow(data)) {
    return("NA")
  }
  
  ## Return hospital name in that state with the given rank 30-day death rate
  name <- selectHospital(data, outcome, num, outcomes)
  name
}


