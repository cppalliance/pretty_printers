//
// Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
//

#include <testlib/gdb.hpp>

#include <string>

namespace testlib
{

struct key_value_pair
{
    std::string key;
    int value;
};

struct memory_resource
{
    unsigned char* buffer;
    std::size_t size;

    template<std::size_t N>
    memory_resource(unsigned char (&buf)[N]) noexcept
        : memory_resource(buf, N)
    {}

    memory_resource(unsigned char *buf, std::size_t n) noexcept
        : buffer(buf), size(n)
    {}
};

} // namespace testlib
