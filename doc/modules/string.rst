.. ############################################################################
.. File  : doc/modules/string.rst
.. ############################################################################

.. _modules_string:

******
String
******

The string module includes the ``String`` derived type and a handful of string
conversion functions.

.. _modules_string_type:

String type
===========

The C++ standard library "string" is a dynamically resizable, mutable character
array.

Constructors
------------

Strings are constructed using three interface functions:

  - The function without arguments creates an empty string;
  - An integer argument ``count`` and a single character will create a string
    of size ``count`` filled with that character; and
  - A standard Fortran ``character(kind=C_CHAR, len=*)`` which will be copied
    to the string.

Here are three examples of initialization::

   use flc_string, only : String
   type(String) :: s

   s = String()
   ! s%size() == 0
   s = String(10, "!")
   ! s%size() == 10
   ! s%get(i) == "!"
   s = String("I am a string!")


Character element access
------------------------

The number of characters in the string is returned by the bound function
``size``. The ``get`` function returns the character at an index; and ``front``
and ``back`` are aliases for ``get(1)`` and ``get(v%size())``, respectively.

.. important:: Unlike the C++ version of this class, **strings in Flibcpp
   use 1-offset indexing**. See :ref:`conventions_indexing`.

Modification
------------

Like :ref:`vectors <modules_Vector>`, Strings can be resized dynamically using
a variety of methods:

  - ``resize`` to specify an exact size;
  - ``push_back`` to add a new character to the end of it;
  - ``append`` to add another string to the end
  - ``pop_back`` to remove the last character;
  - ``clear`` to remove all elements.

The string also has a ``set`` bound subroutine for assigning a character to a
specified index::

   type(String) :: s

   s = String("=", 10)
   call s%set(1, "8")
   call s%set(s%size(), "D")

Search
------

The ``find`` bound function will search for a substring, starting at an
optional position. Like the :ref:`search
algorithms <modules_algorithm_searching>` in Flibcpp, a search result of `0`
indicates "not found" and any other result is the 1-offset index in the
string. ::

   type(String) :: s
   integer :: i

   s = String("meowmeow")
   i = s%find("meow")    ! Returns 1
   i = s%find("meow", 3) ! Returns 5
   i = s%find("woof")    ! Returns 0

View as an array pointer
------------------------

The string can be viewed (and indeed modified) as an array of character
elements::

   type(String) :: s
   character, dimension(:), pointer :: charptr

   s = String("Hello!")
   charptr => s%view()
   charptr(6) = "?" ! change greeting to a question

Conversion to native string
---------------------------

The ``str`` type-bound function returns an allocated character string::

   character(len=:), allocatable :: native
   type(String) :: s

   s = String("Hello world")
   native = s%str()
   write(0,"(a)") native


Conversion functions
====================

The ``flc_string`` module includes several module procedures for converting
native Fortran strings to integers and real numbers. These functions are robust
and exception-safe, allowing intelligent error handling from the Fortran side.

 - Integer conversion: ``stoi``, ``stol``, ``stoll``
 - Real conversion: ``stof``, ``stod``

::

   use flc, only : ierr, get_serr, SWIG_OverflowError, SWIG_ValueError
   use flc_string
   implicit none
   integer(4) :: temp
   character(len=100) :: tempstr

   read(*, '(a)') tempstr
   temp = stoi(trim(tempstr))
   if (ierr == SWIG_OverflowError) then
     write(0,*) "Your integer is too darn big!"
   elseif (ierr == SWIG_ValueError) then
     write(0,*) "That thing you entered? It wasn't an integer."
   end if

Integer conversion defaults to base-10, but passing an additional integer
argument allows conversion from other bases. The special integer value of ``0``
allows auto-detection of values in octal (with a leading ``0`` as in ``0777``)
or hexadecimal (with a leading ``0x`` as in ``0xb1f1c2a3``).

.. ############################################################################
.. end of doc/modules/string.rst
.. ############################################################################
