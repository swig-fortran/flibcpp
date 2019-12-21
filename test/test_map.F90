!-----------------------------------------------------------------------------!
! \file   test/test_map.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_map
  implicit none
  call test_int_int()
  call test_string_string()
contains

!-----------------------------------------------------------------------------!
subroutine test_int_int()
  use, intrinsic :: ISO_C_BINDING
  use flc_map, only : Map => MapIntInt
  implicit none
  type(Map) :: m
  logical :: inserted = .false.

  m = Map()
  ASSERT(m%size() == 0)
  ASSERT(m%empty())

  call m%insert(123, 456)
  ASSERT(m%size() == 1)
  ASSERT(m%get(123) == 456)

  ! Map elements are unique: inserting does *not* overwrite
  call m%insert(123, 567, inserted)
  ASSERT(inserted .eqv. .false.)
  ASSERT(m%get(123) == 456)

  ! Elements can be overwritten with 'set'
  call m%set(123, 567)
  ASSERT(m%get(123) == 567)

  ! Elements not present will be created with `get`
  ASSERT(m%count(911) == 0)
  ASSERT(m%get(911) == 0)
  ASSERT(m%count(911) == 1)

  ! Elements can be removed from the map
  call m%erase(911)
  ASSERT(m%count(911) == 0)

  call m%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_string_string()
  use, intrinsic :: ISO_C_BINDING
  use flc_map, only : Map => MapStringString
  use flc_string, only : String
  implicit none
  type(Map) :: m

  m = Map()
  ASSERT(m%empty())

  call m%insert("bugsbunny", "yoohoo")
  call m%insert("texas", "howdy")
  ASSERT(m%size() == 2)
  ASSERT(m%count("bugsbunny") == 1)
  ASSERT(m%count("jersey") == 0)
  ASSERT(m%get("texas") == "howdy")
  call m%release()
end subroutine

!-----------------------------------------------------------------------------!
end program
