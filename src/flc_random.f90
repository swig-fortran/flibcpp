! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.1.0+fortran
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! Flibcpp project, https://github.com/swig-fortran/flibcpp
! Copyright (c) 2019-2020 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.

module flc_random
 use, intrinsic :: ISO_C_BINDING
 use flc
 implicit none
 private

 ! DECLARATION CONSTRUCTS

 integer, parameter :: swig_cmem_own_bit = 0
 integer, parameter :: swig_cmem_rvalue_bit = 1
 type, bind(C) :: SwigClassWrapper
  type(C_PTR), public :: cptr = C_NULL_PTR
  integer(C_INT), public :: cmemflags = 0
 end type
 ! class std::mt19937
 type, public :: MersenneEngine4
  type(SwigClassWrapper), public :: swigdata
 contains
  procedure :: seed => swigf_MersenneEngine4_seed
  procedure :: discard => swigf_MersenneEngine4_discard
  procedure :: next => swigf_MersenneEngine4_next
  procedure :: release => swigf_MersenneEngine4_release
  procedure, private :: swigf_MersenneEngine4_op_assign__
  generic :: assignment(=) => swigf_MersenneEngine4_op_assign__
 end type MersenneEngine4
 ! class std::mt19937_64
 type, public :: MersenneEngine8
  type(SwigClassWrapper), public :: swigdata
 contains
  procedure :: seed => swigf_MersenneEngine8_seed
  procedure :: discard => swigf_MersenneEngine8_discard
  procedure :: next => swigf_MersenneEngine8_next
  procedure :: release => swigf_MersenneEngine8_release
  procedure, private :: swigf_MersenneEngine8_op_assign__
  generic :: assignment(=) => swigf_MersenneEngine8_op_assign__
 end type MersenneEngine8
 type, bind(C) :: SwigArrayWrapper
  type(C_PTR), public :: data = C_NULL_PTR
  integer(C_SIZE_T), public :: size = 0
 end type
 public :: uniform_real_distribution
 public :: normal_distribution
 interface MersenneEngine8
  module procedure swigf_new_MersenneEngine8__SWIG_0, swigf_new_MersenneEngine8__SWIG_1
 end interface
 interface uniform_int_distribution
  module procedure swigf_uniform_int_distribution__SWIG_1, swigf_uniform_int_distribution__SWIG_2
 end interface
 public :: uniform_int_distribution
 interface discrete_distribution
  module procedure swigf_discrete_distribution__SWIG_1, swigf_discrete_distribution__SWIG_2
 end interface
 public :: discrete_distribution
 interface MersenneEngine4
  module procedure swigf_new_MersenneEngine4__SWIG_0, swigf_new_MersenneEngine4__SWIG_1
 end interface

! WRAPPER DECLARATIONS
interface
function swigc_new_MersenneEngine4__SWIG_0() &
bind(C, name="_wrap_new_MersenneEngine4__SWIG_0") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper) :: fresult
end function

function swigc_new_MersenneEngine4__SWIG_1(farg1) &
bind(C, name="_wrap_new_MersenneEngine4__SWIG_1") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
integer(C_INT32_T), intent(in) :: farg1
type(SwigClassWrapper) :: fresult
end function

subroutine swigc_MersenneEngine4_seed(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine4_seed")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT32_T), intent(in) :: farg2
end subroutine

subroutine swigc_MersenneEngine4_discard(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine4_discard")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_LONG_LONG), intent(in) :: farg2
end subroutine

function swigc_MersenneEngine4_next(farg1) &
bind(C, name="_wrap_MersenneEngine4_next") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT32_T) :: fresult
end function

subroutine swigc_delete_MersenneEngine4(farg1) &
bind(C, name="_wrap_delete_MersenneEngine4")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
end subroutine

subroutine swigc_MersenneEngine4_op_assign__(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine4_op_assign__")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
type(SwigClassWrapper), intent(in) :: farg2
end subroutine

function swigc_new_MersenneEngine8__SWIG_0() &
bind(C, name="_wrap_new_MersenneEngine8__SWIG_0") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper) :: fresult
end function

function swigc_new_MersenneEngine8__SWIG_1(farg1) &
bind(C, name="_wrap_new_MersenneEngine8__SWIG_1") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
integer(C_INT64_T), intent(in) :: farg1
type(SwigClassWrapper) :: fresult
end function

subroutine swigc_MersenneEngine8_seed(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine8_seed")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT64_T), intent(in) :: farg2
end subroutine

subroutine swigc_MersenneEngine8_discard(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine8_discard")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_LONG_LONG), intent(in) :: farg2
end subroutine

function swigc_MersenneEngine8_next(farg1) &
bind(C, name="_wrap_MersenneEngine8_next") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(in) :: farg1
integer(C_INT64_T) :: fresult
end function

subroutine swigc_delete_MersenneEngine8(farg1) &
bind(C, name="_wrap_delete_MersenneEngine8")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
end subroutine

subroutine swigc_MersenneEngine8_op_assign__(farg1, farg2) &
bind(C, name="_wrap_MersenneEngine8_op_assign__")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
type(SwigClassWrapper), intent(inout) :: farg1
type(SwigClassWrapper), intent(in) :: farg2
end subroutine

subroutine swigc_uniform_int_distribution__SWIG_1(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_uniform_int_distribution__SWIG_1")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
integer(C_INT32_T), intent(in) :: farg1
integer(C_INT32_T), intent(in) :: farg2
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

subroutine swigc_uniform_int_distribution__SWIG_2(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_uniform_int_distribution__SWIG_2")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
integer(C_INT64_T), intent(in) :: farg1
integer(C_INT64_T), intent(in) :: farg2
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

subroutine swigc_uniform_real_distribution(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_uniform_real_distribution")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
real(C_DOUBLE), intent(in) :: farg1
real(C_DOUBLE), intent(in) :: farg2
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

subroutine swigc_normal_distribution(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_normal_distribution")
use, intrinsic :: ISO_C_BINDING
import :: swigclasswrapper
import :: swigarraywrapper
real(C_DOUBLE), intent(in) :: farg1
real(C_DOUBLE), intent(in) :: farg2
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

subroutine swigc_discrete_distribution__SWIG_1(farg1, farg3, farg4) &
bind(C, name="_wrap_discrete_distribution__SWIG_1")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
import :: swigclasswrapper
type(SwigArrayWrapper) :: farg1
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

subroutine swigc_discrete_distribution__SWIG_2(farg1, farg3, farg4) &
bind(C, name="_wrap_discrete_distribution__SWIG_2")
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
import :: swigclasswrapper
type(SwigArrayWrapper) :: farg1
type(SwigClassWrapper), intent(in) :: farg3
type(SwigArrayWrapper) :: farg4
end subroutine

end interface


contains
 ! MODULE SUBPROGRAMS
function swigf_new_MersenneEngine4__SWIG_0() &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MersenneEngine4) :: self
type(SwigClassWrapper) :: fresult 

fresult = swigc_new_MersenneEngine4__SWIG_0()
self%swigdata = fresult
end function

function swigf_new_MersenneEngine4__SWIG_1(seed_value) &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MersenneEngine4) :: self
integer(C_INT32_T), intent(in) :: seed_value
type(SwigClassWrapper) :: fresult 
integer(C_INT32_T) :: farg1 

farg1 = seed_value
fresult = swigc_new_MersenneEngine4__SWIG_1(farg1)
self%swigdata = fresult
end function

subroutine swigf_MersenneEngine4_seed(self, seed_value)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine4), intent(in) :: self
integer(C_INT32_T), intent(in) :: seed_value
type(SwigClassWrapper) :: farg1 
integer(C_INT32_T) :: farg2 

farg1 = self%swigdata
farg2 = seed_value
call swigc_MersenneEngine4_seed(farg1, farg2)
end subroutine

subroutine swigf_MersenneEngine4_discard(self, count)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine4), intent(in) :: self
integer(C_LONG_LONG), intent(in) :: count
type(SwigClassWrapper) :: farg1 
integer(C_LONG_LONG) :: farg2 

farg1 = self%swigdata
farg2 = count
call swigc_MersenneEngine4_discard(farg1, farg2)
end subroutine

function swigf_MersenneEngine4_next(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT32_T) :: swig_result
class(MersenneEngine4), intent(in) :: self
integer(C_INT32_T) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MersenneEngine4_next(farg1)
swig_result = fresult
end function

subroutine swigf_MersenneEngine4_release(self)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine4), intent(inout) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
if (btest(farg1%cmemflags, swig_cmem_own_bit)) then
call swigc_delete_MersenneEngine4(farg1)
endif
farg1%cptr = C_NULL_PTR
farg1%cmemflags = 0
self%swigdata = farg1
end subroutine

subroutine swigf_MersenneEngine4_op_assign__(self, other)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine4), intent(inout) :: self
type(MersenneEngine4), intent(in) :: other
type(SwigClassWrapper) :: farg1 
type(SwigClassWrapper) :: farg2 

farg1 = self%swigdata
farg2 = other%swigdata
call swigc_MersenneEngine4_op_assign__(farg1, farg2)
self%swigdata = farg1
end subroutine

function swigf_new_MersenneEngine8__SWIG_0() &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MersenneEngine8) :: self
type(SwigClassWrapper) :: fresult 

fresult = swigc_new_MersenneEngine8__SWIG_0()
self%swigdata = fresult
end function

function swigf_new_MersenneEngine8__SWIG_1(seed_value) &
result(self)
use, intrinsic :: ISO_C_BINDING
type(MersenneEngine8) :: self
integer(C_INT64_T), intent(in) :: seed_value
type(SwigClassWrapper) :: fresult 
integer(C_INT64_T) :: farg1 

farg1 = seed_value
fresult = swigc_new_MersenneEngine8__SWIG_1(farg1)
self%swigdata = fresult
end function

subroutine swigf_MersenneEngine8_seed(self, seed_value)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine8), intent(in) :: self
integer(C_INT64_T), intent(in) :: seed_value
type(SwigClassWrapper) :: farg1 
integer(C_INT64_T) :: farg2 

farg1 = self%swigdata
farg2 = seed_value
call swigc_MersenneEngine8_seed(farg1, farg2)
end subroutine

subroutine swigf_MersenneEngine8_discard(self, count)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine8), intent(in) :: self
integer(C_LONG_LONG), intent(in) :: count
type(SwigClassWrapper) :: farg1 
integer(C_LONG_LONG) :: farg2 

farg1 = self%swigdata
farg2 = count
call swigc_MersenneEngine8_discard(farg1, farg2)
end subroutine

function swigf_MersenneEngine8_next(self) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T) :: swig_result
class(MersenneEngine8), intent(in) :: self
integer(C_INT64_T) :: fresult 
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
fresult = swigc_MersenneEngine8_next(farg1)
swig_result = fresult
end function

subroutine swigf_MersenneEngine8_release(self)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine8), intent(inout) :: self
type(SwigClassWrapper) :: farg1 

farg1 = self%swigdata
if (btest(farg1%cmemflags, swig_cmem_own_bit)) then
call swigc_delete_MersenneEngine8(farg1)
endif
farg1%cptr = C_NULL_PTR
farg1%cmemflags = 0
self%swigdata = farg1
end subroutine

subroutine swigf_MersenneEngine8_op_assign__(self, other)
use, intrinsic :: ISO_C_BINDING
class(MersenneEngine8), intent(inout) :: self
type(MersenneEngine8), intent(in) :: other
type(SwigClassWrapper) :: farg1 
type(SwigClassWrapper) :: farg2 

farg1 = self%swigdata
farg2 = other%swigdata
call swigc_MersenneEngine8_op_assign__(farg1, farg2)
self%swigdata = farg1
end subroutine

subroutine SWIGTM_fin_int32_t_Sb__SB_(finp, iminp)
  use, intrinsic :: ISO_C_BINDING
  integer(C_INT32_T), dimension(:), intent(in), target :: finp
  type(SwigArrayWrapper), intent(out) :: iminp
  integer(C_SIZE_T) :: sz
  integer(C_INT32_T), pointer :: imtemp

  sz = size(finp, kind=C_SIZE_T)
  if (sz > 0_c_size_t) then
    imtemp => finp(1)
    iminp%data = c_loc(imtemp)
  else
    iminp%data = c_null_ptr
  end if
  iminp%size = sz
end subroutine
subroutine swigf_uniform_int_distribution__SWIG_1(left, right, engine, data)
use, intrinsic :: ISO_C_BINDING
integer(C_INT32_T), intent(in) :: left
integer(C_INT32_T), intent(in) :: right
class(MersenneEngine4), intent(in) :: engine
integer(C_INT32_T), dimension(:), target :: data
integer(C_INT32_T) :: farg1 
integer(C_INT32_T) :: farg2 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

farg1 = left
farg2 = right
farg3 = engine%swigdata
call SWIGTM_fin_int32_t_Sb__SB_(data, farg4)
call swigc_uniform_int_distribution__SWIG_1(farg1, farg2, farg3, farg4)
end subroutine

subroutine SWIGTM_fin_int64_t_Sb__SB_(finp, iminp)
  use, intrinsic :: ISO_C_BINDING
  integer(C_INT64_T), dimension(:), intent(in), target :: finp
  type(SwigArrayWrapper), intent(out) :: iminp
  integer(C_SIZE_T) :: sz
  integer(C_INT64_T), pointer :: imtemp

  sz = size(finp, kind=C_SIZE_T)
  if (sz > 0_c_size_t) then
    imtemp => finp(1)
    iminp%data = c_loc(imtemp)
  else
    iminp%data = c_null_ptr
  end if
  iminp%size = sz
end subroutine
subroutine swigf_uniform_int_distribution__SWIG_2(left, right, engine, data)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), intent(in) :: left
integer(C_INT64_T), intent(in) :: right
class(MersenneEngine4), intent(in) :: engine
integer(C_INT64_T), dimension(:), target :: data
integer(C_INT64_T) :: farg1 
integer(C_INT64_T) :: farg2 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

farg1 = left
farg2 = right
farg3 = engine%swigdata
call SWIGTM_fin_int64_t_Sb__SB_(data, farg4)
call swigc_uniform_int_distribution__SWIG_2(farg1, farg2, farg3, farg4)
end subroutine

subroutine SWIGTM_fin_double_Sb__SB_(finp, iminp)
  use, intrinsic :: ISO_C_BINDING
  real(C_DOUBLE), dimension(:), intent(in), target :: finp
  type(SwigArrayWrapper), intent(out) :: iminp
  integer(C_SIZE_T) :: sz
  real(C_DOUBLE), pointer :: imtemp

  sz = size(finp, kind=C_SIZE_T)
  if (sz > 0_c_size_t) then
    imtemp => finp(1)
    iminp%data = c_loc(imtemp)
  else
    iminp%data = c_null_ptr
  end if
  iminp%size = sz
end subroutine
subroutine uniform_real_distribution(left, right, engine, data)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: left
real(C_DOUBLE), intent(in) :: right
class(MersenneEngine4), intent(in) :: engine
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE) :: farg1 
real(C_DOUBLE) :: farg2 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

farg1 = left
farg2 = right
farg3 = engine%swigdata
call SWIGTM_fin_double_Sb__SB_(data, farg4)
call swigc_uniform_real_distribution(farg1, farg2, farg3, farg4)
end subroutine

subroutine normal_distribution(mean, stddev, engine, data)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: mean
real(C_DOUBLE), intent(in) :: stddev
class(MersenneEngine4), intent(in) :: engine
real(C_DOUBLE), dimension(:), target :: data
real(C_DOUBLE) :: farg1 
real(C_DOUBLE) :: farg2 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

farg1 = mean
farg2 = stddev
farg3 = engine%swigdata
call SWIGTM_fin_double_Sb__SB_(data, farg4)
call swigc_normal_distribution(farg1, farg2, farg3, farg4)
end subroutine

subroutine swigf_discrete_distribution__SWIG_1(weights, engine, data)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(:), intent(in), target :: weights
class(MersenneEngine4), intent(in) :: engine
integer(C_INT32_T), dimension(:), target :: data
type(SwigArrayWrapper) :: farg1 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

call SWIGTM_fin_double_Sb__SB_(weights, farg1)
farg3 = engine%swigdata
call SWIGTM_fin_int32_t_Sb__SB_(data, farg4)
call swigc_discrete_distribution__SWIG_1(farg1, farg3, farg4)
end subroutine

subroutine swigf_discrete_distribution__SWIG_2(weights, engine, data)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(:), intent(in), target :: weights
class(MersenneEngine4), intent(in) :: engine
integer(C_INT64_T), dimension(:), target :: data
type(SwigArrayWrapper) :: farg1 
type(SwigClassWrapper) :: farg3 
type(SwigArrayWrapper) :: farg4 

call SWIGTM_fin_double_Sb__SB_(weights, farg1)
farg3 = engine%swigdata
call SWIGTM_fin_int64_t_Sb__SB_(data, farg4)
call swigc_discrete_distribution__SWIG_2(farg1, farg3, farg4)
end subroutine


end module
