import matplotlib.pyplot as plt

plt.style.use('grayscale')  # czarno-biały styl tła, linie mogą być kolorowe

# Przychód
plt.subplot(3, 2, 1)
plt.plot([130, 150, 170], [0, 1, 1], color='black', label='F. przynależności')
plt.plot(150, 1, 'go', label='zamierzenie')
plt.plot(150, 1, 'ro', label='wynik')
plt.title('Funkcja przynależności - przychód', fontsize=7)
plt.xlabel('Przychód [tys. PLN]')
plt.ylabel('µ_przychód(x)')
plt.grid(True)
plt.legend(fontsize=4, loc='lower right')

# Emisja zanieczyszczeń
plt.subplot(3, 2, 2)
plt.plot([17, 30, 35], [1, 1, 0], color='black')
plt.plot(30, 1, 'go', label='zamierzenie')
plt.plot(22.11, 1, 'ro', label='wynik')
plt.title('Funkcja przynależności - zanieczyszczenia', fontsize=7)
plt.xlabel('Zanieczyszczenia [kg]')
plt.ylabel('µ_zanieczyszczenia(x)')
plt.grid(True)
plt.legend(fontsize=4, loc='lower right')

# Koszt
plt.subplot(3, 2, 3)
plt.plot([20, 70, 80], [1, 1, 0], color='black')
plt.plot(70, 1, 'go', label='zamierzenie')
plt.plot(30.32, 1, 'ro', label='wynik')
plt.title('Funkcja przynależności - koszt', fontsize=7)
plt.xlabel('Koszt [tys. PLN]')
plt.ylabel('µ_koszt(x)')
plt.grid(True)
plt.legend(fontsize=4, loc='lower right')

# Zużycie S1
plt.subplot(3, 2, 5)
plt.plot([90, 100, 110], [1, 1, 0], color='black')
plt.plot(100, 1, 'go', label='zamierzenie')
plt.plot(58.84, 1, 'ro', label='wynik')
plt.title('Funkcja przynależności - zużycie S1', fontsize=7)
plt.xlabel('Zużycie S1 [kg]')
plt.ylabel('µ_S1(x)')
plt.grid(True)
plt.legend(fontsize=4, loc='lower right')

# Zużycie S2
plt.subplot(3, 2, 6)
plt.plot([45, 50, 55], [1, 1, 0], color='black')
plt.plot(50, 1, 'go', label='zamierzenie')
plt.plot(48.11, 1, 'ro', label='wynik')
plt.title('Funkcja przynależności - zużycie S2', fontsize=7)
plt.xlabel('Zużycie S2 [kg]')
plt.ylabel('µ_S2(x)')
plt.grid(True)
plt.legend(fontsize=4, loc='lower right')

plt.tight_layout()
plt.savefig("wykres1.png", dpi=300)
plt.show()