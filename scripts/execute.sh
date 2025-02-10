#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    echo "Usage: execute.sh <number of processes> <port1> <port2>"
    exit 1
fi

# Get the node name and set the MPI path
NODENAME=`uname -n`
MPIPATH=/usr/bin

# Update nodefile with the current node name
cp  $HOME/FlexMPI_Demo/configuration_files/nodefiles/nodefile.demo1 $HOME/FlexMPI_Demo/configuration_files/nodefiles/nodefile
sed -i -e 's/nodename/'"$NODENAME"'/g' $HOME/FlexMPI_Demo/configuration_files/nodefiles/nodefile

# Update corefile with the current node name
cp $HOME/FlexMPI_Demo/configuration_files/corefiles/corefile.demo1 $HOME/FlexMPI_Demo/configuration_files/corefiles/corefile
sed -i -e 's/nodename/'"$NODENAME"'/g' $HOME/FlexMPI_Demo/configuration_files/corefiles/corefile

# Update rankfile with the current node name
cp $HOME/FlexMPI_Demo/controller/rankfiles/rankfile.demo1  $HOME/FlexMPI_Demo/controller/rankfiles/rankfile
sed -i -e 's/nodename/'"$NODENAME"'/g' $HOME/FlexMPI_Demo/controller/rankfiles/rankfile

# Get the list of nodes from the nodefile
list=`cat $HOME/FlexMPI_Demo/configuration_files/nodefiles/nodefile |  awk -F: '{print $1}'`

# Copy the demo file to /tmp on each node
for item in $list; do
  cp $HOME/FlexMPI_Demo/demo /tmp/demo
done

# Execute the MPI program with the specified parameters
echo "$MPIPATH/mpiexec -genvall -f $HOME/FlexMPI_Demo/controller/rankfiles/rankfile -np $1 /tmp/demo -cfile $HOME/FlexMPI/configuration_files/corefiles/corefile -policy-malleability-triggered -lbpolicy-counts 15000 100 -ni 100 -ports $2 $3 -controller $NODENAME -IOaction 2"
$MPIPATH/mpiexec -genvall -f $HOME/FlexMPI_Demo/controller/rankfiles/rankfile -np $1 /tmp/demo -cfile $HOME/FlexMPI/configuration_files/corefiles/corefile -policy-malleability-triggered -lbpolicy-counts 15000 100 -ni 100 -ports $2 $3 -controller $NODENAME -IOaction 2
