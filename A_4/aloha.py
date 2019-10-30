import matplotlib.pyplot as plt
import numpy as np
import math

def combinacao (n, p):
    return (math.factorial(n)/(math.factorial(n-p)*math.factorial(p)))

def epoca_k (N, a, k):
    return combinacao(N,k)*(a**k)*((1-a)**(N-k))

def vazao_pure(N, a, T):
    u0 = (epoca_k(N,a,0))
    u1 = (epoca_k(N,a,1))
    P = [[u0, (1-u0-u1), (u1)],[u0, (1-u0), 0],[u0, (1-u0), 0]]
    #s1 = u0
    #s2 = 1 - u0 - u1
    #s3 = u0 * u1 #vazão do sistema em relacao a um passo
    return u0 * u1

def vs_slotted(N, a):
    return N*a*((1-a)**(N-1))

def vs_pure(N, a):
    return N*a*((1-a)**((2*N)-1))

N = 10
a = 0.2
T = 1/10**7

vs_aloha_pure = vs_pure(N, a)
vs_aloha_slotted = vs_slotted(N, a)
print ('Vazão frames por steps aloha puro', vs_aloha_pure)
print ('Vazão frames por segundo aloha puro', vs_aloha_pure/T)
print ('Vazão frames por steps aloha slotted', vs_aloha_slotted)
print ('Vazão frames por segundo aloha slotted', vs_aloha_slotted/T)

base = np.arange(0,1,0.1)
yp = np.arange(0,1,0.1)
x = np.arange(0,1,0.1)
ys = np.arange(0,1,0.1)

for i in range (10):
    x[i] = N * base[i]
    yp[i] = vs_pure (N, base[i])
    ys[i] = vs_slotted (N, base[i])

print('Vs aloha puro: ', vs_aloha_pure)
print('Vs aloha slotted: ', vs_aloha_slotted)
plt.xlabel('Na')
plt.ylabel('V')
plt.title('Aloha puro x Aloha Slotted')
plt.plot(x, yp)
plt.plot(x, ys)
plt.savefig('comparacao.png')

