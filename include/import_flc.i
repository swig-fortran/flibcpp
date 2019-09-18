/*!
 * \file import_flc.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

// Make sure that the downstream module isn't doing ``%import "import_flc.i"``
// or ``%import "flc.i"``: only ``%include "import_flc.i"``
#ifndef SWIGIMPORTED
#define FLC_SWIGIMPORTED
#endif

// Set up macros, etc.
%import "flc.i"

// Support external exceptions
%include <extern_exception.i>
