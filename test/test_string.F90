!-----------------------------------------------------------------------------!
! \file   test/test_string.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_string
  implicit none
  call test_class()
  call test_conversion()
  !call test_reading()
contains

!-----------------------------------------------------------------------------!
subroutine test_class()
  use, intrinsic :: ISO_C_BINDING
  use flc_string, only : String
  implicit none
  type(String) :: s
  character, dimension(:), pointer :: charptr
  character(len=:), allocatable :: native
  integer :: i

  s = String("Hi there!")
  ASSERT(s%size() == 9)
  ASSERT(s%get(1) == "H")
  ASSERT(s%get(4) == "t")

  call s%clear()
  call s%push_back("!")
  ASSERT(s%size() == 1)

  s = String(10, "*")
  ASSERT(s%size() == 10)
  ASSERT(s%get(1) == "*")
  ASSERT(s%get(10) == "*")

  s = String("Hello!")
  call s%set(6, ".")
  ASSERT(s%back() == ".")

  ! Interact with an array pointer to the string data
  charptr => s%view()
  charptr(1) = "Y"
  ! Convert the string to a Fortran string
  allocate(native, source=s%str())
  ASSERT(native == "Yello.")
  call s%pop_back()
  call s%append(" there")
  ASSERT(s%str() == "Yello there")

  ! Find characters in the string
  ASSERT(s%find("o") == 5)
  ASSERT(s%find("Q") == 0)

  ! Free memory
  call s%release()

  s = String("meowmeow")
  i = s%find("meow")
  ASSERT(i == 1)
  i = s%find("meow", 3)
  ASSERT(i == 5)
  i = s%find("woof")
  ASSERT(i == 0)
  call s%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_conversion()
  use, intrinsic :: ISO_C_BINDING
  use flc, only : ierr, SWIG_OverflowError, SWIG_ValueError
  use flc_string
  implicit none
  integer(4) :: temp
  real(8) :: dbl

  ASSERT(stoi("1234567") == 1234567_c_int32_t)
  ASSERT(stoll("1234567890123") == 1234567890123_c_int64_t)

  ! Check alternate bases
  ASSERT(stoi("0x100", 16) == 256)

  ! Check error reporting
  temp = stoi("1234567890123")
  ASSERT(ierr == SWIG_OverflowError)
  ierr = 0

  temp = stoi("three")
  ASSERT(ierr == SWIG_ValueError)
  ierr = 0

  temp = stoi("123 go")
  ASSERT(ierr == SWIG_ValueError)
  ierr = 0

  dbl = stod("3.625")
  ASSERT(dbl == 3.625)

end subroutine

!-----------------------------------------------------------------------------!
end program
