clean_filedocumentr <- function(dir) {
  if (fs::dir_exists(dir)) fs::dir_delete(dir)
}
