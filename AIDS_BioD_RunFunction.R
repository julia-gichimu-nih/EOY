
directory <-  "C:/Users/gichimujw/OneDrive - National Institutes of Health/Data Quality/AIDS_BioD Checkouts/Input"
AIDSBioD_Category <- "Biodefense Vaccine"
RCDC_Category <- "Emerging Infectious Diseases"


source('AIDS_BioD_Checkout.R')

# BioD Research + Emerging Infectious Diseases
# BioD Research + Infectious Diseases
# BioD Vaccine + Immunization 
# BioD Vaccine + Prevention 
# BioD Vaccine + Vaccine Related



AIDS_BioD_Checkout( "Biodefense Research", "Emerging Infectious Diseases")

AIDS_BioD_Checkout("Biodefense Research", "Infectious Diseases")

AIDS_BioD_Checkout("Biodefense Vaccine", "Immunization")

AIDS_BioD_Checkout("Biodefense Vaccine", "Prevention")

AIDS_BioD_Checkout("Biodefense Vaccine", "Vaccine Related")


# BSS AIDS + BSS
# Clinical Trial AIDS + Clinical Trials 
# Pediatric AIDS + Pediatric
# Prevention AIDS + Prevention
# Vaccine Related AIDS + Immunization 
# Vaccine Related AIDS + Prevention 
# Vaccine Related AIDS + Vaccine Related 



AIDS_BioD_Checkout( "BSS AIDS", "BSS")

AIDS_BioD_Checkout("Clinical Trials AIDS", "Clinical Trials")

AIDS_BioD_Checkout( "Prevention AIDS","Prevention")

AIDS_BioD_Checkout( "Pediatric AIDS","Pediatric")
                   
AIDS_BioD_Checkout("Vaccine Related AIDS", "Prevention")

AIDS_BioD_Checkout( "Vaccine Related AIDS","Vaccine Related")

AIDS_BioD_Checkout("Vaccine Related AIDS", "Immunization")





