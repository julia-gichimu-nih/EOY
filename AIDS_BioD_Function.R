


AIDS_BioD_Checkout <- function (AIDSBioD_Category, RCDC_Category){
  
  
  ## This function will merge data from 2 sources that will later be analyzed by SIA's 
  ## Match row by row, Appl ID and CAN numbers for all projects reported in the child category and 
  ## all projects that have child only source in the parent category  
  ## In cases where there Appl ID + CAN are not shared by two categories, 
  ## the merge function will create empty rows for the category that doesn't have that information 
  
  
  # Create Path to Child and Parent category spreadsheets
  # Child is the AIDS/BioD Category 
  # Parent is the RCDC Category that has the child roll up 
  
  path_child <- paste(getwd(), "/", "Input", "/", AIDSBioD_Category, ".csv", sep= "")
  path_parent <- paste(getwd(),"/", "Input", "/", RCDC_Category, ".csv", sep= "")
  
  ChildCategory <- read.csv(path_child)
  ParentCategory <- read.csv(path_parent)
  
  colnames(ChildCategory)[1] <- "Project.Number"  
  colnames(ParentCategory)[1] <- "Project.Number" 
  
  
  

  # Create a not in operator 
  `%notin%` <- Negate(`%in%`)
  
  # Set condition to stop running if input is not
  if(AIDSBioD_Category %notin% c("Pediatric AIDS",
                               "Prevention AIDS",
                               "Vaccine Related AIDS", 
                               "Clinical Trials AIDS",
                               "BSS AIDS", 
                               
                               "Biodefense Research",
                               "Biodefense Vaccine")) {
    stop("Invalid AIDS-BioD Category")
    
  } 
  
  if(RCDC_Category %notin% c("Pediatric",
                              "Prevention",
                              "Vaccine Related", 
                              "Clinical Trials",
                              "BSS", 
                              "Immunization",
                              "Infectious Diseases",
                              "Emerging Infectious Diseases")) {
    stop("Invalid RCDC Category")
    
  }
  
  
  # Filter Child Only Appl IDs from the parent 
  # The check is to ensure that these Appls are accurately reported
  
  ChildOnly_ParentProjects <- dplyr::filter(ParentCategory, Source == "Child")
  
  
  # Full outer join of Child Category projects and Child Only projects from the parent 
  
  Merged_data <- merge(ChildCategory, ChildOnly_ParentProjects, by = c("Appl.ID", "CAN"), all = TRUE) 
  
                            
  # Identify parent vs child data using an identifier suffix 
  colnames(Merged_data) <-  stringr::str_replace(colnames(Merged_data), pattern = ".x$", replacement = ".child")
  colnames(Merged_data) <-  stringr::str_replace(colnames(Merged_data), pattern = ".y$", replacement = ".parent")
  
  
  
  Merged_data <- dplyr::mutate(Merged_data, Matched.Project.Numbers = dplyr::case_when(
                                            Merged_data$Project.Number.child == Merged_data$Project.Number.parent ~ "TRUE",
                                            Merged_data$Project.Number.child != Merged_data$Project.Number.parent ~ "FALSE")
                              )
 
  Merged_data <- dplyr::mutate(Merged_data, Dollar_Match_Test = dplyr::case_when(
                                              Merged_data$Amount.child == Merged_data$Amount.parent ~ "Equal",
                                              Merged_data$Amount.child != Merged_data$Amount.parent ~ "Error")
                              )
  
  
  # Generate output sheet for further SIA Analysis 
  
  
  # Create a list of data frames to be included in the output. 
  # Create names for the list, this will appear as names for the tabs in the excel sheet 
  
  mylist = list(ChildCategory, ParentCategory, Merged_data) 
  names(mylist) <- c(get("AIDSBioD_Category"), get("RCDC_Category"), "Merged_Data")
  
  
  # Create file name that follows the format: (AIDSBioD_RCDC.xlsx)
  
  Base_directory_name <- stringr::str_replace(getwd(), pattern = "/Input", replacement = "") # Remove the Input folder directory path 
 
  # Create path to the folder for output files
  Output_Directory <- paste(Base_directory_name, "/", "Output", "/", AIDSBioD_Category, "_", RCDC_Category, ".xlsx", sep = "" )
  
  # Write the excel sheet to specified directory with the specified file name
 
     writexl::write_xlsx(mylist, Output_Directory)
  
}
  



  
