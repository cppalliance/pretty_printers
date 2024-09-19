#
# Copyright (c) 2024 Dmitry Arkhipov (grisumbras@yandex.ru)
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#

import gdb
import gdb.printing


collection = gdb.printing.RegexpCollectionPrettyPrinter(
    'BoostPrettyPrintersTest')
def register_one(printer, ns=None, template=False):
    typename = getattr(printer, '__name__')
    ns = ns or 'boost_pp'
    collection.add_printer(
        typename,
        '^{ns}::{typename}{marker}'.format(
            ns=ns,
            typename=typename,
            marker='<'if template else '$'),
        printer)

obj_file = gdb.current_objfile()
mod = obj_file or gdb
for printer in getattr(mod, 'pretty_printers', []):
    if getattr(printer, 'name') == collection.name:
        return
gdb.printing.register_pretty_printer(obj_file, collection)
