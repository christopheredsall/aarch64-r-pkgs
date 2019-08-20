all: testthat


testthat:
	R --vanilla --quiet --file=testthat.r
