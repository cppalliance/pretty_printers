//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <example/all.hpp>

#include <cstdlib>


int main()
{
    example::mystruct s{"foo", 12};
    // TEST_EXPR( 's', 'mystruct["foo" = 12]' )
    (void)s;

    return EXIT_SUCCESS;
}
