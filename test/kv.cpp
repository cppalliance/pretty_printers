//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <testlib/all.hpp>

void test_kvpair()
{
    testlib::key_value_pair kv{"foo", 12};
    // TEST_EXPR( 'kv', 'key_value_pair["foo" = 12]' )
    (void)kv;
}
