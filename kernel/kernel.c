void kernel_main() {
    const char *msg = "openMOS v0.1 booted successfully!";
    char *video = (char *)0xB8000; // VGA text mode buffer
    for (int i = 0; msg[i] != '\0'; i++) {
        video[i * 2] = msg[i]; // Character
        video[i * 2 + 1] = 0x07; // Attribute (white on black)
    }
    while (1);
}