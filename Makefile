SOURCE = math.f90
OBJECTS= $(SOURCE:%.f90=obj/%.o)

distance: math.f90 main.f90
	gfortran $^ -o $@

UNIT_TESTS=$(wildcard test_*.f90)
UNIT_TESTS_OBJ=$(UNIT_TESTS:%.f90=test_obj/%.o)

obj/%.o: %.f90
	gfortran -J./obj/ -fprofile-arcs -ftest-coverage -c $^ -o $@

test_obj/%.o: %.f90 ${OBJECTS}
	gfortran -J./obj/ -c $< -o $@ 

distance_unit_tests: ${OBJECTS} ${UNIT_TESTS_OBJ} test_obj/distance_unit_tests.o
	gfortran -fprofile-arcs -ftest-coverage $^ -o $@ 

distance_unit_tests.f90: create_test_main.sh ${UNIT_TESTS} Makefile
	./create_test_main.sh $@

clean:
	rm -vf *.gcda *.gcno *.mod *.o distance_unit_tests distance obj/* test_obj/*
