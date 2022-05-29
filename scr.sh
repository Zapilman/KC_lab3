#!/usr/bin/bash
ml icc
for i in "O1" "O2" "O3"
do
icc -$i -std=c99 Fact.c -o Fact.$i
echo "Optimization "$i
echo "Execution time of 1000 launches:"

time for p in {1..1000}
do
./Fact.$i
done
done

echo "Processor extensions:"

for t in SSE2 SSE3 SSSE3 SSE4.1 SSE4.2 AVX CORE-AVX2 CORE-AVX-I ATOM_SSE4.2  ATOM_SSSE3 MIC-AVX512 KNM CORE-AVX512 COMMON-AVX512 BROADWELL CANNONLAKE HASWELL ICELAKE-CLIENT ICELAKE-SERVER IVYBRIDGE KNL SANDYBRIDGE SILVERMONT SKYLAKE SKYLAKE-AVX512
do
icc -x$t -std=c99 Fact.c -o Fact.$t
echo "Optimization "$t
if ./Fact.$t
then
echo "Execution time of 1000 launches:"
 
time for p in {1..1000}

do
./Fact.$t
done
fi
done
