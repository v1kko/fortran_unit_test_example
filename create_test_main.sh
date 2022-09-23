#!/usr/bin/env bash

cat << EOF > $1
program unit_tests
EOF

for file in test_*.f90; do
  modname=`grep -i module ${file} | grep 'test' | cut -d' ' -f2`
  if [ -n "${modname}" ]; then
    echo "use ${modname}" >> $1
  fi
done

for file in test_*.f90; do
  subnames=`grep -i subroutine ${file} | grep 'test' |sed -e 's/^[ \t]*//'|cut -d' ' -f2`
  for subname in ${subnames}; do
    echo "call ${subname}" >> $1
  done
done

cat << EOF >> $1
end program unit_tests
EOF
