## this program best.R houses the main function best.R which determines the best hospital in a specified 
## state in terms of the 30-day mortality rate of a specified outcome (i.e., heart attack, heart failure, 
## or pneumonia)
## best.R is supported by 4 functions:
##     (1) read_data(): read in the dataset containing data on 4000 major U.S. hospitals on various metrics including 30-day mortality rate for heart attack, heart failure, and pneumonia
##     (2) validateState(): ensure the passed in state is valid
##     (3) validateOutcome(): ensure the passed in outcome is valid 
##     (4) findBestHospital(): return the best hospital in the state for the outcome


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


## this function checks that outcome is valid
## the outcomes can be one of "heart attack", "heart failure", or "pneumonia" 
## this function stops the execution if outcome is invalid
validateOutcome <- function(outcome, possible_outcomes) {
  if (!(outcome %in% names(outcomes))) {
    stop("Invalid outcome!")
  }
}


## this function returns the best hospital in the state with the lowest mortality rate for the specified outcome
findBestHospital <- function(data) {
  min_fatality <- Inf
  hospitals <- c()

  for(i in 1:nrow(data)) {
    fatality_rate <- data$rate[i]
    hospital <- data$hospital[i]
    if (fatality_rate < min_fatality) {
        min_fatality <- fatality_rate
        hospitals <- hospital
    }
    if (fatality_rate == min_fatality) {
      hospitals <- c(hospitals,hospital)
    }
  }
  ## sort the hospital names and return the top one in lexicographical order
  hospitals <- sort(hospitals)
  hospitals[1]
}


## this function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specifed outcome in that state. 
## If there is a tie for the best hospital for a given outcome, then the hospital names should be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b" and "c" are tied for best, then hospital "b" should be returned)
best <- function(state, outcome) {
  ## Check that state and outcome are valid
  ## there are 3 outcomes in scope for this analysis: heart attack, heart failure, pneumonia 
  outcomes <- c("heart attack" = 11, "heart failure"=17, "pneumonia"=23)
  validateOutcome(outcome,outcomes)
  state_file_path <- "states.csv"
  validateState(state,state_file_path)
  
  ## Read outcome data for hospitals in the state, except ones with no data on the outcome
  outcome_file_path <- "outcome-of-care-measures.csv"
  data <- readData(outcome_file_path, state, outcome, outcomes)
  
  ## return hospital name in that state with lowest 30-day death rate
  best_hospital <- findBestHospital(data)
  best_hospital
}

