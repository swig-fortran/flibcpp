!-----------------------------------------------------------------------------!
! \file   test/test_algorithm.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

module fortran_comparators
  use, intrinsic :: ISO_C_BINDING
  use flc_algorithm, only : INDEX_INT
  implicit none
  public
contains
function compare_ge(left, right) bind(C) &
    result(fresult)
  integer(INDEX_INT), intent(in), value :: left
  integer(INDEX_INT), intent(in), value :: right
  logical(C_BOOL) :: fresult

  fresult = (left >= right)
end function
end module

program test_algorithm
  implicit none
  call test_sort()
  call test_sort_compare()
  call test_argsort()
  call test_shuffle()
  call test_binary_search()
contains

!-----------------------------------------------------------------------------!
subroutine test_sort()
  use, intrinsic :: ISO_C_BINDING
  use flc_algorithm, only : sort
  implicit none
  integer(4), dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  integer(C_INT64_T), dimension(5) :: larr = [ 2_C_INT64_T, 5_C_INT64_T, &
      -2_C_INT64_T, -10000_C_INT64_T, 10000000000_C_INT64_T]
  real(c_double), dimension(4) :: darr = [ 2.1d0, 5.9d0, 0.d0, -1.25d0 ]

  call sort(iarr)
  write(*,*) "Result:", iarr
  call sort(larr)
  write(*,*) "Result:", larr
  call sort(darr)
  write(*,*) "Result:", darr

end subroutine

!-----------------------------------------------------------------------------!
subroutine test_sort_compare()
  use, intrinsic :: ISO_C_BINDING
  use fortran_comparators, only : compare_ge
  use flc_algorithm, only : sort, INDEX_INT
  implicit none
  integer(INDEX_INT), dimension(:), allocatable :: arr

  allocate(arr(5), source=[ 2, 3, 4, 4, 9])

  call sort(arr, c_funloc(compare_ge))
  write(*,*) "Result:", arr
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_argsort()
  use, intrinsic :: ISO_C_BINDING
  use flc_algorithm, only : argsort, INDEX_INT
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  integer(INDEX_INT), dimension(5) :: idx

  ! Call correctly, with size(idx) == size(iarr)
  call argsort(iarr, idx)
  write(*,*) "Result:", idx
  write(*,*) "Reorganized:", iarr(idx)

  ! Call with size(idx) > size(iarr)
  idx(:) = -1
  call argsort(iarr(1:3), idx)
  write(*,*) "Bad:", idx

  ! Call with size(idx) < size(iarr)
  idx(:) = -1
  call argsort(iarr, idx(1:3))
  write(*,*) "Also bad:", idx

end subroutine

!-----------------------------------------------------------------------------!
subroutine test_shuffle()
  use, intrinsic :: ISO_C_BINDING
  use flc_algorithm, only : shuffle
  use flc_random, only : Engine
  implicit none
  integer :: i
  integer, dimension(8) :: iarr = (/ ((i), i = -4, 3) /)
  type(Engine) :: rng
  rng = Engine()

  do i = 1,3
      call shuffle(rng, iarr)
      write(*,*) "Shuffled:", iarr
  end do
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_binary_search()
  use, intrinsic :: ISO_C_BINDING
  use flc_algorithm, only : binary_search
  implicit none
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  ASSERT(binary_search(iarr, -100) == 0) ! not found
  ASSERT(binary_search(iarr, 1) == 2)
  ASSERT(binary_search(iarr, 2) == 4)
  ASSERT(binary_search(iarr, 3) == 0) ! not found
  ASSERT(binary_search(iarr, 9) == 6)
  ASSERT(binary_search(iarr, 10) == 0)

end subroutine

!-----------------------------------------------------------------------------!

end program

