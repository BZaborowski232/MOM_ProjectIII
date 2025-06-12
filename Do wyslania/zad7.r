library(FuzzyLP)

# Nazwy zgodne z wcześniejszym modelem AMPL
produkty <- c("P1", "P2", "P3")
skladniki <- c("S1", "S2", "S3")

# Macierz ograniczeń (kolejność: S1, S2, S3, min P1, min P3, przychod, zanieczyszczenia, koszt)
ograniczenia <- matrix(
    c(
        2,  8,  4,  # S1 <= 100 tolerance 10  
        8,  1,  4,  # S2 <= 50 tolerance 5
        5,  1,  2,  # S3 <= 50 tolerance 0
        1,  0,  0,  # P1 >= 3 tolerance 0
        0,  0,  1,  # P3 >= 5 tolerance 0
        9, 21, 11,  # przychod >= 150 tolerance 20 (z tabeli: Cx)
        1,  1,  3,  # zanieczyszczenia <= 30 tolerance 5 (Zx)
        1,  3,  3   # koszt <= 70 tolerance 10 (Kx)
    ),
    nrow = 8, 
    byrow = TRUE
)
kierunki <- c("<=", "<=", "<=", ">=", ">=", ">=", "<=", "<=")
zamierzenia <- c(100, 50, 50, 3, 5, 150, 30, 70)
tolerancje <- c(10, 5, 0, 0, 0, 20, 5, 10)

# Wektory celu zgodne z nazwami AMPL
przychod_jednostkowy <- c(9, 21, 11)
zanieczyszczenia_jednostkowe <- c(1, 1, 3)
koszt_jednostkowy <- c(1, 3, 3)

oblicz <- function(cel, cel_aspiracja, cel_tolerancja, maksimum) {
    wynik <- FCLP.fuzzyObjective(
        cel, 
        ograniczenia, 
        kierunki, 
        zamierzenia, 
        tolerancje, 
        z0 = cel_aspiracja,
        t0 = cel_tolerancja, 
        maximum = maksimum, 
        verbose = TRUE
    )
    return(wynik)
}

pokaz_wyniki <- function(wynik, nazwa) {
    przychod <- sum(przychod_jednostkowy * wynik[, c("x1", "x2", "x3")])
    zanieczyszczenia <- sum(zanieczyszczenia_jednostkowe * wynik[, c("x1", "x2", "x3")])
    koszt <- sum(koszt_jednostkowy * wynik[, c("x1", "x2", "x3")])

    S1_zuzycie <- 2 * wynik[, "x1"] + 8 * wynik[, "x2"] + 4 * wynik[, "x3"]
    S2_zuzycie <- 8 * wynik[, "x1"] + 1 * wynik[, "x2"] + 4 * wynik[, "x3"]
    S3_zuzycie <- 5 * wynik[, "x1"] + 1 * wynik[, "x2"] + 2 * wynik[, "x3"]

    cat("Cel optymalizowany:", nazwa, "\n")
    cat("Przychód =", przychod, "\n")
    cat("Zanieczyszczenia =", zanieczyszczenia, "\n")
    cat("Koszt =", koszt, "\n")
    cat("Zużycie S1 =", S1_zuzycie, "\n")
    cat("Zużycie S2 =", S2_zuzycie, "\n")
    cat("Zużycie S3 =", S3_zuzycie, "\n\n")
}

cat("\nWyniki:\n\n")

wynik <- oblicz(przychod_jednostkowy, 150, 20, TRUE)
pokaz_wyniki(wynik, "przychód")

wynik <- oblicz(zanieczyszczenia_jednostkowe, 30, 5, FALSE)
pokaz_wyniki(wynik, "zanieczyszczenia")

wynik <- oblicz(koszt_jednostkowy, 70, 10, FALSE)
pokaz_wyniki(wynik, "koszt")