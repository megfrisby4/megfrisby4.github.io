df = read.csv("Data/Fake_grade_data.csv")
row.names(df) <- df$Student
df$Student <- NULL
totals <- rowSums(df)
df$Final.Points <- totals

data_course_letter_grades = function(x, a.cutoff = 700, 
                                     b.cutoff = c(640,699), 
                                     c.cutoff = c(560,639), 
                                     d.cutoff = c(480,559)){   
  Grade = c()
  
  for(i in 1:length(row.names(x))){
    
    if(x$Final.Points[i] >= a.cutoff){Grade[i] <- "A"}  
    if(x$Final.Points[i] %in% c(b.cutoff[1]:b.cutoff[2])){Grade[i] <- "B"}   
    if(x$Final.Points[i] %in% c(c.cutoff[1]:c.cutoff[2])){Grade[i] <- "C"} 
    if(x$Final.Points[i] %in% c(d.cutoff[1]:d.cutoff[2])){Grade[i] <- "D"}
    if(x$Final.Points[i] < d.cutoff[1]){Grade[i] <- "E"}   
  }  
  assign("letter.grades", Grade, envir = .GlobalEnv)
}
data_course_letter_grades(df)
df$LetterGrade <- letter.grades
cbind(row.names(df),df$LetterGrade)


