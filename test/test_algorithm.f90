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
function compare_ge(left, right) bind(C) &
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
  call test_sort_compare()
contains

!-----------------------------------------------------------------------------!
subroutine test_sort_compare()
  use, intrinsic :: ISO_C_BINDING
  use fortran_comparators
  use flc_algorithm, only : sort
  implicit none
  integer(C_INT), dimension(:), allocatable :: arr

  allocate(arr(5), source=[ 2, 3, 4, 4, 9])

  call sort(arr, c_funloc(compare_ge))
  write(*,*) "Result:", arr
end subroutine
!-----------------------------------------------------------------------------!

end program

