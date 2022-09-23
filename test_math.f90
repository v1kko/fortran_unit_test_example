module test_math_mod
  use iso_fortran_env, only: real64
  implicit none
contains
  subroutine test_euclidean_distance
    use math_mod, only: euclidean_distance
    
    real(real64)                    :: input_a(2) = [ 3, 4 ]
    real(real64)                    :: ans


    ans = euclidean_distance(input_a)
    if (ans /= 5d0) then
      write(0,*) "Error:", input_a, "should be 5.0, not: ", ans
    end if
  end subroutine
end module
