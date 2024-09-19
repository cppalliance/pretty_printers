# Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# For Drone CI we use the Starlark scripting language to reduce duplication.
# As the yaml syntax for Drone CI is rather limited.

linuxglobalimage="cppalliance/droneubuntu1804:1"

def main(ctx):
  return [
    linux_cxx("B2", "g++", packages="g++-13 gdb", buildscript="drone", buildtype="b2", image=linuxglobalimage),
    linux_cxx("CMake", "g++", packages="g++-13 gdb", buildtype="cmake", buildscript="drone", image=linuxglobalimage),
  ]

# from https://github.com/boostorg/boost-ci
load("@boost_ci//ci/drone/:functions.star", "linux_cxx")
