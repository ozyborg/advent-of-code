def input():
  return list(open('./input.txt', 'r').read().strip())

def process(data):
  return data.count('(') - data.count(')')

print(process(input()))
