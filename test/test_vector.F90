!-----------------------------------------------------------------------------!
! \file   test/test_vector.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_vector
  implicit none
  call test_int4()
  call test_string()
contains

!-----------------------------------------------------------------------------!
subroutine test_int4()
  use, intrinsic :: ISO_C_BINDING
  use flc, only : ierr, get_serr
  use flc_vector, only : Vector => VectorInt4
  implicit none
  integer(4), dimension(4), parameter :: iarr = [ 1, -2, 4, -8 ]
  integer(4), dimension(:), pointer :: view => NULL()
  integer(4), pointer :: element_ptr => NULL()
  type(Vector) :: v, v2

  v = Vector(iarr)
  ASSERT(v%size() == 4)
  ASSERT(v%get(1) == 1_c_int)
  ASSERT(v%get(4) == -8_c_int)

  call v%clear()
  call v%push_back(123_c_int)
  ASSERT(v%size() == 1)

  call v%assign(iarr)
  ASSERT(v%size() == 4)
  ASSERT(v%get(1) == 1_c_int)
  ASSERT(v%get(4) == -8_c_int)

  ! Remove the 3rd element (value of 4)
  call v%erase(3)
  ASSERT(ierr == 0)
  view => v%view()
  ASSERT(size(view) == 3)
  ASSERT(view(2) == -2)
  ASSERT(view(3) == -8)

  ! Remove the last two elements (start/stop). Note that since we modified the
  ! vector, we have to update the view
  call v%erase(2, 4)
  view => v%view()
  ASSERT(ierr == 0)
  ASSERT(size(view) == 1)
  ASSERT(view(1) == 1)

  ! Make a bad call and check+clear the error
  call v%erase(12345)
  write (0,*) "Should have a nice error message here: ", get_serr()
  ASSERT(ierr /= 0)
  ! Clear the error
  ierr = 0

  ! Copy to a new vector and delete the old
  call v%assign(iarr)
  v2 = Vector(v)
  call v%release()
  ASSERT(v2%size() == 4)

  ! Assign by reference
  element_ptr => v2%get_ref(2)
  ASSERT(element_ptr == -2)
  element_ptr = 1234
  ASSERT(v2%get(2) == 1234)

end subroutine

!-----------------------------------------------------------------------------!
subroutine test_string()
  use, intrinsic :: ISO_C_BINDING
  use flc_vector, only : Vector => VectorString
  use flc_string, only : String
  implicit none
  type(Vector) :: v
  type(String) :: sref

  v = Vector(5, "mine") ! 5 elements, all "mine"
  call v%set(5, "yours")
  ASSERT(v%get(5) == "yours")
  sref = v%get_ref(1)
  ASSERT(sref%str() == "mine")
  call sref%assign("I me")
  ! Changing the reference changes the value in the original vector
  ASSERT(v%get(1) == "I me")

  call v%set_ref(4, v%get_ref(5))
  ASSERT(v%get(4) == "yours")

end subroutine

!-----------------------------------------------------------------------------!
end program
