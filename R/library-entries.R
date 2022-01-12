#' Lower level helper function to enable saving of intermediate data entries.
#'
#' @param .library_name A character string for the name of the table.
#' @param ... The variables entered in the the table.
#' @param .create_dir Boolean indicating whether a separated directory is
#'  generated.
#' @param .alt_path Alternative path to the directory.
#' @param .save Boolean, whether to save the entry as an .RDS file.
#' @param .primary_key Equivalent to a serial primary key in SQL for uniqueness
#'  of observations.
#'
#' @return A \code{tibble:\link[tibble:tibble]{tibble()}} alongside a .RDS file
#'  with the entries.
#' @export
#'
library_entry <- function(.library_name, ..., .create_dir = TRUE,
                          .alt_path = NULL, .save = TRUE, .primary_key = TRUE) {

  # quote variables entered on dots
  vars <- rlang::enquos(...)

  path_to_library <- fs::path(.library_name, ext = "RDS")

  if (isTRUE(.create_dir) & isTRUE(.save)) {
    fs::dir_create(.library_name)
    path_to_library <- fs::path(.library_name, path_to_library)
  }

  if (isFALSE(.create_dir) & !is.null(.alt_path)) {
    if (!fs::dir_exists(.alt_path)) fs::dir_create(.alt_path)
    path_to_library <- fs::path(.alt_path, path_to_library)
  }

  # does path exist
  path_lg <- fs::file_exists(path_to_library)


  library_entry <- eval(rlang::call2(
    if (isTRUE(path_lg)) "add_row" else "tibble",
    if (isTRUE(path_lg)) add_variable(readRDS(path_to_library), vars),
    prim_key = serial_id(dir = .library_name),
    !!! vars,
    .ns = "tibble"
  ))

  # save library
  if (isTRUE(.save)) saveRDS(library_entry, path_to_library)
  library_entry
}


add_variable <- function(library, vars) {

  # return if not needed, otherwise add new vars
  if(!any(colnames(library) %in% names(vars))) {
    library
  } else {
    library_nms <- names(vars)
    new_vars <- library_nms[!library_nms %in% colnames(library)]
    new_vars <- rlang::set_names(rep(NA, length(new_vars)), nm = new_vars)
    dplyr::mutate(library, !!! new_vars)
  }
}


serial_id <- function(dir) {

  # short cuts if dir does not exist
  if (!fs::file_exists(fs::path(dir, ".counter.RDS"))) {
    return(counter(0, dir))
  # otherwise add number
  } else {
    x <- readRDS(fs::path(dir, ".counter.RDS"))
    counter(x[max(length(x))], dir)
  }
}

counter <- function(num, dir) {

  num_init <- as.integer(num)

  # make counter file if needed
  if (!fs::file_exists(fs::path(dir, ".counter.RDS"))) {
    # make dir if needed
    if (!fs::dir_exists(dir)) fs::dir_create(dir)
    saveRDS(num, fs::path(dir, ".counter.RDS"))
  }

  # load counter
  counter <- readRDS(fs::path(dir, ".counter.RDS"))

  # increment counter
  num <- num_init + 1

  # save counter
  counter <- c(counter,  num)
  saveRDS(counter, fs::path(dir, ".counter.RDS"))

  # print
  num
}
