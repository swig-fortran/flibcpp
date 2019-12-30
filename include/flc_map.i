/*!
 * \file flc_map.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_map"
%include "import_flc.i"
%flc_add_header

%include <std_map.i>

/* -------------------------------------------------------------------------
 * Numeric maps
 * ------------------------------------------------------------------------- */

%template(MapIntInt) std::map<int, int>;

/* -------------------------------------------------------------------------
 * String maps
 * ------------------------------------------------------------------------- */

%include <std_string.i>
%import "flc_string.i"
%template(MapStringInt) std::map<std::string, int>;
%template(MapStringString) std::map<std::string, std::string>;
