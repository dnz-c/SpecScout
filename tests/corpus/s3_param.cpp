// S1 gadget whose attacker index is a FUNCTION PARAMETER (syscall-style).
// Scan with:  specscout s3.exe --params            (taints all function params)
//        or:  specscout s3.exe --params --function victim
#include <cstdint>
#include <cstddef>
uint8_t  array1[16] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
size_t   array1_size = 16;
uint8_t  array2[256 * 512];
volatile uint8_t sink = 0;

extern "C" __declspec(dllexport, noinline) void victim(size_t i) {
    if (i < array1_size)                 // guard on an attacker-controlled parameter
        sink = array2[array1[i] * 512];  // S1 a[b[i]]
}
int main(int argc, char**) { victim((size_t)argc); return sink; }
