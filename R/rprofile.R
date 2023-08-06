#' Create .Rprofile
#'
#' @return creating a .Rprofile file
#' @export
create_Rprofile = function(){
  github = readline(prompt = "your github repo url: ")
  glue::glue("rprofile = new.env()
rprofile$pj = rprojroot::find_rstudio_root_file()
rprofile$github = \"{github}\"
attach(rprofile)
rm(rprofile)") |>
    xfun::write_utf8(
      con=file.path(".Rprofile")
    )

}
