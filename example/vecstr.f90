!-----------------------------------------------------------------------------!
! \file   example/vecstr.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

program vecstr_example
  use, intrinsic :: ISO_FORTRAN_ENV
  use, intrinsic :: ISO_C_BINDING
  use flc
  use flc_string, only : String
  use flc_vector, only : VectorString
  implicit none
  integer, parameter :: STDOUT = OUTPUT_UNIT
  integer :: i
  type(VectorString) :: vec
  type(String) :: back, front
  character(C_CHAR), dimension(:), pointer :: chars

  ! Read a vector of strings
  call read_strings(vec)

  write(STDOUT, "(a, i3, a)") "Read ", vec%size(), " strings:"
  do i = 1, vec%size()
    write(STDOUT, "(i3, ': ', a)") i, vec%get(i)
  end do

  if (vec%empty()) then
    write(STDOUT, *) "No vectors provided"
    call vec%release()
    stop 0
  endif

  ! Get the final string for modification
  back = vec%back_ref()
  chars => back%view()
  ! Change all characters to exclamation points
  chars(:) = '!'
  write(STDOUT, *) "The last string is very excited: " // vec%get(vec%size())


  ! *Copy* back string to front, and add a question mark
  front = vec%front_ref()
  ! XXX: this creates an *alias* rather than assigning values. Revisit
  ! ownership semantics??
  ! front = back
  call vec%set_ref(1, back)
  call front%push_back("?")
  
  ! Modify back to be something else. 
  call back%assign("the end")

  ! Modifying 'back' invalidates the 'chars' view. Clear it to be safe.
  chars => NULL()

  write(STDOUT, *) "Modified 'front' string is " // vec%get(1)
  write(STDOUT, *) "Modified 'back' string is " // vec%get(vec%size())

  ! Remove the first string (invalidating back and front references)
  call vec%erase(1)
  call back%release()
  call front%release()

  write(STDOUT, "(a, i3, a)") "Ended up with ", vec%size(), " strings:"
  do i = 1, vec%size()
    write(STDOUT, "(i3, ': ', a)") i, vec%get(i)
  end do

  ! Free allocated vector memory
  call vec%release()
contains

! Loop until the user inputs a positive integer. Catch error conditions. 
subroutine read_strings(vec)
  use flc
  use flc_string, only : stoi
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
end program

!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
