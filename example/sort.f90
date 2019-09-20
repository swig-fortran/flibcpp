!-----------------------------------------------------------------------------!
! \file   example/sort.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

program sort_example
  use, intrinsic :: ISO_C_BINDING
  use flc
  use flc_algorithm, only : sort
  use flc_random, only : Engine, normal_distribution
  use example_utils, only : write_version, read_positive_int, STDOUT
  implicit none
  integer :: arr_size
  real(c_double), dimension(:), allocatable :: x
  real(c_double), parameter :: MEAN = 1.0d0, SIGMA = 0.5d0
  type(Engine) :: rng

  ! Print version information
  call write_version()

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

  call rng%release()
end program

!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
