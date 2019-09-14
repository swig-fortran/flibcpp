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
  native = s%str()
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
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_conversion()
  use, intrinsic :: ISO_C_BINDING
  use flc, only : ierr, SWIG_OverflowError, SWIG_ValueError
  use flc_string
  implicit none
  integer(4) :: temp
  real(8) :: dbl
  character(len=100) :: tempstr

  ASSERT(stoi("1234567") == 1234567_c_int32_t)
  ASSERT(stoll("1234567890123") == 1234567890123_c_int64_t)

  ! Check error reporting
  temp = stoi("1234567890123")
  ASSERT(ierr == SWIG_OverflowError)
  ierr = 0

  temp = stoi("three")
  ASSERT(ierr == SWIG_ValueError)
  ierr = 0

  dbl = stod("3.625")
  ASSERT(dbl == 3.625)

end subroutine

! ! An example of best practices for loop logic
! subroutine test_reading()
!   use, intrinsic :: ISO_C_BINDING
!   use flc, only : ierr, get_serr, SWIG_OverflowError, SWIG_ValueError
!   use flc_string
!   implicit none
!   integer(4) :: temp
!   character(len=100) :: tempstr
! 
! 1 write(0,*) "Enter an integer > 10 to exit"
!   read(*, '(a)') tempstr
!   temp = stoi(trim(tempstr))
!   if (ierr == SWIG_OverflowError) then
!     write(0,*) "Your integer is too darn big!"
!     goto 2
!   elseif (ierr == SWIG_ValueError) then
!     write(0,*) "That thing you entered? It wasn't an integer."
!     goto 2
!   elseif (ierr /= 0) then
!     write(0,*) "Unknown error", ierr
!     goto 2
!   elseif (temp > 10) then
!     goto 3
!   end if
!   goto 1
! 2 write(0,*) "(Detailed error message: ", get_serr(), ")"
!   ierr = 0
!   goto 1
! 3 write(0,*) "You did it!"
! end subroutine

!-----------------------------------------------------------------------------!
end program
