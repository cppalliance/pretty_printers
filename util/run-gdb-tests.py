#!/usr/bin/env python
#
# Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#

import os.path
import subprocess
import sys

gdb = sys.argv[1]
program = sys.argv[2]
runner = sys.argv[3]

result = subprocess.run(
    [
        gdb, '--batch-silent',
        '-iex', 'add-auto-load-safe-path %s' % os.path.dirname(runner),
        '-x', runner,
        program,
    ],
    stdin=sys.stdin, stdout=sys.stdout, stderr=sys.stderr)
sys.exit(result.returncode)
