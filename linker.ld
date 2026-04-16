ENTRY(kernel_main)

SECTIONS {
    . = 1M;

    .text : {
        *(.text)
    }

    .ordata : {
        *(.rodata)
    }
    
    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}