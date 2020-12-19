import hashlib
import itertools

def input():
  return open('./input.txt', 'r').read().strip()

def process(data):
  for i in itertools.count():
    sequence = f'{data}{i}'.encode()
    digest = hashlib.md5(sequence).hexdigest()
    if digest.startswith('000000'):
      return i

print(process(input()))
