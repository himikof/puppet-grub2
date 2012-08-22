# Overview

This puppet module manages grub 2.x bootloader.

# Classes

## grub

The grub class performs all steps needed to the use of grub such as package
installation and the configuration of grub.
See the variables above to show what are the available options to configure.
The grub.cfg file is automatically regenerated after configuration changes.

### Parameters

#### $default_entry

The default menu entry. This may be a number, in which case it identifies 
the Nth entry in the generated menu counted from zero, or the title of a menu
entry, or the special string ‘saved’. Using the title may be useful if you 
want to set a menu entry as the default even though there may be a variable
number of entries before it.

The default is ‘0’. 

#### $timeout

Boot the default entry this many seconds after the menu is displayed, unless
a key is pressed. The default is ‘5’. Set to ‘0’ to boot immediately without
displaying the menu, or to ‘-1’ to wait indefinitely. 

#### $distributor

Set by distributors of GRUB to their identifying name. This is used to
generate more informative menu entry titles. 

#### $cmdline_linux_default

Unless ‘GRUB_DISABLE_RECOVERY’ is set to ‘true’, two menu entries will be 
generated for each Linux kernel: one default entry and one entry for recovery
mode. This option lists command-line arguments to add only to the default menu
entry, after those listed in ‘GRUB_CMDLINE_LINUX’. 

#### $cmdline_linux

Command-line arguments to add to menu entries for the Linux kernel. 

#### $badram

If this option is set, GRUB will issue a badram command to filter out
specified regions of RAM. 

#### $terminal

Select the terminal input/output device. You may select multiple devices here,
separated by spaces.
Valid terminal output names depend on the platform, but may include ‘console’
(PC BIOS and EFI consoles), ‘serial’ (serial terminal),
‘gfxterm’ (graphics-mode output), ‘ofconsole’ (Open Firmware console), or
‘vga_text’ (VGA text output, mainly useful with Coreboot).

The default is to use the platform's native terminal output. 

#### $serial_command

A command to configure the serial port when using the serial console. 
Defaults to ‘serial’. 

#### $gfxmode

Set the resolution used on the ‘gfxterm’ graphical terminal. Note that you
can only use modes which your graphics card supports via VESA BIOS Extensions
(VBE), so for example native LCD panel resolutions may not be available. 
The default is ‘640x480’. 

#### $disable_linux_uuid

Normally, grub-mkconfig will generate menu entries that use universally-unique
identifiers (UUIDs) to identify the root filesystem to the Linux kernel, using
a ‘root=UUID=...’ kernel parameter. This is usually more reliable, but in some
cases it may not be appropriate. 
To disable the use of UUIDs, set this option to ‘true’. 

#### $disable_linux_recovery

If this option is set to ‘true’, disable the generation of recovery mode menu
entries. 

#### $init_tune

Play a tune on the speaker when GRUB starts. This is particularly useful for
users unable to see the screen.
The value of this option is passed directly to play. 


# Licensing

This puppet module is licensed under the GPL version 3 or later. Redistribution
and modification is encouraged.

The GPL version 3 license text can be found in the "LICENSE" file accompanying
this puppet module, or at the following URL:

http://www.gnu.org/licenses/gpl-3.0.html
