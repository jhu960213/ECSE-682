/***************************************************************************//**
 * GCC Linker script for Silicon Labs devices
 *******************************************************************************
 * # License
 * <b>Copyright 2020 Silicon Laboratories Inc. www.silabs.com</b>
 *******************************************************************************
 *
 * SPDX-License-Identifier: Zlib
 *
 * The licensor of this software is Silicon Laboratories Inc.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 ******************************************************************************/

MEMORY
{
  FLASH   (rx)  : ORIGIN = 0x6000, LENGTH = 0x78000
  RAM     (rwx) : ORIGIN = 0x20000000, LENGTH = 0x8000
}

ENTRY(Reset_Handler)

SECTIONS
{

  .text :
  {
    linker_vectors_begin = .;
    KEEP(*(.vectors))
    linker_vectors_end = .;

    __Vectors_End = .;
    __Vectors_Size = __Vectors_End - __Vectors;

    linker_code_begin = .;
    *(.text*)
    linker_code_end = .;

    KEEP(*(.init))
    KEEP(*(.fini))

    /* .ctors */
    *crtbegin.o(.ctors)
    *crtbegin?.o(.ctors)
    *(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
    *(SORT(.ctors.*))
    *(.ctors)

    /* .dtors */
    *crtbegin.o(.dtors)
    *crtbegin?.o(.dtors)
    *(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
    *(SORT(.dtors.*))
    *(.dtors)

    *(.rodata*)
    *(.eh_frame*)
  } > FLASH

  .ARM.extab :
  {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > FLASH

  __exidx_start = .;
  .ARM.exidx :
  {
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  } > FLASH
  __exidx_end = .;
  __etext = .;

  /* Start placing output sections which are loaded into RAM */
  . = ORIGIN(RAM);

  .stack ALIGN(8) (NOLOAD):
  {
    __StackLimit = .;
    KEEP(*(.stack*))
    . = ALIGN(4);
    __StackTop = .;
    PROVIDE(__stack = __StackTop);
  } > RAM

  .noinit . (NOLOAD):
  {
    *(.noinit*);
  } > RAM

  .data . : AT (__etext)
  {
    . = ALIGN(4);
    __data_start__ = .;
    *(vtable)
    *(.data*)
    . = ALIGN (4);

    PROVIDE(__ram_func_section_start = .);
    *(.ram)
    PROVIDE(__ram_func_section_end = .);

    . = ALIGN(4);
    /* preinit data */
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP(*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);

    . = ALIGN(4);
    /* init data */
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP(*(SORT(.init_array.*)))
    KEEP(*(.init_array))
    PROVIDE_HIDDEN (__init_array_end = .);

    . = ALIGN(4);
    /* finit data */
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP(*(SORT(.fini_array.*)))
    KEEP(*(.fini_array))
    PROVIDE_HIDDEN (__fini_array_end = .);

    . = ALIGN(4);
    /* All data end */
    __data_end__ = .;

  } > RAM

  .bss . :
  {
    . = ALIGN(4);
    __bss_start__ = .;
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    __bss_end__ = .;
  } > RAM

  .heap (COPY):
  {
    __HeapBase = .;
    __end__ = .;
    end = __end__;
    _end = __end__;
    KEEP(*(.heap*))
    . = ORIGIN(RAM) + LENGTH(RAM);
    __HeapLimit = .;
  } > RAM

  __heap_size = __HeapLimit - __HeapBase;

  /* This is where we handle flash storage blocks. We use dummy sections for finding the configured
   * block sizes and then "place" them at the end of flash when the size is known. */
  .internal_storage (DSECT) : {
    KEEP(*(.internal_storage*))
  } > FLASH

  .nvm (DSECT) : {
    KEEP(*(.simee*))
  } > FLASH

  linker_nvm_end = ORIGIN(FLASH) + LENGTH(FLASH);
  linker_nvm_begin = linker_nvm_end - SIZEOF(.nvm);
  linker_nvm_size = SIZEOF(.nvm);
  linker_storage_end = linker_nvm_begin;
  linker_storage_begin = linker_storage_end - SIZEOF(.internal_storage);
  linker_storage_size = SIZEOF(.internal_storage);
  __nvm3Base = linker_nvm_begin;

  ASSERT( LENGTH(FLASH) >= (__etext + SIZEOF(.data)), "FLASH memory overflowed !")
  ASSERT( (ORIGIN(RAM) + LENGTH(RAM)) >= (__HeapBase + SIZEOF(.heap)), "RAM memory overflowed !")
}
