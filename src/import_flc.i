/*!
 * \file import_flc.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

#ifdef SWIGIMPORTED
#error "To use this header, %include "import_flc.i", don't %import it"
#endif

// Set up macros, etc.
%import "flc.i"

// Support external exceptions
%include <extern_exception.i>

// Instantiate header
%flc_add_header
