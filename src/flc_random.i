/*!
 * \file flc_random.i
 *
 * Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
 * Distributed under an MIT open source license: see LICENSE for details.
 */

%module "flc_random"
%import "flc.i"
%flc_add_header


%{
#include <random>
#include <algorithm>
static std::mt19937* g_generator = nullptr;
%}

%inline %{
static void init_rng(int seed) {
    delete g_generator;
    g_generator = new std::mt19937(seed);
}

template<class T>
static void shuffle(T *DATA, size_t SIZE) {
    std::shuffle(DATA, DATA + SIZE, *g_generator);
}

%}

%flc_template_numeric(shuffle)
