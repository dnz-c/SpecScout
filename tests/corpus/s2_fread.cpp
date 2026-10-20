// S2 gadget: b[i]() indirect call via attacker index from fread().
// Note: /Qspectre targets load bounds-check-bypass, NOT indirect calls, so this
// gadget is expected to survive /Qspectre -- a direct demonstration of a miss.
#include <cstdio>
#include <cstddef>
#include <cstdint>

typedef void (*fn_t)(void);
volatile int g_acc = 0;
static void f0(void){ g_acc += 1; }
static void f1(void){ g_acc += 2; }
static void f2(void){ g_acc += 3; }
static void f3(void){ g_acc += 4; }
static fn_t  ftab[4] = { f0, f1, f2, f3 };
static size_t ftab_size = 4;

static void victim(void) {
    unsigned char buf[8] = {0};
    fread(buf, 1, sizeof(buf), stdin);   // taint source
    size_t i = (size_t)buf[0];           // attacker-controlled index
    if (i < ftab_size) {                 // mistrainable bounds check (guard)
        ftab[i]();                       // S2: b[i]() indirect call
    }
}

int main(void) { victim(); return g_acc; }
