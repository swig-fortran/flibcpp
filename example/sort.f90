!-----------------------------------------------------------------------------!
! \file   example/sort.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

program main
  use ISO_FORTRAN_ENV
  use, intrinsic :: ISO_C_BINDING
  use flc
  use flc_algorithm, only : sort
  use flc_random, only : Engine, normal_distribution
  implicit none
  integer, parameter :: STDOUT = OUTPUT_UNIT
  integer :: arr_size
  real(c_double), dimension(:), allocatable :: x
  real(c_double), parameter :: MEAN = 1.0d0, SIGMA = 0.5d0
  type(Engine) :: rng

  ! Print version information
  write(STDOUT, "(a)") "========================================"
  write(STDOUT, "(a, a)") "Flibcpp version: ", get_flibcpp_version()
  write(STDOUT, "(a, 2(i1,'.'), (i1), a)") "(Numeric version: ", &
      flibcpp_version_major, flibcpp_version_minor, flibcpp_version_patch, &
      ")"
  write(STDOUT, "(a)") "========================================"

  ! Get array size
  arr_size = read_positive_int("array size")
  allocate(x(arr_size))

  ! Fill randomly with normal distribution
  rng = Engine()
  call normal_distribution(MEAN, SIGMA, rng, x)

  ! Sort the array
  call sort(x)

  ! Write output
  write(STDOUT, "(a, 4(f8.3,','))") "First few elements:", x(:min(4, size(x)))
contains

! Loop until the user inputs a positive integer. Catch error conditions. 
function read_positive_int(desc) result(result_int)
  use flc
  use flc_string, only : stoi
  use ISO_FORTRAN_ENV
  implicit none
  character(len=*), intent(in) :: desc
  integer, parameter :: STDOUT = OUTPUT_UNIT, STDIN = INPUT_UNIT
  character(len=80) :: readstr
  integer :: result_int, io_ierr
  do
    write(STDOUT, *) "Enter " // desc // ": "
    read(STDIN, "(a)", iostat=io_ierr) readstr
    if (io_ierr == IOSTAT_END) then
      ! Error condition: ctrl-D during input
      write(STDOUT, *) "End of line"
      stop 0
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
      write(0,*) "Your integer is too darn big!"
    else if (ierr == SWIG_VALUEERROR) then
      ! Error condition: not an integer at all
      write(0,*) "That text you entered? It wasn't an integer."
    else
      write(0,*) "Unknown error", ierr
    end if
    write(0,*) "(Detailed error message: ", get_serr(), ")"

    ! Clear error flag so the next call to stoi succeeds
    ierr = 0
  end do
end function
end program

!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
