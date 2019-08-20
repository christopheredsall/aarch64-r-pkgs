all: testthat


testthat:
	module load  cray-R/3.4.2
	R --vanilla --quiet --file=testthat.r
