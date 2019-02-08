!-----------------------------------------------------------------------------!
! \file   example/sort.f90
!-----------------------------------------------------------------------------!

program main
    use ISO_FORTRAN_ENV
    use, intrinsic :: ISO_C_BINDING
    use flc_algorithm, only : sort

    implicit none
    integer :: n = 10000
    real(c_double), dimension(:), allocatable :: x

    allocate(x(n))
    ! TODO: fill randomly
    x = 1
    call sort(x)
end program


!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
