!-----------------------------------------------------------------------------!
! \file   test/test_algorithm.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

module fortran_comparators
  use, intrinsic :: ISO_C_BINDING
  implicit none
  public
contains
function compare_less(left, right) bind(C) &
    result(fresult)
  use, intrinsic :: ISO_C_BINDING
  integer(C_INT), intent(in), value :: left
  integer(C_INT), intent(in), value :: right
  logical(C_BOOL) :: fresult

  fresult = (left >= right)
end function
end module

program main
  implicit none
  call test_compare()
contains

!-----------------------------------------------------------------------------!
subroutine test_compare()
  use, intrinsic :: ISO_C_BINDING
  use fortran_comparators
  use flc_algorithm, only : passthrough_comparator
  implicit none

  write(*,*) "Result:", passthrough_comparator(123, 100, c_funloc(compare_less))
end subroutine
!-----------------------------------------------------------------------------!

end program

