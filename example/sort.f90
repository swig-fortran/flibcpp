!-----------------------------------------------------------------------------!
! \file   example/sort.f90
!-----------------------------------------------------------------------------!

program main
    use ISO_FORTRAN_ENV
    use, intrinsic :: ISO_C_BINDING
    use flc
    use flc_algorithm, only : sort

    implicit none
    integer :: n = 10000
    real(c_double), dimension(:), allocatable :: x

    write(*,"(a, 2(i1,'.'), (i1))") "Flibcpp version number: ", &
        flibcpp_version_major, flibcpp_version_minor, flibcpp_version_patch
    write(*,*) "Flibcpp version string: ", get_flibcpp_version()

    allocate(x(n))
    ! TODO: fill randomly
    x = 1
    call sort(x)

    write(*,*) "Success!"
end program


!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
