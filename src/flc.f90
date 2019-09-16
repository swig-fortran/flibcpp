! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.0.0
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! Flibcpp project, https://github.com/swig-fortran/flibcpp
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.

module flc
 use, intrinsic :: ISO_C_BINDING
 implicit none
 private

 ! DECLARATION CONSTRUCTS
 integer(C_INT), public, &
   bind(C, name="flc_ierr") :: ierr
 type, bind(C) :: SwigArrayWrapper
  type(C_PTR), public :: data = C_NULL_PTR
  integer(C_SIZE_T), public :: size = 0
 end type
 public :: get_serr
 integer(C_INT), parameter, public :: SWIG_UnknownError = -1_C_INT
 integer(C_INT), parameter, public :: SWIG_IOError = -2_C_INT
 integer(C_INT), parameter, public :: SWIG_RuntimeError = -3_C_INT
 integer(C_INT), parameter, public :: SWIG_IndexError = -4_C_INT
 integer(C_INT), parameter, public :: SWIG_TypeError = -5_C_INT
 integer(C_INT), parameter, public :: SWIG_DivisionByZero = -6_C_INT
 integer(C_INT), parameter, public :: SWIG_OverflowError = -7_C_INT
 integer(C_INT), parameter, public :: SWIG_SyntaxError = -8_C_INT
 integer(C_INT), parameter, public :: SWIG_ValueError = -9_C_INT
 integer(C_INT), parameter, public :: SWIG_SystemError = -10_C_INT
 integer(C_INT), parameter, public :: SWIG_AttributeError = -11_C_INT
 integer(C_INT), parameter, public :: SWIG_MemoryError = -12_C_INT
 integer(C_INT), parameter, public :: SWIG_NullReferenceError = -13_C_INT
 public :: get_flibcpp_version
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_major") :: flibcpp_version_major
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_minor") :: flibcpp_version_minor
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_patch") :: flibcpp_version_patch

! WRAPPER DECLARATIONS
interface
 subroutine SWIG_free(cptr) &
  bind(C, name="free")
 use, intrinsic :: ISO_C_BINDING
 type(C_PTR), value :: cptr
end subroutine
function swigc_get_serr() &
bind(C, name="_wrap_get_serr") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: fresult
end function

function swigc_flibcpp_version_get() &
bind(C, name="_wrap_flibcpp_version_get") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: fresult
end function

end interface


contains
 ! MODULE SUBPROGRAMS

subroutine SWIGTM_fout_const_SS_char_Sm_(imout, fout)
  use, intrinsic :: ISO_C_BINDING
  type(SwigArrayWrapper), intent(in) :: imout
  character(kind=C_CHAR, len=:), allocatable, intent(out) :: fout
  character(kind=C_CHAR), dimension(:), pointer :: chars
  integer(kind=C_SIZE_T) :: i
  call c_f_pointer(imout%data, chars, [imout%size])
  allocate(character(kind=C_CHAR, len=imout%size) :: fout)
  do i=1, imout%size
    fout(i:i) = chars(i)
  end do
end subroutine

function get_serr() &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
character(kind=C_CHAR, len=:), allocatable :: swig_result
type(SwigArrayWrapper) :: fresult 

fresult = swigc_get_serr()
call SWIGTM_fout_const_SS_char_Sm_(fresult, swig_result)
if (.false.) call SWIG_free(fresult%data)
end function

function get_flibcpp_version() &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
character(kind=C_CHAR, len=:), allocatable :: swig_result
type(SwigArrayWrapper) :: fresult 

fresult = swigc_flibcpp_version_get()
call SWIGTM_fout_const_SS_char_Sm_(fresult, swig_result)
if (.false.) call SWIG_free(fresult%data)
end function


end module