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
 type, bind(C) :: SwigArrayWrapper
  type(C_PTR), public :: data = C_NULL_PTR
  integer(C_SIZE_T), public :: size = 0
 end type
 public :: get_flibcpp_version
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_major") :: flibcpp_version_major
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_minor") :: flibcpp_version_minor
 integer(C_INT), protected, public, &
   bind(C, name="flibcpp_version_patch") :: flibcpp_version_patch

! WRAPPER DECLARATIONS
interface
function swigc_flibcpp_version_get() &
bind(C, name="_wrap_flibcpp_version_get") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
import :: swigarraywrapper
type(SwigArrayWrapper) :: fresult
end function

 subroutine SWIG_free(cptr) &
  bind(C, name="free")
 use, intrinsic :: ISO_C_BINDING
 type(C_PTR), value :: cptr
end subroutine
end interface


contains
 ! MODULE SUBPROGRAMS

subroutine SWIG_chararray_to_string(wrap, string)
  use, intrinsic :: ISO_C_BINDING
  type(SwigArrayWrapper), intent(IN) :: wrap
  character(kind=C_CHAR, len=:), allocatable, intent(OUT) :: string
  character(kind=C_CHAR), dimension(:), pointer :: chars
  integer(kind=C_SIZE_T) :: i
  call c_f_pointer(wrap%data, chars, [wrap%size])
  allocate(character(kind=C_CHAR, len=wrap%size) :: string)
  do i=1, wrap%size
    string(i:i) = chars(i)
  end do
end subroutine

function get_flibcpp_version() &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
character(kind=C_CHAR, len=:), allocatable :: swig_result
type(SwigArrayWrapper) :: fresult 

fresult = swigc_flibcpp_version_get()
call SWIG_chararray_to_string(fresult, swig_result)
if (.false.) call SWIG_free(fresult%data)
end function


end module
