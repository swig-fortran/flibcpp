/*!
 * \file flc_chrono.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_chrono"
%include "import_flc.i"

%{
#include <chrono>
#include <thread>
#include <stdexcept>
%}

%inline %{
static void sleep_for(int ms) {
    if (ms < 0)
        throw std::domain_error("Invalid sleep time");
    std::this_thread::sleep_for(std::chrono::milliseconds(ms));
}
%}
