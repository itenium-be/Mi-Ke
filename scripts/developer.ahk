; ---------------------------------------------------------------------------------------------------------------- GUIDS

:*:0uid::00000000-0000-0000-0000-000000000000
:*:1uid::11111111-1111-1111-1111-111111111111
:*:ruid::
Send % GUID()
return


; --------------------------------------------------------------------------------------------------------------- BASE64

^#b::
; Control + Win + B ; followed by 'e' or 'd'
Base64Chars = ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/

encodeKey = e
decodeKey = d

clipboard =
Send, ^c
ClipWait, 2

Input key, I L1
if key = %encodeKey%
	result := Base64Encode(clipboard)
else if key = %decodeKey%
	result := Base64Decode(clipboard)
else {
	Notify("Base64: Expected " encodeKey " (to encode) or " decodeKey " (to decode) to be pressed")
	return
}

clipboard := result
Notify(result)
return
