#' Create research project folder structure
#'
#' @param pj_structure a alist of folder structure, default = pj_structure in package data
#' @param root string of root absolute path, default = NULL meaning project root
#'
#' @return creating folder structure
#' @export
create_structure <- function(pj_structure=NULL, root = NULL) {
  tryCatch(
    {
      rprojroot::find_rstudio_root_file()
    },
    error = function(e) {
      NA
    }
  ) -> pj

  assertthat::assert_that(
    !is.na(pj),
    msg = "RStudio is not launched as a project"
  )

  if(is.null(pj_structure)) create_pj_structure() -> pj_structure
  if (is.null(root)){
    root <- pj
  }
  folderNames <- names(pj_structure)
  for (.x in folderNames) {
    .path <- file.path(root, .x)
    if (!dir.exists(.path)) dir.create(.path)
    if (is.call(pj_structure[[.x]])) {
      .root <- file.path(root, .x)
      create_structure(pj_structure[[.x]], root = .root)
    }
  }
}

# helpers ----
create_pj_structure = function(){
  pj_structure <- alist(
    data = ,
    docs = alist(
      md = ,
      rmd =
    ),
    `local-data` = ,
    output = ,
    R =
  )
  pj_structure
}

