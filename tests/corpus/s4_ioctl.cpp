// S1 gadget reached through an IOCTL dispatch routine (driver model, mimicked
// in user mode with the real x64 _IRP offset so SpecScout's --driver setup
// matches). Signature mirrors DRIVER_DISPATCH(PDEVICE_OBJECT, PIRP): irp = RDX.
// Scan with:  specscout s4.exe --driver --function DispatchIoctl
#include <cstdint>
#include <cstddef>
uint8_t  array1[16] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
size_t   array1_size = 16;
uint8_t  array2[256 * 512];
volatile uint8_t sink = 0;

extern "C" __declspec(dllexport, noinline) long DispatchIoctl(void* devobj, void* irp) {
    (void)devobj;
    // Irp->AssociatedIrp.SystemBuffer  (offset 0x18 on x64)
    unsigned char* sysbuf = *(unsigned char**)((char*)irp + 0x18);
    size_t i = (size_t)sysbuf[0];        // attacker index from the IOCTL input buffer
    if (i < array1_size)                 // guard
        sink = array2[array1[i] * 512];  // S1 a[b[i]]
    return 0;
}
int main() {
    static char irp[0x200] = {0};
    static unsigned char buf[8] = {0};
    *(void**)(irp + 0x18) = buf;
    return (int)DispatchIoctl(0, irp);
}
