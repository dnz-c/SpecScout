// S1 gadget: a[b[i]] bounds-check-bypass, attacker index from fread().
// Build:  cl /O2 s1_fread.cpp            -> gadget present (no lfence)
//         cl /O2 /Qspectre s1_fread.cpp  -> MSVC inserts lfence (mitigated)
#include <cstdio>
#include <cstddef>
#include <cstdint>

static uint8_t  array1[16] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
static size_t   array1_size = 16;
static uint8_t  array2[256 * 512];
volatile uint8_t g_sink = 0;

static void victim(void) {
    unsigned char buf[8] = {0};
    fread(buf, 1, sizeof(buf), stdin);   // taint source (return ignored)
    size_t i = (size_t)buf[0];           // attacker-controlled index
    if (i < array1_size) {               // mistrainable bounds check (guard)
        g_sink = array2[array1[i] * 512];// S1: a[b[i]] dependent load
    }
}

int main(void) { victim(); return (int)g_sink; }
