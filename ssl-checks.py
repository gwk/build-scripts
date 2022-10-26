# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

from ssl import *

from pithy.fs import path_exists
from pithy.io import errL

paths = get_default_verify_paths()
#print(paths)

def check(name):
  val = getattr(paths, name)
  errL(f'{name}: {val} ? {val and path_exists(val, follow=True)}')

check('cafile')
check('capath')
check('openssl_cafile')
check('openssl_capath')
