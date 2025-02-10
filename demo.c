#include <stdio.h>
#include <mpi.h>
#include <empi.h>

int main(int argc, char **argv)
{
    // Variables
    int rank, size, dim, len, desp, count, type;
    char mpi_name[128];

    // Initialize the MPI environment
    MPI_Init(&argc, &argv);

    // Get rank & size
    MPI_Comm_rank(EMPI_COMM_WORLD, &rank);
    MPI_Comm_size(EMPI_COMM_WORLD, &size);
    MPI_Get_processor_name(mpi_name, &len);

    // Get worksize
    EMPI_Get_wsize(rank, size, dim, &desp, &count, NULL, NULL);

    // Get type
    EMPI_Get_type(&type);

    // Print off a hello world message
    printf("Hello world from processor %s, rank %d out of %d processors\n",
           mpi_name, rank, size);

    // Finalize the MPI environment
    MPI_Finalize();
    return 0;
}