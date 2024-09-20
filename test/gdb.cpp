//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <testlib/all.hpp>

#include <cstdlib>

int main()
{
    testlib::key_value_pair kv{"foo", 12};
    // TEST_EXPR( 'kv', 'key_value_pair["foo" = 12]' )
    (void)kv;

    unsigned char b[1024];
    testlib::memory_resource mr(b);
    // TEST_EXPR( 'mr', 'memory_resource[buffer={}, size=1024]', '/a &b' )
    (void)mr;

    return EXIT_SUCCESS;
}
