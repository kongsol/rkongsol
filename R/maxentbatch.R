# This script is an example of batchrunning MaxEnt java software using .lambdas files

projDIR <- list.dirs("path/to/project/environments") # path to project environmental data
lambdas <- list.files("path/to/lambdas", pattern='.lambdas$', full.names=TRUE) # path to lambdas files
MaxEnt <- "path/to/maxent.jar"

for (proj in projDIR) {
  for (lamb in lambdas) {

    outDIR <- paste0("dir/to/output", basename(proj))

    rkongsol::dir.check(outDIR)

    command <- paste0(sprintf("java -mx8g -cp ", MaxEnt, "density.Project %s %s %s %s",
                              lamb,
                              proj,
                              paste0(outDIR, "/", tools::file_path_sans_ext(basename(lamb))),
                              "nowriteclampgrid")) # arguments
    system(command)
    print(paste0("Prediction on ", basename(proj), " with ", basename(lamb), " was completed"))

  }

  x <- mean(stack(list.files(outDIR, pattern=paste0("_", "[:digit:]{1}"), full.names=TRUE)))
  writeRaster(x, paste0("E:/Solenopsis_invicta/171130/result/pilotrun_Peterson2/batchrun/", basename(proj), ".asc"))
  print(paste0("Prediction on ", basename(proj), " was completed"))

}

