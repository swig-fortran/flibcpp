!-----------------------------------------------------------------------------!
! \file   test/test_algorithm.F90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

#include "fassert.h"

program test_random
  implicit none
  call test_engines()
  call test_uniform_int_distribution()
  call test_uniform_real_distribution()
  call test_normal_distribution()
  call test_discrete_distribution()
contains

!-----------------------------------------------------------------------------!
subroutine test_engines()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : MersenneEngine4, MersenneEngine8
  implicit none
  type(MersenneEngine4) :: eng4
  type(MersenneEngine8) :: eng8
  integer(4), dimension(2) :: i4
  integer(8), dimension(2) :: i8
  integer(4), dimension(2), parameter :: expected_i4 = [ &
      822569775, 2137449171]
  integer(8), dimension(2), parameter :: expected_i8 = [ &
      -973404863619218144_8 , 963351229459618018_8]

  eng4 = MersenneEngine4(1234_c_int32_t)
  i4(1) = eng4%next()
  i4(2) = eng4%next()
  ASSERT(all(expected_i4 == i4))

  eng8 = MersenneEngine8(1234_c_int64_t)
  i8(1) = eng8%next()
  i8(2) = eng8%next()
  ASSERT(all(expected_i8 == i8))

  call eng4%release()
  call eng8%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_uniform_int_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine => MersenneEngine4, uniform_int_distribution
  implicit none
  integer(C_INT), dimension(:), allocatable :: arr
  type(Engine) :: rng

  allocate(arr(128))
  rng = Engine(1234_c_int32_t) ! Initialize with seed

  call uniform_int_distribution(5, 15, rng, arr)
  ASSERT(minval(arr) >= 5)
  ASSERT(maxval(arr) <= 15)
  ASSERT(abs(sum(arr) - (10 * size(arr))) < size(arr) / 10)

  call rng%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_uniform_real_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine => MersenneEngine4, uniform_real_distribution
  implicit none
  real(C_DOUBLE), dimension(256) :: arr
  real(C_DOUBLE) :: avg
  type(Engine) :: rng

  rng = Engine() ! Initialize with default seed

  call uniform_real_distribution(5.d0, 15.d0, rng, arr)
  ASSERT(minval(arr) >= 5.d0)
  ASSERT(maxval(arr) <= 15.d0)

  avg = sum(arr) / real(size(arr), kind=8)
  ASSERT(avg >= 9.5 .and. avg <= 10.5)

  call rng%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_normal_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine => MersenneEngine4, normal_distribution
  implicit none
  real(C_DOUBLE), dimension(:), allocatable :: arr
  real(C_DOUBLE) :: avg
  type(Engine) :: rng

  allocate(arr(1024))
  rng = Engine() ! Initialize with default seed

  ! Mean=10, sigma=2
  call normal_distribution(10.0d0, 2.0d0, rng, arr)

  avg = sum(arr) / real(size(arr), kind=8)
  ASSERT(avg >= 9.9 .and. avg <= 10.1)

  call rng%release()
end subroutine

!-----------------------------------------------------------------------------!
subroutine test_discrete_distribution()
  use, intrinsic :: ISO_C_BINDING
  use flc_random, only : Engine => MersenneEngine4, discrete_distribution
  implicit none
  real(C_DOUBLE), dimension(4), parameter :: weights &
      = [.125d0, .125d0, .25d0, .5d0]
  integer(C_INT), dimension(1024) :: sampled
  integer(C_INT), dimension(4) :: tallied = 0
  integer(C_INT), dimension(4), parameter :: gold_result = [130, 127, 267, 500]
  integer :: i

  ! Sample 1024 random ints
  call discrete_distribution(weights, Engine(), sampled)
  ASSERT(minval(sampled) == 1)
  ASSERT(maxval(sampled) == size(weights))
  do i = 1, size(sampled)
    tallied(sampled(i)) = tallied(sampled(i)) + 1
  enddo

  ASSERT(all(tallied == gold_result))
end subroutine

!-----------------------------------------------------------------------------!

end program

