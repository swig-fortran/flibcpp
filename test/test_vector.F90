!-----------------------------------------------------------------------------!
! \file   test/test_vector.F90
!
! Copyright (c) 2019-2020 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_vector
  implicit none
  call test_int4()
  call test_complex8()
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
  call v2%release()

  ! Create from an in-place array
  v = Vector([integer(4) :: 1, 2, 3, 5, 8, 13])
  ASSERT(v%size() == 6)
  ASSERT(v%get(1) == 1)
  ASSERT(v%back() == 13)
  call v%release()
end subroutine

!-----------------------------------------------------------------------------!
pure elemental function is_close(a, b) result(fresult)
  use, intrinsic :: ISO_C_BINDING
  implicit none
  complex(C_DOUBLE_COMPLEX), intent(in) :: a
  complex(C_DOUBLE_COMPLEX), intent(in) :: b
  logical :: fresult
  fresult = abs(a - b) < 1.0d-12
end function

subroutine test_complex8()
  use, intrinsic :: ISO_C_BINDING
  use flc, only : ierr, get_serr
  use flc_vector, only : Vector => VectorComplex8
  implicit none
  complex(8), dimension(3), parameter :: carr &
      = [ complex(8) :: (1, -2), (2, 1), (1.5d0, 0) ]
  complex(8), dimension(:), pointer :: view => NULL()
  complex(8), pointer :: element_ptr => NULL()
  type(Vector) :: v

  v = Vector(carr)
  ASSERT(v%size() == 3)
  ASSERT(is_close(v%get(1), cmplx(1, -2, C_DOUBLE_COMPLEX)))
  ASSERT(is_close(v%get(3), cmplx(1.5d0, 0, C_DOUBLE_COMPLEX)))

  call v%erase(2)
  ASSERT(ierr == 0)
  view => v%view()
  ASSERT(size(view) == 2)
  ASSERT(is_close(view(2), cmplx(1.5d0, 0, C_DOUBLE_COMPLEX)))

  call v%push_back((10d0, -5d0))
  ASSERT(v%size() == 3)
  ASSERT(is_close(v%get(3), cmplx(10, -5, C_DOUBLE_COMPLEX)))
  ASSERT(is_close(v%back(), cmplx(10, -5, C_DOUBLE_COMPLEX)))

  ! Assign by reference
  element_ptr => v%get_ref(2)
  write(*,*) "value:", v%get(2)
  ASSERT(is_close(element_ptr, (1.5d0, 0d0)))
  element_ptr = (3, 4)
  ASSERT(is_close(v%get(2), (3d0, 4d0)))

  call v%release()

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

  call sref%release()
  call v%release()
end subroutine

!-----------------------------------------------------------------------------!
end program
