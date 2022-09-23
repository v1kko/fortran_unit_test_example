! File math.f90
module math_mod
  use iso_fortran_env, only: real64
  implicit none

  real(real64),pointer,dimension(:) :: glob_dims

contains
  function euclidean_distance(dims) result(distance)
    real(real64), target, intent(in)  :: dims(:)
    real(real64)                      :: distance
    ! Not thread safe
    glob_dims => dims
    distance = sqrt(euclidean_distance_sqr(1, 0d0))
  end function


  recursive pure function euclidean_distance_sqr(n, work) &
                                        result (distance)
    integer     , value, intent(in)   :: n
    real(real64), value, intent(in)   :: work
    real(real64)                      :: distance

    if ( n == size(glob_dims) + 1 ) then
      distance = work
      return
    end if
    distance = euclidean_distance_sqr(n+1, work+glob_dims(n)**2)
  end function

end module
