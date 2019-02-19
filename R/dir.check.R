# dir.check()
dir.check <- function(dir) {
  if (dir.exists(dir)) {
    print(paste0("Directory (", dir, ") exists"))
  } else {
    dir.create(dir, recursive=TRUE)
    print(paste0("Directory (", dir, ") created"))
  }
}