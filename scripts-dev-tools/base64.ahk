; We're past the auto execute section, Base64Chars is defined before calling the functions
; (it is copied here for snippet copy paste completeness)
; StringCaseSense On
Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/


Base64Encode(string) {
   Loop Parse, string
   {
      m := Mod(A_Index,3)
      IfEqual      m,1, SetEnv buffer, % Asc(A_LoopField) << 16
      Else IfEqual m,2, EnvAdd buffer, % Asc(A_LoopField) << 8
      Else {
         buffer += Asc(A_LoopField)
         out := out Base64EncodePos(buffer>>18) Base64EncodePos(buffer>>12) Base64EncodePos(buffer>>6) Base64EncodePos(buffer)
      }
   }

   IfEqual m,0, Return out
   IfEqual m,1, Return out Base64EncodePos(buffer>>18) Base64EncodePos(buffer>>12) "=="
   Return out Base64EncodePos(buffer>>18) Base64EncodePos(buffer>>12) Base64EncodePos(buffer>>6) "="
}

Base64EncodePos(i) {   ; <== Base64Chars[i & 63], 0-base index
   Global Base64Chars
   StringMid i, Base64Chars, (i&63)+1, 1
   Return i
}



Base64Decode(code) {
   StringReplace code, code, =,,All
   Loop Parse, code
   {
      m := A_Index & 3 ; mod 4
      IfEqual m,0, {
         buffer += Base64DecodePos(A_LoopField)
         out := out Chr(buffer>>16) Chr(255 & buffer>>8) Chr(255 & buffer)
      }
      Else IfEqual m,1, SetEnv buffer, % Base64DecodePos(A_LoopField) << 18
      Else buffer += Base64DecodePos(A_LoopField) << 24-6*m
   }
   IfEqual m,0, Return out
   IfEqual m,2, Return out Chr(buffer>>16)
   Return out Chr(buffer>>16) Chr(255 & buffer>>8)
}

Base64DecodePos(c) { ; c = a char in Base64Chars ==> position [0,63]
   Global Base64Chars
   Return InStr(Base64Chars,c,1) - 1
}
