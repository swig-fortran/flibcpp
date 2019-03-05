!-----------------------------------------------------------------------------!
! \file   test/test_algorithm.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

module fortran_comparators
  use flc_algorithm, only : INDEX_INT
  implicit none
  public
contains
function compare_ge(left, right) bind(C) &
    result(fresult)
  use, intrinsic :: ISO_C_BINDING
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
  call test_equal_range()
  call test_minmax_element()
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
  write(*,"(A8,(8I10))") "Result:", iarr
  call sort(larr)
  write(*,*) "Result:", larr
  call sort(darr)
  write(*,"(A8,(8f10.3))") "Result:", darr

end subroutine

!-----------------------------------------------------------------------------!
subroutine test_sort_compare()
  use, intrinsic :: ISO_C_BINDING
  use fortran_comparators, only : compare_ge
  use flc_algorithm, only : sort, INDEX_INT
  implicit none
  integer(INDEX_INT), dimension(:), allocatable :: arr
  character(len=*), parameter :: outfmt = "(A12,(8I6))"

  allocate(arr(5), source=[ 2, 3, 4, 4, 9])

  call sort(arr, c_funloc(compare_ge))
  write(*,outfmt) "Result:", arr
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_argsort()
  use flc_algorithm, only : argsort, INDEX_INT
  implicit none
  integer, dimension(5) :: iarr = [ 2, 5, -2, 3, -10000]
  integer(INDEX_INT), dimension(5) :: idx
  character(len=*), parameter :: outfmt = "(A12,(8I6))"

  ! Call correctly, with size(idx) == size(iarr)
  call argsort(iarr, idx)
  write(*,outfmt) "Result:", idx
  write(*,outfmt) "Reorganized:", iarr(idx)

  ! Call with size(idx) > size(iarr)
  idx(:) = -1
  call argsort(iarr(1:3), idx)
  write(*,outfmt) "Bad:", idx

  ! Call with size(idx) < size(iarr)
  idx(:) = -1
  call argsort(iarr, idx(1:3))
  write(*,outfmt) "Also bad:", idx

end subroutine

!-----------------------------------------------------------------------------!
subroutine test_shuffle()
  use flc_algorithm, only : shuffle
  use flc_random, only : Engine
  implicit none
  integer :: i
  integer, dimension(8) :: iarr = (/ ((i), i = -4, 3) /)
  type(Engine) :: rng
  rng = Engine()

  do i = 1,3
      call shuffle(rng, iarr)
      write(*,"(A,(8I4))") "Shuffled:", iarr
  end do
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_binary_search()
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
subroutine test_equal_range()
  use flc_algorithm, only : equal_range, INDEX_INT
  implicit none
  integer(INDEX_INT) :: first_idx, last_idx
  integer, dimension(6) :: iarr = [ -5, 1, 1, 2, 4, 9]

  call equal_range(iarr, -6, first_idx, last_idx)
  ASSERT(first_idx == 1)
  ASSERT(last_idx == 0)
  write(*,"(A,(8I4))") "Equal to -6:", iarr(first_idx:last_idx)

  call equal_range(iarr, -5, first_idx, last_idx)
  ASSERT(first_idx == 1)
  ASSERT(last_idx == 1)
  write(*,"(A,(8I4))") "Equal to -5:", iarr(first_idx:last_idx)

  call equal_range(iarr, 1, first_idx, last_idx)
  ASSERT(first_idx == 2)
  ASSERT(last_idx == 3)
  write(*,"(A,(8I4))") "Equal to 1:", iarr(first_idx:last_idx)

  call equal_range(iarr, 3, first_idx, last_idx)
  ASSERT(first_idx == 5)
  ASSERT(last_idx == 4)

  call equal_range(iarr, 9, first_idx, last_idx)
  ASSERT(first_idx == 6)
  ASSERT(last_idx == 6)
  write(*,"(A,(8I4))") "Equal to 9:", iarr(first_idx:last_idx)

  call equal_range(iarr, 10, first_idx, last_idx)
  ASSERT(first_idx == 7)
  ASSERT(last_idx == 6)
  write(*,"(A,(8I4))") "Equal to 10:", iarr(first_idx:last_idx)


end subroutine

!-----------------------------------------------------------------------------!
subroutine test_minmax_element()
  use flc_algorithm, only : minmax_element, INDEX_INT
  implicit none
  integer, dimension(6) :: iarr = [ -5, 1000, -1000, 999, -1000, 1000]
  integer(INDEX_INT) :: min_idx, max_idx

  call minmax_element(iarr, min_idx, max_idx)
  ASSERT(iarr(min_idx) == -1000)
  ASSERT(iarr(max_idx) == 1000)
  ! First occurrence is preferably selected for min
  ASSERT(min_idx == 3)
  ! Second occurrence is preferably selected for max
  ASSERT(max_idx == 6)

end subroutine

!-----------------------------------------------------------------------------!

end program

