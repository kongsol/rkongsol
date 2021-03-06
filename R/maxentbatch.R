# This function is an example of batchrunning MaxEnt java software using .lambdas files, not about modelling itself
# This function will also produce averaged output if multiple lambdas files are exist
maxentbatch <- function(projDIR, lambdas, MaxEnt, ram, arguments) {

  require(rkongsol)

  # projDIR; path to projecting(predicting) environmental data
  # lambdas; path to lambdas files
  # MaxEnt; path to MaxEnt.jar
  # ram; how much memory you want to use, in gigabyte unit
  # arguments; character vector of additional arguments

  arguments <- paste(arguments, collapse=" ")

  for (proj in projDIR) {
    for (lamb in lambdas) {

      outDIR <- paste0("main/path/to/output", "/", basename(proj))

      rkongsol::dir.check(outDIR) # This line will create output folder if it doesn`t exists

      command <- paste0(sprintf("java -mx", ram, "g -cp ", MaxEnt, "density.Project %s %s %s %s", # main structure
                                lamb, # lambdas file
                                proj, # project environment folder
                                paste0(outDIR, "/", tools::file_path_sans_ext(basename(lamb))), # output file main name
                                arguments)) # additional arguments
      system(command) # run the command line
      print(paste0("Prediction on ", basename(proj), " with ", basename(lamb), " completed"))

    }

    if(length(lambdas) > 1) {

      x <- mean(stack(list.files(outDIR, pattern=paste0("_", "[:digit:]{1}"), full.names=TRUE))) # averaging outputs
      writeRaster(x, paste0(outDIR, ".asc")) # write averaged output

    }

    print(paste0("Prediction on ", basename(proj), " completed"))

  }

}



