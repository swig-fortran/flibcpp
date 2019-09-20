!-----------------------------------------------------------------------------!
! \file   example/example_utils.f90
! \brief  example_utils module
! \note   Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

module example_utils
  use, intrinsic :: ISO_FORTRAN_ENV
  use, intrinsic :: ISO_C_BINDING
  implicit none
  integer, parameter :: STDOUT = OUTPUT_UNIT, STDIN = INPUT_UNIT
  public
    
contains

subroutine write_version()
  use flc
  implicit none
  ! Print version information
  write(STDOUT, "(a)") "========================================"
  write(STDOUT, "(a, a)") "Flibcpp version: ", get_flibcpp_version()
  write(STDOUT, "(a, 2(i1,'.'), (i1), a)") "(Numeric version: ", &
      flibcpp_version_major, flibcpp_version_minor, flibcpp_version_patch, &
      ")"
  write(STDOUT, "(a)") "========================================"
end subroutine
    
! Loop until the user inputs a positive integer. Catch error conditions. 
function read_positive_int(desc) result(result_int)
  use flc
  use flc_string, only : stoi
  implicit none
  character(len=*), intent(in) :: desc
  character(len=80) :: readstr
  integer :: result_int, io_ierr
  do
    write(STDOUT, *) "Enter " // desc // ": "
    read(STDIN, "(a)", iostat=io_ierr) readstr
    if (io_ierr == IOSTAT_END) then
      ! Error condition: ctrl-D during input
      write(STDOUT, *) "User terminated"
      stop 1
    endif

    result_int = stoi(readstr)
    if (ierr == 0) then
      if (result_int <= 0) then
        ! Error condition: non-positive value
        write(STDOUT, *) "Invalid " // desc // ": ", result_int
        continue
      end if

      write(STDOUT, *) "Read " // desc // "=", result_int
      exit
    endif

    if (ierr == SWIG_OVERFLOWERROR) then
      ! Error condition: integer doesn't fit in native integer
      write(STDOUT,*) "Your integer is too darn big!"
    else if (ierr == SWIG_VALUEERROR) then
      ! Error condition: not an integer at all
      write(STDOUT,*) "That text you entered? It wasn't an integer."
    else
      write(STDOUT,*) "Unknown error", ierr
    end if
    write(STDOUT,*) "(Detailed error message: ", get_serr(), ")"

    ! Clear error flag so the next call to stoi succeeds
    ierr = 0
  end do
end function

! Loop until the user inputs a positive integer. Catch error conditions. 
subroutine read_strings(vec)
  use flc
  use flc_string, only : String
  use flc_vector, only : VectorString
  use ISO_FORTRAN_ENV
  implicit none
  type(VectorString), intent(out) :: vec
  integer, parameter :: STDOUT = OUTPUT_UNIT, STDIN = INPUT_UNIT
  character(len=80) :: readstr
  integer :: io_ierr
  type(String) :: str

  ! Allocate the vector
  vec = VectorString()

  do
    ! Request and read a string
    write(STDOUT, "(a, i3, a)") "Enter string #", vec%size() + 1, &
        " or Ctrl-D/empty string to complete"
    read(STDIN, "(a)", iostat=io_ierr) readstr
    if (io_ierr == IOSTAT_END) then
      ! Break out of loop on ^D (EOF)
      exit
    end if

    ! Add string to the end of the vector
    call vec%push_back(trim(readstr))
    ! Get a String object reference to the back to check if it's empty
    str = vec%back_ref()
    if (str%empty()) then
      ! Remove the empty string
      call vec%pop_back()
      exit
    end if
  end do
end subroutine

end module

!-----------------------------------------------------------------------------!
! end of example/example_utils.f90
!-----------------------------------------------------------------------------!
