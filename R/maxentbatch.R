# This script is an example of batchrunning MaxEnt java software using .lambdas files
require(rkongsol)
projDIR <- list.dirs("path/to/project/environments") # path to project environmental data
lambdas <- list.files("path/to/lambdas", pattern='.lambdas$', full.names=TRUE) # path to lambdas files
MaxEnt <- "path/to/maxent.jar"

for (proj in projDIR) {
  for (lamb in lambdas) {

    outDIR <- paste0("main/path/to/output", "/", basename(proj))

    rkongsol::dir.check(outDIR) # This line will create output folder if it doesn`t exists`

    command <- paste0(sprintf("java -mx8g -cp ", MaxEnt, "density.Project %s %s %s %s", # main structure
                              lamb, # lambdas file
                              proj, # project environment folder
                              paste0(outDIR, "/", tools::file_path_sans_ext(basename(lamb))), # output file main name
                              "nowriteclampgrid")) # additional arguments
    system(command) # run the command line
    print(paste0("Prediction on ", basename(proj), " with ", basename(lamb), " completed"))

  }

  x <- mean(stack(list.files(outDIR, pattern=paste0("_", "[:digit:]{1}"), full.names=TRUE))) # averaging outputs
  writeRaster(x, paste0(outDIR, ".asc")) # write averaged output
  print(paste0("Prediction on ", basename(proj), " completed"))

}

