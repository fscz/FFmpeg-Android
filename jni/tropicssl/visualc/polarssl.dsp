# Microsoft Developer Studio Project File - Name="tropicssl" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=tropicssl - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "tropicssl.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "tropicssl.mak" CFG="tropicssl - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "tropicssl - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "tropicssl - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "tropicssl - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir ""
# PROP BASE Intermediate_Dir "temp"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ""
# PROP Intermediate_Dir "temp"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "../include" /D "NDEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x40c /d "NDEBUG"
# ADD RSC /l 0x40c /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "tropicssl - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir ""
# PROP BASE Intermediate_Dir "temp"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir ""
# PROP Intermediate_Dir "temp"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /Z7 /Od /I "../include" /D "_DEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD BASE RSC /l 0x40c /d "_DEBUG"
# ADD RSC /l 0x40c /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "tropicssl - Win32 Release"
# Name "tropicssl - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\library\aes.c
# End Source File
# Begin Source File

SOURCE=..\library\arc4.c
# End Source File
# Begin Source File

SOURCE=..\library\base64.c
# End Source File
# Begin Source File

SOURCE=..\library\bignum.c
# End Source File
# Begin Source File

SOURCE=..\library\certs.c
# End Source File
# Begin Source File

SOURCE=..\library\debug.c
# End Source File
# Begin Source File

SOURCE=..\library\des.c
# End Source File
# Begin Source File

SOURCE=..\library\dhm.c
# End Source File
# Begin Source File

SOURCE=..\library\havege.c
# End Source File
# Begin Source File

SOURCE=..\library\md2.c
# End Source File
# Begin Source File

SOURCE=..\library\md4.c
# End Source File
# Begin Source File

SOURCE=..\library\md5.c
# End Source File
# Begin Source File

SOURCE=..\library\net.c
# End Source File
# Begin Source File

SOURCE=..\library\padlock.c
# End Source File
# Begin Source File

SOURCE=..\library\rsa.c
# End Source File
# Begin Source File

SOURCE=..\library\sha1.c
# End Source File
# Begin Source File

SOURCE=..\library\sha2.c
# End Source File
# Begin Source File

SOURCE=..\library\sha4.c
# End Source File
# Begin Source File

SOURCE=..\library\ssl_cli.c
# End Source File
# Begin Source File

SOURCE=..\library\ssl_srv.c
# End Source File
# Begin Source File

SOURCE=..\library\ssl_tls.c
# End Source File
# Begin Source File

SOURCE=..\library\timing.c
# End Source File
# Begin Source File

SOURCE=..\library\x509parse.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\include\tropicssl\aes.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\arc4.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\base64.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\bignum.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\bn_mul.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\certs.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\config.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\debug.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\des.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\dhm.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\havege.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\md2.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\md4.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\md5.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\net.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\padlock.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\rsa.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\sha1.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\sha2.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\sha4.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\ssl.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\timing.h
# End Source File
# Begin Source File

SOURCE=..\include\tropicssl\x509.h
# End Source File
# End Group
# End Target
# End Project
