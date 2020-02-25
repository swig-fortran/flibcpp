!-----------------------------------------------------------------------------!
! \file   example/sort_generic.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

! Mock-up of a user-created type and comparison operator
module sort_generic_extras
  implicit none
  public

  ! Declare an example Fortran derived type
  type :: FortranString
    character(len=:), allocatable :: chars
  end type

  ! Declare a 'less than' operator for that type
  interface operator(<)
    module procedure fortranstring_less
  end interface

contains

! Lexicographically compare strings of equal length.
elemental function chars_less(left, right, length) &
    result(fresult)
  character(len=*), intent(in) :: left
  character(len=*), intent(in) :: right
  integer, intent(in) :: length
  logical :: fresult
  integer :: i, lchar, rchar

  ! If any character code is less than the RHS, it is less than.
  do i = 1, length
    lchar = ichar(left(i:i))
    rchar = ichar(right(i:i))
    if (lchar < rchar) then
      fresult = .true.
      return
    elseif (lchar > rchar) then
      fresult = .false.
      return
    endif
  end do

  fresult = .false.
end function

elemental function fortranstring_less(self, other) &
    result(fresult)
  type(FortranString), intent(in) :: self
  type(FortranString), intent(in) :: other
  logical :: fresult

  if (.not. allocated(other%chars)) then
    ! RHS is null and LHS is not
    fresult = .true.
  elseif (.not. allocated(self%chars)) then
    ! LHS is null => "greater than" (if LHS is string) or equal (if both null)
    fresult = .false.
  elseif (len(self%chars) < len(other%chars)) then
    ! Since LHS is shorter, it is "less than" the RHS.
    fresult = .true.
  elseif (len(self%chars) > len(other%chars)) then
    ! If RHS is shorter
    fresult = .false.
  else
    ! Compare strings of equal length
    fresult = chars_less(self%chars, other%chars, len(self%chars))
  endif
end function

! C++-accessible comparison function for two pointers-to-strings
! (null strings always compare "greater than" to move to end of a list)
function compare_strings(lcptr, rcptr) bind(C) &
    result(fresult)
  use, intrinsic :: ISO_C_BINDING
  type(C_PTR), intent(in), value :: lcptr
  type(C_PTR), intent(in), value :: rcptr
  logical(C_BOOL) :: fresult
  type(FortranString), pointer :: lptr
  type(FortranString), pointer :: rptr

  if (.not. c_associated(rcptr)) then
    ! RHS is null and LHS is not
    fresult = .true.
  elseif (.not. c_associated(lcptr)) then
    ! LHS is null => "greater than" (if LHS is string) or equal (if both null)
    fresult = .false.
  else
    ! Both associated: convert from C to Fortran pointers
    call c_f_pointer(cptr=lcptr, fptr=lptr)
    call c_f_pointer(cptr=rcptr, fptr=rptr)

    ! Compare the strings
    fresult = (lptr < rptr)
  endif
end function
end module

program sort_generic_example
  use, intrinsic :: ISO_FORTRAN_ENV
  use, intrinsic :: ISO_C_BINDING
  use flc
  use flc_algorithm, only : argsort, INDEX_INT
  use sort_generic_extras, only : compare_strings, FortranString
  use example_utils, only : write_version, read_positive_int, STDOUT, STDIN
  implicit none
  type(FortranString), dimension(:), allocatable, target :: fs_array
  type(C_PTR), dimension(:), allocatable, target :: ptrs
  integer(INDEX_INT), dimension(:), allocatable, target :: ordering
  character(len=80) :: readstr
  integer :: arr_size, i, io_ierr

  call write_version()

  ! Read strings
  arr_size = read_positive_int("string array size")
  allocate(fs_array(arr_size))
  do i = 1, arr_size
    write(STDOUT, "(a, i3)") "Enter string #", i
    read(STDIN, "(a)", iostat=io_ierr) readstr
    if (io_ierr == IOSTAT_END) then
      ! Leave further strings unallocated
      exit
    endif
    ! Allocate string
    allocate(fs_array(i)%chars, source=trim(readstr))
  enddo

  ! Create C pointers to the Fortran objects
  ptrs = [(c_loc(fs_array(i)), i = 1, arr_size)]

  ! Use 'argsort' to determine the new ordering
  allocate(ordering(arr_size))
  call argsort(ptrs, ordering, compare_strings)
  write(STDOUT, "(a, 20(i3))") "New order:", ordering

  ! Reorder the Fortran data
  fs_array = fs_array(ordering)

  ! Print the results
  write(STDOUT, *) "Sorted:"
  do i = 1, arr_size
    if (.not. allocated(fs_array(i)%chars)) then
      write(STDOUT, "(i3, '-', i3, a)") i, arr_size, " are unallocated"
      exit
    endif
    write(STDOUT, "(i3, ': ', a)") i, fs_array(i)%chars
  enddo

end program

!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
