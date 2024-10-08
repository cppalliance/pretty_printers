//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <testlib/all.hpp>

#include <cstdlib>

void test_kvpair();
void test_memory_res();

int main()
{
    test_memory_res();
    test_kvpair();
    test_kvpair();
    return EXIT_SUCCESS;
}
