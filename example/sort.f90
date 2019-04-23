!-----------------------------------------------------------------------------!
! \file   example/sort.f90
!-----------------------------------------------------------------------------!

program main
    use ISO_FORTRAN_ENV
    use, intrinsic :: ISO_C_BINDING
    use flc, only : get_flibcpp_version_string
    use flc_algorithm, only : sort

    implicit none
    integer :: n = 10000
    real(c_double), dimension(:), allocatable :: x

    write(*,*) "Flibcpp version ", get_flibcpp_version_string()

    allocate(x(n))
    ! TODO: fill randomly
    x = 1
    call sort(x)

    write(*,*) "Success!"
end program


!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
