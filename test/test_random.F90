!-----------------------------------------------------------------------------!
! \file   test/test_algorithm.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

program test_random
  implicit none
  call test_uniform_int_distribution()
  call test_uniform_real_distribution()
  call test_normal_distribution()
contains

!-----------------------------------------------------------------------------!
subroutine test_uniform_int_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine, uniform_int_distribution
  implicit none
  integer(C_INT), dimension(:), allocatable :: arr
  type(Engine) :: rng

  allocate(arr(20))
  rng = Engine(1234_c_int64_t) ! Initialize with seed

  call uniform_int_distribution(5, 15, rng, arr)
  write(*,*) "Result:", arr
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_uniform_real_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine, uniform_real_distribution
  implicit none
  real(C_DOUBLE), dimension(10) :: arr
  type(Engine) :: rng

  rng = Engine() ! Initialize with default seed

  call uniform_real_distribution(5.d0, 15.d0, rng, arr)
  write(*,*) "Result:", arr
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_normal_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine, normal_distribution
  implicit none
  real(C_DOUBLE), dimension(:), allocatable :: arr
  type(Engine) :: rng

  allocate(arr(10))
  rng = Engine() ! Initialize with default seed

  ! Mean=10, sigma=5
  call normal_distribution(10.0d0, 5.0d0, rng, arr)
  write(*,*) "Result:", arr
  ! Mean=1, sigma=1
  call normal_distribution(1.0d0, rng, arr)
  write(*,*) "Result:", arr
end subroutine

!-----------------------------------------------------------------------------!

end program

