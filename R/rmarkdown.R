#' Render the active Rmd to md for Github repo
#'
#' @return none
#' @export
render_github_md <- function() {

  # render to md
  rmarkdown::render(
    input = rstudioapi::getSourceEditorContext()$path,
    output_format = rmarkdown::github_document(),
    output_dir = file.path(pj,"docs/md")
  )

  # fixed path to github url
  githubRaw <- "/../../raw/main"
  # file.path(
  #   stringr::str_remove(github, "/$"), "raw/main")

  basename(rstudioapi::getSourceEditorContext()$path) |>
    stringr::str_replace("\\.[Rr][Mm][Dd]", ".md") -> mdfilename
  xfun::read_utf8(
    con=file.path(pj, "docs/md", mdfilename)
  ) -> mdlines

  mdlines |>
    stringr::str_replace_all(
      pj, githubRaw
    ) |>
    xfun::write_utf8(
      con=file.path(pj, "docs/md", mdfilename)
    )

}

