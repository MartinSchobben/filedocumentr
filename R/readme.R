#' Document files structure in data directory
#'
#' Create an overview file of the data consisted within the directory by
#' documenting some minimal information, such as author, date of data generation
#' , instrumentation and laboratory.
#'
#' @return
#' Rmd template file for annotating common metadata associated with data files.
#'
#' @export
#'
#' @examples
#' # generate README in current directory
#' use_filedocumentr()
use_filedocumentr <- function(name = "README") {
  rmarkdown::draft(name, template = "README", package = "filedocumentr")
}
