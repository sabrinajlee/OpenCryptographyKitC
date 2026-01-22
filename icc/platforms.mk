#Linux/unix systems need LD_LIBRARY_PATH setup to run the SSL tests
#Linux/unix systems need icc symlink to run the ICC tests
#(TODO use ICC_ROOT define for Linux so can remove icc symlink)
#runtime uses symlink for icc
#Windows systems need libeay32.dll in PATH or current directory

# NOTE: This file should contain NO references to directories in the
#       build system. It's ALL generic system stuff

# CLFAGS2/LDLFAGS2/SLDFLAGS2 are to cater with cross complied systems
# where we need to build some native executables, OS400, OSX both
# exploit this

# these are the same on all platforms
$(OPSYS)_RM = rm -f
$(OPSYS)_CP = cp -f
$(OPSYS)_MKDIR = [ -d $@ ] || mkdir -p

#--- VisualC++ definitions on Win32
# cant use symlinks so define absolute location of ICC ie parent of package directory
DEFAULT_DEBUGGER       = msdev
DEFAULT_CC             = cl
DEFAULT_CXX             = cl -TP
DEFAULT_debug_CFLAGS   = -MDd -Zi -D DEBUG -RTCu
# Optimization off generates faster starting code ...
DEFAULT_release_CFLAGS = -MD -Zi
DEFAULT_CFLAGS         = -nologo $($(OPSYS)_$(CONFIG)_CFLAGS) -W3 -GF -GS -D WIN32 -D $(OPSYS) -D _MBCS -D_CRT_SECURE_NO_WARNINGS -c 
DEFAULT_CXXFLAGS       = $($(OPSYS)_CFLAGS)
DEFAULT_LD             = link
DEFAULT_LD_CXX         = link
DEFAULT_SLD            = $($(OPSYS)_LD)
DEFAULT_AR             = $($(OPSYS)_LD)
DEFAULT_debug_LDFLAGS  = 
DEFAULT_LDFLAGS        = -DYNAMICBASE -NXCOMPAT -nologo -DEBUG -out:$@
DEFAULT_LDXXFLAGS      = $($(OPSYS)_LDFLAGS)
DEFAULT_SLDFLAGS       = -dll $($(OPSYS)_LDFLAGS) 
DEFAULT_ARFLAGS        = -lib -nologo -out:$@ 
DEFAULT_release_LDLIBS = ws2_32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib
DEFAULT_debug_LDLIBS   = ws2_32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib
DEFAULT_LDLIBS         = -DYNAMICBASE -NXCOMPAT $($(OPSYS)_$(CONFIG)_LDLIBS)
DEFAULT_OBJSUFX        = .obj
DEFAULT_EXESUFX        = .exe
DEFAULT_SHLPRFX        = 
# SO_EXT in other words
DEFAULT_SHLSUFX        = .dll
DEFAULT_STLPRFX        = 
DEFAULT_STLSUFX        = .lib
DEFAULT_debug_STRIP    = touch
DEFAULT_release_STRIP  = touch
DEFAULT_OUT            = -Fo
DEFAULT_CFLAGS2        = $($(OPSYS)_CFLAGS)
DEFAULT_LDFLAGS2       = $($(OPSYS)_LDFLAGS)
DEFAULT_SLDFLAGS2      = $($(OPSYS)_SLDFLAGS)
# mt is deprecated
DEFAULT_MT	     = echo mt is deprecated ,

# pre-build will set MUPPET but we can override it
# use this when no FIPS module is available
NO_MUPPET =
# use this definition to link in old FIPS module
UNIX_MUPPET         = $(OLD_ICC)/iccsdk/$(ICCLIB)

DEFAULT_MUPPET         = $(OLD_ICC)/iccsdk/$(ICCLIB)

# any flag can be defaulted this way to reduce copying overhead note = not :=
# example default LDXXFLAGS to be LDFLAGS
# override in OPSYS stanza

#set up defaults for all windows - specific stanzas will redefined as required
$(OPSYS)_CC = $(DEFAULT_CC)
$(OPSYS)_CXX = $(DEFAULT_CXX)
$(OPSYS)_debug_CFLAGS   = $(DEFAULT_debug_CFLAGS)
$(OPSYS)_release_CFLAGS = $(DEFAULT_release_CFLAGS)
$(OPSYS)_CFLAGS         = $(DEFAULT_CFLAGS)
$(OPSYS)_CXXFLAGS       = $($(OPSYS)_CFLAGS)
$(OPSYS)_LD             = $(DEFAULT_LD)
$(OPSYS)_LD_CXX         = $(DEFAULT_LD_CXX)
$(OPSYS)_SLD            = $(DEFAULT_LD)
$(OPSYS)_AR             = $(DEFAULT_AR)
$(OPSYS)_debug_LDFLAGS  = $(DEFAULT_debug_LDFLAGS)
$(OPSYS)_LDFLAGS        = $(DEFAULT_LDFLAGS)
$(OPSYS)_LDXXFLAGS      = $($(OPSYS)_LDFLAGS)
$(OPSYS)_SLDFLAGS       = $(DEFAULT_SLDFLAGS)
$(OPSYS)_ARFLAGS        = $(DEFAULT_ARFLAGS)
$(OPSYS)_release_LDLIBS = $(DEFAULT_release_LDLIBS)
$(OPSYS)_debug_LDLIBS   = $(DEFAULT_debug_LDLIBS)
$(OPSYS)_LDLIBS         = $(DEFAULT_LDLIBS)
$(OPSYS)_OBJSUFX        = $(DEFAULT_OBJSUFX)
$(OPSYS)_EXESUFX        = $(DEFAULT_EXESUFX)
$(OPSYS)_SHLPRFX        = $(DEFAULT_SHLPRFX)
$(OPSYS)_SHLSUFX        = $(DEFAULT_SHLSUFX)
$(OPSYS)_STLPRFX        = $(DEFAULT_STLPRFX)
$(OPSYS)_STLSUFX        = $(DEFAULT_STLSUFX)
$(OPSYS)_debug_STRIP    = $(DEFAULT_debug_STRIP)
$(OPSYS)_release_STRIP  = $(DEFAULT_release_STRIP)
$(OPSYS)_OUT            = $(DEFAULT_OUT)
$(OPSYS)_CFLAGS2        = $(DEFAULT_CFLAGS2)
$(OPSYS)_LDFLAGS2       = $(DEFAULT_LDFLAGS2)
$(OPSYS)_SLDFLAGS2      = $(DEFAULT_SLDFLAGS2)
$(OPSYS)_MT             = $(DEFAULT_MT)
$(OPSYS)_MUPPET         = $(DEFAULT_MUPPET)


# Convenience definition for Linuxi
#
LINUX_OUT           = -o 

LINUX_debug_CFLAGS   = -g3 -O0
LINUX_asan_CFLAGS	 = $(LINUX_debug_CFLAGS) -fsanitize=address
LINUX_beam_CFLAGS    = -g -O3
LINUX_release_CFLAGS = -g1 -O3

LINUX_asan_LDFLAGS	 = -fsanitize=address

# std=gnu99 will allow declaring variables in the for loop header on phelix (gcc 4.1.2/2006)
LINUX32_CFLAGS = -std=gnu99 -m32 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fno-exceptions -fPIC -Wall -c
LINUX32_CXXFLAGS = -std=gnu99 -m32 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fPIC -Wall -c
LINUX32_LDFLAGS = -std=gnu99 -m32 $(LINUX_$(CONFIG)_LDFLAGS) $(LINUX_OUT) $@
LINUX32_SLDFLAGS = -std=gnu99 -m32 $(LINUX_$(CONFIG)_LDFLAGS) -shared -Wl,-soname,$@  -Wl,--rpath,\$$ORIGIN $(LINUX_OUT) $@

# This one makes too many "error" matches in log file searches
#LINUX64_CFLAGS += -Werror=implicit-function-declaration
ifeq (OFFICIAL, $(BUILD))
LINUX64_CFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fno-exceptions -fPIC -Wall -c
LINUX64_CXXFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fPIC -Wall -c
else
LINUX64_CFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fno-exceptions -fPIC -Wall -c \
                 -Werror=incompatible-pointer-types \
                 -Werror=implicit-int \
                 -Werror=implicit-function-declaration \
                 -Werror=return-type \
                 -Werror=int-conversion   
LINUX64_CXXFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_CFLAGS) -D_REENTRANT -fno-strict-aliasing -fPIC -Wall -c \
                   -Werror=return-type
endif

LINUX64_LDFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_LDFLAGS) $(LINUX_OUT) $@
LINUX64_SLDFLAGS = -std=gnu99 -m64 $(LINUX_$(CONFIG)_LDFLAGS) -shared -Wl,-soname,$@ -Wl,--rpath,\$$ORIGIN $(LINUX_OUT) $@

#--- GCC definitions on Linux IA32
LINUX_RM             = rm -f
LINUX_MKDIR          = [ -d $@ ] || mkdir -p
LINUX_CP             = cp -f
LINUX_DEBUGGER       = ddd
LINUX_CC             = gcc
LINUX_CXX            = g++
LINUX_CFLAGS         = $(LINUX32_CFLAGS)
LINUX_CXXFLAGS       = $(LINUX32_CXXFLAGS)
LINUX_release_LD     = $(LINUX_CC)
LINUX_debug_LD       = $(LINUX_CC)
LINUX_beam_LD        = true
LINUX_LD             = $(LINUX_CC)
LINUX_LD_CXX         = $(LINUX_CXX)
LINUX_SLD            = $(LINUX_LD)
LINUX_AR             = ar
LINUX_LDFLAGS        = $(LINUX32_LDFLAGS)
LINUX_SLDFLAGS       = $(LINUX32_SLDFLAGS)  -z noexecstack
LINUX_ARFLAGS        = -ruv $@
LINUX_LDLIBS         = -lpthread -ldl
LINUX_release_OBJSUFX   = .o
LINUX_debug_OBJSUFX  = .o
LINUX_beam_OBJSUFX   = .beam
LINUX_OBJSUFX        = $(LINUX_$(CONFIG)_OBJSUFX)
LINUX_EXESUFX        =
LINUX_SHLPRFX        = lib
LINUX_SHLSUFX        = .so
LINUX_STLPRFX        = lib
LINUX_STLSUFX        = .a
LINUX_debug_STRIP   = touch
LINUX_release_STRIP = strip
LINUX_beam_STRIP    = touch
LINUX_CFLAGS2        = $(LINUX32_CFLAGS)
LINUX_LDFLAGS2       = $(LINUX32_LDFLAGS)
LINUX_SLDFLAGS2      = $(LINUX32_SLDFLAGS)  -z noexecstack
LINUX_MT             = true
# HP/UX Specific
LINUX_ICCLIB_LNK     =


#--- GCC definitions on Linux IA32/IA64, Directly linked to OpenSSL
#--
#-- Uses "normal" shared library linkage not dlopen/dlsym
#-- This isn't a production version, but it's used to debug platforms 
#-- like OS400 which don't have dlopen/dlsym
#--
#-- Note that that it's also useful for debugging, the table based calls aren't
#-- traced well by debuggers like valgrind unless the libs are linked normally.
#--
LINUXDL_RM             = rm -f
LINUXDL_MKDIR          = [ -d $@ ] || mkdir -p
LINUXDL_CP             = cp -f
LINUXDL_DEBUGGER       = ddd
LINUXDL_CC             = $(LINUX_CC)
LINUXDL_CXX            = $(LINUX_CXX)
LINUXDL_debug_CFLAGS   = -g3
LINUXDL_beam_CFLAGS    = -g -O3
LINUXDL_release_CFLAGS = -g1 -O3
LINUXDL_CFLAGS         = $(LINUXDL_$(CONFIG)_CFLAGS) -D_REENTRANT -DDIRECT_LINK -fPIC -Wall  -c
LINUXDL_release_LD     = $(LINUXDL_CC)
LINUXDL_debug_LD       = $(LINUXDL_CC)
LINUXDL_beam_LD        = true
LINUXDL_LD             = $(LINUX_LD)
LINUXDL_LD_CXX         = $(LINUXDL_CXX)
LINUXDL_SLD            = $(LINUXDL_LD)
LINUXDL_AR             = ar
LINUXDL_LDFLAGS        = $(LINUX_OUT)
LINUXDL_SLDFLAGS       = $(LINUX_SLDFLAGS)  -z noexecstack
LINUXDL_ARFLAGS        = -ruv $@
LINUXDL_LDLIBS         = -lpthread -ldl
LINUXDL_debug_OBJSUFX  = .o
LINUXDL_beam_OBJSUFX   = .beam
LINUXDL_OBJSUFX        = $(LINUXDL_$(CONFIG)_OBJSUFX)
LINUXDL_EXESUFX        =
LINUXDL_SHLPRFX        = lib
LINUXDL_SHLSUFX        = .so
LINUXDL_STLPRFX        = lib
LINUXDL_STLSUFX        = .a
LINUXDL_debug_STRIP   = touch
LINUXDL_release_STRIP = strip
LINUXDL_beam_STRIP    = touch
LINUXDL_OUT           = $(LINUX_OUT)
LINUXDL_CFLAGS2        = $(LINUXDL_CFLAGS)
LINUXDL_LDFLAGS2       = $(LINUXDL_LDFLAGS)
LINUXDL_SLDFLAGS2      = $(LINUXDL_SLDFLAGS)  -z noexecstack
LINUX_DL_MT            = true



#--- GCC definitions on Linux AMD64
AMD64_LINUX_CC             = $(LINUX_CC)
AMD64_LINUX_CXX             = $(LINUX_CXX)
AMD64_LINUX_CFLAGS         = $(LINUX64_CFLAGS)
AMD64_LINUX_debug_CFLAGS   =
AMD64_LINUX_release_CFLAGS =
AMD64_LINUX_CXXFLAGS       = $(LINUX64_CXXFLAGS)
AMD64_LINUX_LD             = $(LINUX_LD)
AMD64_LINUX_LD_CXX         = $(LINUX_CXX)
AMD64_LINUX_SLD            = $(LINUX_LD)
AMD64_LINUX_AR             = ar
AMD64_LINUX_LDFLAGS        = $(LINUX64_LDFLAGS)
AMD64_LINUX_SLDFLAGS       = $(LINUX64_SLDFLAGS) -z noexecstack
AMD64_LINUX_ARFLAGS        = -ruv $@
AMD64_LINUX_LDLIBS         = -lpthread -ldl
AMD64_LINUX_OBJSUFX        = .o
AMD64_LINUX_EXESUFX        =
AMD64_LINUX_SHLPRFX        = lib
AMD64_LINUX_SHLSUFX        = .so
AMD64_LINUX_STLPRFX        = lib
AMD64_LINUX_STLSUFX        = .a
AMD64_LINUX_debug_STRIP    = touch
AMD64_LINUX_asan_STRIP	   = touch
AMD64_LINUX_release_STRIP  = strip
AMD64_LINUX_OUT            = $(LINUX_OUT)
AMD64_LINUX_CFLAGS2        = $(AMD64_LINUX_CFLAGS)
AMD64_LINUX_LDFLAGS2       = $(AMD64_LINUX_LDFLAGS)
AMD64_LINUX_SLDFLAGS2      = $(AMD64_LINUX_SLDFLAGS)
AMD64_LINUX_MT             = true
AMD64_LINUX_MUPPET         = $(UNIX_MUPPET)

# muppet.mk needs this definition, mainly used in iccpkg
$(OPSYS)_OLD_ICC	= OLD_ICC/$(OPSYS)
OLD_ICC		= $($(OPSYS)_OLD_ICC)

# MUPPET is set by the build system based on FIPS module presence and it also writes gsk_wrap2_a.c to match
# if we reset it here then we will be inconsistent with gsk_wrap2_a.c which links in FIPS ICCC_ prefix APIs
#MUPPET = $($(OPSYS)_MUPPET)
