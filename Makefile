LIBEMPI_DIR=$(HOME)/FlexMPI

# For a system-level (non-local) installation of the libraries
MPICC=mpicc

# Uncomment for a local installation of the libraries
#PAPI_DIR=$(HOME)/LIBS/papi
#GLPK_DIR=$(HOME)/LIBS/glpk
#MPICC=$(HOME)/LIBS/mpich/bin/mpicc
#PAPI=-I$(PAPI_DIR)/include/ -L$(PAPI_DIR)/lib 
#GLPK=-I$(GLPK_DIR)/include/ -L$(GLPK_DIR)/lib/ 

# Other options
EMPI=-I$(LIBEMPI_DIR)/include/ -L$(LIBEMPI_DIR)/lib/ -I$(LIBEMPI_DIR)/include -lempi -lmpi 
CFLAGS=-Wall -g
MATH= -lm

all:
	make clean
	make demo
	@echo "+++ MAKE COMPLETE +++"

demo:
	$(MPICC) $(CFLAGS) -o demo demo.c $(EMPI) $(PAPI) -lpapi $(GLPK) -lglpk 

clean:
	rm -f demo
