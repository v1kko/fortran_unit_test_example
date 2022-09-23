! File main.f90
program main
  use iso_fortran_env, only: real64
  use math_mod, only: euclidean_distance
  integer                             :: argc, n, length
  character(len=:), allocatable       :: arg
  real(real64)    , allocatable       :: dims(:)

  argc = command_argument_count()
  allocate(dims(argc))

  do n = 1, argc
    call get_command_argument(n, length=length)
    allocate(character(len=length) :: arg)
    call get_command_argument(n, value=arg)
    read(arg,*) dims(n)
    deallocate(arg)
  end do

  write(*,*) euclidean_distance(dims)
end program main
