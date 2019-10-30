class RandomADS:
    def __init__(self, a, c, m, seed):
        self.a = a
        self.c = c
        self.m = m
        self.seed = seed
        self.z0 = seed

    def calculo(self):
        self.seed = (self.a * self.seed + self.c) % self.m
        return self.seed

    def fracional(self, nome):
        self.nome = nome
     
    def limite(self, idade):
        self.idade = idade
     
