#' \code{rodeo} Class
#'
#' This documents the \code{rodeo} class to represent an ODE-based
#' model. See the \code{\link{rodeo-package}} main page or type
#' \code{help(package="rodeo")} for an introduction to the package of
#' the same name.
#'
#' @name rodeo-class
#'
#' @field prosTbl A data frame with fields 'name', 'unit', 'description', and
#'   'expression' defining the process rates.
#' @field stoiTbl A data frame with fields 'variable', 'process', and 'expression'
#'   reprenting the stoichiometry matrix in data base format.
#' @field varsTbl A data frame with fields 'name', 'unit', 'description' declaring
#'   the state variables of the model. The declared names become valid
#'   identifiers to be used in the expression fields of \code{prosTbl} or \code{stoiTbl}.
#' @field parsTbl A data frame of the same structure as \code{vars} declaring the
#'   parameters of the model. The declared names become valid
#'   identifiers to be used in the expression fields of \code{prosTbl} or \code{stoiTbl}.
#' @field funsTbl A data frame of the same structure as \code{vars} declaring any
#'   functions referenced in the expression fields of \code{prosTbl} or \code{stoiTbl}.
#' @field sections Number of spatial sections (integer).
#' @field v Numeric matrix, holding values of variables (columns) in the
#'   model's spatial compartments (rows).
#' @field p Numeric matrix, holding values of parameters (columns) in the
#'   model's spatial compartments (rows).
#'
#' @section Class methods:
#'
#' For most of the methods below, a separate help page is available describing
#' its arguments and usage.
#'
#' \itemize{
#'   \item{\code{\link{initialize}}} Initialization method for new objects.
#'   \item{\code{namesVars, namesPars, namesFuns, namesPros}} Functions
#'     returning the names of declared state variables, parameters,
#'     functions, and processes, respectively (character vectors). No arguments.
#'   \item{\code{lenVars, lenPars, lenFuns, lenPros}} Functions
#'     returning the number of declared state variables, parameters, functions
#'     and processes, respectively (integer). No arguments.
#'   \item{\code{getVarsTable, getParsTable, getFunsTable, getProsTable,
#'     getStoiTable}} Functions returning the data frames used to initialize
#'     the object. No arguments
#'   \item{\code{size}} Returns the number spatial sections (integer).
#'     No arguments."
#'   \item{\code{\link{compile}}} Compiles a Fortran library for use with
#'     numerical methods from packages \code{\link[deSolve]{deSolve}} or
#'     \code{\link[rootSolve]{rootSolve}}.
#'   \item{\code{\link{generate}}} Translate the ODE-model specification into a
#'     function that computes process rates and the state variables' derivatives
#'     (either in R or Fortran). Consider to use the high-level method
#'     \code{\link{compile}}.
#'   \item{\code{\link{assignVars}}} Assign values to state variables.
#'   \item{\code{\link{assignPars}}} Assign values to parameters.
#'   \item{\code{\link{queryVars}}} Returns the values of state variables.
#'   \item{\code{\link{queryPars}}} Returns the values of parameters.
#'   \item{\code{\link{stoichiometry}}} Returns the stoichiometry matrix, either
#'     evaluated (numeric) or as text.
#'   \item{\code{\link{plotStoichiometry}}} Plots qualitative stoichiometry
#'     information.
#' }
#'
#' @seealso See the \code{\link{rodeo-package}} main page or type
#'   \code{help(package="rodeo")} to find the documentation of any non-class
#'   methods contained in the \code{rodeo} package.
#' 
#' @examples
#' data(exampleIdentifiers, exampleProcesses, exampleStoichiometry)
#' model <- rodeo$new(
#'   vars=subset(exampleIdentifiers, type=="v"),
#'   pars=subset(exampleIdentifiers, type=="p"),
#'   funs=subset(exampleIdentifiers, type=="f"),
#'   pros=exampleProcesses, stoi=exampleStoichiometry
#' )
#' print(model)
#'
#' @export

rodeo <- R6Class("rodeo",
  private = list(
    varsTbl=NA,
    parsTbl=NA,
    funsTbl=NA,
    prosTbl=NA,
    stoiTbl=NA,
    sections=NA,
    v=NA,
    p=NA,
    steppers=list()
  )
)

