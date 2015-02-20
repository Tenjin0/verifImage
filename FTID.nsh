/*

FTID.nsh - signature-based file type identification

Usage:
${GetFileType} File -> result on the stack
E.g.
${GetFileType} "$INSTDIR\SomeFile"
Pop $0

Return values:
ERROR_FILEOPEN - file could not be opened
ERROR_FILEREAD - file could not be read
ERROR_FILETYPE - file type could not be identified
If identified, the return value is the file type. Currently supported:
bmp, gif, jpg, png, wav, mp3, flac, avi, mkv, mp4, flv, mpg, mov, 3gp

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!define ReadBytes 16 ; bytes to read from file

; Signatures:
!define BMP   424D
!define GIF   47494638
!define JPG   FFD8FF
!define PNG   89504E470D0A1A0A
!define WAV   57415645666D7420
!define MP3a  494433
!define MP3b  FFFB
!define MP3c  FFF3
!define MP3d  FFE3
!define FLAC  664C614300000022
!define AVI   415649204C495354
!define MKV   1A45DFA3
!define MP4a  667479706D703432
!define MP4b  6674797069736F6D
!define MP4c  6674797033677035
!define FLV   464C5601
!define MPGa  000001BA
!define MPGb  000001B3
!define MOVa  6D6F6F76
!define MOVb  6674797071742020
!define 3GP   66747970336770

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!macro GetFileType File
Push "${File}"
Call GetFileType
!macroend
!define GetFileType "!insertmacro GetFileType"

!macro IsType Type Signature Offset
StrLen $0 ${Signature}
StrCpy $0 $R1 $0 ${Offset}
StrCmp $0 ${Signature} 0 +3
StrCpy $R1 ${Type}
Goto GetFileTypeEnd
!macroend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        Function GetFileType

Exch $R0
Push $R1
Push $0
Push $1

ClearErrors
FileOpen $R0 "$R0" r
IfErrors 0 +3
StrCpy $R1 "ERROR_FILEOPEN"
Goto GetFileTypeEnd

StrCpy $1 0
StrCpy $R1 ''
FileReadLoop:
FileReadByte $R0 $0
IfErrors 0 +4
FileClose $R0
StrCpy $R1 "ERROR_FILEREAD"
Goto GetFileTypeEnd
IntFmt $0 "%02X" $0
StrCpy $R1 "$R1$0"
IntOp $1 $1 + 1
IntCmp $1 ${ReadBytes} 0 FileReadLoop
FileClose $R0

!insertmacro IsType bmp  ${BMP}   0
!insertmacro IsType gif  ${GIF}   0
!insertmacro IsType jpg  ${JPG}   0
!insertmacro IsType png  ${PNG}   0
!insertmacro IsType wav  ${WAV}  16 ; skips 8 bytes
!insertmacro IsType mp3  ${MP3a}  0
!insertmacro IsType mp3  ${MP3b}  0
!insertmacro IsType mp3  ${MP3c}  0
!insertmacro IsType mp3  ${MP3d}  0
!insertmacro IsType flac ${FLAC}  0
!insertmacro IsType avi  ${AVI}  16
!insertmacro IsType mkv  ${MKV}   0
!insertmacro IsType mp4  ${MP4a}  8
!insertmacro IsType mp4  ${MP4b}  8
!insertmacro IsType mp4  ${MP4c}  8
!insertmacro IsType flv  ${FLV}   0
!insertmacro IsType mpg  ${MPGa}  0
!insertmacro IsType mpg  ${MPGb}  0
!insertmacro IsType mov  ${MOVa}  8
!insertmacro IsType mov  ${MOVb}  8
!insertmacro IsType 3gp  ${3GP}   8

StrCpy $R1 "ERROR_FILETYPE"

GetFileTypeEnd:
Pop $1
Pop $0
Exch $R1
Exch
Pop $R0

FunctionEnd


; 2013 aerDNA