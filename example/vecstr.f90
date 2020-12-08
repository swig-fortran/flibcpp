!-----------------------------------------------------------------------------!
! \file   example/vecstr.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
!-----------------------------------------------------------------------------!

program vecstr_example
  use, intrinsic :: ISO_C_BINDING
  use flc
  use flc_string, only : String
  use flc_vector, only : VectorString
  use example_utils, only : read_strings, write_version, STDOUT
  implicit none
  integer :: i
  type(VectorString) :: vec
  type(String) :: back, front, temp
  character(C_CHAR), dimension(:), pointer :: chars

  ! Print version information
  call write_version()

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
  temp = String(back%str())
  ! Change all characters to exclamation points
  chars(:) = '!'
  write(STDOUT, *) "The last string is very excited: " // vec%get(vec%size())

  ! Modify a reference to the front value
  front = vec%front_ref()
  call front%push_back("?")

  ! Insert the original 'back' after the first string (make it element #2)
  call vec%insert(2, temp%str())
  ! Inserting the vector invalidates the 'chars' view and back reference.
  chars => NULL()
  back = vec%back_ref()
  write(STDOUT, *) "Inserted the original last string: " // vec%get(2)
  
  ! Modify back to be something else. 
  call back%assign("the end")

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
end program

!-----------------------------------------------------------------------------!
! end of example/sort.f90
!-----------------------------------------------------------------------------!
