!-----------------------------------------------------------------------------!
! \file   test/test_set.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_set
  implicit none
  call test_int()
  call test_string()
contains

!-----------------------------------------------------------------------------!
subroutine test_int()
  use, intrinsic :: ISO_C_BINDING
  use flc_set, only : Set => SetInt
  implicit none
  type(Set) :: s
  integer :: num_erased

  s = Set()
  ASSERT(s%size() == 0)
  ASSERT(s%empty())

  call s%insert(4)
  ASSERT(s%size() == 1)

  ! Set elements are unique
  call s%insert(10)
  call s%insert(10)
  ASSERT(s%size() == 2)

  ! 'erase' takes OPTIONAL argument 
  call s%erase(10, num_erased)
  ASSERT(num_erased == 1)
  call s%erase(4)

  ! Insert an array of data
  call s%insert([1, 1, 2, 3, 5, 8, 13, 21])
  ASSERT(s%size() == 7)

  call s%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_string()
  use, intrinsic :: ISO_C_BINDING
  use flc_set, only : Set => SetString
  use flc_string, only : String
  implicit none
  type(Set) :: s

  s = Set()
  ASSERT(s%empty())

  call s%insert("yoohoo")
  call s%insert("howdy")
  ASSERT(s%size() == 2)
  ASSERT(s%count("yoohoo") == 1)
  ASSERT(s%count("hiya") == 0)

  call s%insert("howdy")
  ASSERT(s%count("howdy") == 1)
  ASSERT(s%size() == 2)

  call s%erase("yoohoo")
  ASSERT(s%size() == 1)
  ASSERT(s%count("yoohoo") == 0)

  call s%clear()
  ASSERT(s%empty())

  call s%release()
end subroutine

!-----------------------------------------------------------------------------!
end program
