! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.0.0
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! Flibcpp project, https://github.com/swig-fortran/flibcpp
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.

module flc_algorithm
 use, intrinsic :: ISO_C_BINDING
 use flc
 use flc_random
 implicit none
 private

 ! DECLARATION CONSTRUCTS
 type, bind(C) :: SwigArrayWrapper
  type(C_PTR), public :: data = C_NULL_PTR
  integer(C_SIZE_T), public :: size = 0
 end type
 enum, bind(c)
  enumerator :: SWIG_NULL
  enumerator :: SWIG_OWN
  enumerator :: SWIG_MOVE
  enumerator :: SWIG_REF
  enumerator :: SWIG_CREF
 end enum
 integer, parameter :: SwigMemState = kind(SWIG_NULL)
 type, bind(C) :: SwigClassWrapper
  type(C_PTR), public :: cptr = C_NULL_PTR
  integer(C_INT), public :: mem = SWIG_NULL
 end type
 interface binary_search
  module procedure swigf_binary_search__SWIG_1, swigf_binary_search__SWIG_2, swigf_binary_search__SWIG_3
 end interface
 public :: binary_search
 interface shuffle
  module procedure swigf_shuffle__SWIG_1, swigf_shuffle__SWIG_2, swigf_shuffle__SWIG_3
 end interface
 public :: shuffle
 interface is_sorted
  module procedure swigf_is_sorted__SWIG_1, swigf_is_sorted__SWIG_2, swigf_is_sorted__SWIG_3, swigf_is_sorted__SWIG_4, &
    swigf_is_sorted__SWIG_5, swigf_is_sorted__SWIG_6
 end interface
 public :: is_sorted
 interface sort
  module procedure swigf_sort__SWIG_1, swigf_sort__SWIG_2, swigf_sort__SWIG_3, swigf_sort__SWIG_4, swigf_sort__SWIG_5, &
    swigf_sort__SWIG_6
 end interface
 public :: sort

! WRAPPER DECLARATIONS
interface
subroutine swigc_sort__SWIG_1(farg1) &
bind(C, name="_wrap_sort__SWIG_1")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
end subroutine

subroutine swigc_sort__SWIG_2(farg1) &
bind(C, name="_wrap_sort__SWIG_2")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
end subroutine

subroutine swigc_sort__SWIG_3(farg1) &
bind(C, name="_wrap_sort__SWIG_3")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
end subroutine

subroutine swigc_sort__SWIG_4(farg1, farg3) &
bind(C, name="_wrap_sort__SWIG_4")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
end subroutine

subroutine swigc_sort__SWIG_5(farg1, farg3) &
bind(C, name="_wrap_sort__SWIG_5")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
end subroutine

subroutine swigc_sort__SWIG_6(farg1, farg3) &
bind(C, name="_wrap_sort__SWIG_6")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
end subroutine

function swigc_is_sorted__SWIG_1(farg1) &
bind(C, name="_wrap_is_sorted__SWIG_1") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
integer(C_INT) :: fresult
end function

function swigc_is_sorted__SWIG_2(farg1) &
bind(C, name="_wrap_is_sorted__SWIG_2") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
integer(C_INT) :: fresult
end function

function swigc_is_sorted__SWIG_3(farg1) &
bind(C, name="_wrap_is_sorted__SWIG_3") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
integer(C_INT) :: fresult
end function

function swigc_is_sorted__SWIG_4(farg1, farg3) &
bind(C, name="_wrap_is_sorted__SWIG_4") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_is_sorted__SWIG_5(farg1, farg3) &
bind(C, name="_wrap_is_sorted__SWIG_5") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_is_sorted__SWIG_6(farg1, farg3) &
bind(C, name="_wrap_is_sorted__SWIG_6") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
type(C_FUNPTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_binary_search__SWIG_1(farg1, farg3) &
bind(C, name="_wrap_binary_search__SWIG_1") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
integer(C_INT32_T), intent(in) :: farg3
integer(C_INT) :: fresult
end function

function swigc_binary_search__SWIG_2(farg1, farg3) &
bind(C, name="_wrap_binary_search__SWIG_2") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
integer(C_INT64_T), intent(in) :: farg3
integer(C_INT) :: fresult
end function

function swigc_binary_search__SWIG_3(farg1, farg3) &
bind(C, name="_wrap_binary_search__SWIG_3") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: farg1
real(C_DOUBLE), intent(in) :: farg3
integer(C_INT) :: fresult
end function

subroutine swigc_shuffle__SWIG_1(farg1, farg2) &
bind(C, name="_wrap_shuffle__SWIG_1")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper) :: farg1
type(SwigArrayWrapper) :: farg2
end subroutine

subroutine swigc_shuffle__SWIG_2(farg1, farg2) &
bind(C, name="_wrap_shuffle__SWIG_2")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper) :: farg1
type(SwigArrayWrapper) :: farg2
end subroutine

subroutine swigc_shuffle__SWIG_3(farg1, farg2) &
bind(C, name="_wrap_shuffle__SWIG_3")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper) :: farg1
type(SwigArrayWrapper) :: farg2
end subroutine

end interface


contains
 ! MODULE SUBPROGRAMS
subroutine swigf_sort__SWIG_1(data)
use, intrinsic :: ISO_C_BINDING
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg1_view
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
call swigc_sort__SWIG_1(farg1)
end subroutine

subroutine swigf_sort__SWIG_2(data)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg1_view
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
call swigc_sort__SWIG_2(farg1)
end subroutine

subroutine swigf_sort__SWIG_3(data)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg1_view
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
call swigc_sort__SWIG_3(farg1)
end subroutine

subroutine swigf_sort__SWIG_4(data, cmp)
use, intrinsic :: ISO_C_BINDING
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
call swigc_sort__SWIG_4(farg1, farg3)
end subroutine

subroutine swigf_sort__SWIG_5(data, cmp)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
call swigc_sort__SWIG_5(farg1, farg3)
end subroutine

subroutine swigf_sort__SWIG_6(data, cmp)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
call swigc_sort__SWIG_6(farg1, farg3)
end subroutine


function SWIG_int_to_logical(inp) &
    result(out)
  use, intrinsic :: ISO_C_BINDING
  integer(kind=C_INT), intent(IN) :: inp
  logical :: out
  if (inp /= 0) then
    out = .true.
  else
    out = .false.
  end if
end function

function swigf_is_sorted__SWIG_1(data) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg1_view
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
fresult = swigc_is_sorted__SWIG_1(farg1)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_is_sorted__SWIG_2(data) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg1_view
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
fresult = swigc_is_sorted__SWIG_2(farg1)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_is_sorted__SWIG_3(data) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg1_view
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
fresult = swigc_is_sorted__SWIG_3(farg1)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_is_sorted__SWIG_4(data, cmp) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
fresult = swigc_is_sorted__SWIG_4(farg1, farg3)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_is_sorted__SWIG_5(data, cmp) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
fresult = swigc_is_sorted__SWIG_5(farg1, farg3)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_is_sorted__SWIG_6(data, cmp) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg1_view
type(C_FUNPTR), intent(in), value :: cmp
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
type(C_FUNPTR) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = cmp
fresult = swigc_is_sorted__SWIG_6(farg1, farg3)
swig_result = SWIG_int_to_logical(fresult)
end function

function swigf_binary_search__SWIG_1(data, value) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg1_view
integer(C_INT32_T), intent(in) :: value
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
integer(C_INT32_T) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = value
fresult = swigc_binary_search__SWIG_1(farg1, farg3)
swig_result = fresult
end function

function swigf_binary_search__SWIG_2(data, value) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg1_view
integer(C_INT64_T), intent(in) :: value
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
integer(C_INT64_T) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = value
fresult = swigc_binary_search__SWIG_2(farg1, farg3)
swig_result = fresult
end function

function swigf_binary_search__SWIG_3(data, value) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg1_view
real(C_DOUBLE), intent(in) :: value
integer(C_INT) :: fresult 
type(SwigArrayWrapper) :: farg1 
real(C_DOUBLE) :: farg3 

if (size(data) > 0) then
farg1_view => data(1)
farg1%data = c_loc(farg1_view)
farg1%size = size(data)
else
farg1%data = c_null_ptr
farg1%size = 0
end if
farg3 = value
fresult = swigc_binary_search__SWIG_3(farg1, farg3)
swig_result = fresult
end function

subroutine swigf_shuffle__SWIG_1(g, data)
use, intrinsic :: ISO_C_BINDING
class(Engine), intent(in) :: g
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T), pointer :: farg2_view
type(SwigClassWrapper) :: farg1 
type(SwigArrayWrapper) :: farg2 

farg1 = g%swigdata
if (size(data) > 0) then
farg2_view => data(1)
farg2%data = c_loc(farg2_view)
farg2%size = size(data)
else
farg2%data = c_null_ptr
farg2%size = 0
end if
call swigc_shuffle__SWIG_1(farg1, farg2)
end subroutine

subroutine swigf_shuffle__SWIG_2(g, data)
use, intrinsic :: ISO_C_BINDING
class(Engine), intent(in) :: g
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T), pointer :: farg2_view
type(SwigClassWrapper) :: farg1 
type(SwigArrayWrapper) :: farg2 

farg1 = g%swigdata
if (size(data) > 0) then
farg2_view => data(1)
farg2%data = c_loc(farg2_view)
farg2%size = size(data)
else
farg2%data = c_null_ptr
farg2%size = 0
end if
call swigc_shuffle__SWIG_2(farg1, farg2)
end subroutine

subroutine swigf_shuffle__SWIG_3(g, data)
use, intrinsic :: ISO_C_BINDING
class(Engine), intent(in) :: g
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE), pointer :: farg2_view
type(SwigClassWrapper) :: farg1 
type(SwigArrayWrapper) :: farg2 

farg1 = g%swigdata
if (size(data) > 0) then
farg2_view => data(1)
farg2%data = c_loc(farg2_view)
farg2%size = size(data)
else
farg2%data = c_null_ptr
farg2%size = 0
end if
call swigc_shuffle__SWIG_3(farg1, farg2)
end subroutine


end module
