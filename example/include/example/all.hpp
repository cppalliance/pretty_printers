//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#ifndef EXAMPLE_ALL_HPP
#define EXAMPLE_ALL_HPP

// Inlusion of the header with embedded pretty printers module is wrapped with
// a macro, in order to allow the users to disable the inclusion project-wise
// and only include that header in one translation unit. This is done, because
// reportedly some linkers get confused and add multiple copies of pretty
// printers into the resulting binary.
#ifndef EXAMPLE_NO_EMBEDDED_GDB_SCRIPTS
// The header is public, so that users could include it by themselves.
# include <example/gdb_printers.hpp>
#endif

#include <string>

namespace example
{

struct mystruct
{
    std::string key;
    int value;
};

} // namespace example


#endif // EXAMPLE_ALL_HPP
