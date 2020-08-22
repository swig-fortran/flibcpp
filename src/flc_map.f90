! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.0.2
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! Flibcpp project, https://github.com/swig-fortran/flibcpp
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.

module flc_map
 use, intrinsic :: ISO_C_BINDING
 use flc
 use flc_string
 implicit none
 private

 ! DECLARATION CONSTRUCTS

 integer, parameter :: swig_cmem_own_bit = 0
 integer, parameter :: swig_cmem_rvalue_bit = 1
 type, bind(C) :: SwigClassWrapper
  type(C_PTR), public :: cptr = C_NULL_PTR
  integer(C_INT), public :: cmemflags = 0
 end type
 ! class std::map< int,int >
 type, public :: MapIntInt
  type(SwigClassWrapper), public :: swigdata
 contains
  procedure :: empty => swigf_MapIntInt_empty
  procedure :: size => swigf_MapIntInt_size
  procedure :: clear => swigf_MapIntInt_clear
  procedure :: erase => swigf_MapIntInt_erase
  procedure :: count => swigf_MapIntInt_count
  procedure :: insert => swigf_MapIntInt_insert
  procedure :: get => swigf_MapIntInt_get
  procedure :: set => swigf_MapIntInt_set
  procedure :: release => swigf_MapIntInt_release
  procedure, private :: swigf_MapIntInt_op_assign__
  generic :: assignment(=) => swigf_MapIntInt_op_assign__
 end type MapIntInt
 type, bind(C) :: SwigArrayWrapper
  type(C_PTR), public :: data = C_NULL_PTR
  integer(C_SIZE_T), public :: size = 0
 end type
 ! class std::map< std::string,int >
 type, public :: MapStringInt
  type(SwigClassWrapper), public :: swigdata
 contains
  procedure :: empty => swigf_MapStringInt_empty
  procedure :: size => swigf_MapStringInt_size
  procedure :: clear => swigf_MapStringInt_clear
  procedure :: erase => swigf_MapStringInt_erase
  procedure :: count => swigf_MapStringInt_count
  procedure :: insert => swigf_MapStringInt_insert
  procedure :: get => swigf_MapStringInt_get
  procedure :: set => swigf_MapStringInt_set
  procedure :: release => swigf_MapStringInt_release
  procedure, private :: swigf_MapStringInt_op_assign__
  generic :: assignment(=) => swigf_MapStringInt_op_assign__
 end type MapStringInt
 ! class std::map< std::string,std::string >
 type, public :: MapStringString
  type(SwigClassWrapper), public :: swigdata
 contains
  procedure :: empty => swigf_MapStringString_empty
  procedure :: size => swigf_MapStringString_size
  procedure :: clear => swigf_MapStringString_clear
  procedure :: erase => swigf_MapStringString_erase
  procedure :: count => swigf_MapStringString_count
  procedure :: insert => swigf_MapStringString_insert
  procedure :: get => swigf_MapStringString_get
  procedure :: set => swigf_MapStringString_set
  procedure :: release => swigf_MapStringString_release
  procedure, private :: swigf_MapStringString_op_assign__
  generic :: assignment(=) => swigf_MapStringString_op_assign__
 end type MapStringString
 interface MapIntInt
  module procedure swigf_new_MapIntInt
 end interface
 interface MapStringInt
  module procedure swigf_new_MapStringInt
 end interface
 interface MapStringString
  module procedure swigf_new_MapStringString
 end interface

! WRAPPER DECLARATIONS
interface
function swigc_new_MapIntInt() &
bind(C, name="_wrap_new_MapIntInt") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper) :: fresult
end function

function swigc_MapIntInt_empty(farg1) &
bind(C, name="_wrap_MapIntInt_empty") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT) :: fresult
end function

function swigc_MapIntInt_size(farg1) &
bind(C, name="_wrap_MapIntInt_size") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_LONG) :: fresult
end function

subroutine swigc_MapIntInt_clear(farg1) &
bind(C, name="_wrap_MapIntInt_clear")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
end subroutine

function swigc_MapIntInt_erase(farg1, farg2) &
bind(C, name="_wrap_MapIntInt_erase") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapIntInt_count(farg1, farg2) &
bind(C, name="_wrap_MapIntInt_count") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapIntInt_insert(farg1, farg2, farg3) &
bind(C, name="_wrap_MapIntInt_insert") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT), intent(in) :: farg3
integer(C_INT) :: fresult
end function

function swigc_MapIntInt_get(farg1, farg2) &
bind(C, name="_wrap_MapIntInt_get") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

subroutine swigc_MapIntInt_set(farg1, farg2, farg3) &
bind(C, name="_wrap_MapIntInt_set")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT), intent(in) :: farg3
end subroutine

subroutine swigc_delete_MapIntInt(farg1) &
bind(C, name="_wrap_delete_MapIntInt")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
end subroutine

subroutine swigc_MapIntInt_op_assign__(farg1, farg2) &
bind(C, name="_wrap_MapIntInt_op_assign__")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
type(SwigClassWrapper), intent(in) :: farg2
end subroutine

function swigc_new_MapStringInt() &
bind(C, name="_wrap_new_MapStringInt") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper) :: fresult
end function

function swigc_MapStringInt_empty(farg1) &
bind(C, name="_wrap_MapStringInt_empty") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT) :: fresult
end function

function swigc_MapStringInt_size(farg1) &
bind(C, name="_wrap_MapStringInt_size") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_LONG) :: fresult
end function

subroutine swigc_MapStringInt_clear(farg1) &
bind(C, name="_wrap_MapStringInt_clear")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
end subroutine

function swigc_MapStringInt_erase(farg1, farg2) &
bind(C, name="_wrap_MapStringInt_erase") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapStringInt_count(farg1, farg2) &
bind(C, name="_wrap_MapStringInt_count") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapStringInt_insert(farg1, farg2, farg3) &
bind(C, name="_wrap_MapStringInt_insert") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_INT), intent(in) :: farg3
integer(C_INT) :: fresult
end function

function swigc_MapStringInt_get(farg1, farg2) &
bind(C, name="_wrap_MapStringInt_get") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_INT) :: fresult
end function

subroutine swigc_MapStringInt_set(farg1, farg2, farg3) &
bind(C, name="_wrap_MapStringInt_set")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_INT), intent(in) :: farg3
end subroutine

subroutine swigc_delete_MapStringInt(farg1) &
bind(C, name="_wrap_delete_MapStringInt")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
end subroutine

subroutine swigc_MapStringInt_op_assign__(farg1, farg2) &
bind(C, name="_wrap_MapStringInt_op_assign__")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
type(SwigClassWrapper), intent(in) :: farg2
end subroutine

function swigc_new_MapStringString() &
bind(C, name="_wrap_new_MapStringString") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper) :: fresult
end function

function swigc_MapStringString_empty(farg1) &
bind(C, name="_wrap_MapStringString_empty") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT) :: fresult
end function

function swigc_MapStringString_size(farg1) &
bind(C, name="_wrap_MapStringString_size") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_LONG) :: fresult
end function

subroutine swigc_MapStringString_clear(farg1) &
bind(C, name="_wrap_MapStringString_clear")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
end subroutine

function swigc_MapStringString_erase(farg1, farg2) &
bind(C, name="_wrap_MapStringString_erase") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapStringString_count(farg1, farg2) &
bind(C, name="_wrap_MapStringString_count") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
integer(C_LONG) :: fresult
end function

function swigc_MapStringString_insert(farg1, farg2, farg3) &
bind(C, name="_wrap_MapStringString_insert") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
type(SwigArrayWrapper) :: farg3
integer(C_INT) :: fresult
end function

 subroutine SWIG_free(cptr) &
  bind(C, name="free")
 use, intrinsic :: ISO_C_BINDING
 type(C_PTR), value :: cptr
end subroutine
function swigc_MapStringString_get(farg1, farg2) &
bind(C, name="_wrap_MapStringString_get") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
type(SwigArrayWrapper) :: fresult
end function

subroutine swigc_MapStringString_set(farg1, farg2, farg3) &
bind(C, name="_wrap_MapStringString_set")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
type(SwigClassWrapper), intent(in) :: farg1
type(SwigArrayWrapper) :: farg2
type(SwigArrayWrapper) :: farg3
end subroutine

subroutine swigc_delete_MapStringString(farg1) &
bind(C, name="_wrap_delete_MapStringString")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
end subroutine

subroutine swigc_MapStringString_op_assign__(farg1, farg2) &
bind(C, name="_wrap_MapStringString_op_assign__")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
type(SwigClassWrapper), intent(in) :: farg2
end subroutine

end interface


contains
 ! MODULE SUBPROGRAMS
function swigf_new_MapIntInt() &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MapIntInt) :: self
type(SwigClassWrapper) :: fresult 

fresult = swigc_new_MapIntInt()
self%swigdata = fresult
end function


subroutine SWIGTM_fout_bool(imout, fout)
  use, intrinsic :: ISO_C_BINDING
  integer(kind=C_INT), intent(in) :: imout
  logical, intent(out) :: fout
  fout = (imout /= 0)
end subroutine

function swigf_MapIntInt_empty(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
class(MapIntInt), intent(in) :: self
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapIntInt_empty(farg1)
call SWIGTM_fout_bool(fresult, swig_result)
end function

function swigf_MapIntInt_size(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapIntInt), intent(in) :: self
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapIntInt_size(farg1)
swig_result = int(fresult)
end function

subroutine swigf_MapIntInt_clear(self)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(in) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
call swigc_MapIntInt_clear(farg1)
end subroutine

subroutine swigf_MapIntInt_erase(self, x, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(in) :: self
integer(C_INT), intent(in) :: x
integer, intent(out), optional :: swig_result
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
integer(C_INT) :: farg2 

farg1 = self%swigdata
farg2 = x
fresult = swigc_MapIntInt_erase(farg1, farg2)
if (present(swig_result)) then
swig_result = int(fresult)
endif

end subroutine

function swigf_MapIntInt_count(self, x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapIntInt), intent(in) :: self
integer(C_INT), intent(in) :: x
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
integer(C_INT) :: farg2 

farg1 = self%swigdata
farg2 = x
fresult = swigc_MapIntInt_count(farg1, farg2)
swig_result = int(fresult)
end function

subroutine swigf_MapIntInt_insert(self, k, v, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(in) :: self
integer(C_INT), intent(in) :: k
integer(C_INT), intent(in) :: v
logical, intent(out), optional :: swig_result
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 
integer(C_INT) :: farg2 
integer(C_INT) :: farg3 

farg1 = self%swigdata
farg2 = k
farg3 = v
fresult = swigc_MapIntInt_insert(farg1, farg2, farg3)
if (present(swig_result)) then
call SWIGTM_fout_bool(fresult, swig_result)
endif

end subroutine

function swigf_MapIntInt_get(self, k) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
class(MapIntInt), intent(in) :: self
integer(C_INT), intent(in) :: k
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 
integer(C_INT) :: farg2 

farg1 = self%swigdata
farg2 = k
fresult = swigc_MapIntInt_get(farg1, farg2)
swig_result = fresult
end function

subroutine swigf_MapIntInt_set(self, k, v)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(in) :: self
integer(C_INT), intent(in) :: k
integer(C_INT), intent(in) :: v
type(SwigClassWrapper) :: farg1 
integer(C_INT) :: farg2 
integer(C_INT) :: farg3 

farg1 = self%swigdata
farg2 = k
farg3 = v
call swigc_MapIntInt_set(farg1, farg2, farg3)
end subroutine

subroutine swigf_MapIntInt_release(self)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(inout) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
if (btest(farg1%cmemflags, swig_cmem_own_bit)) then
call swigc_delete_MapIntInt(farg1)
endif
farg1%cptr = C_NULL_PTR
farg1%cmemflags = 0
self%swigdata = farg1
end subroutine

subroutine swigf_MapIntInt_op_assign__(self, other)
use, intrinsic :: ISO_C_BINDING
class(MapIntInt), intent(inout) :: self
type(MapIntInt), intent(in) :: other
type(SwigClassWrapper) :: farg1 
type(SwigClassWrapper) :: farg2 

farg1 = self%swigdata
farg2 = other%swigdata
call swigc_MapIntInt_op_assign__(farg1, farg2)
self%swigdata = farg1
end subroutine

function swigf_new_MapStringInt() &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MapStringInt) :: self
type(SwigClassWrapper) :: fresult 

fresult = swigc_new_MapStringInt()
self%swigdata = fresult
end function

function swigf_MapStringInt_empty(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
class(MapStringInt), intent(in) :: self
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapStringInt_empty(farg1)
call SWIGTM_fout_bool(fresult, swig_result)
end function

function swigf_MapStringInt_size(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapStringInt), intent(in) :: self
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapStringInt_size(farg1)
swig_result = int(fresult)
end function

subroutine swigf_MapStringInt_clear(self)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(in) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
call swigc_MapStringInt_clear(farg1)
end subroutine


subroutine SWIGTM_fin_char_Sm_(finp, iminp, temp)
  use, intrinsic :: ISO_C_BINDING
  character(len=*), intent(in) :: finp
  type(SwigArrayWrapper), intent(out) :: iminp
  character(kind=C_CHAR), dimension(:), target, allocatable, intent(out) :: temp
  integer :: i

  allocate(character(kind=C_CHAR) :: temp(len(finp) + 1))
  do i=1,len(finp)
    temp(i) = char(ichar(finp(i:i)), kind=C_CHAR)
  end do
  i = len(finp) + 1
  temp(i) = C_NULL_CHAR ! C finp compatibility
  iminp%data = c_loc(temp)
  iminp%size = len(finp, kind=C_SIZE_T)
end subroutine

subroutine swigf_MapStringInt_erase(self, x, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(in) :: self
character(len=*), target :: x
integer, intent(out), optional :: swig_result
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(x, farg2, farg2_temp)
fresult = swigc_MapStringInt_erase(farg1, farg2)
if (present(swig_result)) then
swig_result = int(fresult)
endif

end subroutine

function swigf_MapStringInt_count(self, x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapStringInt), intent(in) :: self
character(len=*), target :: x
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(x, farg2, farg2_temp)
fresult = swigc_MapStringInt_count(farg1, farg2)
swig_result = int(fresult)
end function

subroutine swigf_MapStringInt_insert(self, k, v, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(in) :: self
character(len=*), target :: k
integer(C_INT), intent(in) :: v
logical, intent(out), optional :: swig_result
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 
integer(C_INT) :: farg3 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
farg3 = v
fresult = swigc_MapStringInt_insert(farg1, farg2, farg3)
if (present(swig_result)) then
call SWIGTM_fout_bool(fresult, swig_result)
endif

end subroutine

function swigf_MapStringInt_get(self, k) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
class(MapStringInt), intent(in) :: self
character(len=*), target :: k
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
fresult = swigc_MapStringInt_get(farg1, farg2)
swig_result = fresult
end function

subroutine swigf_MapStringInt_set(self, k, v)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(in) :: self
character(len=*), target :: k
integer(C_INT), intent(in) :: v
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 
integer(C_INT) :: farg3 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
farg3 = v
call swigc_MapStringInt_set(farg1, farg2, farg3)
end subroutine

subroutine swigf_MapStringInt_release(self)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(inout) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
if (btest(farg1%cmemflags, swig_cmem_own_bit)) then
call swigc_delete_MapStringInt(farg1)
endif
farg1%cptr = C_NULL_PTR
farg1%cmemflags = 0
self%swigdata = farg1
end subroutine

subroutine swigf_MapStringInt_op_assign__(self, other)
use, intrinsic :: ISO_C_BINDING
class(MapStringInt), intent(inout) :: self
type(MapStringInt), intent(in) :: other
type(SwigClassWrapper) :: farg1 
type(SwigClassWrapper) :: farg2 

farg1 = self%swigdata
farg2 = other%swigdata
call swigc_MapStringInt_op_assign__(farg1, farg2)
self%swigdata = farg1
end subroutine

function swigf_new_MapStringString() &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MapStringString) :: self
type(SwigClassWrapper) :: fresult 

fresult = swigc_new_MapStringString()
self%swigdata = fresult
end function

function swigf_MapStringString_empty(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
logical :: swig_result
class(MapStringString), intent(in) :: self
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapStringString_empty(farg1)
call SWIGTM_fout_bool(fresult, swig_result)
end function

function swigf_MapStringString_size(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapStringString), intent(in) :: self
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MapStringString_size(farg1)
swig_result = int(fresult)
end function

subroutine swigf_MapStringString_clear(self)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(in) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
call swigc_MapStringString_clear(farg1)
end subroutine

subroutine swigf_MapStringString_erase(self, x, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(in) :: self
character(len=*), target :: x
integer, intent(out), optional :: swig_result
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(x, farg2, farg2_temp)
fresult = swigc_MapStringString_erase(farg1, farg2)
if (present(swig_result)) then
swig_result = int(fresult)
endif

end subroutine

function swigf_MapStringString_count(self, x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer :: swig_result
class(MapStringString), intent(in) :: self
character(len=*), target :: x
integer(C_LONG) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(x, farg2, farg2_temp)
fresult = swigc_MapStringString_count(farg1, farg2)
swig_result = int(fresult)
end function

subroutine swigf_MapStringString_insert(self, k, v, swig_result)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(in) :: self
character(len=*), target :: k
character(len=*), target :: v
logical, intent(out), optional :: swig_result
integer(C_INT) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg3_temp 
type(SwigArrayWrapper) :: farg3 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
call SWIGTM_fin_char_Sm_(v, farg3, farg3_temp)
fresult = swigc_MapStringString_insert(farg1, farg2, farg3)
if (present(swig_result)) then
call SWIGTM_fout_bool(fresult, swig_result)
endif

end subroutine


subroutine SWIGTM_fout_char_Sm_(imout, fout)
  use, intrinsic :: ISO_C_BINDING
  type(SwigArrayWrapper), intent(in) :: imout
  character(len=:), allocatable, intent(out) :: fout
  character(kind=C_CHAR), dimension(:), pointer :: chars
  integer(kind=C_SIZE_T) :: i
  call c_f_pointer(imout%data, chars, [imout%size])
  allocate(character(len=imout%size) :: fout)
  do i=1, imout%size
    fout(i:i) = char(ichar(chars(i)))
  end do
end subroutine

function swigf_MapStringString_get(self, k) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
character(len=:), allocatable :: swig_result
class(MapStringString), intent(in) :: self
character(len=*), target :: k
type(SwigArrayWrapper) :: fresult 
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
fresult = swigc_MapStringString_get(farg1, farg2)
call SWIGTM_fout_char_Sm_(fresult, swig_result)
call SWIG_free(fresult%data)
end function

subroutine swigf_MapStringString_set(self, k, v)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(in) :: self
character(len=*), target :: k
character(len=*), target :: v
type(SwigClassWrapper) :: farg1 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg2_temp 
type(SwigArrayWrapper) :: farg2 
character(kind=C_CHAR), dimension(:), allocatable, target :: farg3_temp 
type(SwigArrayWrapper) :: farg3 

farg1 = self%swigdata
call SWIGTM_fin_char_Sm_(k, farg2, farg2_temp)
call SWIGTM_fin_char_Sm_(v, farg3, farg3_temp)
call swigc_MapStringString_set(farg1, farg2, farg3)
end subroutine

subroutine swigf_MapStringString_release(self)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(inout) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
if (btest(farg1%cmemflags, swig_cmem_own_bit)) then
call swigc_delete_MapStringString(farg1)
endif
farg1%cptr = C_NULL_PTR
farg1%cmemflags = 0
self%swigdata = farg1
end subroutine

subroutine swigf_MapStringString_op_assign__(self, other)
use, intrinsic :: ISO_C_BINDING
class(MapStringString), intent(inout) :: self
type(MapStringString), intent(in) :: other
type(SwigClassWrapper) :: farg1 
type(SwigClassWrapper) :: farg2 

farg1 = self%swigdata
farg2 = other%swigdata
call swigc_MapStringString_op_assign__(farg1, farg2)
self%swigdata = farg1
end subroutine


end module
