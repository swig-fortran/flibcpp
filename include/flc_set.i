/*!
 * \file flc_set.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_set"
%include "import_flc.i"
%flc_add_header

%include <std_set.i>

/* -------------------------------------------------------------------------
 * Numeric sets
 * ------------------------------------------------------------------------- */

%template(SetInt) std::set<int>;

%include <std_string.i>
%import "flc_string.i"

/* -------------------------------------------------------------------------
 * String sets
 * ------------------------------------------------------------------------- */

%template(SetString) std::set<std::string>;
