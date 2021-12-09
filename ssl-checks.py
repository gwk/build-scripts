from ssl import *

from pithy.fs import *
from pithy.io import *

paths = get_default_verify_paths()
#print(paths)

def check(name):
  val = getattr(paths, name)
  errFL('{}: {} ? {}', name, val, val and path_exists(val))

check('cafile')
check('capath')
check('openssl_cafile')
check('openssl_capath')
