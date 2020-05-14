# R: Hospital Performance Analysis

"__Repository Description:__
<br/>
This repository stores the work as part of the Data Science: Foundations using R specialization by Johns Hopkins University. Course URL: https://www.coursera.org/specializations/data-science-foundations-r. Code in this repository is written by myself, Kristen Phan.
<br/>
<br/>
__Caveat__: 
<br/>
If you're currently taking the same course, please refrain yourself from checking out this solution as it will be against Coursera's Honor Code and won’t do you any good. Plus, once you're worked your heart out and was able to solve a particularly difficult problem, a sense of confidence you gained from such experience is priceless :)
<br/>
<br/>
__Assignment Description:__
<br/>
Dataset (file name: outcome-of-care-measures.csv): The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov) run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certifed hospitals in the U.S. This dataset es-
sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients 
(see http://goo.gl/jAXFX for some background on this particular topic).
<br/>
<br/>
Task 1: Write a program named 'best.R' to find the best hospital in a given state in terms of 30-day mortality rate for a specified health condition (heart attack, heart failure, or pneumonia). E.g., best("TX", "heart attack") returns the name of the best hospital in in terms of mortality rate for heart attack (lowest mortality rate) in the state of Texas.
<br/>
<br/>
Task 2: Write a program named 'rankhospital.R' to return the name of the hospital in a specified state given the ranking in mortality rate for a specified health condition (heart attack, heart failure, or pneumonia). E.g., rankhospital("MD", "heart failure", 5) returns the name of the hospital with the 5th lowest 30-day death rate for heart failure in the state of Maryland.
